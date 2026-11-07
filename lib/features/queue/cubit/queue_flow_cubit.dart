import 'dart:async';

import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Look at a shop's line, pay for a place in it, and follow it to the chair.
///
/// Like booking, the app never puts the customer in line itself: paying tells
/// Stripe, Stripe tells the webhook, the webhook gives the place, and the app
/// reads the queue back until its own entry is there.
class QueueFlowCubit extends Cubit<QueueFlowState> {
  QueueFlowCubit({
    required QueueRepository queue,
    required ShopDirectoryRepository shops,
    required PaymentService payments,
    required String shopId,
  }) : _queue = queue,
       _shops = shops,
       _payments = payments,
       super(QueueFlowState(shopId: shopId, now: DateTime.now().toUtc())) {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  final QueueRepository _queue;
  final ShopDirectoryRepository _shops;
  final PaymentService _payments;

  late final Timer _ticker;
  int _seconds = 0;

  /// How often the line is read again while it is on screen (queue spec §4.1).
  static const int _refreshEverySeconds = 20;

  /// How long the app waits for the webhook to give the place.
  static const Duration _placeTimeout = Duration(seconds: 20);

  /// Loads the shop and its queue, and resumes a place the customer holds.
  Future<void> start() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final shop = await _shops.byId(state.shopId);
    if (isClosed) return;
    switch (shop) {
      case Failure<Shop>(:final error):
        emit(state.copyWith(isLoading: false, failure: error));
        return;
      case Success<Shop>(:final data):
        final active = data.activeServices;
        emit(state.copyWith(shop: data, service: active.firstOrNull));
    }

    await refresh();
    if (isClosed) return;
    emit(state.copyWith(isLoading: false));
  }

  /// Reads the line again. Also how a place given by the webhook, a call, or
  /// the end of the customer's turn reaches the screen.
  Future<void> refresh() async {
    final result = await _queue.shopQueue(state.shopId);
    if (isClosed) return;

    switch (result) {
      case Failure<ShopQueue>(:final error):
        // A failed background read is not worth a toast every 20 seconds;
        // only the first load reports it.
        if (state.queue == null) emit(state.copyWith(failure: error));
      case Success<ShopQueue>(:final data):
        final mine = data.myEntry;
        final wasInLine = state.step == QueueStep.inLine;
        emit(
          state.copyWith(
            queue: data,
            entry: mine ?? (wasInLine ? state.entry : null),
            step: switch ((mine, wasInLine)) {
              (final QueueEntry _, _) => QueueStep.inLine,
              // In line a moment ago and gone now: served, removed, or the
              // day closed. The push says which.
              (null, true) => QueueStep.ended,
              _ => state.step,
            },
          ),
        );
    }
  }

  void chooseService(ShopService service) {
    final keeps =
        state.shop
            ?.providersFor(service.id)
            .any((p) => p.id == state.providerId) ??
        false;
    // Someone who does not do the new service cannot stay chosen.
    emit(
      state.copyWith(
        service: service,
        providerId: keeps ? state.providerId : null,
      ),
    );
  }

  /// Who to wait for: one person, or whoever is free first for null.
  void chooseProvider(String? providerId) =>
      emit(state.copyWith(providerId: providerId));

  void review() {
    if (!state.canJoin) return;
    emit(state.copyWith(step: QueueStep.confirm, failure: null));
  }

  void back() => emit(state.copyWith(step: QueueStep.overview, failure: null));

  /// Opens the payment for a place, and waits for the webhook to give it.
  Future<void> payAndJoin() async {
    final service = state.service;
    if (service == null || state.isBusy) return;

    emit(state.copyWith(isBusy: true, failure: null));

    final join = state.join ?? await _join(service.id);
    if (isClosed || join == null) return;

    emit(state.copyWith(join: join, step: QueueStep.paying));

    final outcome = await _payments.pay(
      clientSecret: join.clientSecret,
      merchantName: state.shop?.name ?? 'BookNow',
    );
    if (isClosed) return;

    switch (outcome) {
      case PaymentOutcome.paid:
        await _awaitPlace();
      case PaymentOutcome.cancelled:
        // The pending place stands until its ten minutes are up, so the
        // summary is where the customer lands.
        emit(state.copyWith(isBusy: false, step: QueueStep.confirm));
      case PaymentOutcome.failed:
        emit(state.copyWith(isBusy: false, step: QueueStep.declined));
    }
  }

  Future<QueueJoin?> _join(String serviceId) async {
    final result = await _queue.join(
      shopId: state.shopId,
      serviceId: serviceId,
      providerId: state.providerId,
    );

    switch (result) {
      case Success<QueueJoin>(:final data):
        return data;
      case Failure<QueueJoin>(:final error):
        emit(state.copyWith(isBusy: false, failure: error));
        // The queue filled up or paused while the customer read the summary:
        // the overview, freshly read, says which.
        if (error.code == ApiErrorCode.queueNotAccepting) {
          emit(state.copyWith(step: QueueStep.overview));
          await refresh();
        }
        return null;
    }
  }

  /// Reads the queue until the webhook has put the customer in line.
  Future<void> _awaitPlace() async {
    final deadline = DateTime.now().add(_placeTimeout);

    while (DateTime.now().isBefore(deadline)) {
      await refresh();
      if (isClosed) return;
      if (state.queue?.myEntry != null) {
        emit(state.copyWith(isBusy: false, step: QueueStep.inLine, join: null));
        return;
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      if (isClosed) return;
    }

    // Paid, but the place has not shown up yet. The webhook either places the
    // customer or refunds them and says so in a push; the line view keeps
    // reading in the meantime.
    emit(
      state.copyWith(
        isBusy: false,
        step: QueueStep.inLine,
        entry: state.join?.entry,
        join: null,
      ),
    );
  }

  /// After a decline: the pending place stands, so this re-opens its payment.
  Future<void> retry() async {
    emit(state.copyWith(step: QueueStep.confirm));
    await payAndJoin();
  }

  /// Leaves the line. The server decides the refund, and says so.
  Future<void> leave() async {
    final entry = state.entry;
    if (entry == null || state.isBusy) return;

    emit(state.copyWith(isBusy: true, failure: null));
    final result = await _queue.leave(entry.id);
    if (isClosed) return;

    switch (result) {
      case Success<QueueEntry>(:final data):
        emit(
          state.copyWith(
            isBusy: false,
            step: QueueStep.ended,
            entry: data,
            leftRefunded: data.refunded,
          ),
        );
      case Failure<QueueEntry>(:final error):
        emit(state.copyWith(isBusy: false, failure: error));
        // Already in the chair or gone: the line, read again, shows where.
        if (error.code == ApiErrorCode.entryNotLeavable) await refresh();
    }
  }

  void _tick() {
    _seconds += 1;
    emit(state.copyWith(now: DateTime.now().toUtc()));

    final watching =
        state.step == QueueStep.overview || state.step == QueueStep.inLine;
    if (watching && !state.isBusy && _seconds % _refreshEverySeconds == 0) {
      unawaited(refresh());
    }
  }

  @override
  Future<void> close() {
    _ticker.cancel();
    return super.close();
  }
}

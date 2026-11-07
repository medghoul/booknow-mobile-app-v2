import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What the owner's queue screen is showing.
class OwnerQueueState {
  const OwnerQueueState({
    required this.now,
    this.queue,
    this.services = const [],
    this.isLoading = true,
    this.busy = false,
    this.failure,
  });

  final OwnerQueue? queue;

  /// The shop's active services, for the walk-in sheet.
  final List<ShopService> services;
  final bool isLoading;

  /// A button is waiting on the server; the others wait with it.
  final bool busy;

  /// Drives the "ha ancora 7 min" countdown on the called customer.
  final DateTime now;
  final NetworkException? failure;

  OwnerQueueState copyWith({
    OwnerQueue? queue,
    List<ShopService>? services,
    bool? isLoading,
    bool? busy,
    DateTime? now,
    NetworkException? failure,
    bool clearFailure = false,
  }) => OwnerQueueState(
    queue: queue ?? this.queue,
    services: services ?? this.services,
    isLoading: isLoading ?? this.isLoading,
    busy: busy ?? this.busy,
    now: now ?? this.now,
    failure: clearFailure ? null : (failure ?? this.failure),
  );
}

/// Runs today's queue from the owner's side (queue spec §5).
///
/// Every button answers with the whole line as it now stands, so the screen
/// never patches the list itself: what it shows is always the server's.
class OwnerQueueCubit extends Cubit<OwnerQueueState> {
  OwnerQueueCubit(this._queue, this._shops)
    : super(OwnerQueueState(now: DateTime.now().toUtc())) {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  final QueueRepository _queue;
  final ShopRepository _shops;
  late final Timer _ticker;
  int _seconds = 0;

  /// Joins and leaves come from customers' phones; the owner sees them on the
  /// next read (queue spec §14: polling, no socket).
  static const int _refreshEverySeconds = 20;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearFailure: true));

    final (queue, shop) = await (_queue.ownerQueue(), _shops.getMyShop()).wait;
    if (isClosed) return;

    final services = switch (shop) {
      Success<Shop?>(:final data) => data?.activeServices,
      Failure<Shop?>() => null,
    };

    switch (queue) {
      case Success<OwnerQueue>(:final data):
        emit(state.copyWith(queue: data, services: services, isLoading: false));
      case Failure<OwnerQueue>(:final error):
        emit(
          state.copyWith(services: services, isLoading: false, failure: error),
        );
    }
  }

  Future<void> refresh() async {
    final result = await _queue.ownerQueue();
    if (isClosed) return;
    if (result case Success<OwnerQueue>(:final data)) {
      emit(state.copyWith(queue: data));
    }
  }

  /// Calls the next person for [providerId], or for the shop's one chair.
  Future<void> callNext({String? providerId}) =>
      _act(() => _queue.callNext(providerId: providerId));

  Future<void> pause() => _act(() => _queue.setState(QueueState.paused));

  Future<void> resume() => _act(() => _queue.setState(QueueState.open));

  Future<void> closeForToday() =>
      _act(() => _queue.setState(QueueState.closed));

  Future<void> start(String entryId) => _act(() => _queue.start(entryId));

  Future<void> done(String entryId) => _act(() => _queue.done(entryId));

  Future<void> noShow(String entryId) => _act(() => _queue.noShow(entryId));

  Future<void> remove(String entryId) => _act(() => _queue.remove(entryId));

  Future<void> addWalkIn({String? serviceId, String? name}) =>
      _act(() => _queue.addWalkIn(serviceId: serviceId, name: name));

  Future<void> _act(Future<ApiResult<OwnerQueue>> Function() action) async {
    if (state.busy) return;
    emit(state.copyWith(busy: true, clearFailure: true));

    final result = await action();
    if (isClosed) return;

    switch (result) {
      case Success<OwnerQueue>(:final data):
        emit(state.copyWith(queue: data, busy: false));
      case Failure<OwnerQueue>(:final error):
        emit(state.copyWith(busy: false, failure: error));
        // The line moved under the owner — somebody left, or was already
        // called. Reading it again shows where things stand.
        await refresh();
    }
  }

  void _tick() {
    _seconds += 1;
    emit(state.copyWith(now: DateTime.now().toUtc()));
    if (!state.busy && _seconds % _refreshEverySeconds == 0) {
      unawaited(refresh());
    }
  }

  @override
  Future<void> close() {
    _ticker.cancel();
    return super.close();
  }
}

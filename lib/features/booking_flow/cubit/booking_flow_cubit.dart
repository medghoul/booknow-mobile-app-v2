import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pick a time, pay for it, and wait for the server to say it is confirmed.
///
/// The app never writes `confirmed` itself: paying tells Stripe, Stripe tells
/// the webhook, and the webhook is what moves the booking. So the last step of
/// a successful payment is to read the booking back until the server agrees —
/// which is also what makes the rare failure visible instead of silently
/// showing a success screen for a booking that never landed.
class BookingFlowCubit extends Cubit<BookingFlowState> {
  BookingFlowCubit({
    required BookingRepository bookings,
    required ShopDirectoryRepository shops,
    required PaymentService payments,
    required String shopId,
    String? serviceId,
    DateTime? start,
    String? initialDate,
  }) : _bookings = bookings,
       _shops = shops,
       _payments = payments,
       _wantedServiceId = serviceId,
       super(
         BookingFlowState(
           shopId: shopId,
           // Opens on the day of the slot that got the customer here, or on
           // today when they came in from a shop card.
           date:
               initialDate ??
               ShopClock.dateOf(start ?? DateTime.now(), _defaultZone),
           start: start,
           now: DateTime.now().toUtc(),
         ),
       ) {
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) => emit(state.copyWith(now: DateTime.now().toUtc())),
    );
  }

  static const String _defaultZone = 'Europe/Rome';

  final BookingRepository _bookings;
  final ShopDirectoryRepository _shops;
  final PaymentService _payments;
  final String? _wantedServiceId;

  late final Timer _ticker;

  /// How long the app waits for the webhook before it stops asking (§8.3).
  ///
  /// Generous, because the alternative is telling somebody who has just been
  /// charged that nothing happened. When it does run out the booking is still
  /// in their list, where it turns confirmed on its own.
  static const Duration _confirmTimeout = Duration(seconds: 20);

  /// Loads the shop, picks the service, and reads the day's free times.
  Future<void> start() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final shop = await _shops.byId(state.shopId);
    if (isClosed) return;

    switch (shop) {
      case Failure<Shop>(:final error):
        emit(state.copyWith(isLoading: false, failure: error));
        return;
      case Success<Shop>(:final data):
        emit(
          state.copyWith(
            shop: data,
            service: _chooseService(data),
            isLoading: false,
          ),
        );
    }

    await loadDay(state.date);
  }

  /// The service the flow is for: the one the slot carried, or the shop's
  /// cheapest when there is only one to have.
  ShopService? _chooseService(Shop shop) {
    final active = shop.services.where((service) => service.isActive).toList();
    if (active.isEmpty) return null;

    for (final service in active) {
      if (service.id == _wantedServiceId) return service;
    }

    return active.first;
  }

  /// Reads one day's start times for the chosen service.
  Future<void> loadDay(String date) async {
    final service = state.service;
    if (service == null) {
      emit(state.copyWith(date: date, availability: null));
      return;
    }

    emit(state.copyWith(date: date, isLoading: true, failure: null));

    final result = await _bookings.availability(
      shopId: state.shopId,
      serviceId: service.id,
      date: date,
      providerId: state.providerId,
    );
    if (isClosed) return;

    switch (result) {
      case Success<Availability>(:final data):
        emit(
          state.copyWith(
            availability: data,
            isLoading: false,
            // A time chosen on another day, or one that has just been taken,
            // cannot stay selected.
            start: data.starts.contains(state.start) ? state.start : null,
          ),
        );
      case Failure<Availability>(:final error):
        emit(state.copyWith(isLoading: false, failure: error));
    }
  }

  /// Switches service, which changes which times fit (§6.3).
  Future<void> chooseService(ShopService service) async {
    emit(
      state.copyWith(
        service: service,
        start: null,
        // Someone who does not do the new service cannot stay chosen.
        providerId: _keeps(state.providerId, service) ? state.providerId : null,
      ),
    );
    await loadDay(state.date);
  }

  /// Switches who the times are for: one person, or anyone for null.
  Future<void> chooseProvider(String? providerId) async {
    if (providerId == state.providerId) return;
    emit(state.copyWith(providerId: providerId, start: null));
    await loadDay(state.date);
  }

  bool _keeps(String? providerId, ShopService service) =>
      providerId != null &&
      (state.shop?.providersFor(service.id).any((p) => p.id == providerId) ??
          false);

  void chooseStart(DateTime start) => emit(state.copyWith(start: start));

  void review() {
    if (state.start == null) return;
    emit(state.copyWith(step: BookingStep.confirm, failure: null));
  }

  void backToSlots() =>
      emit(state.copyWith(step: BookingStep.slot, failure: null));

  /// Holds the slot, opens the Payment Sheet, and waits for confirmation.
  ///
  /// The hold comes first and is the server's answer to "is this time still
  /// yours" — a `409` here is an ordinary outcome, not an error state, and it
  /// sends the customer back to a freshly read list of times.
  Future<void> payAndConfirm() async {
    final service = state.service;
    final start = state.start;
    if (service == null || start == null || state.isBusy) return;

    emit(state.copyWith(isBusy: true, failure: null));

    final held = state.hold ?? await _hold(service.id, start);
    if (isClosed) return;
    if (held == null) return;

    emit(state.copyWith(hold: held, step: BookingStep.paying));

    // Nothing to charge: the shop takes this booking for free, so there is no
    // sheet to open and only the confirmation left to wait for.
    if (held.clientSecret.isEmpty) {
      await _awaitConfirmation(held.booking.id);
      return;
    }

    final outcome = await _payments.pay(
      clientSecret: held.clientSecret,
      merchantName: state.shop?.name ?? 'BookNow',
    );
    if (isClosed) return;

    switch (outcome) {
      case PaymentOutcome.paid:
        await _awaitConfirmation(held.booking.id);
      case PaymentOutcome.cancelled:
        // The slot is still theirs until the hold runs out, so the summary is
        // where they land — not back at the times.
        emit(state.copyWith(isBusy: false, step: BookingStep.confirm));
      case PaymentOutcome.failed:
        emit(state.copyWith(isBusy: false, step: BookingStep.declined));
    }
  }

  Future<BookingHold?> _hold(String serviceId, DateTime start) async {
    final result = await _bookings.hold(
      shopId: state.shopId,
      serviceId: serviceId,
      startUtc: start,
      providerId: state.providerId,
    );

    switch (result) {
      case Success<BookingHold>(:final data):
        return data;
      case Failure<BookingHold>(:final error):
        emit(state.copyWith(isBusy: false, failure: error));
        // Somebody else paid for this minute first, so the times on screen
        // are already out of date.
        if (error.code == ApiErrorCode.slotTaken) {
          await loadDay(state.date);
          emit(state.copyWith(step: BookingStep.slot, start: null));
        }
        return null;
    }
  }

  /// Reads the booking back until the webhook has confirmed it (§8.3).
  Future<void> _awaitConfirmation(String bookingId) async {
    final deadline = DateTime.now().add(_confirmTimeout);

    while (DateTime.now().isBefore(deadline)) {
      final result = await _bookings.byId(bookingId);
      if (isClosed) return;

      if (result case Success<Booking>(:final data)) {
        if (data.status == BookingStatus.confirmed) {
          emit(
            state.copyWith(
              booking: data,
              isBusy: false,
              step: BookingStep.done,
            ),
          );
          return;
        }
      }

      await Future<void>.delayed(const Duration(seconds: 1));
      if (isClosed) return;
    }

    // Paid, but the confirmation has not arrived. Not a failure to show as
    // one: the money is taken and the booking is in their list, where it turns
    // confirmed by itself. The done screen says so.
    emit(
      state.copyWith(
        isBusy: false,
        step: BookingStep.done,
        booking: state.hold?.booking,
      ),
    );
  }

  /// After a decline: the slot is still held, so this re-opens the same sheet.
  Future<void> retry() async {
    emit(state.copyWith(step: BookingStep.confirm));
    await payAndConfirm();
  }

  @override
  Future<void> close() {
    _ticker.cancel();
    return super.close();
  }
}

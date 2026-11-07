import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The customer's two lists, and the one write they can make from them.
class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(this._repository)
    : super(BookingsState(now: DateTime.now().toUtc())) {
    // A pending booking's countdown and a confirmed one's free-cancellation
    // deadline both pass while the list is open, so the screen is wrong a
    // minute after it is drawn unless something moves it.
    _ticker = Timer.periodic(
      const Duration(seconds: 30),
      (_) => emit(state.copyWith(now: DateTime.now().toUtc())),
    );
  }

  final BookingRepository _repository;
  late final Timer _ticker;

  /// Loads one tab. Both are loaded on open, so the badge on "Prossime" is
  /// right before the tab is ever tapped.
  Future<void> load({BookingScope? scope, bool refresh = false}) async {
    final wanted = scope ?? state.scope;
    if (!refresh) emit(state.copyWith(isLoading: true, failure: null));

    final result = await _repository.list(wanted);
    if (isClosed) return;

    switch (result) {
      case Success<List<Booking>>(:final data):
        emit(
          state.copyWith(
            scope: wanted,
            upcoming: wanted == BookingScope.upcoming ? data : state.upcoming,
            past: wanted == BookingScope.past ? data : state.past,
            isLoading: false,
            now: DateTime.now().toUtc(),
            failure: null,
          ),
        );
      case Failure<List<Booking>>(:final error):
        emit(state.copyWith(isLoading: false, failure: error));
    }
  }

  /// Reads both lists at once, for the screen that shows them together.
  ///
  /// As one state change, so neither list says "nothing here" while the other
  /// has already answered and it is still on its way.
  Future<void> loadAll({bool refresh = false}) async {
    if (!refresh) emit(state.copyWith(isLoading: true, failure: null));

    final (upcoming, past) = await (
      _repository.list(BookingScope.upcoming),
      _repository.list(BookingScope.past),
    ).wait;
    if (isClosed) return;

    final failure = switch ((upcoming, past)) {
      (Failure<List<Booking>>(:final error), _) => error,
      (_, Failure<List<Booking>>(:final error)) => error,
      _ => null,
    };

    emit(
      state.copyWith(
        upcoming: upcoming is Success<List<Booking>>
            ? upcoming.data
            : state.upcoming,
        past: past is Success<List<Booking>> ? past.data : state.past,
        isLoading: false,
        now: DateTime.now().toUtc(),
        failure: failure,
      ),
    );
  }

  /// Switches tab, loading that list the first time it is asked for.
  Future<void> show(BookingScope scope) async {
    if (scope == state.scope) return;

    final loaded = scope == BookingScope.upcoming
        ? state.upcoming.isNotEmpty
        : state.past.isNotEmpty;

    emit(state.copyWith(scope: scope, failure: null));
    if (!loaded) await load(scope: scope);
  }

  /// Cancels, then re-reads both lists.
  ///
  /// Re-read rather than moving the booking across in memory: cancelling frees
  /// the slot, and the past list it lands in is grouped and ordered by the
  /// server. Returns the cancelled booking so the caller can say whether the
  /// fee came back.
  Future<Booking?> cancel(String bookingId) async {
    emit(state.copyWith(isCancelling: true, failure: null));

    final result = await _repository.cancel(bookingId);
    if (isClosed) return null;

    switch (result) {
      case Success<Booking>(:final data):
        emit(state.copyWith(isCancelling: false));
        await load(scope: BookingScope.upcoming, refresh: true);
        await load(scope: BookingScope.past, refresh: true);
        return data;
      case Failure<Booking>(:final error):
        emit(state.copyWith(isCancelling: false, failure: error));
        return null;
    }
  }

  @override
  Future<void> close() {
    _ticker.cancel();
    return super.close();
  }
}

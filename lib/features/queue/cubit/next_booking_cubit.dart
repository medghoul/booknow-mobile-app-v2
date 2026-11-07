import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/booking.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The customer's next confirmed visit, for the bar above the tabs when they
/// are not in a line. Null when there is none.
///
/// A failed read keeps what is on screen.
class NextBookingCubit extends Cubit<Booking?> {
  NextBookingCubit(this._bookings) : super(null);

  final BookingRepository _bookings;
  Timer? _timer;

  static const Duration _every = Duration(minutes: 1);

  void watch() {
    _timer ??= Timer.periodic(_every, (_) => refresh());
    refresh();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    if (!isClosed) emit(null);
  }

  Future<void> refresh() async {
    final result = await _bookings.list(BookingScope.upcoming);
    if (isClosed) return;

    if (result case Success<List<Booking>>(:final data)) {
      final now = DateTime.now().toUtc();
      final next =
          data
              .where(
                (booking) =>
                    booking.status == BookingStatus.confirmed &&
                    booking.startUtc.isAfter(now),
              )
              .toList()
            ..sort((a, b) => a.startUtc.compareTo(b.startUtc));
      emit(next.firstOrNull);
    }
  }

  /// Cancels it. The returned booking says whether the fee came back; null
  /// means the cancel failed and the booking stands.
  Future<Booking?> cancel(String bookingId) async {
    final result = await _bookings.cancel(bookingId);
    if (isClosed) return null;

    if (result case Success<Booking>(:final data)) {
      unawaited(refresh());
      return data;
    }
    return null;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

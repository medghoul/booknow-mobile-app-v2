import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookings_state.freezed.dart';

@freezed
abstract class BookingsState with _$BookingsState {
  const factory BookingsState({
    @Default(BookingScope.upcoming) BookingScope scope,
    @Default(<Booking>[]) List<Booking> upcoming,
    @Default(<Booking>[]) List<Booking> past,
    @Default(true) bool isLoading,

    /// Set while a cancellation is in flight, so the sheet's button can wait
    /// rather than letting a second tap start a second cancel.
    @Default(false) bool isCancelling,

    /// The clock the list is drawn against — whether a hold has run out, and
    /// whether free cancellation is still open, both move on their own.
    required DateTime now,
    NetworkException? failure,
  }) = _BookingsState;

  const BookingsState._();

  /// Whichever list the chosen tab shows.
  List<Booking> get visible => scope == BookingScope.upcoming ? upcoming : past;

  /// The count on the "Prossime" pill, absent rather than zero when empty.
  int? get upcomingBadge => upcoming.isEmpty ? null : upcoming.length;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'booking.dart';

part 'booking_hold.freezed.dart';

/// A held slot and the payment that will confirm it (§8.3).
///
/// The amount is the server's: it is read back from the booking it created,
/// never sent. The app's only job with [clientSecret] is to hand it to the
/// Payment Sheet.
@freezed
abstract class BookingHold with _$BookingHold {
  const factory BookingHold({
    required Booking booking,
    required String clientSecret,
    required DateTime holdExpiresAt,
    required int feeCents,
  }) = _BookingHold;
}

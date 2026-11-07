import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/structures/enums/booking_status.dart';

part 'booking.freezed.dart';

/// One booking, as every customer screen reads it.
///
/// The same model on the home card, in both lists and on the detail screen:
/// the API returns one shape for all of them, so tapping the home card opens
/// the detail with what it already has rather than loading it again.
@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,
    required BookingStatus status,
    required DateTime startUtc,
    required DateTime endUtc,
    required int durationMinutes,
    required String timeZone,
    required String shopId,
    required String? shopName,
    required String? shopAddressLine,
    required String? shopPhone,
    required String serviceId,
    required String serviceName,
    required int priceCents,
    required int feeCents,

    /// Two hours before the start. Cancelling after it keeps the fee (§10.1).
    required DateTime freeCancellationUntilUtc,

    /// Only while the booking is waiting to be paid for.
    required DateTime? holdExpiresAt,
    required String? cardBrand,
    required String? cardLast4,
    required String? cancelledBy,
    required bool refunded,
  }) = _Booking;

  const Booking._();

  /// Whether the free-cancellation window is still open.
  ///
  /// Takes the clock as an argument rather than reading it: a card that says
  /// "free until 22:30" and a sheet that decides whether to promise a refund
  /// have to agree, and a widget that reads `DateTime.now()` itself cannot be
  /// tested against the minute either side of the boundary.
  bool refundableAt(DateTime now) => now.isBefore(freeCancellationUntilUtc);

  /// Whether the customer can still cancel at all (§10.1).
  bool cancellableAt(DateTime now) =>
      status == BookingStatus.confirmed && now.isBefore(startUtc);

  /// What is left of the payment window, or null when nothing is held.
  Duration? holdLeftAt(DateTime now) {
    final expiry = holdExpiresAt;
    if (status != BookingStatus.pendingPayment || expiry == null) return null;

    final left = expiry.difference(now);
    return left.isNegative ? Duration.zero : left;
  }
}

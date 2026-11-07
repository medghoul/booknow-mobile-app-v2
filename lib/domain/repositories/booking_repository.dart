import '../../core/error/api_result.dart';
import '../models/availability.dart';
import '../models/booking.dart';
import '../models/booking_hold.dart';

/// Which half of "Prenotazioni" to read.
enum BookingScope {
  upcoming('upcoming'),
  past('past');

  const BookingScope(this.wireName);

  final String wireName;
}

/// Everything a customer does with a booking.
///
/// Holding and confirming are deliberately two steps, because they are two
/// steps on the server: [hold] takes the time off the market and opens a
/// payment, Stripe's webhook confirms it, and [byId] is how the app finds out —
/// the app never writes `confirmed` itself.
abstract interface class BookingRepository {
  /// `GET /v1/shops/{shopId}/availability` — the times one service can start.
  ///
  /// With [providerId], that person's times; without, anyone's.
  Future<ApiResult<Availability>> availability({
    required String shopId,
    required String serviceId,
    required String date,
    String? providerId,
  });

  /// `POST /v1/bookings` — holds the slot and opens its payment.
  ///
  /// A `409 SLOT_TAKEN` is an expected outcome here, not an edge case:
  /// somebody else can always pay for the same minute first.
  Future<ApiResult<BookingHold>> hold({
    required String shopId,
    required String serviceId,
    required DateTime startUtc,

    /// Who to book; null lets the server pick whoever is free with the
    /// fewest bookings that day.
    String? providerId,
  });

  /// `GET /v1/me/bookings?scope=`.
  Future<ApiResult<List<Booking>>> list(BookingScope scope);

  /// `GET /v1/bookings/{id}` — also what the app polls after paying.
  Future<ApiResult<Booking>> byId(String bookingId);

  /// `POST /v1/bookings/{id}/cancel` — the returned booking says whether the
  /// fee came back.
  Future<ApiResult<Booking>> cancel(String bookingId);
}

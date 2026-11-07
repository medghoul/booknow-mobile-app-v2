import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';

/// The real booking endpoints.
class ApiBookingRepository implements BookingRepository {
  const ApiBookingRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<Availability>> availability({
    required String shopId,
    required String serviceId,
    required String date,
    String? providerId,
  }) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.shopAvailability(shopId),
      queryParameters: {
        'serviceId': serviceId,
        'date': date,
        'providerId': ?providerId,
      },
    );

    return result.parsed((json) => AvailabilityDto.fromJson(json).toDomain());
  }

  @override
  Future<ApiResult<BookingHold>> hold({
    required String shopId,
    required String serviceId,
    required DateTime startUtc,
    String? providerId,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.bookings,
      data: {
        'shopId': shopId,
        'serviceId': serviceId,
        'startUtc': startUtc.toUtc().toIso8601String(),
        'providerId': ?providerId,
      },
    );

    return result.fold(
      onSuccess: (body) {
        final hold = BookingHoldDto.fromJson(body).toDomain();
        // The slot is held either way — the server answered 201 — but without
        // a client secret there is nothing to pay with, and a held slot the
        // customer cannot pay for is worse news than a plain failure. The hold
        // lapses on its own ten minutes later.
        return hold == null
            ? ApiResult.failure(
                const UnexpectedError('hold response had no payment'),
              )
            : ApiResult.success(hold);
      },
      onFailure: ApiResult.failure,
    );
  }

  @override
  Future<ApiResult<List<Booking>>> list(BookingScope scope) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.myBookings,
      queryParameters: {'scope': scope.wireName},
    );

    return result.parsed((json) => BookingListDto.fromJson(json).toDomain());
  }

  @override
  Future<ApiResult<Booking>> byId(String bookingId) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.booking(bookingId),
    );

    return result.fold(
      onSuccess: (body) {
        final booking = BookingDto.fromJson(body).toDomain();
        return booking == null
            ? ApiResult.failure(
                const UnexpectedError('booking response had no start'),
              )
            : ApiResult.success(booking);
      },
      onFailure: ApiResult.failure,
    );
  }

  @override
  Future<ApiResult<Booking>> cancel(String bookingId) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.cancelBooking(bookingId),
    );

    return result.fold(
      onSuccess: (body) {
        final booking = BookingDto.fromJson(body).toDomain();
        // It is cancelled whatever the echo looks like, and the list is
        // re-read on the way out; an unreadable body only costs the screen its
        // refund verdict.
        return booking == null
            ? ApiResult.failure(
                const UnexpectedError('cancel response had no booking'),
              )
            : ApiResult.success(booking);
      },
      onFailure: ApiResult.failure,
    );
  }
}

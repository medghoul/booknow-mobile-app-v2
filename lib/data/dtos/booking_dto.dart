import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/booking.dart';
import 'package:booknow_mobile/domain/models/booking_hold.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_dto.freezed.dart';
part 'booking_dto.g.dart';

/// One booking, from `GET /v1/bookings/{id}`, both list endpoints and `/home`.
@freezed
abstract class BookingDto with _$BookingDto {
  const factory BookingDto({
    @JsonKey(name: 'bookingId') Object? bookingId,
    @JsonKey(name: 'status') Object? status,
    @JsonKey(name: 'startUtc') Object? startUtc,
    @JsonKey(name: 'endUtc') Object? endUtc,
    @JsonKey(name: 'durationMin') Object? durationMin,
    @JsonKey(name: 'timeZone') Object? timeZone,
    @JsonKey(name: 'shopId') Object? shopId,
    @JsonKey(name: 'shopName') Object? shopName,
    @JsonKey(name: 'shopAddressLine') Object? shopAddressLine,
    @JsonKey(name: 'shopPhone') Object? shopPhone,
    @JsonKey(name: 'serviceId') Object? serviceId,
    @JsonKey(name: 'serviceName') Object? serviceName,
    @JsonKey(name: 'providerName') Object? providerName,
    @JsonKey(name: 'priceCents') Object? priceCents,
    @JsonKey(name: 'feeAmountCents') Object? feeAmountCents,
    @JsonKey(name: 'freeCancellationUntilUtc') Object? freeCancellationUntilUtc,
    @JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,
    @JsonKey(name: 'cardBrand') Object? cardBrand,
    @JsonKey(name: 'cardLast4') Object? cardLast4,
    @JsonKey(name: 'cancelledBy') Object? cancelledBy,
    @JsonKey(name: 'refunded') Object? refunded,
  }) = _BookingDto;

  const BookingDto._();

  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);

  /// Null when the booking has no readable start, which nothing downstream
  /// could draw: every screen that shows one is built around when it is.
  Booking? toDomain() {
    final start = asInstantOrNull(startUtc);
    if (start == null) return null;

    final minutes = asInt(durationMin, 30);
    final end =
        asInstantOrNull(endUtc) ?? start.add(Duration(minutes: minutes));

    return Booking(
      id: asText(bookingId),
      status: BookingStatus.fromWire(asText(status)),
      startUtc: start,
      endUtc: end,
      durationMinutes: minutes,
      // An absent zone is a server that did not say, not permission to show
      // the customer their phone's idea of the time.
      timeZone: asText(timeZone, 'Europe/Rome'),
      shopId: asText(shopId),
      shopName: asTextOrNull(shopName),
      shopAddressLine: asTextOrNull(shopAddressLine),
      shopPhone: asTextOrNull(shopPhone),
      serviceId: asText(serviceId),
      serviceName: asText(serviceName),
      providerName: asTextOrNull(providerName),
      priceCents: asInt(priceCents),
      feeCents: asInt(feeAmountCents),
      // The deadline is the server's arithmetic; falling back to it here keeps
      // an older build from drawing a date it made up.
      freeCancellationUntilUtc:
          asInstantOrNull(freeCancellationUntilUtc) ??
          start.subtract(const Duration(hours: 2)),
      holdExpiresAt: asInstantOrNull(holdExpiresAt),
      cardBrand: asTextOrNull(cardBrand),
      cardLast4: asTextOrNull(cardLast4),
      cancelledBy: asTextOrNull(cancelledBy),
      refunded: asBool(refunded, fallback: false),
    );
  }
}

/// `GET /v1/me/bookings?scope=`.
@freezed
abstract class BookingListDto with _$BookingListDto {
  const factory BookingListDto({
    @JsonKey(name: 'scope') Object? scope,
    @JsonKey(name: 'bookings') List<dynamic>? bookings,
  }) = _BookingListDto;

  const BookingListDto._();

  factory BookingListDto.fromJson(Map<String, dynamic> json) =>
      _$BookingListDtoFromJson(json);

  /// Bookings the app can draw, in the order the server sent them.
  ///
  /// One unreadable row is dropped rather than failing the list: a customer
  /// with four bookings should see three of them, not an error page.
  List<Booking> toDomain() => readBookings(bookings);
}

/// `POST /v1/bookings` — the hold and the payment that confirms it.
@freezed
abstract class BookingHoldDto with _$BookingHoldDto {
  const factory BookingHoldDto({
    @JsonKey(name: 'booking') Map<String, dynamic>? booking,
    @JsonKey(name: 'clientSecret') Object? clientSecret,
    @JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,
    @JsonKey(name: 'feeAmountCents') Object? feeAmountCents,
  }) = _BookingHoldDto;

  const BookingHoldDto._();

  factory BookingHoldDto.fromJson(Map<String, dynamic> json) =>
      _$BookingHoldDtoFromJson(json);

  /// Null unless the hold is usable: without a booking or a client secret
  /// there is nothing to pay for and nothing to show.
  BookingHold? toDomain() {
    final held = booking == null
        ? null
        : BookingDto.fromJson(booking!).toDomain();
    final secret = asTextOrNull(clientSecret);
    if (held == null) return null;

    // A free booking has no payment behind it. Anything charged must have one:
    // a fee with no way to pay it is a booking that can never confirm.
    final fee = asInt(feeAmountCents, held.feeCents);
    if (secret == null && fee != 0) return null;

    return BookingHold(
      booking: held,
      clientSecret: secret ?? '',
      holdExpiresAt:
          asInstantOrNull(holdExpiresAt) ??
          held.holdExpiresAt ??
          DateTime.now().toUtc().add(const Duration(minutes: 10)),
      feeCents: asInt(feeAmountCents, held.feeCents),
    );
  }
}

/// Shared by the list endpoint and the home payload.
List<Booking> readBookings(List<dynamic>? json) => [
  for (final entry in json?.whereType<Map>() ?? const <Map>[])
    ?BookingDto.fromJson(Map<String, dynamic>.from(entry)).toDomain(),
];

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) => _BookingDto(
  bookingId: json['bookingId'],
  status: json['status'],
  startUtc: json['startUtc'],
  endUtc: json['endUtc'],
  durationMin: json['durationMin'],
  timeZone: json['timeZone'],
  shopId: json['shopId'],
  shopName: json['shopName'],
  shopAddressLine: json['shopAddressLine'],
  shopPhone: json['shopPhone'],
  serviceId: json['serviceId'],
  serviceName: json['serviceName'],
  providerName: json['providerName'],
  priceCents: json['priceCents'],
  feeAmountCents: json['feeAmountCents'],
  freeCancellationUntilUtc: json['freeCancellationUntilUtc'],
  holdExpiresAt: json['holdExpiresAt'],
  cardBrand: json['cardBrand'],
  cardLast4: json['cardLast4'],
  cancelledBy: json['cancelledBy'],
  refunded: json['refunded'],
);

Map<String, dynamic> _$BookingDtoToJson(_BookingDto instance) =>
    <String, dynamic>{
      'bookingId': ?instance.bookingId,
      'status': ?instance.status,
      'startUtc': ?instance.startUtc,
      'endUtc': ?instance.endUtc,
      'durationMin': ?instance.durationMin,
      'timeZone': ?instance.timeZone,
      'shopId': ?instance.shopId,
      'shopName': ?instance.shopName,
      'shopAddressLine': ?instance.shopAddressLine,
      'shopPhone': ?instance.shopPhone,
      'serviceId': ?instance.serviceId,
      'serviceName': ?instance.serviceName,
      'providerName': ?instance.providerName,
      'priceCents': ?instance.priceCents,
      'feeAmountCents': ?instance.feeAmountCents,
      'freeCancellationUntilUtc': ?instance.freeCancellationUntilUtc,
      'holdExpiresAt': ?instance.holdExpiresAt,
      'cardBrand': ?instance.cardBrand,
      'cardLast4': ?instance.cardLast4,
      'cancelledBy': ?instance.cancelledBy,
      'refunded': ?instance.refunded,
    };

_BookingListDto _$BookingListDtoFromJson(Map<String, dynamic> json) =>
    _BookingListDto(
      scope: json['scope'],
      bookings: json['bookings'] as List<dynamic>?,
    );

Map<String, dynamic> _$BookingListDtoToJson(_BookingListDto instance) =>
    <String, dynamic>{'scope': ?instance.scope, 'bookings': ?instance.bookings};

_BookingHoldDto _$BookingHoldDtoFromJson(Map<String, dynamic> json) =>
    _BookingHoldDto(
      booking: json['booking'] as Map<String, dynamic>?,
      clientSecret: json['clientSecret'],
      holdExpiresAt: json['holdExpiresAt'],
      feeAmountCents: json['feeAmountCents'],
    );

Map<String, dynamic> _$BookingHoldDtoToJson(_BookingHoldDto instance) =>
    <String, dynamic>{
      'booking': ?instance.booking,
      'clientSecret': ?instance.clientSecret,
      'holdExpiresAt': ?instance.holdExpiresAt,
      'feeAmountCents': ?instance.feeAmountCents,
    };

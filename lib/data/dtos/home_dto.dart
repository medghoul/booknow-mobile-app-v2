import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/data/dtos/booking_dto.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/customer_home.dart';
import 'package:booknow_mobile/domain/models/free_slot.dart';
import 'package:booknow_mobile/domain/models/shop_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_dto.freezed.dart';
part 'home_dto.g.dart';

/// `GET /v1/home?lat=&lng=`.
@freezed
abstract class HomeDto with _$HomeDto {
  const factory HomeDto({
    @JsonKey(name: 'nextBooking') Map<String, dynamic>? nextBooking,
    @JsonKey(name: 'freeToday') List<dynamic>? freeToday,
    @JsonKey(name: 'freeTodayTotal') Object? freeTodayTotal,
    @JsonKey(name: 'shopsNearby') List<dynamic>? shopsNearby,
  }) = _HomeDto;

  const HomeDto._();

  factory HomeDto.fromJson(Map<String, dynamic> json) =>
      _$HomeDtoFromJson(json);

  CustomerHome toDomain() {
    final slots = readFreeSlots(freeToday);

    return CustomerHome(
      nextBooking: nextBooking == null
          ? null
          : BookingDto.fromJson(nextBooking!).toDomain(),
      freeToday: slots,
      // An older server that does not send the total still has to produce a
      // "+n more" card that is not a lie, so the count falls back to what the
      // carousel actually holds.
      freeTodayTotal: asInt(freeTodayTotal, slots.length),
      shops: readShopSummaries(shopsNearby),
    );
  }
}

/// `GET /v1/shops?lat=&lng=&q=`.
@freezed
abstract class ShopDirectoryDto with _$ShopDirectoryDto {
  const factory ShopDirectoryDto({
    @JsonKey(name: 'shops') List<dynamic>? shops,
  }) = _ShopDirectoryDto;

  const ShopDirectoryDto._();

  factory ShopDirectoryDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDirectoryDtoFromJson(json);

  List<ShopSummary> toDomain() => readShopSummaries(shops);
}

/// One card in the "shops near you" carousel.
@freezed
abstract class ShopSummaryDto with _$ShopSummaryDto {
  const factory ShopSummaryDto({
    @JsonKey(name: 'shopId') Object? shopId,
    @JsonKey(name: 'name') Object? name,
    @JsonKey(name: 'address') Object? address,
    @JsonKey(name: 'city') Object? city,
    @JsonKey(name: 'distanceM') Object? distanceM,
    @JsonKey(name: 'openNow') Object? openNow,
    @JsonKey(name: 'closesAt') Object? closesAt,
    @JsonKey(name: 'opensAt') Object? opensAt,
    @JsonKey(name: 'servicesCount') Object? servicesCount,
    @JsonKey(name: 'fromPriceCents') Object? fromPriceCents,
    @JsonKey(name: 'photoUrl') Object? photoUrl,
    @JsonKey(name: 'mode') Object? mode,
    @JsonKey(name: 'category') Object? category,
  }) = _ShopSummaryDto;

  const ShopSummaryDto._();

  factory ShopSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$ShopSummaryDtoFromJson(json);

  /// Null without an id: a card nothing can open is worse than no card.
  ShopSummary? toDomain() {
    final id = asTextOrNull(shopId);
    if (id == null) return null;

    return ShopSummary(
      id: id,
      name: asTextOrNull(name),
      addressLine: asTextOrNull(address),
      city: asTextOrNull(city),
      distanceMeters: asDoubleOrNull(distanceM)?.round(),
      openNow: asBool(openNow, fallback: false),
      closesAt: asTextOrNull(closesAt),
      opensAt: asTextOrNull(opensAt),
      activeServices: asInt(servicesCount),
      fromPriceCents: asDoubleOrNull(fromPriceCents)?.round(),
      photoUrl: asTextOrNull(photoUrl),
      mode: ShopMode.fromWire(asTextOrNull(mode)),
      category: asTextOrNull(category),
    );
  }
}

/// One free time in the home carousel or on a shop page.
@freezed
abstract class FreeSlotDto with _$FreeSlotDto {
  const factory FreeSlotDto({
    @JsonKey(name: 'shopId') Object? shopId,
    @JsonKey(name: 'shopName') Object? shopName,
    @JsonKey(name: 'serviceId') Object? serviceId,
    @JsonKey(name: 'serviceName') Object? serviceName,
    @JsonKey(name: 'durationMin') Object? durationMin,
    @JsonKey(name: 'priceCents') Object? priceCents,
    @JsonKey(name: 'startUtc') Object? startUtc,
  }) = _FreeSlotDto;

  const FreeSlotDto._();

  factory FreeSlotDto.fromJson(Map<String, dynamic> json) =>
      _$FreeSlotDtoFromJson(json);

  /// Null without a start or a service: the card's whole purpose is to open
  /// the summary pre-filled, and it cannot do that with either missing.
  FreeSlot? toDomain() {
    final start = asInstantOrNull(startUtc);
    final service = asTextOrNull(serviceId);
    final shop = asTextOrNull(shopId);
    if (start == null || service == null || shop == null) return null;

    return FreeSlot(
      shopId: shop,
      shopName: asTextOrNull(shopName),
      serviceId: service,
      serviceName: asText(serviceName),
      durationMinutes: asInt(durationMin, 30),
      priceCents: asInt(priceCents),
      startUtc: start,
    );
  }
}

List<ShopSummary> readShopSummaries(List<dynamic>? json) => [
  for (final entry in json?.whereType<Map>() ?? const <Map>[])
    ?ShopSummaryDto.fromJson(Map<String, dynamic>.from(entry)).toDomain(),
];

List<FreeSlot> readFreeSlots(List<dynamic>? json) => [
  for (final entry in json?.whereType<Map>() ?? const <Map>[])
    ?FreeSlotDto.fromJson(Map<String, dynamic>.from(entry)).toDomain(),
];

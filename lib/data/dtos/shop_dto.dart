import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/opening_hours.dart';
import 'package:booknow_mobile/domain/models/shop.dart';
import 'package:booknow_mobile/domain/models/shop_address.dart';
import 'package:booknow_mobile/domain/models/shop_provider.dart';
import 'package:booknow_mobile/domain/models/shop_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_dto.freezed.dart';
part 'shop_dto.g.dart';

/// `GET /me/shop`, and the body every `/shops/me` write answers with.
///
/// The wire keeps the address and the coordinates in two separate objects;
/// the domain folds them into one [ShopAddress], which is the only reason
/// this layer exists rather than parsing straight into the model.
@freezed
abstract class ShopDto with _$ShopDto {
  const factory ShopDto({
    @JsonKey(name: 'shopId') Object? shopId,
    @JsonKey(name: 'id') Object? id,
    @JsonKey(name: 'status') Object? status,
    @JsonKey(name: 'name') Object? name,
    @JsonKey(name: 'phone') Object? phone,
    @JsonKey(name: 'photoUrl') Object? photoUrl,
    @JsonKey(name: 'address') AddressDto? address,
    @JsonKey(name: 'location') LocationDto? location,

    /// `{ "mon": [], "tue": [{ "from": "09:00", "to": "13:00" }] }` — read as
    /// a raw map because an unknown day key must be skipped, not throw.
    @JsonKey(name: 'openingHours') Map<String, dynamic>? openingHours,

    @JsonKey(name: 'closures') List<dynamic>? closures,
    @JsonKey(name: 'services') List<dynamic>? services,
    @JsonKey(name: 'providers') List<dynamic>? providers,
    @JsonKey(name: 'feeAmountCents') Object? feeAmountCents,
    @JsonKey(name: 'mode') Object? mode,
  }) = _ShopDto;

  factory ShopDto.fromJson(Map<String, dynamic> json) =>
      _$ShopDtoFromJson(json);
}

@freezed
abstract class AddressDto with _$AddressDto {
  const factory AddressDto({
    @JsonKey(name: 'line') Object? line,
    @JsonKey(name: 'city') Object? city,
    @JsonKey(name: 'zip') Object? zip,
    @JsonKey(name: 'country') Object? country,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);
}

@freezed
abstract class LocationDto with _$LocationDto {
  const factory LocationDto({
    @JsonKey(name: 'lat') Object? lat,
    @JsonKey(name: 'lng') Object? lng,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}

@freezed
abstract class ServiceDto with _$ServiceDto {
  const factory ServiceDto({
    @JsonKey(name: 'serviceId') Object? serviceId,
    @JsonKey(name: 'id') Object? id,
    @JsonKey(name: 'name') Object? name,
    @JsonKey(name: 'durationMin') Object? durationMin,
    @JsonKey(name: 'priceCents') Object? priceCents,
    @JsonKey(name: 'active') Object? active,
    @JsonKey(name: 'order') Object? order,
  }) = _ServiceDto;

  factory ServiceDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceDtoFromJson(json);
}

/// One provider: the owner's full row, or the customer page's short one.
@freezed
abstract class ProviderDto with _$ProviderDto {
  const factory ProviderDto({
    @JsonKey(name: 'providerId') Object? providerId,
    @JsonKey(name: 'name') Object? name,
    @JsonKey(name: 'type') Object? type,
    @JsonKey(name: 'serviceIds') List<dynamic>? serviceIds,
    @JsonKey(name: 'openingHours') Map<String, dynamic>? openingHours,
    @JsonKey(name: 'timeOff') List<dynamic>? timeOff,
    @JsonKey(name: 'active') Object? active,
    @JsonKey(name: 'order') Object? order,
  }) = _ProviderDto;

  factory ProviderDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderDtoFromJson(json);
}

extension ShopDtoX on ShopDto {
  Shop toDomain() => Shop(
    id: asText(shopId, asText(id)),
    // Never guessed: an unknown status is treated as a draft, so a newer API
    // can never make this build show an unpublished shop to customers.
    status: ShopStatus.fromWire(asTextOrNull(status)),
    name: asTextOrNull(name),
    phone: asTextOrNull(phone),
    photoUrl: asTextOrNull(photoUrl),
    address: address?.toDomain(location),
    openingHours: _openingHours(openingHours),
    closures: closures?.whereType<String>().toList() ?? const [],
    feeCents: asDoubleOrNull(feeAmountCents)?.round(),
    mode: ShopMode.fromWire(asTextOrNull(mode)),
    services:
        services
            ?.whereType<Map<String, dynamic>>()
            .map((json) => ServiceDto.fromJson(json).toDomain())
            .toList() ??
        const [],
    providers: providersFrom(providers),
  );
}

/// A provider list as any response carries it, by display order.
List<ShopProvider> providersFrom(List<dynamic>? json) {
  final providers =
      json
          ?.whereType<Map<String, dynamic>>()
          .map((json) => ProviderDto.fromJson(json).toDomain())
          .where((provider) => provider.id.isNotEmpty)
          .toList() ??
      <ShopProvider>[];
  return providers..sort((a, b) => a.order.compareTo(b.order));
}

extension ProviderDtoX on ProviderDto {
  ShopProvider toDomain() => ShopProvider(
    id: asText(providerId),
    name: asTextOrNull(name),
    type: ProviderType.fromWire(asTextOrNull(type)),
    // Null is a value here, "every service", not a missing field.
    serviceIds: serviceIds?.whereType<String>().toList(),
    // Likewise: null is "the shop's hours", where an empty map would be a
    // provider who never works.
    openingHours: openingHours == null ? null : _openingHours(openingHours),
    timeOff: timeOff?.whereType<String>().toList() ?? const [],
    isActive: asBool(active, fallback: true),
    order: asInt(order),
  );
}

extension AddressDtoX on AddressDto {
  ShopAddress toDomain([LocationDto? location]) => ShopAddress(
    line: asText(line),
    city: asText(city),
    zip: asText(zip),
    country: asText(country, 'IT'),
    latitude: asDoubleOrNull(location?.lat),
    longitude: asDoubleOrNull(location?.lng),
  );
}

extension ServiceDtoX on ServiceDto {
  ShopService toDomain() => ShopService(
    id: asText(serviceId, asText(id)),
    name: asText(name),
    durationMinutes: asInt(durationMin, 30),
    priceCents: asInt(priceCents),
    isActive: asBool(active, fallback: true),
    order: asInt(order),
  );
}

/// Days the app does not recognise are skipped rather than failing the whole
/// shop, and a range that reads backwards is dropped on the way in.
OpeningHours _openingHours(Map<String, dynamic>? json) {
  if (json == null) return const OpeningHours();

  final byDay = <Weekday, List<TimeRange>>{};
  for (final entry in json.entries) {
    final day = Weekday.fromWire(entry.key);
    if (day == null) continue;

    final ranges =
        (entry.value as List?)
            ?.whereType<Map>()
            .map(
              (range) => TimeRange(
                from: asText(range['from']),
                to: asText(range['to']),
              ),
            )
            .where((range) => range.isValid)
            .toList() ??
        const <TimeRange>[];

    if (ranges.isNotEmpty) byDay[day] = ranges;
  }
  return OpeningHours(byDay);
}

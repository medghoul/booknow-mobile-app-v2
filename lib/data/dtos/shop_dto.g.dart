// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopDto _$ShopDtoFromJson(Map<String, dynamic> json) => _ShopDto(
  shopId: json['shopId'],
  id: json['id'],
  status: json['status'],
  name: json['name'],
  phone: json['phone'],
  photoUrl: json['photoUrl'],
  address: json['address'] == null
      ? null
      : AddressDto.fromJson(json['address'] as Map<String, dynamic>),
  location: json['location'] == null
      ? null
      : LocationDto.fromJson(json['location'] as Map<String, dynamic>),
  openingHours: json['openingHours'] as Map<String, dynamic>?,
  closures: json['closures'] as List<dynamic>?,
  services: json['services'] as List<dynamic>?,
  feeAmountCents: json['feeAmountCents'],
  mode: json['mode'],
);

Map<String, dynamic> _$ShopDtoToJson(_ShopDto instance) => <String, dynamic>{
  'shopId': ?instance.shopId,
  'id': ?instance.id,
  'status': ?instance.status,
  'name': ?instance.name,
  'phone': ?instance.phone,
  'photoUrl': ?instance.photoUrl,
  'address': ?instance.address?.toJson(),
  'location': ?instance.location?.toJson(),
  'openingHours': ?instance.openingHours,
  'closures': ?instance.closures,
  'services': ?instance.services,
  'feeAmountCents': ?instance.feeAmountCents,
  'mode': ?instance.mode,
};

_AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => _AddressDto(
  line: json['line'],
  city: json['city'],
  zip: json['zip'],
  country: json['country'],
);

Map<String, dynamic> _$AddressDtoToJson(_AddressDto instance) =>
    <String, dynamic>{
      'line': ?instance.line,
      'city': ?instance.city,
      'zip': ?instance.zip,
      'country': ?instance.country,
    };

_LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) =>
    _LocationDto(lat: json['lat'], lng: json['lng']);

Map<String, dynamic> _$LocationDtoToJson(_LocationDto instance) =>
    <String, dynamic>{'lat': ?instance.lat, 'lng': ?instance.lng};

_ServiceDto _$ServiceDtoFromJson(Map<String, dynamic> json) => _ServiceDto(
  serviceId: json['serviceId'],
  id: json['id'],
  name: json['name'],
  durationMin: json['durationMin'],
  priceCents: json['priceCents'],
  active: json['active'],
  order: json['order'],
);

Map<String, dynamic> _$ServiceDtoToJson(_ServiceDto instance) =>
    <String, dynamic>{
      'serviceId': ?instance.serviceId,
      'id': ?instance.id,
      'name': ?instance.name,
      'durationMin': ?instance.durationMin,
      'priceCents': ?instance.priceCents,
      'active': ?instance.active,
      'order': ?instance.order,
    };

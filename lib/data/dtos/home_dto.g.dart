// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeDto _$HomeDtoFromJson(Map<String, dynamic> json) => _HomeDto(
  nextBooking: json['nextBooking'] as Map<String, dynamic>?,
  freeToday: json['freeToday'] as List<dynamic>?,
  freeTodayTotal: json['freeTodayTotal'],
  shopsNearby: json['shopsNearby'] as List<dynamic>?,
);

Map<String, dynamic> _$HomeDtoToJson(_HomeDto instance) => <String, dynamic>{
  'nextBooking': ?instance.nextBooking,
  'freeToday': ?instance.freeToday,
  'freeTodayTotal': ?instance.freeTodayTotal,
  'shopsNearby': ?instance.shopsNearby,
};

_ShopDirectoryDto _$ShopDirectoryDtoFromJson(Map<String, dynamic> json) =>
    _ShopDirectoryDto(shops: json['shops'] as List<dynamic>?);

Map<String, dynamic> _$ShopDirectoryDtoToJson(_ShopDirectoryDto instance) =>
    <String, dynamic>{'shops': ?instance.shops};

_ShopSummaryDto _$ShopSummaryDtoFromJson(Map<String, dynamic> json) =>
    _ShopSummaryDto(
      shopId: json['shopId'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      distanceM: json['distanceM'],
      openNow: json['openNow'],
      closesAt: json['closesAt'],
      opensAt: json['opensAt'],
      servicesCount: json['servicesCount'],
      fromPriceCents: json['fromPriceCents'],
      photoUrl: json['photoUrl'],
      mode: json['mode'],
      category: json['category'],
    );

Map<String, dynamic> _$ShopSummaryDtoToJson(_ShopSummaryDto instance) =>
    <String, dynamic>{
      'shopId': ?instance.shopId,
      'name': ?instance.name,
      'address': ?instance.address,
      'city': ?instance.city,
      'distanceM': ?instance.distanceM,
      'openNow': ?instance.openNow,
      'closesAt': ?instance.closesAt,
      'opensAt': ?instance.opensAt,
      'servicesCount': ?instance.servicesCount,
      'fromPriceCents': ?instance.fromPriceCents,
      'photoUrl': ?instance.photoUrl,
      'mode': ?instance.mode,
      'category': ?instance.category,
    };

_FreeSlotDto _$FreeSlotDtoFromJson(Map<String, dynamic> json) => _FreeSlotDto(
  shopId: json['shopId'],
  shopName: json['shopName'],
  serviceId: json['serviceId'],
  serviceName: json['serviceName'],
  durationMin: json['durationMin'],
  priceCents: json['priceCents'],
  startUtc: json['startUtc'],
);

Map<String, dynamic> _$FreeSlotDtoToJson(_FreeSlotDto instance) =>
    <String, dynamic>{
      'shopId': ?instance.shopId,
      'shopName': ?instance.shopName,
      'serviceId': ?instance.serviceId,
      'serviceName': ?instance.serviceName,
      'durationMin': ?instance.durationMin,
      'priceCents': ?instance.priceCents,
      'startUtc': ?instance.startUtc,
    };

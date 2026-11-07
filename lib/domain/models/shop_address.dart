import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_address.freezed.dart';

/// A geocoded address.
///
/// The coordinates are set by the API from Amazon Location, never typed and
/// never sent by the app — the owner picks a suggestion, the server resolves
/// it. That is why there is no constructor taking a free-text address.
@freezed
abstract class ShopAddress with _$ShopAddress {
  const factory ShopAddress({
    required String line,
    required String city,
    required String zip,
    required String country,
    double? latitude,
    double? longitude,
  }) = _ShopAddress;

  const ShopAddress._();

  bool get isGeocoded => latitude != null && longitude != null;

  /// One line, as the shop card and the review step show it.
  String get formatted =>
      [line, zip, city].where((p) => p.isNotEmpty).join(', ');
}

/// One result from `GET /places/autocomplete`.
///
/// [placeId] is the only part the app sends back: `PATCH /shops/me` takes the
/// id and the server calls `GetPlace` to store the address and coordinates.
@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory PlaceSuggestion({
    required String placeId,
    required String label,
    String? secondaryLabel,
  }) = _PlaceSuggestion;
}

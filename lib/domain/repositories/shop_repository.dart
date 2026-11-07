import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/domain/models/index.dart';

/// The owner's shop and its services.
///
/// Every wizard step saves immediately through one of these calls, which is
/// what makes the wizard resumable: there is no "unsaved draft" living only in
/// the app.
abstract interface class ShopRepository {
  /// `GET /me/shop` — null when the owner has no shop yet.
  ///
  /// The API answers 404 in that case, which this maps to a successful null
  /// rather than a failure: an owner who has just picked their role and has no
  /// shop is in a normal state, not a broken one.
  Future<ApiResult<Shop?>> getMyShop();

  /// `POST /shops` — creates the empty draft. 409 if the owner already has
  /// one, which in v0 is a hard limit of one shop per owner.
  Future<ApiResult<Shop>> createShop();

  /// `PATCH /shops/me` — saves a wizard step.
  ///
  /// [placeId] comes from an autocomplete suggestion; the server resolves it
  /// through Amazon Location and stores the address and coordinates. The app
  /// never sends coordinates, which is why there is no address parameter here
  /// beyond the id.
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    String? placeId,
    OpeningHours? openingHours,
    List<String>? closures,
  });

  Future<ApiResult<ShopService>> addService({
    required String name,
    required int durationMinutes,
    required int priceCents,
  });

  Future<ApiResult<ShopService>> updateService(
    String serviceId, {
    String? name,
    int? durationMinutes,
    int? priceCents,
  });

  /// Soft delete — the service stays resolvable for bookings that reference
  /// it. Rejected with 422 if it is the last active service of a published
  /// shop.
  Future<ApiResult<void>> deleteService(String serviceId);

  /// `POST /shops/me/providers` — someone new working in the shop.
  ///
  /// Null [serviceIds] is every service, including ones added later; null
  /// [openingHours] is the shop's hours.
  Future<ApiResult<ShopProvider>> addProvider({
    required String name,
    required ProviderType type,
    required List<String>? serviceIds,
    required OpeningHours? openingHours,
    required List<String> timeOff,
  });

  /// `PATCH /shops/me/providers/{id}`.
  ///
  /// [name] and [type] go only when given. The other three always go, because
  /// null is a value for both of the first two: every service, the shop's
  /// hours. Taking a service away is refused with `PROVIDER_IN_USE` while a
  /// customer still needs it from them.
  Future<ApiResult<ShopProvider>> updateProvider(
    String providerId, {
    String? name,
    ProviderType? type,
    required List<String>? serviceIds,
    required OpeningHours? openingHours,
    required List<String> timeOff,
  });

  /// `DELETE /shops/me/providers/{id}` — a soft delete, so past bookings keep
  /// their name. Refused for the owner's own provider, and while customers
  /// are booked with them or waiting for them.
  Future<ApiResult<void>> removeProvider(String providerId);

  /// Brings back a removed provider, under the same limit as adding one.
  Future<ApiResult<ShopProvider>> restoreProvider(String providerId);

  /// `POST /shops/me/publish` — validates and flips the shop to `active`.
  ///
  /// A 422 carries the list of missing fields; the cubit turns that into the
  /// step to jump back to.
  Future<ApiResult<Shop>> publish();

  /// `GET /places/autocomplete?q=` — Italian addresses only, resolved
  /// server-side so no Location credentials ever reach the app.
  /// Uploads a photo and returns the shop that now carries it.
  ///
  /// Three steps behind one call — ask for a presigned URL, PUT the bytes
  /// straight to storage, then claim the key — because the caller has no
  /// reason to know that the bytes never pass through the API.
  Future<ApiResult<Shop>> uploadPhoto({
    required String filePath,
    required String contentType,
  });

  /// Drops the shop's photo. The object is left in storage; nothing points at
  /// it any more, which is what the owner asked for.
  Future<ApiResult<Shop>> removePhoto();

  Future<ApiResult<List<PlaceSuggestion>>> searchAddresses(String query);
}

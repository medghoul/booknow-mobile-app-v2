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

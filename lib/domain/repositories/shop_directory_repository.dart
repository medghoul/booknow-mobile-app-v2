import '../../core/error/api_result.dart';
import '../models/shop.dart';
import '../models/shop_summary.dart';

/// The shops a customer can see.
///
/// Separate from `ShopRepository`, which is the owner's wizard: these endpoints
/// only ever return published shops, and nothing here can write.
abstract interface class ShopDirectoryRepository {
  /// `GET /v1/shops?lat=&lng=&q=` — nearest first, or by name without a
  /// location.
  Future<ApiResult<List<ShopSummary>>> search({
    double? lat,
    double? lng,
    String? query,
  });

  /// `GET /v1/shops/{shopId}` — the shop page, with its active services.
  Future<ApiResult<Shop>> byId(String shopId);
}

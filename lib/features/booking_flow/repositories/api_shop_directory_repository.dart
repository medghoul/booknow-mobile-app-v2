import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';

/// The customer-facing shop reads.
class ApiShopDirectoryRepository implements ShopDirectoryRepository {
  const ApiShopDirectoryRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<List<ShopSummary>>> search({
    double? lat,
    double? lng,
    String? query,
  }) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.shops,
      queryParameters: {
        if (lat != null && lng != null) ...{'lat': lat, 'lng': lng},
        'q': ?query,
      },
    );

    return result.parsed((json) => ShopDirectoryDto.fromJson(json).toDomain());
  }

  @override
  Future<ApiResult<Shop>> byId(String shopId) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.shop(shopId),
    );

    return result.parsed((json) => ShopDto.fromJson(json).toDomain());
  }
}

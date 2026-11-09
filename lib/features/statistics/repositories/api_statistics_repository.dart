import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';

/// The real statistics endpoint.
class ApiStatisticsRepository implements StatisticsRepository {
  const ApiStatisticsRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<ShopStatistics>> statistics({
    int? days,
    String? from,
    String? to,
    String? providerId,
    String? serviceId,
  }) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.myShopStatistics,
      queryParameters: {
        'days': ?days,
        'from': ?from,
        'to': ?to,
        'providerId': ?providerId,
        'serviceId': ?serviceId,
      },
    );
    return result.parsed(shopStatisticsFromJson);
  }
}

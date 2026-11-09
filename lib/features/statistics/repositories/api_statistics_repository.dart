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

  @override
  Future<ApiResult<StaffStatistics>> staff(
    String providerId, {
    int? days,
    String? from,
    String? to,
  }) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.staffStatistics(providerId),
      queryParameters: {'days': ?days, 'from': ?from, 'to': ?to},
    );
    return result.parsed(staffStatisticsFromJson);
  }

  @override
  Future<ApiResult<List<DurationSuggestion>>> suggestions() async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.statisticsSuggestions,
    );
    return result.parsed(suggestionsFromJson);
  }

  @override
  Future<ApiResult<List<DurationSuggestion>>> acceptSuggestion(
    String serviceId,
  ) => _decide(serviceId, 'accept');

  @override
  Future<ApiResult<List<DurationSuggestion>>> dismissSuggestion(
    String serviceId,
  ) => _decide(serviceId, 'dismiss');

  Future<ApiResult<List<DurationSuggestion>>> _decide(
    String serviceId,
    String action,
  ) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.statisticsSuggestion(serviceId, action),
    );
    return result.parsed(suggestionsFromJson);
  }

  @override
  Future<ApiResult<ReviewList>> reviewItems() async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.statisticsReview,
    );
    return result.parsed(reviewListFromJson);
  }

  @override
  Future<ApiResult<void>> correctVisit(
    ReviewItem item, {
    DateTime? startedAt,
    DateTime? finishedAt,
  }) => _client.post<void>(
    ApiEndpoints.statisticsReviewVisit(item.visitId),
    data: {
      'localDate': item.localDate,
      'startedAt': ?startedAt?.toUtc().toIso8601String(),
      'finishedAt': ?finishedAt?.toUtc().toIso8601String(),
    },
  );

  @override
  Future<ApiResult<void>> dismissVisit(ReviewItem item) => _client.post<void>(
    ApiEndpoints.statisticsReviewVisit(item.visitId),
    data: {'localDate': item.localDate, 'dismiss': true},
  );
}

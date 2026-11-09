import '../../core/error/api_result.dart';
import '../models/statistics.dart';

/// What the owner reads about their own shop (statistics §6).
abstract interface class StatisticsRepository {
  /// Either [days] back from the shop's today, or [from] to [to], as
  /// `yyyy-MM-dd`.
  Future<ApiResult<ShopStatistics>> statistics({
    int? days,
    String? from,
    String? to,
    String? providerId,
    String? serviceId,
  });

  /// One person against the shop, over the same kind of range.
  Future<ApiResult<StaffStatistics>> staff(
    String providerId, {
    int? days,
    String? from,
    String? to,
  });

  Future<ApiResult<List<DurationSuggestion>>> suggestions();

  /// Changes the menu. `409 SUGGESTION_GONE` means the numbers have moved.
  Future<ApiResult<List<DurationSuggestion>>> acceptSuggestion(
    String serviceId,
  );

  Future<ApiResult<List<DurationSuggestion>>> dismissSuggestion(
    String serviceId,
  );

  Future<ApiResult<ReviewList>> reviewItems();

  /// Adds the corrected times. At least one of the two has to be set.
  Future<ApiResult<void>> correctVisit(
    ReviewItem item, {
    DateTime? startedAt,
    DateTime? finishedAt,
  });

  /// Leaves the visit as it is, out of the averages and off the list.
  Future<ApiResult<void>> dismissVisit(ReviewItem item);

  Future<ApiResult<StatisticsSettings>> settings();

  Future<ApiResult<StatisticsSettings>> updateSettings({
    int? retentionMonths,
    bool? staffStatistics,
  });
}

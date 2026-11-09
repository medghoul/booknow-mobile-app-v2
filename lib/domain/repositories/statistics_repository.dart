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
}

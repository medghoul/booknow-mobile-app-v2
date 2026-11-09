import '../../core/error/api_result.dart';
import '../models/chairs.dart';

/// Today, one card per chair, from the owner's side (statistics §3).
abstract interface class ChairsRepository {
  /// `GET /v1/shops/me/chairs`.
  Future<ApiResult<ChairBoard>> board();

  /// Puts [visit] on the chair, and finishes whoever was still on it.
  ///
  /// `409 VISIT_MOVED` is an ordinary answer: the customer may have left.
  Future<ApiResult<ChairBoard>> start(String providerId, ChairVisit visit);

  Future<ApiResult<ChairBoard>> done(String providerId, ChairVisit visit);

  /// Someone at the door the shop could not take.
  Future<ApiResult<void>> turnedAway();
}

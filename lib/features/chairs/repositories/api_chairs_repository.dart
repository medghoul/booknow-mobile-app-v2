import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/chairs.dart';
import 'package:booknow_mobile/domain/repositories/chairs_repository.dart';

/// The real chairs endpoints.
class ApiChairsRepository implements ChairsRepository {
  const ApiChairsRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<ChairBoard>> board() async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.myShopChairs,
    );
    return result.parsed(chairBoardFromJson);
  }

  @override
  Future<ApiResult<ChairBoard>> start(String providerId, ChairVisit visit) =>
      _move(providerId, 'start', visit);

  @override
  Future<ApiResult<ChairBoard>> done(String providerId, ChairVisit visit) =>
      _move(providerId, 'done', visit);

  @override
  Future<ApiResult<void>> turnedAway() =>
      _client.post<void>(ApiEndpoints.myShopQueueTurnedAway, data: const {});

  Future<ApiResult<ChairBoard>> _move(
    String providerId,
    String action,
    ChairVisit visit,
  ) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.chairAction(providerId, action),
      data: {'kind': visit.kind.name, 'visitId': visit.id},
    );
    return result.parsed(chairBoardFromJson);
  }
}

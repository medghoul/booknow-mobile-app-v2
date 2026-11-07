import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';

/// The real queue endpoints.
class ApiQueueRepository implements QueueRepository {
  const ApiQueueRepository(this._client);

  final DioClient _client;

  // ─── Customer ───────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<ShopQueue>> shopQueue(String shopId) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.shopQueue(shopId),
    );
    return result.parsed((json) => ShopQueueDto.fromJson(json).toDomain());
  }

  @override
  Future<ApiResult<QueueJoin>> join({
    required String shopId,
    required String serviceId,
    String? providerId,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.shopQueue(shopId),
      data: {'serviceId': serviceId, 'providerId': ?providerId},
    );

    return result.fold(
      onSuccess: (body) {
        final join = QueueJoinDto.fromJson(body).toDomain();
        // Without a client secret there is nothing to pay with; the pending
        // place lapses on its own ten minutes later.
        return join == null
            ? ApiResult.failure(
                const UnexpectedError('join response had no payment'),
              )
            : ApiResult.success(join);
      },
      onFailure: ApiResult.failure,
    );
  }

  @override
  Future<ApiResult<QueueEntry?>> mine() async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.myQueue,
    );
    return result.parsed((json) => readQueueEntry(json['entry']));
  }

  @override
  Future<ApiResult<QueueEntry>> leave(String entryId) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.leaveQueue(entryId),
    );

    return result.fold(
      onSuccess: (body) {
        final entry = readQueueEntry(body['entry']);
        // Left either way — the server answered 200. An unreadable echo only
        // costs the screen its refund verdict.
        return entry == null
            ? ApiResult.failure(
                const UnexpectedError('leave response had no entry'),
              )
            : ApiResult.success(entry);
      },
      onFailure: ApiResult.failure,
    );
  }

  // ─── Owner ──────────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<OwnerQueue>> ownerQueue() async =>
      (await _client.get<Map<String, dynamic>>(
        ApiEndpoints.myShopQueue,
      ))._ownerQueue();

  @override
  Future<ApiResult<OwnerQueue>> addWalkIn({
    String? serviceId,
    String? name,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.myShopQueueWalkIns,
      data: {'serviceId': ?serviceId, 'name': ?name},
    );
    // The walk-in route answers `{ entry, queue }`; the screen only needs the
    // line as it now stands.
    return result.parsed(
      (json) => OwnerQueueDto.fromJson(
        json['queue'] is Map
            ? Map<String, dynamic>.from(json['queue'] as Map)
            : json,
      ).toDomain(),
    );
  }

  @override
  Future<ApiResult<OwnerQueue>> callNext({String? providerId}) => _ownerAction(
    ApiEndpoints.myShopQueueCallNext,
    data: providerId == null ? null : {'providerId': providerId},
  );

  @override
  Future<ApiResult<OwnerQueue>> setState(QueueState state) =>
      _ownerAction(switch (state) {
        QueueState.open => ApiEndpoints.myShopQueueResume,
        QueueState.paused => ApiEndpoints.myShopQueuePause,
        QueueState.closed => ApiEndpoints.myShopQueueClose,
      });

  @override
  Future<ApiResult<OwnerQueue>> start(String entryId) =>
      _ownerAction(ApiEndpoints.queueEntryAction(entryId, 'start'));

  @override
  Future<ApiResult<OwnerQueue>> done(String entryId) =>
      _ownerAction(ApiEndpoints.queueEntryAction(entryId, 'done'));

  @override
  Future<ApiResult<OwnerQueue>> noShow(String entryId) =>
      _ownerAction(ApiEndpoints.queueEntryAction(entryId, 'no-show'));

  @override
  Future<ApiResult<OwnerQueue>> remove(String entryId) =>
      _ownerAction(ApiEndpoints.queueEntryAction(entryId, 'remove'));

  @override
  Future<ApiResult<Shop>> setMode(ShopMode mode) async {
    final result = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.myShopDetails,
      data: {'mode': mode.wireName},
    );
    return result.parsed((json) => ShopDto.fromJson(json).toDomain());
  }

  /// Every owner button answers with the line as it now stands.
  Future<ApiResult<OwnerQueue>> _ownerAction(
    String path, {
    Map<String, dynamic>? data,
  }) async => (await _client.post<Map<String, dynamic>>(
    path,
    data: data,
  ))._ownerQueue();
}

extension on ApiResult<Map<String, dynamic>> {
  ApiResult<OwnerQueue> _ownerQueue() =>
      parsed((json) => OwnerQueueDto.fromJson(json).toDomain());
}

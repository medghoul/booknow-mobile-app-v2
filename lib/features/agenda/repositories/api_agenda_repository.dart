import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';

/// The real agenda and block endpoints.
class ApiAgendaRepository implements AgendaRepository {
  const ApiAgendaRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<AgendaDay>> day({String? date}) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.myShopAgenda,
      queryParameters: {'date': ?date},
    );

    return result.parsed((json) => AgendaDayDto.fromJson(json).toDomain());
  }

  @override
  Future<ApiResult<TimeBlock>> block({
    required DateTime startUtc,
    required DateTime endUtc,
    String? note,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.myShopBlocks,
      data: {
        'startUtc': startUtc.toUtc().toIso8601String(),
        'endUtc': endUtc.toUtc().toIso8601String(),
        'note': ?note,
      },
    );

    return result.fold(
      onSuccess: (body) {
        final block = BlockDto.fromJson(body).toDomain();
        // The block was written either way — the server answered 201. Only its
        // echo is unreadable, so this is the body-contract failure, not a
        // refusal, and the day is re-read on the way out of the sheet.
        return block == null
            ? ApiResult<TimeBlock>.failure(
                const UnexpectedError('block response had no range'),
              )
            : ApiResult.success(block);
      },
      onFailure: ApiResult.failure,
    );
  }

  @override
  Future<ApiResult<void>> unblock({
    required String blockId,
    required String date,
  }) => _client.delete<void>(
    ApiEndpoints.myShopBlock(blockId),
    queryParameters: {'date': date},
  );

  @override
  Future<ApiResult<void>> markArrived(String bookingId) =>
      _bookingAction(ApiEndpoints.bookingArrived(bookingId));

  @override
  Future<ApiResult<void>> markNoShow(String bookingId) =>
      _bookingAction(ApiEndpoints.bookingNoShow(bookingId));

  @override
  Future<ApiResult<void>> cancelBooking(String bookingId) =>
      _bookingAction(ApiEndpoints.cancelBooking(bookingId));

  /// The day is read again afterwards, so only success matters here.
  Future<ApiResult<void>> _bookingAction(String path) async {
    final result = await _client.post<Map<String, dynamic>>(path);
    return result.fold(
      onSuccess: (_) => const ApiResult<void>.success(null),
      onFailure: ApiResult<void>.failure,
    );
  }
}

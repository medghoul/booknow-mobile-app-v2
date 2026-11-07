import 'dart:io';

import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:dio/dio.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/data/dio_client/dio_client.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/data/entities/api_endpoints.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';

/// The real shop, service and address endpoints.
class ApiShopRepository implements ShopRepository {
  const ApiShopRepository(this._client);

  final DioClient _client;

  @override
  Future<ApiResult<Shop?>> getMyShop() async {
    final result = await _client.get<Map<String, dynamic>>(ApiEndpoints.myShop);

    return result.fold(
      onSuccess: (body) => ApiResult.success(ShopDto.fromJson(body).toDomain()),
      // An owner who has just chosen their role has no shop, and the API says
      // so with a 404. That is a state, not a failure — every other error
      // still propagates.
      onFailure: (error) => error is NotFound
          ? const ApiResult.success(null)
          : ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<Shop>> createShop() async {
    final result = await _client.post<Map<String, dynamic>>(ApiEndpoints.shops);
    return result._shop();
  }

  @override
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    String? placeId,
    OpeningHours? openingHours,
    List<String>? closures,
  }) async {
    final result = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.myShopDetails,
      data: {
        'name': ?name,
        'phone': ?phone,
        // The id of a chosen suggestion. The server resolves it through
        // Amazon Location and stores the address and coordinates; the app
        // never sends either.
        'placeId': ?placeId,
        if (openingHours != null)
          'openingHours': ShopRequests.openingHours(openingHours),
        'closures': ?closures,
      },
    );
    return result._shop();
  }

  @override
  Future<ApiResult<ShopService>> addService({
    required String name,
    required int durationMinutes,
    required int priceCents,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.myShopServices,
      data: {
        'name': name,
        'durationMin': durationMinutes,
        'priceCents': priceCents,
      },
    );
    return result._service();
  }

  @override
  Future<ApiResult<ShopService>> updateService(
    String serviceId, {
    String? name,
    int? durationMinutes,
    int? priceCents,
  }) async {
    final result = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.myShopService(serviceId),
      data: {
        'name': ?name,
        'durationMin': ?durationMinutes,
        'priceCents': ?priceCents,
      },
    );
    return result._service();
  }

  @override
  Future<ApiResult<void>> deleteService(String serviceId) =>
      _client.delete<void>(ApiEndpoints.myShopService(serviceId));

  @override
  Future<ApiResult<Shop>> publish() async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.myShopPublish,
    );
    return result._shop();
  }

  @override
  Future<ApiResult<Shop>> uploadPhoto({
    required String filePath,
    required String contentType,
  }) async {
    // 1. Ask where to put it. The server mints the key; a client that named
    //    its own could name another shop's.
    final presign = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.myShopPhoto,
      data: {'contentType': contentType},
    );

    final upload = presign.fold<PhotoUpload?>(
      onSuccess: (body) => PhotoUploadDto.fromJson(body).toDomain(),
      onFailure: (_) => null,
    );
    if (presign case Failure(:final error)) return ApiResult.failure(error);
    if (upload == null) {
      return const ApiResult.failure(
        UnexpectedError('The upload URL was missing from the response'),
      );
    }

    // 2. Straight to storage. A bare client on purpose: the interceptors would
    //    add an Authorization header, and S3 rejects a presigned request that
    //    carries one alongside the signature.
    final file = File(filePath);
    try {
      await Dio().put<void>(
        upload.uploadUrl,
        data: file.openRead(),
        options: Options(
          headers: {
            Headers.contentTypeHeader: contentType,
            Headers.contentLengthHeader: await file.length(),
          },
        ),
      );
    } on DioException catch (error, stackTrace) {
      AppLogger.error('[shop] photo upload failed', error, stackTrace);
      return ApiResult.failure(NetworkException.fromDio(error));
    }

    // 3. Claim it. Until this lands the object exists but no shop points at it.
    final claimed = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.myShopDetails,
      data: {'photoKey': upload.photoKey},
    );
    return claimed._shop();
  }

  @override
  Future<ApiResult<Shop>> removePhoto() async {
    final result = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.myShopDetails,
      data: {'photoKey': null},
    );
    return result._shop();
  }

  @override
  Future<ApiResult<List<PlaceSuggestion>>> searchAddresses(String query) async {
    final result = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.placesAutocomplete,
      queryParameters: {'q': query},
    );

    return result.fold(
      onSuccess: (body) => ApiResult.success(
        (body['results'] as List? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map((json) => PlaceSuggestionDto.fromJson(json).toDomain())
            .toList(),
      ),
      onFailure: ApiResult.failure,
    );
  }
}

extension on ApiResult<Map<String, dynamic>> {
  ApiResult<Shop> _shop() =>
      parsed((json) => ShopDto.fromJson(json).toDomain());

  ApiResult<ShopService> _service() =>
      parsed((json) => ServiceDto.fromJson(json).toDomain());
}

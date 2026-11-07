import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:dio/dio.dart';

/// The app's HTTP client.
///
/// Every verb returns an [ApiResult] rather than throwing, so callers handle
/// the failure path explicitly. Responses are returned as the decoded JSON
/// body — DTO parsing belongs in the repository that knows the shape.
class DioClient {
  DioClient({required List<Interceptor> interceptors, Dio? dio})
    : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    _dio.interceptors
      ..clear()
      ..addAll(interceptors);
  }

  final Dio _dio;

  /// The underlying instance, for the rare call that needs Dio directly
  /// (multipart uploads, cancel tokens, streamed downloads).
  Dio get raw => _dio;

  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) => _send<T>(
    () => _dio.get<T>(
      path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ),
  );

  Future<ApiResult<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) => _send<T>(
    () => _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ),
  );

  Future<ApiResult<T>> put<T>(
    String path, {
    Object? data,
    CancelToken? cancelToken,
  }) => _send<T>(() => _dio.put<T>(path, data: data, cancelToken: cancelToken));

  Future<ApiResult<T>> patch<T>(
    String path, {
    Object? data,
    CancelToken? cancelToken,
  }) =>
      _send<T>(() => _dio.patch<T>(path, data: data, cancelToken: cancelToken));

  Future<ApiResult<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) => _send<T>(
    () => _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ),
  );

  Future<ApiResult<T>> _send<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      return ApiResult.success(response.data as T);
    } on DioException catch (exception) {
      return ApiResult.failure(NetworkException.fromDio(exception));
    } catch (error) {
      return ApiResult.failure(UnexpectedError(error.toString()));
    }
  }
}

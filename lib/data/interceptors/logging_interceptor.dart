import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:dio/dio.dart';

/// Logs requests and failures in non-production builds.
///
/// Bodies are deliberately not logged: they carry customer names, phone
/// numbers and booking details. Method, path, status and the API error code
/// are enough to debug with.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('→ ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.debug(
      '← ${response.statusCode} '
      '${response.requestOptions.method} ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final body = err.response?.data;
    final code = body is Map<String, dynamic> ? body['code'] : null;
    AppLogger.warning(
      '✗ ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.method} ${err.requestOptions.path}'
      '${code != null ? ' — $code' : ''}',
    );
    handler.next(err);
  }
}

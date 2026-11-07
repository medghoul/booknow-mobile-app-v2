import 'package:booknow_mobile/core/services/connectivity/network_info.dart';
import 'package:dio/dio.dart';

/// Fails a request immediately when the device has no network, instead of
/// waiting out the connect timeout.
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._networkInfo);

  final NetworkInfo _networkInfo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await _networkInfo.isConnected) {
      handler.next(options);
      return;
    }
    handler.reject(
      DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: 'No network interface available',
      ),
    );
  }
}

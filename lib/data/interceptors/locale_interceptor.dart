import 'package:dio/dio.dart';

/// Sends the UI language so the API can localise its messages.
///
/// The app never displays a server message verbatim for anything it has a
/// localised string for; this is for the cases where it has none.
class LocaleInterceptor extends Interceptor {
  LocaleInterceptor(this._localeCode);

  /// Read lazily — the user can change the language without rebuilding Dio.
  final String Function() _localeCode;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = _localeCode();
    handler.next(options);
  }
}

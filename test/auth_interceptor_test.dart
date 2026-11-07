import 'package:booknow_mobile/core/services/storage/secure_storage_service.dart';
import 'package:booknow_mobile/core/structures/enums/prefs_keys.dart';
import 'package:booknow_mobile/data/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// The real service over an in-memory map, so the interceptor is exercised
/// through the same API it uses in the app.
class _MemoryStorage extends SecureStorageService {
  _MemoryStorage(this.values);

  final Map<String, String> values;

  @override
  Future<String?> get idToken async => values[PrefsKey.idToken.value];
}

void main() {
  late AuthInterceptor interceptor;
  late int unauthorizedCalls;

  RequestOptions request(String path) => RequestOptions(path: path);

  setUp(() {
    unauthorizedCalls = 0;
    interceptor = AuthInterceptor(
      storage: _MemoryStorage({PrefsKey.idToken.value: 'id-token'}),
      onUnauthorized: () async => unauthorizedCalls++,
    );
  });

  Future<RequestOptions> send(String path) async {
    final options = request(path);
    final handler = RequestInterceptorHandler();
    await interceptor.onRequest(options, handler);
    return options;
  }

  // `/shops` was listed as an anonymous path and matched with a bare
  // `startsWith`, so every owner route under it went out with no Authorization
  // header and the API answered 401.
  group('attaches the ID token to owner routes', () {
    for (final path in const [
      '/shops',
      '/shops/me',
      '/shops/me/services',
      '/shops/me/services/abc',
      '/shops/me/publish',
      '/me',
      '/me/shop',
      '/places/autocomplete',
    ]) {
      test(path, () async {
        final options = await send(path);
        expect(options.headers['Authorization'], 'Bearer id-token');
      });
    }
  });

  test('leaves the Stripe webhook unsigned', () async {
    final options = await send('/webhooks/stripe');
    expect(options.headers.containsKey('Authorization'), isFalse);
  });

  test(
    'a path merely starting with the same letters is still signed',
    () async {
      final options = await send('/webhooks-admin');
      expect(options.headers['Authorization'], 'Bearer id-token');
    },
  );

  test('a 401 with no token leaves the guest where they are', () async {
    final handler = ErrorInterceptorHandler();
    // ignore: invalid_use_of_protected_member
    final forwarded = handler.future.then<Object?>(
      (state) => state,
      onError: (Object error) => error,
    );

    await interceptor.onError(
      DioException(
        requestOptions: request('/home'),
        response: Response<void>(
          requestOptions: request('/home'),
          statusCode: 401,
        ),
      ),
      handler,
    );

    expect(unauthorizedCalls, 0);
    expect(await forwarded, isNotNull);
  });

  test('a 401 reports once, and passes the error on', () async {
    final handler = ErrorInterceptorHandler();
    // `handler.future` is protected, but the alternative is leaving the
    // handler's result unclaimed, which surfaces as an unhandled async error
    // and fails the test for the wrong reason.
    // ignore: invalid_use_of_protected_member
    final forwarded = handler.future.then<Object?>(
      (state) => state,
      onError: (Object error) => error,
    );

    await interceptor.onError(
      DioException(
        requestOptions: request('/me')
          ..headers['Authorization'] = 'Bearer id-token',
        response: Response<void>(
          requestOptions: request('/me'),
          statusCode: 401,
        ),
      ),
      handler,
    );

    expect(unauthorizedCalls, 1);
    expect(await forwarded, isNotNull);
  });

  test('a non-401 is left alone', () async {
    final handler = ErrorInterceptorHandler();
    // ignore: invalid_use_of_protected_member
    final forwarded = handler.future.then<Object?>(
      (state) => state,
      onError: (Object error) => error,
    );

    await interceptor.onError(
      DioException(
        requestOptions: request('/me'),
        response: Response<void>(
          requestOptions: request('/me'),
          statusCode: 500,
        ),
      ),
      handler,
    );

    expect(unauthorizedCalls, 0);
    expect(await forwarded, isNotNull);
  });
}

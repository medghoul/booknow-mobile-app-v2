import 'package:booknow_mobile/core/services/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';

/// Attaches the Cognito **ID token** to every request except the ones that
/// can't have one yet.
///
/// The ID token, not the access token: the API gateway's JWT authorizer checks
/// `audience` against the app client, and on Cognito only the ID token carries
/// an `aud` claim — the access token has `client_id` instead and is rejected.
///
/// A 401 is not retried here: v0 signs in through Cognito's managed login, so
/// there is no refresh call this interceptor could make on its own. It clears
/// the session and lets [onUnauthorized] put the user back to browsing.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required SecureStorageService storage,
    required Future<void> Function() onUnauthorized,
  }) : _storage = storage,
       _onUnauthorized = onUnauthorized;

  final SecureStorageService _storage;
  final Future<void> Function() _onUnauthorized;

  /// Paths that authenticate themselves.
  ///
  /// Only the Stripe webhook, which is server-to-server and never called from
  /// the app. Every other route sits behind the JWT authorizer, including the
  /// customer-facing shop reads.
  ///
  /// Matching is on a whole path segment: a bare `startsWith` entry for
  /// `/shops` would also strip the token from `/shops/me` and everything
  /// under it, which is exactly how the owner wizard lost its Authorization header.
  static const Set<String> _anonymousPaths = {'/webhooks'};

  bool _isAnonymous(String path) => _anonymousPaths.any(
    (anonymous) => path == anonymous || path.startsWith('$anonymous/'),
  );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_isAnonymous(options.path)) {
      final token = await _storage.idToken;
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Clearing the session is the callback's job, not this interceptor's:
    // wiping storage from here left the auth repository's in-memory session
    // cache alive, so the next restore handed back a session whose tokens
    // were already gone and every call 401'd in a loop.
    //
    // Only for a request that carried a token. A guest has no session to lose,
    // so the API refusing one of their reads must not move them anywhere.
    final hadToken = err.requestOptions.headers.containsKey('Authorization');
    if (err.response?.statusCode == 401 && hadToken) await _onUnauthorized();
    handler.next(err);
  }
}

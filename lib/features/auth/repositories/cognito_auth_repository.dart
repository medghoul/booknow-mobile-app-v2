import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/core/services/storage/secure_storage_service.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/domain/models/auth_session.dart';
import 'package:booknow_mobile/domain/repositories/auth_repository.dart';
import 'package:booknow_mobile/features/auth/repositories/id_token_claims.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

/// Sign-in through Cognito's hosted login.
///
/// The pool is social-only — nobody can create a username/password account —
/// so the whole flow is: open the hosted UI pinned to one identity provider,
/// let it hand back an authorization code, exchange that for tokens. The app
/// client is public and uses PKCE, which is why there is no secret here.
///
/// The **ID token** is what gets stored and sent to the API. The gateway's JWT
/// authorizer checks `audience` against the app client, and on Cognito only
/// the ID token carries `aud`; the access token carries `client_id` instead
/// and would be rejected.
class CognitoAuthRepository implements AuthRepository {
  CognitoAuthRepository(this._storage, {FlutterAppAuth? appAuth})
    : _appAuth = appAuth ?? const FlutterAppAuth();

  final SecureStorageService _storage;
  final FlutterAppAuth _appAuth;

  AuthSession? _session;

  /// Cognito's hosted UI is not at the issuer's OIDC discovery endpoints, so
  /// the three URLs are given explicitly rather than discovered.
  AuthorizationServiceConfiguration get _serviceConfiguration {
    final domain = AppConfig.cognitoDomain;
    return AuthorizationServiceConfiguration(
      authorizationEndpoint: '$domain/oauth2/authorize',
      tokenEndpoint: '$domain/oauth2/token',
      endSessionEndpoint: '$domain/logout',
    );
  }

  static const List<String> _scopes = ['openid', 'email', 'profile'];

  /// The provider names as the pool declares them.
  static String _identityProvider(AuthProviderKind provider) =>
      switch (provider) {
        AuthProviderKind.google => 'Google',
        AuthProviderKind.apple => 'SignInWithApple',
      };

  @override
  Future<ApiResult<AuthSession>> signInWith(AuthProviderKind provider) async {
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AppConfig.cognitoClientId,
          AppConfig.cognitoRedirectUri,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          // Skips the hosted UI's provider chooser and goes straight to the
          // one the user tapped, so the app's own buttons stay the choice.
          additionalParameters: {
            'identity_provider': _identityProvider(provider),
          },
        ),
      );

      final session = await _sessionFrom(result, provider);
      if (session == null) {
        return const ApiResult.failure(
          UnexpectedError('Cognito returned no usable ID token'),
        );
      }
      return ApiResult.success(session);
    } on FlutterAppAuthUserCancelledException {
      // Backing out of the hosted UI is a decision, not a failure: the screen
      // should go back to resting, with nothing shown.
      return const ApiResult.failure(RequestCancelled());
    } catch (error, stackTrace) {
      AppLogger.error('[auth] sign-in failed', error, stackTrace);
      return ApiResult.failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AuthSession?> restoreSession() async {
    if (_session != null) return _session;

    final idToken = await _storage.idToken;
    if (idToken == null || idToken.isEmpty) return null;

    final expiry = IdTokenClaims.expiryOf(idToken);
    final isExpired = expiry == null || expiry.isBefore(DateTime.now().toUtc());

    if (isExpired) {
      final refreshed = await _refresh();
      if (refreshed == null) await _storage.clear();
      return refreshed;
    }

    return _session = _sessionFromTokens(
      idToken: idToken,
      accessToken: await _storage.accessToken ?? idToken,
      refreshToken: await _storage.refreshToken,
    );
  }

  @override
  Future<AuthSession?> refreshSession() => _refresh();

  /// Trades the stored refresh token for fresh ones.
  ///
  /// Returns null on any failure — an expired or revoked refresh token means
  /// the user signs in again, which is the correct outcome, not an error to
  /// surface.
  Future<AuthSession?> _refresh() async {
    final refreshToken = await _storage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return null;

    try {
      final result = await _appAuth.token(
        TokenRequest(
          AppConfig.cognitoClientId,
          AppConfig.cognitoRedirectUri,
          serviceConfiguration: _serviceConfiguration,
          refreshToken: refreshToken,
          scopes: _scopes,
        ),
      );
      return await _sessionFrom(result, _session?.provider);
    } catch (error, stackTrace) {
      AppLogger.error('[auth] token refresh failed', error, stackTrace);
      return null;
    }
  }

  Future<AuthSession?> _sessionFrom(
    TokenResponse result,
    AuthProviderKind? provider,
  ) async {
    final idToken = result.idToken;
    if (idToken == null) return null;

    await _storage.saveTokens(
      accessToken: result.accessToken ?? idToken,
      refreshToken: result.refreshToken,
      idToken: idToken,
    );

    return _session = _sessionFromTokens(
      idToken: idToken,
      accessToken: result.accessToken ?? idToken,
      refreshToken: result.refreshToken,
      provider: provider,
    );
  }

  AuthSession? _sessionFromTokens({
    required String idToken,
    required String accessToken,
    String? refreshToken,
    AuthProviderKind? provider,
  }) {
    final profile = IdTokenClaims.profileFrom(idToken);
    if (profile == null) return null;

    return AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      idToken: idToken,
      profile: profile,
      // The tap, when there was one; otherwise whatever the token itself
      // says. A restored session has no tap behind it, and defaulting to one
      // provider told every Apple user they had signed in with Google the
      // moment they reopened the app.
      provider: provider ?? IdTokenClaims.providerFrom(idToken),
    );
  }

  @override
  Future<void> clearSession() async {
    // Both halves, together. Clearing storage alone would leave [_session]
    // holding a dead session, and `restoreSession` returns that cache before
    // it ever reads storage.
    _session = null;
    await _storage.clear();
  }

  @override
  Future<void> signOut() async {
    final idToken = _session?.idToken ?? await _storage.idToken;

    _session = null;
    await _storage.clear();

    if (idToken == null) return;

    try {
      // Ends the hosted-UI session too. Without it the next sign-in silently
      // reuses the browser session and the user cannot switch account.
      await _appAuth.endSession(
        EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: AppConfig.cognitoLogoutUri,
          serviceConfiguration: _serviceConfiguration,
          additionalParameters: {
            'client_id': AppConfig.cognitoClientId,
            'logout_uri': AppConfig.cognitoLogoutUri,
          },
        ),
      );
    } catch (error) {
      AppLogger.error('[auth] hosted logout closed with: $error');
    }
  }
}

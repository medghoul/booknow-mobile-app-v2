import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Runtime configuration, read from a bundled `.env` file.
///
/// Which file is used follows the build mode — debug and profile get
/// `.env.development`, release gets `.env.production` — so the common cases
/// need no flags at all. Point a build somewhere else with
/// `--dart-define=ENV=local`.
///
/// Everything here is readable by anyone who unzips the built app: a `.env`
/// ships as an asset, in the clear. Only public values belong in one. Stripe's
/// publishable key qualifies; its secret key does not, and neither does any
/// other credential.
abstract final class AppConfig {
  /// Overrides the build-mode default. Empty when no flag was passed.
  static const String _envOverride = String.fromEnvironment('ENV');

  /// The env file this build reads.
  static String get fileName {
    if (_envOverride.isNotEmpty) return '.env.$_envOverride';
    return kReleaseMode ? '.env.production' : '.env.development';
  }

  /// Reads the env file into memory. Must run before anything touches the
  /// values below — [main] awaits it before wiring up dependencies.
  static Future<void> load() => dotenv.load(fileName: fileName);

  static String get environment => _string('ENVIRONMENT', 'development');

  static String get apiUrl => _string('API_URL');

  static bool get debugMode => _bool('DEBUG_MODE', defaultValue: true);

  static String get logLevel => _string('LOG_LEVEL', 'debug');

  static String get stripePublishableKey => _string('STRIPE_PUBLISHABLE_KEY');

  static String get stripeMerchantId => _string('STRIPE_MERCHANT_ID');

  static String get cognitoDomain => _string('COGNITO_DOMAIN');

  static String get cognitoClientId => _string('COGNITO_CLIENT_ID');

  static String get cognitoRedirectUri => _string('COGNITO_REDIRECT_URI');

  static String get cognitoLogoutUri => _string('COGNITO_LOGOUT_URI');

  static String get supportEmail => _string('SUPPORT_EMAIL');

  static String get termsUrl => _string('TERMS_URL');

  static String get privacyUrl => _string('PRIVACY_URL');

  static bool get isProduction => environment == 'production';

  /// Stripe is only wired up once a publishable key is supplied; until then
  /// the app runs with payments disabled rather than crashing at startup.
  static bool get hasStripe => stripePublishableKey.isNotEmpty;

  static void assertConfigured() {
    final missing = <String>[
      if (apiUrl.isEmpty) 'API_URL',
      if (cognitoDomain.isEmpty) 'COGNITO_DOMAIN',
      if (cognitoClientId.isEmpty) 'COGNITO_CLIENT_ID',
      if (cognitoRedirectUri.isEmpty) 'COGNITO_REDIRECT_URI',
    ];
    if (missing.isEmpty) return;

    throw StateError(
      'Missing required configuration: ${missing.join(', ')}.\n'
      'Expected to read it from $fileName — check that the file exists, is '
      'listed under `assets:` in pubspec.yaml, and has every key filled in. '
      'The Cognito values come from the stack outputs UserPoolClientId and '
      'CognitoDomain.',
    );
  }

  /// Falls back rather than throwing when the file has not been loaded, so a
  /// widget test that never calls [load] still builds instead of dying on an
  /// uninitialised map.
  static String _string(String key, [String fallback = '']) {
    if (!dotenv.isInitialized) return fallback;
    return dotenv.maybeGet(key)?.trim() ?? fallback;
  }

  static bool _bool(String key, {required bool defaultValue}) {
    final raw = _string(key);
    if (raw.isEmpty) return defaultValue;
    return raw.toLowerCase() == 'true';
  }
}

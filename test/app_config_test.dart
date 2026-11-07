import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  _configurationGuard();

  tearDown(dotenv.clean);

  group('before the env file is loaded', () {
    test('values fall back instead of throwing', () {
      expect(AppConfig.apiUrl, isEmpty);
      expect(AppConfig.environment, 'development');
      expect(AppConfig.debugMode, isTrue);
      expect(AppConfig.hasStripe, isFalse);
      expect(AppConfig.supportEmail, isEmpty);
    });
  });

  group('once loaded', () {
    setUp(() async {
      await dotenv.load(fileName: '.env.production');
    });

    test('reads the values in the file', () {
      expect(AppConfig.environment, 'production');
      expect(AppConfig.apiUrl, 'https://api.booknow.app/v1');
      expect(AppConfig.logLevel, 'info');
      expect(AppConfig.isProduction, isTrue);
    });

    // The help screen prints these, and hides what it has no address for.
    test('carries the support address and the two documents', () {
      expect(AppConfig.supportEmail, 'support@book-now.org');
      expect(AppConfig.termsUrl, 'https://book-now.org/terms-of-use');
      expect(AppConfig.privacyUrl, 'https://book-now.org/privacy-policy');
    });

    test('parses DEBUG_MODE as a bool, not a string', () {
      expect(AppConfig.debugMode, isFalse);
    });

    test('Stripe stays off while no publishable key is set', () {
      expect(AppConfig.stripePublishableKey, isEmpty);
      expect(AppConfig.hasStripe, isFalse);
    });
  });

  group('every shipped env file', () {
    for (final name in ['.env.local', '.env.development', '.env.production']) {
      test('$name defines the keys the app reads', () async {
        await dotenv.load(fileName: name);

        expect(AppConfig.apiUrl, isNotEmpty, reason: '$name has no API_URL');
        expect(AppConfig.environment, isNotEmpty);
        expect(AppConfig.stripeMerchantId, isNotEmpty);
      });

      test('$name carries no secret key', () async {
        await dotenv.load(fileName: name);

        // A Stripe secret key would be readable by anyone who unzips the app.
        final values = dotenv.env.values.join(' ');
        expect(values, isNot(contains('sk_')));
        expect(values, isNot(contains('rk_')));
      });
    }
  });
}

// The guard replaced a silent fallback: a build with no Cognito client id used
// to register a stub repository that fabricated a signed-in user. It has to be
// a throw rather than an assert, because release builds strip asserts and turn
// the logs off — the one build where the fallback was unrecoverable.
void _configurationGuard() {
  group('assertConfigured', () {
    tearDown(dotenv.clean);

    test('passes when every required key is filled in', () async {
      dotenv.loadFromString(
        envString: '''
API_URL=https://api.example.com/v1
COGNITO_DOMAIN=https://example.auth.eu-west-1.amazoncognito.com
COGNITO_CLIENT_ID=abc123
COGNITO_REDIRECT_URI=booknow://auth/callback
''',
      );

      expect(AppConfig.assertConfigured, returnsNormally);
    });

    test('names every missing key at once, not just the first', () async {
      dotenv.loadFromString(envString: 'API_URL=https://api.example.com/v1\n');

      expect(
        AppConfig.assertConfigured,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            allOf(
              contains('COGNITO_DOMAIN'),
              contains('COGNITO_CLIENT_ID'),
              contains('COGNITO_REDIRECT_URI'),
              isNot(contains('API_URL:')),
            ),
          ),
        ),
      );
    });

    test('an empty client id alone is still fatal', () async {
      dotenv.loadFromString(
        envString: '''
API_URL=https://api.example.com/v1
COGNITO_DOMAIN=https://example.auth.eu-west-1.amazoncognito.com
COGNITO_CLIENT_ID=
COGNITO_REDIRECT_URI=booknow://auth/callback
''',
      );

      expect(AppConfig.assertConfigured, throwsStateError);
    });
  });
}

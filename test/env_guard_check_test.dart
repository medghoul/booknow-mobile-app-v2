import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

/// What each shipped env file does at startup.
///
/// `assertConfigured` throws rather than asserts, so a file missing a required
/// key produces a build that refuses to launch — in every mode, not just
/// debug. That is deliberate: the alternative was a stub repository quietly
/// fabricating a signed-in user.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(dotenv.clean);

  for (final file in const ['.env.local', '.env.development']) {
    test('$file can boot', () async {
      await dotenv.load(fileName: file);
      expect(AppConfig.assertConfigured, returnsNormally);
    });
  }

  // Production has no app client yet: the pool exists for development only.
  // This test is the record of that, and it fails the day someone fills the id
  // in — at which point move `.env.production` into the list above.
  test('.env.production cannot boot yet — no COGNITO_CLIENT_ID', () async {
    await dotenv.load(fileName: '.env.production');

    expect(AppConfig.cognitoClientId, isEmpty);
    expect(
      AppConfig.assertConfigured,
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          contains('COGNITO_CLIENT_ID'),
        ),
      ),
    );
  });
}

import 'package:booknow_mobile/core/services/storage/secure_storage_service.dart';
import 'package:booknow_mobile/features/auth/repositories/cognito_auth_repository.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

const _domain = 'https://booknow-development.auth.eu-west-1.amazoncognito.com';
const _clientId = 'abc123';
const _logoutUri = 'booknow://auth/logout';

const _configured =
    'API_URL=https://api.example.com/v1\n'
    'COGNITO_DOMAIN=$_domain\n'
    'COGNITO_CLIENT_ID=$_clientId\n'
    'COGNITO_REDIRECT_URI=booknow://auth/callback\n'
    'COGNITO_LOGOUT_URI=$_logoutUri';

/// Records the end-session request instead of opening a browser, and can be
/// told to fail the way the real one does.
class _FakeAppAuth implements FlutterAppAuth {
  _FakeAppAuth({this.throws});

  final Object? throws;
  final List<EndSessionRequest> endSessions = [];

  @override
  Future<EndSessionResponse> endSession(EndSessionRequest request) async {
    endSessions.add(request);
    if (throws != null) throw throws!;
    return EndSessionResponse(request.state);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError(invocation.memberName.toString());
}

/// Holds the tokens in memory. The real one reaches for the keychain.
class _FakeStorage implements SecureStorageService {
  _FakeStorage({this.storedIdToken});

  String? storedIdToken;
  var cleared = false;

  @override
  Future<String?> get idToken async => storedIdToken;

  @override
  Future<void> clear() async {
    cleared = true;
    storedIdToken = null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError(invocation.memberName.toString());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => dotenv.loadFromString(envString: _configured));
  tearDown(dotenv.clean);

  group('signing out of the hosted UI', () {
    // Cognito's /logout is not the OIDC end-session endpoint. Without these
    // two it signs the user out and then lands on a broken /login page:
    // "An error was encountered with the requested page."
    test('asks Cognito the way Cognito asks to be asked', () async {
      final appAuth = _FakeAppAuth();
      final storage = _FakeStorage(storedIdToken: 'id-token');

      await CognitoAuthRepository(storage, appAuth: appAuth).signOut();

      final request = appAuth.endSessions.single;
      expect(request.additionalParameters?['client_id'], _clientId);
      expect(request.additionalParameters?['logout_uri'], _logoutUri);
      expect(request.postLogoutRedirectUrl, _logoutUri);
      expect(request.idTokenHint, 'id-token');
      expect(
        request.serviceConfiguration?.endSessionEndpoint,
        '$_domain/logout',
      );
    });

    // AppAuth rejects the redirect because Cognito echoes no `state`. The
    // browser has already been to /logout by then, so the user is out.
    test('a rejected redirect is not a failed sign-out', () async {
      final appAuth = _FakeAppAuth(throws: Exception('State mismatch'));
      final storage = _FakeStorage(storedIdToken: 'id-token');

      await CognitoAuthRepository(storage, appAuth: appAuth).signOut();

      expect(storage.cleared, isTrue);
    });

    // Storage goes first: whatever the browser does, this device is signed
    // out.
    test('the device is cleared before the browser is opened', () async {
      final appAuth = _FakeAppAuth();
      final storage = _FakeStorage(storedIdToken: 'id-token');

      await CognitoAuthRepository(storage, appAuth: appAuth).signOut();

      expect(storage.cleared, isTrue);
    });

    test('no token means no trip to the browser', () async {
      final appAuth = _FakeAppAuth();
      final storage = _FakeStorage();

      await CognitoAuthRepository(storage, appAuth: appAuth).signOut();

      expect(appAuth.endSessions, isEmpty);
      expect(storage.cleared, isTrue);
    });
  });
}

import 'dart:async';
import 'dart:io';

import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Handles a push that arrives while the app is not running.
///
/// Runs in its own isolate, so it can reach none of the app's state — no DI,
/// no router, no repositories. Firebase has to be initialised again here for
/// the same reason. Keep it to logging and work that needs nothing else;
/// anything that touches the UI belongs in [PushService].
@pragma('vm:entry-point')
Future<void> pushBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    debugPrint('[push][background] ${message.messageId}');
  }
}

/// Cloud Messaging: permission, the device token, and the three ways a
/// message can arrive.
///
/// BookNow's pushes are booking events — a new booking for the owner, a
/// confirmation or a cancellation for the customer — so every message carries
/// a `data` payload the app acts on. [messages] and [taps] are exposed as
/// streams rather than handled here, because what to do about a booking is a
/// feature's decision, not this service's.
///
/// Registered as a singleton and started *after the first frame*: asking for
/// notification permission during startup puts the system dialog over a blank
/// screen.
class PushService {
  PushService({FirebaseMessaging? messaging}) : _injected = messaging;

  final FirebaseMessaging? _injected;

  FirebaseMessaging get _messaging => _injected ?? FirebaseMessaging.instance;

  final StreamController<RemoteMessage> _messages =
      StreamController<RemoteMessage>.broadcast();
  final StreamController<RemoteMessage> _taps =
      StreamController<RemoteMessage>.broadcast();
  final StreamController<String> _tokenRefreshes =
      StreamController<String>.broadcast();

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  bool _initialized = false;
  String? _token;

  /// Messages that arrive while the app is open and in front.
  Stream<RemoteMessage> get messages => _messages.stream;

  /// The message the user tapped to open or resume the app.
  Stream<RemoteMessage> get taps => _taps.stream;

  /// The FCM registration token, once [initialize] has fetched it.
  ///
  /// Null until then, and null on a device where the user refused
  /// notifications — the backend simply has nobody to send to.
  String? get token => _token;

  /// A new token, whenever FCM rotates one.
  ///
  /// Exposed rather than acted on here for the same reason as [messages]:
  /// telling the API about this device needs a session, and this service has
  /// none. A rotation nobody forwards is a device the backend can no longer
  /// reach, so something has to be listening — [AuthCubit] is.
  Stream<String> get tokenRefreshes => _tokenRefreshes.stream;

  /// Starts listening, and picks up the token if the user has already agreed
  /// to notifications.
  ///
  /// Deliberately does **not** prompt. The spec asks for notification
  /// permission after the role choice, once the user knows what the app will
  /// send them — a prompt at launch lands on onboarding and gets refused.
  /// Call [requestPermission] from that screen instead.
  ///
  /// Idempotent. Never throws: a device with no Play Services, a simulator
  /// with no APNs, and a refused permission are all normal outcomes, and none
  /// of them should stop the app starting.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final settings = await _messaging.getNotificationSettings();
      AppLogger.debug('[push] permission: ${settings.authorizationStatus}');

      _token = await _tokenIfPermitted(settings);
      AppLogger.debug('[push] token: ${_token == null ? 'none' : 'acquired'}');

      _subscriptions.addAll([
        FirebaseMessaging.onMessage.listen(_messages.add),
        FirebaseMessaging.onMessageOpenedApp.listen(_taps.add),
        _messaging.onTokenRefresh.listen((token) {
          _token = token;
          AppLogger.debug('[push] token refreshed');
          _tokenRefreshes.add(token);
        }),
      ]);

      // A push that launched the app from cold arrives here rather than on
      // `onMessageOpenedApp`, which only fires for a warm resume.
      final launchMessage = await _messaging.getInitialMessage();
      if (launchMessage != null) _taps.add(launchMessage);
    } catch (error, stackTrace) {
      AppLogger.error('[push] initialisation failed', error, stackTrace);
    }
  }

  /// The token to register this device under, minting one if there is none.
  ///
  /// [initialize] fetches a token at startup, but it runs once per process
  /// while [forgetToken] runs on every sign-out — so from the first sign-out
  /// onwards the cached token is null for the rest of the run, and nothing
  /// mints another until the app is restarted. The next account to sign in
  /// would be registered with no device at all, and the only symptom is a
  /// push that never arrives.
  ///
  /// Null still means "nothing to register": the user has not granted
  /// permission, or the platform cannot hand a token over. Both are normal.
  Future<String?> acquireToken() async {
    if (_token != null) return _token;

    try {
      final settings = await _messaging.getNotificationSettings();
      _token = await _tokenIfPermitted(settings);
      AppLogger.debug('[push] token: ${_token == null ? 'none' : 'acquired'}');
    } catch (error, stackTrace) {
      AppLogger.error('[push] token fetch failed', error, stackTrace);
    }

    return _token;
  }

  /// Whether the OS will actually deliver what the app sends.
  ///
  /// Read live rather than cached: the user can turn notifications off in
  /// Settings while the app is in the background, and the only way to notice
  /// is to ask again when the screen comes back. A failure reads as "not
  /// permitted" — a device that cannot answer cannot be relied on to deliver.
  Future<bool> hasPermission() async {
    try {
      return _isPermitted(await _messaging.getNotificationSettings());
    } catch (error, stackTrace) {
      AppLogger.error('[push] permission read failed', error, stackTrace);
      return false;
    }
  }

  /// Prompts for notification permission and, if granted, collects the token.
  ///
  /// Returns whether the user agreed, so the caller can move on either way —
  /// refusing is a valid answer and must not block the journey.
  Future<bool> requestPermission() async {
    try {
      final settings = await _messaging.requestPermission();
      AppLogger.debug('[push] requested: ${settings.authorizationStatus}');

      _token = await _tokenIfPermitted(settings);
      return _isPermitted(settings);
    } catch (error, stackTrace) {
      AppLogger.error('[push] permission request failed', error, stackTrace);
      return false;
    }
  }

  /// Throws this device's token away, on sign-out.
  ///
  /// The API is told first — `DELETE /me/devices/{token}` needs the token it
  /// is deleting — and this is the other half: without it FCM keeps handing
  /// the same token back, and the next account on this phone would register
  /// the one the previous user's pushes were already addressed to. The next
  /// [initialize] or permission grant mints a fresh one.
  ///
  /// Never throws: a device with no token, or one that cannot reach FCM, must
  /// not be able to stop a sign-out.
  Future<void> forgetToken() async {
    try {
      await _messaging.deleteToken();
    } catch (error, stackTrace) {
      AppLogger.error('[push] token deletion failed', error, stackTrace);
    } finally {
      _token = null;
    }
  }

  static bool _isPermitted(NotificationSettings settings) =>
      settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional;

  /// No permission means no token to fetch — asking anyway throws on iOS.
  Future<String?> _tokenIfPermitted(NotificationSettings settings) async {
    if (!_isPermitted(settings)) return null;
    return _readToken();
  }

  /// On iOS the FCM token is only available once APNs has handed over its
  /// own, which does not happen on the simulator at all. Asking too early
  /// throws, so the APNs token is checked first and a miss is not an error.
  Future<String?> _readToken() async {
    if (Platform.isIOS) {
      final apns = await _messaging.getAPNSToken();
      if (apns == null) {
        AppLogger.warning(
          '[push] no APNs token — simulator, or permission refused',
        );
        return null;
      }
    }
    return _messaging.getToken();
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    await _messages.close();
    await _taps.close();
    await _tokenRefreshes.close();
    _initialized = false;
  }
}

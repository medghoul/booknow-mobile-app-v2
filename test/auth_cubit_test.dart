import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/core/structures/enums/device_platform.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/domain/repositories/auth_repository.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _profile = UserProfile(
  id: 'u1',
  name: 'Marco Rinaldi',
  email: 'marco@example.com',
  profileSetupSeen: true,
);

/// Tokens only — the role lives behind `GET /me`.
class _FakeAuthRepository implements AuthRepository {
  AuthSession? stored;
  NetworkException? nextFailure;
  int signInCalls = 0;
  int refreshCalls = 0;

  static AuthSession session() => const AuthSession(
    accessToken: 'token',
    provider: AuthProviderKind.google,
    profile: _profile,
  );

  @override
  Future<ApiResult<AuthSession>> signInWith(AuthProviderKind provider) async {
    signInCalls++;
    final failure = nextFailure;
    if (failure != null) return ApiResult.failure(failure);
    stored = session();
    return ApiResult.success(stored!);
  }

  @override
  Future<AuthSession?> restoreSession() async => stored;

  @override
  Future<AuthSession?> refreshSession() async {
    refreshCalls++;
    return stored;
  }

  int signOutCalls = 0;

  @override
  Future<void> signOut() async {
    signOutCalls++;
    stored = null;
  }

  @override
  Future<void> clearSession() async => stored = null;
}

class _FakeUserRepository implements UserRepository {
  _FakeUserRepository({UserProfile? profile}) : _profile = profile;

  UserProfile? _profile;
  NetworkException? nextFailure;
  final List<({String token, DevicePlatform platform})> registeredDevices = [];
  final List<String> removedDevices = [];
  final List<({String? name, String? phone})> profileUpdates = [];

  @override
  Future<ApiResult<UserProfile>> getMe() async {
    final failure = nextFailure;
    if (failure != null) return ApiResult.failure(failure);
    final profile = _profile ??= _profile ?? _profile;
    return profile == null
        ? const ApiResult.failure(Unauthorized())
        : ApiResult.success(profile);
  }

  @override
  Future<ApiResult<UserProfile>> setRole(UserRole role) async {
    final failure = nextFailure;
    if (failure != null) return ApiResult.failure(failure);
    _profile = (_profile ?? _profile)!.copyWith(role: role);
    return ApiResult.success(_profile!);
  }

  @override
  Future<ApiResult<UserProfile>> updateProfile({
    String? name,
    String? phone,
    bool profileSetupSeen = false,
  }) async {
    profileUpdates.add((name: name, phone: phone));
    final failure = nextFailure;
    if (failure != null) return ApiResult.failure(failure);
    _profile = _profile!.copyWith(
      name: name ?? _profile!.name,
      phone: phone ?? _profile!.phone,
      profileSetupSeen: profileSetupSeen || _profile!.profileSetupSeen,
    );
    return ApiResult.success(_profile!);
  }

  /// Not called by [AuthCubit] — the settings screen owns this one. It is
  /// here because the interface is, and a profile comes back so a caller
  /// that does use it gets the shape it expects.
  @override
  Future<ApiResult<UserProfile>> updateNotificationPreferences({
    bool? newBooking,
    bool? cancellation,
    bool? dailySummary,
    String? summaryTime,
    bool? reminder,
    ReminderLead? reminderLead,
  }) async => ApiResult.success(_profile!);

  @override
  Future<ApiResult<void>> registerDevice({
    required String token,
    required DevicePlatform platform,
  }) async {
    registeredDevices.add((token: token, platform: platform));
    final failure = nextDeviceFailure;
    if (failure != null) return ApiResult.failure(failure);
    return const ApiResult.success(null);
  }

  /// Registration fails on its own, without failing `GET /me` with it: a
  /// device the API would not take must not stop anybody signing in.
  NetworkException? nextDeviceFailure;

  @override
  Future<ApiResult<void>> removeDevice(String fcmToken) async {
    removedDevices.add(fcmToken);
    return const ApiResult.success(null);
  }

  int deleteCalls = 0;

  @override
  Future<ApiResult<void>> deleteAccount() async {
    deleteCalls++;
    final failure = nextFailure;
    if (failure != null) return ApiResult.failure(failure);
    _profile = null;
    return const ApiResult.success(null);
  }
}

/// The push service, with the parts the cubit uses under the test's control.
///
/// Extends the real one rather than implementing it: everything else about it
/// talks to Firebase, which a unit test has none of.
class _FakePushService extends PushService {
  String? currentToken;
  int forgetCalls = 0;

  /// Whether the OS would hand a token over at all.
  bool isPermitted = true;

  int mints = 0;

  final StreamController<String> _refreshes =
      StreamController<String>.broadcast();

  @override
  String? get token => currentToken;

  /// What the cubit actually asks for, and FCM's own behaviour: a token on
  /// demand, and a fresh one once the old has been deleted. Only a device
  /// without permission gets none.
  @override
  Future<String?> acquireToken() async {
    if (currentToken != null) return currentToken;
    if (!isPermitted) return null;

    mints++;
    return currentToken = 'fcm-minted-$mints';
  }

  @override
  Stream<String> get tokenRefreshes => _refreshes.stream;

  @override
  Future<void> forgetToken() async {
    forgetCalls++;
    currentToken = null;
  }

  /// FCM rotated the token while the app was open.
  void rotate(String token) {
    currentToken = token;
    _refreshes.add(token);
  }

  @override
  Future<void> dispose() async => _refreshes.close();
}

class _FakeShopRepository implements ShopRepository {
  Shop? shop;
  int getCalls = 0;

  @override
  Future<ApiResult<Shop?>> getMyShop() async {
    getCalls++;
    return ApiResult.success(shop);
  }

  @override
  Future<ApiResult<Shop>> createShop() async =>
      ApiResult.success(shop = const Shop(id: 's', status: ShopStatus.draft));

  @override
  Future<ApiResult<Shop>> uploadPhoto({
    required String filePath,
    required String contentType,
  }) async => ApiResult.success(shop!);

  @override
  Future<ApiResult<Shop>> removePhoto() async => ApiResult.success(shop!);

  @override
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    String? placeId,
    OpeningHours? openingHours,
    List<String>? closures,
  }) async => ApiResult.success(shop!);

  @override
  Future<ApiResult<ShopService>> addService({
    required String name,
    required int durationMinutes,
    required int priceCents,
  }) async => throw UnimplementedError();

  @override
  Future<ApiResult<ShopService>> updateService(
    String serviceId, {
    String? name,
    int? durationMinutes,
    int? priceCents,
  }) async => throw UnimplementedError();

  @override
  Future<ApiResult<void>> deleteService(String serviceId) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<Shop>> publish() async => ApiResult.success(shop!);

  @override
  Future<ApiResult<List<PlaceSuggestion>>> searchAddresses(String q) async =>
      const ApiResult.success([]);
}

Shop activeShop() => const Shop(
  id: 's',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  phone: '+39 06 000000',
  address: ShopAddress(
    line: 'Via dei Coronari 18',
    city: 'Roma',
    zip: '00186',
    country: 'IT',
    latitude: 41.9,
    longitude: 12.47,
  ),
  services: [
    ShopService(
      id: 's1',
      name: 'Taglio',
      durationMinutes: 30,
      priceCents: 1800,
    ),
  ],
);

void main() {
  late _FakeAuthRepository auth;
  late _FakeUserRepository users;
  late _FakeShopRepository shops;
  late PrefsService prefs;
  late _FakePushService push;
  late AuthCubit cubit;

  Future<AuthCubit> build({UserProfile? profile}) async {
    users = _FakeUserRepository(profile: profile ?? _profile);
    return AuthCubit(
      auth: auth,
      users: users,
      shops: shops,
      prefs: prefs,
      push: push,
    );
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({'notifications_prompted': true});
    prefs = await PrefsService.create();
    auth = _FakeAuthRepository();
    shops = _FakeShopRepository();
    // No token by default: a user who has not answered the permission prompt,
    // or refused it, has none — the common case, and the one where nothing
    // should be registered.
    push = _FakePushService();
    cubit = await build();
  });

  tearDown(() => cubit.close());

  group('restore', () {
    test('no stored session means sign in', () async {
      await cubit.restore();
      expect(cubit.state.destination, isA<SignInDestination>());
    });

    test('a session with no role lands on the role screen', () async {
      auth.stored = _FakeAuthRepository.session();
      await cubit.restore();
      expect(cubit.state.destination, isA<RoleChoiceDestination>());
    });
  });

  group('signInWith', () {
    test('resolves a destination and clears the pending provider', () async {
      await cubit.signInWith(AuthProviderKind.google);

      // A first sign-in becomes a customer without stopping to ask.
      expect(cubit.state.profile?.role, UserRole.customer);
      expect(cubit.state.destination, isA<CustomerHomeDestination>());
      expect(cubit.state.pendingProvider, isNull);
    });

    test('a second tap while one is in flight is ignored', () async {
      final first = cubit.signInWith(AuthProviderKind.google);
      await cubit.signInWith(AuthProviderKind.apple);
      await first;

      expect(auth.signInCalls, 1);
    });

    test('a failure surfaces and does not route anywhere', () async {
      auth.nextFailure = const NoInternetConnection();
      await cubit.signInWith(AuthProviderKind.google);

      expect(cubit.state.failure, isA<NoInternetConnection>());
      expect(cubit.state.destination, isNull);
    });
  });

  group('confirmRole', () {
    setUp(() async => cubit.signInWith(AuthProviderKind.google));

    test('a customer goes home without the shop being fetched', () async {
      cubit.selectRole(UserRole.customer);
      await cubit.confirmRole();

      expect(cubit.state.destination, isA<CustomerHomeDestination>());
      expect(shops.getCalls, isZero);
    });

    test('an owner forces a token refresh before going on', () async {
      // Group membership only appears in tokens issued after the group was
      // added, so without this the owner's next owner-only call is rejected.
      cubit.selectRole(UserRole.owner);
      await cubit.confirmRole();

      expect(auth.refreshCalls, 1);
      expect(cubit.state.destination, isA<ShopSetupDestination>());
    });

    test('a customer never triggers the refresh', () async {
      cubit.selectRole(UserRole.customer);
      await cubit.confirmRole();

      expect(auth.refreshCalls, isZero);
    });

    test('an owner with a published shop lands on the agenda', () async {
      shops.shop = activeShop();
      cubit.selectRole(UserRole.owner);
      await cubit.confirmRole();

      expect(cubit.state.destination, isA<OwnerAgendaDestination>());
    });

    test('nothing is sent without a selection', () async {
      await cubit.confirmRole();
      expect(cubit.state.isSubmitting, isFalse);
    });

    test('a conflict is surfaced and nothing moves', () async {
      cubit.selectRole(UserRole.customer);
      users.nextFailure = const ServerError();
      await cubit.confirmRole();

      expect(cubit.state.failure, isA<ServerError>());
    });
  });

  group('the once-only steps', () {
    test(
      'a customer is never taken off their screen to answer the profile step',
      () async {
        cubit = await build(
          profile: _profile.copyWith(profileSetupSeen: false),
        );

        await cubit.signInWith(AuthProviderKind.google);

        expect(cubit.state.destination, isA<CustomerHomeDestination>());
      },
    );

    test(
      'skipping it records the answer on the profile and moves on',
      () async {
        cubit = await build(
          profile: _profile.copyWith(profileSetupSeen: false),
        );

        await cubit.signInWith(AuthProviderKind.google);

        await cubit.skipProfile();

        expect(cubit.state.profile?.profileSetupSeen, isTrue);
        expect(cubit.state.destination, isA<CustomerHomeDestination>());
      },
    );

    // Moving on regardless would route straight back here on the next
    // resolve, because a skip leaves nothing else behind to show it happened.
    test('a skip that does not reach the server stays put', () async {
      cubit = await build(profile: _profile.copyWith(profileSetupSeen: false));

      await cubit.signInWith(AuthProviderKind.google);

      users.nextFailure = const ServerError();
      await cubit.skipProfile();

      expect(cubit.state.failure, isA<ServerError>());
      expect(cubit.state.profile?.profileSetupSeen, isFalse);
    });

    // §4.4 splits the moment per role: an owner is asked by the resolve, once
    // the shop is live; a customer only after their first confirmed booking,
    // which the booking flow announces through `askForNotifications`.
    test('a customer is not asked on the way in', () async {
      SharedPreferences.setMockInitialValues({});
      prefs = await PrefsService.create();
      cubit = await build();

      await cubit.signInWith(AuthProviderKind.google);
      cubit.selectRole(UserRole.customer);
      await cubit.confirmRole();

      expect(cubit.state.destination, isA<CustomerHomeDestination>());
    });

    test('a confirmed booking is when the customer is asked', () async {
      SharedPreferences.setMockInitialValues({});
      prefs = await PrefsService.create();
      cubit = await build();

      await cubit.signInWith(AuthProviderKind.google);
      cubit.selectRole(UserRole.customer);
      await cubit.confirmRole();

      cubit.askForNotifications();

      expect(cubit.state.destination, isA<NotificationPermissionDestination>());
    });

    // Once answered it is never asked again, so the booking flow can call it
    // on every confirmation without checking anything itself.
    test('a prompt already answered is not raised again', () async {
      await cubit.signInWith(AuthProviderKind.google);
      final before = cubit.state.destination;

      cubit.askForNotifications();

      expect(cubit.state.destination, before);
      expect(
        cubit.state.destination,
        isNot(isA<NotificationPermissionDestination>()),
      );
    });

    test('handling notifications registers the token', () async {
      SharedPreferences.setMockInitialValues({});
      prefs = await PrefsService.create();
      cubit = await build();

      // Nothing has been granted yet, so this phone has no token to give.
      push.isPermitted = false;

      await cubit.signInWith(AuthProviderKind.google);
      cubit.selectRole(UserRole.customer);
      await cubit.confirmRole();
      cubit.askForNotifications();
      expect(cubit.state.destination, isA<NotificationPermissionDestination>());

      // Granting permission is what produces a token in the first place.
      push.currentToken = 'fcm-1';
      await cubit.notificationsHandled();

      expect(users.registeredDevices, [
        (token: 'fcm-1', platform: DevicePlatform.current),
      ]);
      expect(prefs.notificationsPrompted, isTrue);
      expect(cubit.state.destination, isA<CustomerHomeDestination>());
    });

    test('refusing still marks it handled and moves on', () async {
      SharedPreferences.setMockInitialValues({});
      prefs = await PrefsService.create();
      cubit = await build();

      // Refused, so no token is ever minted.
      push.isPermitted = false;

      await cubit.signInWith(AuthProviderKind.google);
      cubit.selectRole(UserRole.customer);
      await cubit.confirmRole();
      await cubit.notificationsHandled();

      expect(users.registeredDevices, isEmpty);
      expect(cubit.state.destination, isA<CustomerHomeDestination>());
    });
  });

  group('signOut', () {
    test('drops the device token and returns to sign in', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);
      await cubit.signOut();

      expect(users.removedDevices, ['fcm-1']);
      expect(cubit.state.destination, isA<SignInDestination>());
      expect(cubit.state.session, isNull);
    });

    // Unregistering alone is not enough: FCM hands the same token back, so
    // the next account on this phone would register the one the previous
    // user's pushes are already addressed to.
    test('throws the token away as well as unregistering it', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);
      await cubit.signOut();

      expect(push.forgetCalls, 1);
      expect(push.token, isNull);
    });

    test('a device with no token has nothing to unregister', () async {
      push.isPermitted = false;

      await cubit.signInWith(AuthProviderKind.google);
      await cubit.signOut();

      expect(users.removedDevices, isEmpty);
      expect(push.forgetCalls, 0);
      expect(cubit.state.destination, isA<SignInDestination>());
    });
  });

  // `PUT /me/devices` is what gives a push somewhere to arrive, and it is
  // also where the device's language is recorded — the API stores the
  // `Accept-Language` of this very request, because a push is sent long
  // after any request of its own.
  group('syncDevice', () {
    test('registers the token with the running platform', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);
      users.registeredDevices.clear();

      await cubit.syncDevice();

      expect(users.registeredDevices, [
        (token: 'fcm-1', platform: DevicePlatform.current),
      ]);
    });

    test('signing in registers the token this phone already had', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);

      expect(users.registeredDevices, [
        (token: 'fcm-1', platform: DevicePlatform.current),
      ]);
    });

    // Every launch, not only the launch after a sign-in: the item the API
    // keeps has a 180-day TTL, and this is what keeps it alive.
    test('a restored session registers the device', () async {
      push.currentToken = 'fcm-1';
      auth.stored = _FakeAuthRepository.session();

      await cubit.restore();

      expect(users.registeredDevices, [
        (token: 'fcm-1', platform: DevicePlatform.current),
      ]);
    });

    test('a rotated token is registered when FCM hands it over', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);
      users.registeredDevices.clear();

      push.rotate('fcm-2');
      await pumpEventQueue();

      expect(users.registeredDevices, [
        (token: 'fcm-2', platform: DevicePlatform.current),
      ]);
    });

    test('no session means there is nobody to register against', () async {
      push.currentToken = 'fcm-1';

      await cubit.syncDevice();

      expect(users.registeredDevices, isEmpty);
    });

    test('no token means there is nothing to register', () async {
      // Which is what a refused permission looks like: the platform has no
      // token to give, and an account with no device is a correct state.
      push.isPermitted = false;

      await cubit.signInWith(AuthProviderKind.google);

      expect(users.registeredDevices, isEmpty);
    });

    // Sign-out throws this device's token away, and the service only fetches
    // one at startup — so reading the cached token left the second account to
    // sign in during a single run of the app with no device row at all, and
    // the only symptom was a push that never arrived.
    test('signing in again after a sign-out registers a fresh token', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);
      await cubit.signOut();
      users.registeredDevices.clear();

      await cubit.signInWith(AuthProviderKind.google);

      expect(push.forgetCalls, 1);
      expect(users.registeredDevices, [
        (token: 'fcm-minted-1', platform: DevicePlatform.current),
      ]);
    });

    // A device the API would not take is a push that does not arrive, not a
    // sign-in that fails. The next launch tries again.
    test('a failed registration is not a failure the user sees', () async {
      push.currentToken = 'fcm-1';
      users.nextDeviceFailure = const ServerError();

      await cubit.signInWith(AuthProviderKind.google);

      expect(users.registeredDevices, hasLength(1));
      expect(cubit.state.failure, isNull);
      expect(cubit.state.destination, isA<CustomerHomeDestination>());
    });
  });

  group('editProfile', () {
    // The profile tab is not a step of the journey. Re-resolving here would
    // emit a destination and have `AuthStepListener` replace the stack out
    // from under the screen the user is editing on.
    test('saves without moving the user anywhere', () async {
      await cubit.signInWith(AuthProviderKind.google);
      final before = cubit.state.destination;

      final saved = await cubit.editProfile(
        name: 'Marco Rinaldi',
        phone: '347 8821 940',
      );

      expect(saved, isTrue);
      expect(cubit.state.profile?.name, 'Marco Rinaldi');
      expect(cubit.state.destination, before);
      expect(cubit.state.isSubmitting, isFalse);
    });

    // An empty field is a request to remove the number, and the repository
    // only sends `phone` when it is given one — so it has to arrive as `''`
    // rather than being dropped the way `saveProfile` drops it.
    test('an emptied phone is sent, not swallowed', () async {
      await cubit.signInWith(AuthProviderKind.google);
      users.profileUpdates.clear();

      await cubit.editProfile(name: 'Marco Rinaldi', phone: '');

      expect(users.profileUpdates.single.phone, '');
    });

    test('a failure keeps the session and reports', () async {
      await cubit.signInWith(AuthProviderKind.google);
      users.nextFailure = const ServerError();

      final saved = await cubit.editProfile(name: 'Marco', phone: '');

      expect(saved, isFalse);
      expect(cubit.state.failure, isA<ServerError>());
      expect(cubit.state.session, isNotNull);
      expect(cubit.state.isSubmitting, isFalse);
    });
  });

  group('profileUpdated', () {
    // `PATCH /me/notification-preferences` answers with the whole profile and
    // the settings screen is what calls it, so the profile has to be able to
    // arrive from outside this cubit — otherwise the app holds two that
    // disagree about the switches.
    test('takes a profile fetched somewhere else', () async {
      await cubit.signInWith(AuthProviderKind.google);
      final before = cubit.state.destination;

      cubit.profileUpdated(
        cubit.state.profile!.copyWith(
          notificationPrefs: const NotificationPreferences(
            newBookings: false,
            summaryTime: '07:30',
          ),
        ),
      );

      final preferences = cubit.state.profile!.notificationPrefs;
      expect(preferences.newBookings, isFalse);
      expect(preferences.summaryTime, '07:30');
      // A settings screen is not a step of the journey: re-resolving from
      // here would replace the stack under the user while they are on it.
      expect(cubit.state.destination, before);
    });
  });

  group('deleteAccount', () {
    // The tokens outlive the account: `DELETE /me` takes the Cognito user with
    // it, and a session left in storage would restore on the next launch —
    // before the API deleted the pool account, straight back into a profile
    // `GET /me` had just recreated.
    test('leaves the device signed out, not holding dead tokens', () async {
      push.currentToken = 'fcm-1';
      await cubit.signInWith(AuthProviderKind.google);
      await cubit.deleteAccount();

      expect(users.deleteCalls, 1);
      expect(auth.signOutCalls, 1);
      expect(auth.stored, isNull, reason: 'the stored session went too');
      expect(push.forgetCalls, 1, reason: 'and so did the FCM token');
      expect(cubit.state.session, isNull);
      expect(cubit.state.destination, isA<SignInDestination>());
    });

    // The account is still there, so the session has to be too: the user is
    // on the profile screen being told it failed, and has to be able to ask
    // again.
    test('a refused delete keeps the session', () async {
      await cubit.signInWith(AuthProviderKind.google);
      users.nextFailure = const NoInternetConnection();

      await cubit.deleteAccount();

      expect(auth.signOutCalls, 0);
      expect(cubit.state.session, isNotNull);
      expect(cubit.state.failure, isA<NoInternetConnection>());
      expect(cubit.state.isSubmitting, isFalse);
      expect(cubit.state.destination, isNot(isA<SignInDestination>()));
    });

    test('a second tap while it is running does nothing', () async {
      await cubit.signInWith(AuthProviderKind.google);

      await Future.wait([cubit.deleteAccount(), cubit.deleteAccount()]);

      expect(users.deleteCalls, 1);
    });
  });
}

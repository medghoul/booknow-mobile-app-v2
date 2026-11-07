import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/core/structures/enums/device_platform.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/domain/repositories/auth_repository.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Owns the whole sign-in journey: provider sign-in, the one-time role
/// choice, and working out where the user belongs afterwards.
///
/// A singleton, because every screen in the journey reads the same session and
/// the splash resolves it before any of them is built.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository auth,
    required UserRepository users,
    required ShopRepository shops,
    required PrefsService prefs,
    required PushService push,
  }) : _auth = auth,
       _users = users,
       _shops = shops,
       _prefs = prefs,
       _push = push,
       super(const AuthState()) {
    // FCM can rotate a token at any moment, including while the app is open.
    // The backend would go on sending to the old one, so the new one is
    // registered as soon as it arrives.
    _tokenRefreshes = _push.tokenRefreshes.listen((_) => syncDevice());
  }

  final AuthRepository _auth;
  final UserRepository _users;
  final ShopRepository _shops;
  final PrefsService _prefs;
  final PushService _push;

  late final StreamSubscription<String> _tokenRefreshes;
  UserRole? _roleForNewAccount;

  @override
  Future<void> close() async {
    await _tokenRefreshes.cancel();
    return super.close();
  }

  /// Reads the stored session and resolves where to go.
  Future<void> restore() async {
    final session = await _auth.restoreSession();
    if (session == null) {
      emit(const AuthState(destination: SignInDestination()));
      return;
    }

    emit(state.copyWith(session: session));
    await _resolve();
    await syncDevice();
  }

  /// A 401 came back: the stored tokens are no longer accepted.
  ///
  /// Drops the session through the repository rather than through storage
  /// alone, so the cached one goes with it, and resets the destination to
  /// sign-in. Re-entrant by design — several in-flight requests can each come
  /// back 401 — so it must be safe to call repeatedly.
  Future<void> sessionRejected() async {
    await _auth.clearSession();
    if (!isClosed) emit(const AuthState(destination: SignInDestination()));
  }

  /// [role] is what a first sign-in makes this account: nobody is stopped to
  /// choose, because where they tapped already says which they are.
  Future<void> signInWith(
    AuthProviderKind provider, {
    UserRole role = UserRole.customer,
  }) async {
    if (state.isBusy) return;
    _roleForNewAccount = role;
    emit(state.copyWith(pendingProvider: provider, failure: null));

    final result = await _auth.signInWith(provider);

    await result.fold(
      onSuccess: (session) async {
        emit(state.copyWith(session: session, pendingProvider: null));
        await _resolve();
        // This phone may already hold a token — from a previous account, or
        // from this one on an earlier install. The server moves it onto the
        // user who just signed in, so the other one stops receiving.
        await syncDevice();
      },
      onFailure: (error) async =>
          emit(state.copyWith(failure: error, pendingProvider: null)),
    );
  }

  /// Records the tap on a role card. Nothing is sent until [confirmRole].
  void selectRole(UserRole role) {
    if (state.isBusy) return;
    emit(state.copyWith(selectedRole: role, failure: null));
  }

  Future<void> confirmRole() async {
    final role = state.selectedRole;
    if (role == null || state.isBusy) return;

    emit(state.copyWith(isSubmitting: true, failure: null));
    final result = await _users.setRole(role);

    await result.fold(
      onSuccess: (profile) async {
        // Group membership shows up in `cognito:groups` only in newly issued
        // tokens, so an owner's very next request would otherwise be rejected
        // by the owner-only routes. Refresh before going anywhere.
        if (role == UserRole.owner) {
          await _auth.refreshSession();
        }

        emit(state.copyWith(profile: profile, isSubmitting: false));
        await _resolve();
      },
      onFailure: (error) async =>
          emit(state.copyWith(isSubmitting: false, failure: error)),
    );
  }

  Future<void> saveProfile({required String name, String? phone}) async {
    if (state.isBusy) return;
    emit(state.copyWith(isSubmitting: true, failure: null));

    final result = await _users.updateProfile(
      name: name,
      phone: phone?.isEmpty ?? true ? null : phone,
      profileSetupSeen: true,
    );

    await result.fold(
      onSuccess: (profile) async {
        emit(state.copyWith(profile: profile, isSubmitting: false));
        await _resolve();
      },
      onFailure: (error) async =>
          emit(state.copyWith(isSubmitting: false, failure: error)),
    );
  }

  /// The details already came from the provider, so skipping is a normal
  /// outcome — and it must not be asked again.
  ///
  /// A request rather than a local flag, because skipping leaves nothing else
  /// behind: with no name saved, "answered" and "never asked" look identical
  /// on the next resolve. Which is also why a failure stays here — moving on
  /// without the answer landing would route straight back to this screen.
  Future<void> skipProfile() async {
    if (state.isBusy) return;
    emit(state.copyWith(isSubmitting: true, failure: null));

    final result = await _users.updateProfile(profileSetupSeen: true);

    await result.fold(
      onSuccess: (profile) async {
        emit(state.copyWith(profile: profile, isSubmitting: false));
        await _resolve();
      },
      onFailure: (error) async =>
          emit(state.copyWith(isSubmitting: false, failure: error)),
    );
  }

  /// Saves the name and phone from the profile tab.
  ///
  /// Deliberately not [saveProfile]. That one is a step of the sign-in
  /// journey: it sets `profileSetupSeen` and re-resolves the destination,
  /// which here would have [AuthStepListener] replace the stack under the
  /// screen the user is editing on. This only writes the two fields and
  /// updates the profile every screen reads.
  ///
  /// Returns whether it saved, so the screen knows to go back. A failure
  /// stays on the state for the form to show, and the user keeps what they
  /// typed.
  ///
  /// [phone] is the field as it stands, empty included — emptying it is how
  /// the number is removed, and the repository sends `""` for exactly that.
  /// [saveProfile] drops an empty one instead, because on the way in there is
  /// nothing yet to remove.
  Future<bool> editProfile({
    required String name,
    required String phone,
  }) async {
    if (state.isBusy) return false;
    emit(state.copyWith(isSubmitting: true, failure: null));

    final result = await _users.updateProfile(name: name, phone: phone);

    return result.fold(
      onSuccess: (profile) {
        emit(state.copyWith(profile: profile, isSubmitting: false));
        return true;
      },
      onFailure: (error) {
        emit(state.copyWith(isSubmitting: false, failure: error));
        return false;
      },
    );
  }

  /// Takes a profile that was fetched somewhere other than here.
  ///
  /// `PATCH /me/notification-preferences` answers with the whole profile, and
  /// the notification settings screen is what calls it. Without this the app
  /// would hold two profiles that disagree about the switches: the one that
  /// screen just set, and the one every other screen reads.
  ///
  /// Only the profile moves. The destination is deliberately left alone — a
  /// settings screen is not a step of the journey, and re-resolving from here
  /// would replace the stack under the user while they are still on it.
  void profileUpdated(UserProfile profile) {
    if (isClosed) return;
    emit(state.copyWith(profile: profile));
  }

  /// Tells the API which device this is, so a push has somewhere to arrive.
  ///
  /// Called at every point the answer can change: after signing in, on each
  /// launch once the session is back, when the notification step is answered,
  /// when FCM rotates the token, and after a language change — the request's
  /// `Accept-Language` is what the server stores as this device's language, so
  /// repeating the call is how the next push changes language.
  ///
  /// Idempotent, and quiet. No session or no token means there is nothing to
  /// register: a user who refused notifications has no token at all, and that
  /// is a normal state, not a failure. A failed call is logged and dropped —
  /// the next launch sends it again, and a push that does not arrive must not
  /// become a screen that does not open.
  Future<void> syncDevice() async {
    if (state.session == null) return;

    final token = await _push.acquireToken();
    if (token == null) return;

    final result = await _users.registerDevice(
      token: token,
      platform: DevicePlatform.current,
    );

    result.fold(
      onSuccess: (_) => AppLogger.debug('[auth] device registered'),
      onFailure: (error) =>
          AppLogger.error('[auth] PUT /me/devices failed', error),
    );
  }

  /// Raises the notification explainer now, if it has never been answered.
  ///
  /// The customer's half of §4.4: they are asked after their first confirmed
  /// booking, not on the way in. Before that there is nothing to remind them
  /// about, and the one prompt iOS allows would be spent on a screen they have
  /// no reason to say yes to.
  ///
  /// Whether a booking has just been confirmed is the booking flow's to know,
  /// so this is the entry point it calls — the single one, which is why the
  /// rule for *when* lives next to the rule for the owner's moment rather than
  /// inside a screen. A no-op once the prompt has been answered, so calling it
  /// on every confirmation is correct.
  ///
  /// Owners never reach this: their moment is the end of publishing, and
  /// [AuthRouter.destinationFor] has already taken them there.
  void askForNotifications() {
    if (_prefs.notificationsPrompted || state.profile == null) return;
    emit(
      state.copyWith(destination: const NotificationPermissionDestination()),
    );
  }

  /// Called once the notification step has had its answer, whatever it was.
  ///
  /// Granting permission is the moment a token first exists, so this is where
  /// the device is registered on a fresh install.
  Future<void> notificationsHandled() async {
    await _prefs.setNotificationsPrompted();
    await syncDevice();
    await _resolve();
  }

  /// Re-reads the shop and re-resolves — what the wizard calls after
  /// publishing.
  Future<void> refreshShop() => _resolve();

  /// Signs out, and stops this phone receiving the account's pushes.
  ///
  /// In that order: `DELETE /me/devices/{token}` needs the session that is
  /// about to end, and `deleteToken()` has to come after the token has been
  /// handed over, since it is the argument.
  Future<void> signOut() async {
    await _forgetDevice();
    await _auth.signOut();
    emit(const AuthState(destination: SignInDestination()));
  }

  /// Unregisters this device and throws the token away.
  ///
  /// Both halves matter. Without the first, the API keeps a token for an
  /// account that is no longer on the phone; without the second, FCM hands
  /// the same token to whoever signs in next, and `PUT /me/devices` would
  /// register a token the previous user's pushes are already addressed to.
  Future<void> _forgetDevice() async {
    final token = await _push.acquireToken();
    if (token == null) return;

    await _users.removeDevice(token);
    await _push.forgetToken();
  }

  /// Fetches what the destination depends on, then asks [AuthRouter].
  ///
  /// `GET /me` is the authority on the role, so this runs after anything that
  /// could have changed it rather than trusting the local copy.
  Future<void> _resolve() async {
    final profileResult = await _users.getMe();

    var profile = profileResult.fold<UserProfile?>(
      onSuccess: (profile) => profile,
      onFailure: (error) {
        AppLogger.error('[auth] GET /me failed', error);
        return null;
      },
    );

    // A first sign-in: set the role the tap implied. If this fails the
    // destination falls back to the role screen, so nobody gets stuck.
    final wanted = _roleForNewAccount;
    if (profile != null && profile.role == null && wanted != null) {
      _roleForNewAccount = null;
      final set = await _users.setRole(wanted);
      profile = set.fold<UserProfile?>(
        onSuccess: (updated) => updated,
        onFailure: (error) {
          AppLogger.error('[auth] setting the role failed', error);
          return profile;
        },
      );
      if (wanted == UserRole.owner) await _auth.refreshSession();
    }

    if (profile == null) {
      // Without a profile there is nothing to route on. The session may still
      // be valid, so this is a failure to show, not a sign-out.
      emit(
        state.copyWith(
          failure: profileResult.fold(
            onSuccess: (_) => null,
            onFailure: (error) => error,
          ),
        ),
      );
      return;
    }

    Shop? shop = state.shop;
    if (AuthRouter.needsShop(profile)) {
      final shopResult = await _shops.getMyShop();
      shop = shopResult.fold(
        onSuccess: (shop) => shop,
        onFailure: (error) {
          AppLogger.error('[auth] GET /me/shop failed', error);
          return null;
        },
      );
    }

    emit(
      state.copyWith(
        profile: profile,
        shop: shop,
        selectedRole: profile.role,
        destination: AuthRouter.destinationFor(
          profile: profile,
          shop: shop,
          notificationsPrompted: _prefs.notificationsPrompted,
        ),
        failure: null,
      ),
    );
  }

  /// Deletes the account, then leaves the device signed out.
  ///
  /// The sign-out is not housekeeping. `DELETE /me` takes the Cognito user
  /// with it, but the tokens in secure storage outlive the request, and
  /// [restore] would hand the next launch a session for an account that is
  /// gone. [AuthRepository.signOut] clears them and ends the hosted-UI session
  /// too, so the next sign-in asks who is signing in rather than silently
  /// reusing the browser's answer.
  ///
  /// A failure keeps the session exactly as it was: the account is still
  /// there, and the user has to be able to try again.
  Future<void> deleteAccount() async {
    if (state.isBusy) return;
    emit(state.copyWith(isSubmitting: true, failure: null));

    final result = await _users.deleteAccount();

    await result.fold(
      onSuccess: (_) async {
        // `DELETE /me` removes the device items server-side, so there is
        // nothing to unregister — but the token itself is still on the phone,
        // and the next account must not inherit it.
        await _push.forgetToken();
        await _auth.signOut();
        emit(const AuthState(destination: SignInDestination()));
      },
      onFailure: (error) async =>
          emit(state.copyWith(isSubmitting: false, failure: error)),
    );
  }
}

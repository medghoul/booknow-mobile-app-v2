import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/device_platform.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/user_profile.dart';

/// The `/me` endpoints: who the signed-in user is, and the two things the app
/// may change about them.
///
/// Kept apart from `AuthRepository`, which owns tokens and the hosted-login
/// round trip. Signing in and knowing who you are turned out to be two
/// different jobs the moment `GET /me` became the source of truth for the
/// role.
abstract interface class UserRepository {
  /// `GET /me` — the profile, created server-side on first call if the
  /// post-confirmation trigger missed it. The API self-heals, so a 404 here
  /// is not an expected outcome.
  Future<ApiResult<UserProfile>> getMe();

  /// `POST /me/role` — set once.
  ///
  /// Sending the **same** role again succeeds: the server's condition is
  /// `attribute_not_exists(role) OR role = :role`, so a retry after a failed
  /// group write is safe. A *different* role returns 409.
  Future<ApiResult<UserProfile>> setRole(UserRole role);

  /// `PATCH /me` — name, optional phone, and whether the optional
  /// "finish your profile" step has been answered.
  ///
  /// [profileSetupSeen] only ever goes up: the step cannot be un-answered,
  /// and the server keeps the first answer. Save sends it with the details,
  /// Skip sends it on its own.
  Future<ApiResult<UserProfile>> updateProfile({
    String? name,
    String? phone,
    bool profileSetupSeen,
  });

  /// `PATCH /me/notification-preferences` — one switch at a time.
  ///
  /// Every argument is optional and only the ones given are sent. The settings
  /// screen has no Save button, so each change is its own request, and a field
  /// left out keeps whatever the server already holds — including the other
  /// half of a nested one, so turning the daily summary off keeps the time it
  /// was set to go out at.
  ///
  /// The fields belong to a role and the server refuses the other role's with
  /// a 400. That is not something a user can do: each role's screen only draws
  /// its own rows, so sending the wrong field would be a bug worth a visible
  /// failure.
  ///
  /// Answers with the whole profile, so what the app holds afterwards is what
  /// the server stored rather than what was asked for.
  Future<ApiResult<UserProfile>> updateNotificationPreferences({
    bool? newBooking,
    bool? cancellation,
    bool? dailySummary,
    String? summaryTime,
    bool? reminder,
    ReminderLead? reminderLead,
  });

  /// `PUT /me/devices` — register or refresh the FCM token.
  ///
  /// Idempotent, and called often: after sign-in, on every launch, and
  /// whenever FCM rotates the token. The server takes the token away from any
  /// other user holding it, so a phone that was signed out while offline
  /// stops receiving the previous account's pushes.
  ///
  /// It also carries the device's **language**: the API stores the
  /// `Accept-Language` of this request against the token, because a push is
  /// sent long after any request of its own. Calling it again is therefore how
  /// a language change reaches the server.
  Future<ApiResult<void>> registerDevice({
    required String token,
    required DevicePlatform platform,
  });

  /// `DELETE /me/devices/{token}` — on sign-out, so the device stops getting
  /// pushes for an account that is no longer on it.
  Future<ApiResult<void>> removeDevice(String fcmToken);

  /// `DELETE /me` — deletes the account: the profile, the registered devices,
  /// the owner's shop, and the Cognito user behind all of them.
  ///
  /// Irreversible, and it takes the session with it: the tokens this was sent
  /// with belong to an account that no longer exists, so the caller has to
  /// sign the device out rather than carry on with them.
  Future<ApiResult<void>> deleteAccount();
}

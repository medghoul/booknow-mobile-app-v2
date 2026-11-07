import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/notification_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// The signed-in user, as `GET /me` returns them.
///
/// [role] is nullable on purpose: between the first sign-in and the role
/// screen there is a real user with no role yet, and the app has to be able to
/// represent that rather than guessing a default.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    required String email,
    String? phone,
    UserRole? role,
    @Default(false) bool profileSetupSeen,

    /// What the user may be sent, and when. Part of the profile because
    /// the server returns it there and answers `PATCH
    /// /me/notification-preferences` with the whole thing — so there is one
    /// copy of it, held where every other `/me` field already is.
    @Default(NotificationPreferences())
    NotificationPreferences notificationPrefs,
  }) = _UserProfile;

  const UserProfile._();

  bool get hasRole => role != null;
}

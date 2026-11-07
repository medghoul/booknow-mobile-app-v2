import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/domain/models/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

/// A completed sign-in: the tokens, and who they belong to.
///
/// [provider] is kept because Apple only sends the user's name on the *first*
/// sign-in, and because the profile screen shows which account is connected.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required UserProfile profile,
    AuthProviderKind? provider,
    String? refreshToken,
    String? idToken,
  }) = _AuthSession;
}

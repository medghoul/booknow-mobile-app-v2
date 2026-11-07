import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/domain/models/auth_session.dart';

/// What the app needs from authentication, independent of how it is done.
///
/// v0 signs in through Cognito's managed login with Apple and Google, and
/// there is no email/password path — which is why there is no `signIn(email,
/// password)` here and never should be.
abstract interface class AuthRepository {
  /// Opens the provider's hosted flow and returns the resulting session.
  Future<ApiResult<AuthSession>> signInWith(AuthProviderKind provider);

  /// The stored session, or null when nobody is signed in.
  Future<AuthSession?> restoreSession();

  /// Forces new tokens.
  ///
  /// Needed after an owner's role is set: Cognito puts group membership in
  /// `cognito:groups`, and that claim only appears in tokens issued *after*
  /// the group was added. Without this the owner's next call to an
  /// owner-only route is rejected.
  Future<AuthSession?> refreshSession();

  Future<void> signOut();

  /// Drops the local session without touching the hosted-UI one.
  ///
  /// This is the 401 path: the server has already rejected the tokens, so
  /// there is nothing to end remotely and no reason to open a browser at
  /// someone whose session simply expired. Separate from [signOut] because
  /// that one deliberately ends the provider session too.
  Future<void> clearSession();
}

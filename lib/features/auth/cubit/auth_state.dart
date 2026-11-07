import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    /// Where the user belongs, decided by `AuthRouter` from [profile] and
    /// [shop]. Null while that is still being worked out — the splash shows
    /// until it resolves.
    AuthDestination? destination,

    AuthSession? session,

    /// The server's view of the user, from `GET /me`. The authority on the
    /// role — the ID token's claims are only a hint and go stale the moment a
    /// role is set.
    UserProfile? profile,

    /// Owners only, and null until `GET /me/shop` has answered.
    Shop? shop,

    /// Tapped but not yet confirmed. Separate from [profile]'s role, which
    /// changes only once the server has accepted it.
    UserRole? selectedRole,

    /// Which provider button is waiting, so only that one spins.
    AuthProviderKind? pendingProvider,

    @Default(false) bool isSubmitting,
    NetworkException? failure,
  }) = _AuthState;

  const AuthState._();

  bool get isAuthenticating => pendingProvider != null;

  bool get isBusy => isAuthenticating || isSubmitting;
}

import 'dart:convert';

import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/user_profile.dart';

/// The claims the app reads out of a Cognito ID token.
///
/// Decoding rather than calling `GET /me` on every launch: the token already
/// carries the identity, and the profile endpoint does not exist yet.
///
/// The signature is **not** verified here, and does not need to be — the token
/// came straight from Cognito's token endpoint over TLS and never left the
/// device. The API gateway is what verifies it on the way back in.
abstract final class IdTokenClaims {
  /// Cognito puts group membership in `cognito:groups`; the pool defines an
  /// `owners` group, so anyone in it is an owner and everyone else a customer.
  static const String _ownersGroup = 'owners';

  static Map<String, dynamic>? decode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;

    try {
      final payload = parts[1];
      // JWTs use base64url without padding; `base64Url.decode` wants it.
      final normalised = base64Url.normalize(payload);
      final json = utf8.decode(base64Url.decode(normalised));
      return jsonDecode(json) as Map<String, dynamic>;
    } on FormatException {
      return null;
    }
  }

  /// Builds a profile from a decoded token, or null if the token is unusable.
  static UserProfile? profileFrom(String token) {
    final claims = decode(token);
    final id = claims?['sub'] as String?;
    if (claims == null || id == null) return null;

    return UserProfile(
      id: id,
      // Apple only sends a name on the very first sign-in, so a returning user
      // can legitimately have none. The email is the fallback the design uses.
      name: (claims['name'] as String?) ?? (claims['email'] as String? ?? ''),
      email: claims['email'] as String? ?? '',
      phone: claims['phone_number'] as String?,
      role: _roleFrom(claims),
    );
  }

  /// Which provider this account is federated through.
  ///
  /// Read from the token rather than remembered from the tap, because a
  /// restored session has no tap to remember — and the provider is not only a
  /// sign-in detail, the profile screen names it back to the user.
  ///
  /// Null when the token names no provider the app knows. Naming nothing is
  /// the right failure here; naming the wrong company on someone's own
  /// profile is not.
  static AuthProviderKind? providerFrom(String token) {
    // Cognito writes `identities` as an array of objects, one per federated
    // identity, with the pool's own name for the provider in `providerName`.
    final identities = decode(token)?['identities'];
    if (identities is! List || identities.isEmpty) return null;

    final first = identities.first;
    final name = first is Map ? first['providerName'] : null;

    return switch (name) {
      'SignInWithApple' => AuthProviderKind.apple,
      'Google' => AuthProviderKind.google,
      _ => null,
    };
  }

  /// When the token carries no group the role is simply unknown, which is
  /// different from "customer" — it is what sends a first-time user to the
  /// role screen.
  static UserRole? _roleFrom(Map<String, dynamic> claims) {
    final groups = claims['cognito:groups'];
    if (groups is! List) return null;
    return groups.contains(_ownersGroup) ? UserRole.owner : null;
  }

  /// Seconds-since-epoch `exp`, as a real time.
  static DateTime? expiryOf(String token) {
    final exp = decode(token)?['exp'];
    if (exp is! int) return null;
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
  }
}

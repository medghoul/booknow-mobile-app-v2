import 'dart:convert';

import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/repositories/id_token_claims.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a token with the given claims. Only the payload matters — nothing
/// here verifies the signature, and nothing should: the token arrives from
/// Cognito over TLS and the API is what validates it.
String tokenWith(Map<String, dynamic> claims) {
  String segment(Map<String, dynamic> value) =>
      base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');

  return '${segment({'alg': 'RS256'})}.${segment(claims)}.signature';
}

void main() {
  group('profileFrom', () {
    test('reads sub, name and email', () {
      final profile = IdTokenClaims.profileFrom(
        tokenWith({
          'sub': 'abc-123',
          'name': 'Marco Rinaldi',
          'email': 'marco@example.com',
        }),
      );

      expect(profile?.id, 'abc-123');
      expect(profile?.name, 'Marco Rinaldi');
      expect(profile?.email, 'marco@example.com');
    });

    test('falls back to the email when the provider sent no name', () {
      // Apple only sends a name on the very first sign-in, so a returning
      // user legitimately has none.
      final profile = IdTokenClaims.profileFrom(
        tokenWith({'sub': 'abc-123', 'email': 'marco@example.com'}),
      );

      expect(profile?.name, 'marco@example.com');
    });

    test('membership of the owners group makes an owner', () {
      final profile = IdTokenClaims.profileFrom(
        tokenWith({
          'sub': 'abc-123',
          'email': 'a@b.c',
          'cognito:groups': ['owners'],
        }),
      );

      expect(profile?.role, UserRole.owner);
    });

    test('no group means no role, which is not the same as customer', () {
      final profile = IdTokenClaims.profileFrom(
        tokenWith({'sub': 'abc-123', 'email': 'a@b.c'}),
      );

      // A null role is what sends a first-time user to the role screen;
      // defaulting to customer here would skip it silently.
      expect(profile?.role, isNull);
      expect(profile?.hasRole, isFalse);
    });

    test('a malformed token yields nothing rather than throwing', () {
      expect(IdTokenClaims.profileFrom('not-a-jwt'), isNull);
      expect(IdTokenClaims.profileFrom('a.b'), isNull);
      expect(IdTokenClaims.profileFrom('a.!!!.c'), isNull);
    });

    test('a token with no sub is unusable', () {
      expect(IdTokenClaims.profileFrom(tokenWith({'email': 'a@b.c'})), isNull);
    });
  });

  group('providerFrom', () {
    Map<String, dynamic> identity(String name) => {
      'sub': 'abc-123',
      'identities': [
        {'userId': '001.abc', 'providerName': name, 'providerType': name},
      ],
    };

    // The pool's own names for the two providers, not the app's.
    test('reads the pool name for each provider', () {
      expect(
        IdTokenClaims.providerFrom(tokenWith(identity('SignInWithApple'))),
        AuthProviderKind.apple,
      );
      expect(
        IdTokenClaims.providerFrom(tokenWith(identity('Google'))),
        AuthProviderKind.google,
      );
    });

    // This is the whole point of reading the token: a restored session has
    // no tap behind it, and a default would name the wrong company on the
    // user's own profile.
    test('a provider the app does not know names nobody', () {
      expect(
        IdTokenClaims.providerFrom(tokenWith(identity('Facebook'))),
        isNull,
      );
    });

    test('a token with no identities names nobody', () {
      expect(IdTokenClaims.providerFrom(tokenWith({'sub': 'x'})), isNull);
      expect(
        IdTokenClaims.providerFrom(tokenWith({'sub': 'x', 'identities': []})),
        isNull,
      );
    });

    test('an identities claim of the wrong shape does not throw', () {
      expect(
        IdTokenClaims.providerFrom(
          tokenWith({'sub': 'x', 'identities': 'SignInWithApple'}),
        ),
        isNull,
      );
      expect(
        IdTokenClaims.providerFrom(
          tokenWith({
            'sub': 'x',
            'identities': ['SignInWithApple'],
          }),
        ),
        isNull,
      );
    });
  });

  group('expiryOf', () {
    test('reads exp as a UTC time', () {
      final expiry = DateTime.utc(2030, 1, 1);
      final token = tokenWith({
        'sub': 'x',
        'exp': expiry.millisecondsSinceEpoch ~/ 1000,
      });

      expect(IdTokenClaims.expiryOf(token), expiry);
    });

    test('is null when the claim is missing or not a number', () {
      expect(IdTokenClaims.expiryOf(tokenWith({'sub': 'x'})), isNull);
      expect(
        IdTokenClaims.expiryOf(tokenWith({'sub': 'x', 'exp': 'soon'})),
        isNull,
      );
    });
  });
}

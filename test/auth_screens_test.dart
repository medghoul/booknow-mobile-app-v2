import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// A cubit whose state the test sets directly, so a screen can be pumped in
/// any state without driving the whole journey to get there.
class _StubAuthCubit extends Cubit<AuthState> implements AuthCubit {
  _StubAuthCubit(super.initialState);

  UserRole? selectedRole;
  bool confirmed = false;
  String? savedName;
  String? savedPhone;
  bool skipped = false;

  @override
  void selectRole(UserRole role) {
    selectedRole = role;
    emit(state.copyWith(selectedRole: role));
  }

  @override
  Future<void> confirmRole() async => confirmed = true;

  @override
  Future<void> saveProfile({required String name, String? phone}) async {
    savedName = name;
    savedPhone = phone;
  }

  @override
  Future<void> skipProfile() async => skipped = true;

  @override
  Future<void> signInWith(
    AuthProviderKind provider, {
    UserRole role = UserRole.customer,
  }) async {}

  @override
  Future<void> restore() async {}

  @override
  Future<void> signOut() async {}

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();

  const profile = UserProfile(
    id: 'u1',
    name: 'Marco Rinaldi',
    email: 'marco.rinaldi@icloud.com',
  );

  const session = AuthSession(
    accessToken: 'token',
    provider: AuthProviderKind.apple,
    profile: profile,
  );

  Future<_StubAuthCubit> pumpWith(
    WidgetTester tester,
    Widget view,
    AuthState state,
  ) async {
    final cubit = _StubAuthCubit(state);
    await pumpThemed(
      tester,
      BlocProvider<AuthCubit>.value(value: cubit, child: view),
    );
    return cubit;
  }

  group('SignInView', () {
    testWidgets('offers Apple first on an iPhone', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);

      await pumpWith(
        tester,
        SignInView(onCreateAccount: () {}),
        const AuthState(),
      );

      final apple = tester.getTopLeft(find.text(t.auth.continueWithApple)).dy;
      final google = tester.getTopLeft(find.text(t.auth.continueWithGoogle)).dy;

      expect(apple, lessThan(google));
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('offers Google first on Android', (tester) async {
      await pumpWith(
        tester,
        SignInView(onCreateAccount: () {}),
        const AuthState(),
      );

      final apple = tester.getTopLeft(find.text(t.auth.continueWithApple)).dy;
      final google = tester.getTopLeft(find.text(t.auth.continueWithGoogle)).dy;

      expect(google, lessThan(apple));
    });

    testWidgets('spins only the provider being used', (tester) async {
      await pumpWith(
        tester,
        SignInView(onCreateAccount: () {}),
        const AuthState(pendingProvider: AuthProviderKind.apple),
      );

      expect(find.text(t.auth.continueWithApple), findsNothing);
      expect(find.text(t.auth.continueWithGoogle), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('create-account is wired', (tester) async {
      var tapped = false;
      await pumpWith(
        tester,
        SignInView(onCreateAccount: () => tapped = true),
        const AuthState(),
      );

      await tester.tap(find.text(t.auth.signIn.createAccount));
      expect(tapped, isTrue);
    });
  });

  group('SignUpView', () {
    testWidgets('lists the three reassurances', (tester) async {
      await pumpWith(
        tester,
        SignUpView(onSignInInstead: () {}),
        const AuthState(),
      );

      expect(find.text(t.auth.signUp.noCardTitle), findsOneWidget);
      expect(find.text(t.auth.signUp.dataTitle), findsOneWidget);
      expect(find.text(t.auth.signUp.roleTitle), findsOneWidget);
    });
  });

  group('RoleView', () {
    testWidgets('continue is disabled until a role is chosen', (tester) async {
      await pumpWith(
        tester,
        const RoleView(),
        const AuthState(profile: profile, session: session),
      );

      final button = tester.widget<AppElevatedButton>(
        find.byType(AppElevatedButton),
      );
      expect(button.isDisabled, isTrue);
    });

    testWidgets('tapping a card selects it without submitting', (tester) async {
      final cubit = await pumpWith(
        tester,
        const RoleView(),
        const AuthState(profile: profile, session: session),
      );

      await tester.tap(find.text(t.auth.role.ownerTitle));
      await tester.pumpAndSettle();

      expect(cubit.selectedRole, UserRole.owner);
      expect(cubit.confirmed, isFalse);
    });

    testWidgets('greets the user by first name', (tester) async {
      await pumpWith(
        tester,
        const RoleView(),
        const AuthState(profile: profile, session: session),
      );

      expect(
        find.text(t.auth.role.greeting(name: 'Marco').toUpperCase()),
        findsOneWidget,
      );
    });
  });

  group('ProfileSetupView', () {
    testWidgets('pre-fills the name the provider sent', (tester) async {
      await pumpWith(
        tester,
        const ProfileSetupView(),
        const AuthState(profile: profile, session: session),
      );

      expect(find.text('Marco Rinaldi'), findsWidgets);
    });

    testWidgets('refuses to save an empty name', (tester) async {
      final cubit = await pumpWith(
        tester,
        const ProfileSetupView(),
        const AuthState(profile: profile, session: session),
      );

      await tester.enterText(find.byType(AppTextField).first, '');
      await tester.tap(find.text(t.auth.profile.save));
      await tester.pumpAndSettle();

      expect(cubit.savedName, isNull);
      expect(find.text(t.auth.profile.nameRequired), findsOneWidget);
    });

    testWidgets('saves the trimmed name and the phone', (tester) async {
      final cubit = await pumpWith(
        tester,
        const ProfileSetupView(),
        const AuthState(profile: profile, session: session),
      );

      await tester.enterText(find.byType(AppTextField).first, '  Marco R.  ');
      await tester.enterText(find.byType(AppPhoneField), '347 8821 940');
      await tester.tap(find.text(t.auth.profile.save));
      await tester.pumpAndSettle();

      expect(cubit.savedName, 'Marco R.');
      expect(cubit.savedPhone, '347 8821 940');
    });

    testWidgets('can be skipped', (tester) async {
      final cubit = await pumpWith(
        tester,
        const ProfileSetupView(),
        const AuthState(profile: profile, session: session),
      );

      await tester.tap(find.text(t.common.skip));
      await tester.pumpAndSettle();

      expect(cubit.skipped, isTrue);
    });
  });
}

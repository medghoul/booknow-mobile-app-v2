import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/features/auth/widgets/guest_views.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_test.dart' show pumpThemed;

/// Signing in only records what was asked; the test emits the session and the
/// profile itself, in the order the real cubit does, with a frame between.
class _StubAuthCubit extends Cubit<AuthState> implements AuthCubit {
  _StubAuthCubit() : super(const AuthState());

  UserRole? askedFor;

  @override
  Future<void> signInWith(
    AuthProviderKind provider, {
    UserRole role = UserRole.customer,
  }) async => askedFor = role;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// What the Profile tab does with the auth state: the guest view until there
/// is a session, a loader until the profile arrives, then the account.
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: di<AuthCubit>(),
      builder: (context, auth) {
        if (auth.profile != null) {
          return const AppScaffold(body: Text('signed in'));
        }
        return auth.session == null
            ? const GuestProfileView()
            : const AppScaffold(body: Center(child: AppLoader()));
      },
    );
  }
}

void main() {
  final t = AppLocale.en.buildSync();
  late _StubAuthCubit auth;

  const customer = UserProfile(
    id: 'u1',
    name: 'Ada Rossi',
    email: 'ada@example.com',
    role: UserRole.customer,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    auth = _StubAuthCubit();
    di.registerSingleton<AuthCubit>(auth);
    di.registerSingleton<ThemeService>(
      ThemeService(await PrefsService.create()),
    );
  });

  tearDown(() async => di.reset());

  Future<void> signInFromTheOwnerSheet(WidgetTester tester) async {
    await pumpThemed(tester, const _ProfileTab());
    await tester.scrollUntilVisible(find.text(t.guest.ownerTitle), 200);
    await tester.tap(find.text(t.guest.ownerTitle));
    await tester.pumpAndSettle();

    final sheet = find.byType(BottomSheet);
    await tester.tap(
      find.descendant(
        of: sheet,
        matching: find.text(t.auth.continueWithGoogle),
      ),
    );
    await tester.pump();
  }

  testWidgets('signs in asking for an owner account', (tester) async {
    await signInFromTheOwnerSheet(tester);

    expect(auth.askedFor, UserRole.owner);
  });

  testWidgets(
    'a customer account stays signed in and is told why it is not a shop',
    (tester) async {
      await signInFromTheOwnerSheet(tester);

      // The session first: the tab swaps the guest view out for a loader.
      auth.emit(
        const AuthState(
          session: AuthSession(accessToken: 'token', profile: customer),
        ),
      );
      await tester.pump();

      auth.emit(
        auth.state.copyWith(
          profile: customer,
          destination: const AuthDestination.customerHome(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(t.guest.ownerCustomerAccount), findsOneWidget);
      expect(find.byType(BottomSheet), findsNothing);
      expect(find.text('signed in'), findsOneWidget);
    },
  );
}

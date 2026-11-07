import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Only the state matters here; the listener never calls a method on it.
class _StubAuthCubit extends Cubit<AuthState> implements AuthCubit {
  _StubAuthCubit() : super(const AuthState());

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _StubAuthCubit auth;

  setUp(() {
    auth = _StubAuthCubit();
    di.registerSingleton<AuthCubit>(auth);
  });

  tearDown(() async {
    await di.reset();
  });

  // The wizard and the notification screen mount the listener without a
  // `BlocProvider` above it, because `AuthCubit` is a get_it singleton rather
  // than a scoped provider. Looking it up through the tree threw
  // ProviderNotFoundException and took the whole route down.
  testWidgets('builds with no BlocProvider above it', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthStepListener(child: Scaffold(body: Text('child'))),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('child'), findsOneWidget);
  });

  // The wizard is one route whose step is state, so a step change must not
  // send the listener navigating — that would rebuild the cubit and throw away
  // the half-filled form.
  test('a step change resolves to the same route', () {
    const first = ShopSetupDestination(ShopSetupStep.shop);
    const later = ShopSetupDestination(ShopSetupStep.hours);

    expect(first, isNot(later), reason: 'different values...');
    expect(
      AuthStepListener.routeFor(first)?.routeName,
      AuthStepListener.routeFor(later)?.routeName,
      reason: '...but the same screen',
    );
    expect(
      AuthStepListener.routeFor(later),
      isA<ShopSetupRoute>().having(
        (route) => (route.args as ShopSetupRouteArgs).initialStep,
        'initialStep',
        ShopSetupStep.hours,
      ),
    );
  });

  group('shouldNavigate', () {
    const signIn = SignInDestination();
    const agenda = OwnerAgendaDestination();
    const stepOne = ShopSetupDestination(ShopSetupStep.shop);
    const stepFour = ShopSetupDestination(ShopSetupStep.hours);

    test('a step change does not navigate', () {
      expect(AuthStepListener.shouldNavigate(stepOne, stepFour), isFalse);
    });

    test('an unchanged destination does not navigate', () {
      expect(AuthStepListener.shouldNavigate(signIn, signIn), isFalse);
    });

    test('leaving the wizard navigates', () {
      expect(AuthStepListener.shouldNavigate(stepFour, agenda), isTrue);
    });

    test('a different screen navigates', () {
      expect(AuthStepListener.shouldNavigate(signIn, agenda), isTrue);
    });

    test('the first resolved destination navigates', () {
      expect(AuthStepListener.shouldNavigate(null, stepOne), isTrue);
    });

    test('an unresolved destination never navigates', () {
      expect(AuthStepListener.shouldNavigate(signIn, null), isFalse);
      expect(AuthStepListener.shouldNavigate(null, null), isFalse);
    });
  });

  group('value equality', () {
    test('cases with no fields are equal', () {
      expect(const SignInDestination(), const SignInDestination());
      expect(const OwnerAgendaDestination(), const OwnerAgendaDestination());
    });

    test('different cases are not equal', () {
      expect(const SignInDestination(), isNot(const RoleChoiceDestination()));
    });

    test('a case with a field compares on that field', () {
      expect(
        const ShopSetupDestination(ShopSetupStep.hours),
        const ShopSetupDestination(ShopSetupStep.hours),
      );
      expect(
        const ShopSetupDestination(ShopSetupStep.hours),
        isNot(const ShopSetupDestination(ShopSetupStep.shop)),
      );
    });

    test('equal destinations share a hashCode', () {
      expect(
        const ShopSetupDestination(ShopSetupStep.review).hashCode,
        const ShopSetupDestination(ShopSetupStep.review).hashCode,
      );
    });
  });

  test('every destination maps to a route', () {
    const destinations = <AuthDestination>[
      SignInDestination(),
      RoleChoiceDestination(),
      ProfileSetupDestination(),
      NotificationPermissionDestination(),
      OwnerAgendaDestination(),
      CustomerHomeDestination(),
    ];

    for (final destination in destinations) {
      expect(
        AuthStepListener.routeFor(destination),
        isNotNull,
        reason: '$destination has no route',
      );
    }
  });
}

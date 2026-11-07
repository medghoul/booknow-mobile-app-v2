import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:booknow_mobile/features/onboarding/widgets/onboarding_view.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  late PrefsService prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await PrefsService.create();
  });

  Future<void> pumpDeck(
    WidgetTester tester, {
    VoidCallback? onFinished,
    VoidCallback? onSignInInstead,
  }) async {
    await pumpThemed(
      tester,
      BlocProvider(
        create: (_) => OnboardingCubit(prefs),
        child: OnboardingView(
          onFinished: onFinished ?? () {},
          onSignInInstead: onSignInInstead ?? () {},
        ),
      ),
    );
  }

  final t = AppLocale.en.buildSync();

  group('OnboardingView', () {
    testWidgets('opens on the first slide', (tester) async {
      await pumpDeck(tester);

      expect(find.text(t.onboarding.slideOne.title), findsOneWidget);
      expect(find.text(t.onboarding.next), findsOneWidget);
    });

    testWidgets('the last slide swaps Next for the two real choices', (
      tester,
    ) async {
      await pumpDeck(tester);

      for (var i = 0; i < OnboardingCubit.slideCount - 1; i++) {
        await tester.tap(find.text(t.onboarding.next));
        await tester.pumpAndSettle();
      }

      expect(find.text(t.onboarding.next), findsNothing);
      expect(find.text(t.onboarding.start), findsOneWidget);
      expect(find.text(t.onboarding.haveAccount), findsOneWidget);
    });

    testWidgets('the last slide drops skip, so it ends in a decision', (
      tester,
    ) async {
      await pumpDeck(tester);
      expect(find.text(t.onboarding.skip), findsOneWidget);

      for (var i = 0; i < OnboardingCubit.slideCount - 1; i++) {
        await tester.tap(find.text(t.onboarding.next));
        await tester.pumpAndSettle();
      }

      expect(find.text(t.onboarding.skip), findsNothing);
    });

    testWidgets('skipping marks onboarding seen and finishes', (tester) async {
      var finished = false;
      await pumpDeck(tester, onFinished: () => finished = true);

      await tester.tap(find.text(t.onboarding.skip));
      await tester.pumpAndSettle();

      expect(finished, isTrue);
      expect(prefs.onboardingSeen, isTrue);
    });

    testWidgets('"I already have an account" also marks it seen', (
      tester,
    ) async {
      var wentToSignIn = false;
      await pumpDeck(tester, onSignInInstead: () => wentToSignIn = true);

      for (var i = 0; i < OnboardingCubit.slideCount - 1; i++) {
        await tester.tap(find.text(t.onboarding.next));
        await tester.pumpAndSettle();
      }
      await tester.tap(find.text(t.onboarding.haveAccount));
      await tester.pumpAndSettle();

      expect(wentToSignIn, isTrue);
      expect(prefs.onboardingSeen, isTrue);
    });
  });

  group('OnboardingCubit', () {
    test('knows when it is on the last slide', () {
      final cubit = OnboardingCubit(prefs);

      expect(cubit.isLastSlide, isFalse);
      cubit.onPageChanged(OnboardingCubit.slideCount - 1);
      expect(cubit.isLastSlide, isTrue);

      cubit.close();
    });
  });
}

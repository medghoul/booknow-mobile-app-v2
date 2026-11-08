import 'package:booknow_mobile/core/constants/app_animations.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:booknow_mobile/features/onboarding/widgets/onboarding_view.dart';
import 'package:booknow_mobile/features/splash/widgets/splash_mark.dart';
import 'package:booknow_mobile/features/splash/widgets/splash_view.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  group('AppStagger.delayAt', () {
    test('each child starts a beat after the one above', () {
      expect(AppStagger.delayAt(0), AppAnimations.delayXS);
      expect(
        AppStagger.delayAt(1),
        AppAnimations.delayXS + AppAnimations.delayXS,
      );
      expect(
        AppStagger.delayAt(2),
        AppAnimations.delayXS + 2 * AppAnimations.delayXS,
      );
    });

    // Without the ceiling a long list ends with items trickling in well after
    // the user has started reading, and on a list that scrolls they arrive
    // off-screen anyway.
    test('the climb stops at the cap', () {
      expect(AppStagger.delayAt(50), AppStagger.maxDelay);
      expect(AppStagger.delayAt(500), AppStagger.maxDelay);
    });

    test('the cap is never below the first delay', () {
      expect(AppStagger.maxDelay, greaterThanOrEqualTo(AppAnimations.delayXS));
    });
  });

  group('AppFadeIn', () {
    testWidgets('runs when motion is allowed', (tester) async {
      await pumpThemed(
        tester,
        const AppFadeIn.up(child: Text('hello')),
        animations: true,
      );

      expect(find.byType(Animate), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('hello'), findsOneWidget);
    });

    // Reduce Motion is a setting the user turned on deliberately, and an
    // entrance that starts at zero opacity is exactly what it is for.
    testWidgets('steps out of the way under Reduce Motion', (tester) async {
      await pumpThemed(tester, const AppFadeIn.up(child: Text('hello')));

      expect(find.byType(Animate), findsNothing);
      expect(find.text('hello'), findsOneWidget);
    });

    testWidgets('an upward entrance ends where it would have sat anyway', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        const AppFadeIn.up(child: Text('hello')),
        animations: true,
      );
      final arriving = tester.getTopLeft(find.text('hello')).dy;

      await tester.pumpAndSettle();
      final settled = tester.getTopLeft(find.text('hello')).dy;

      // Up means it starts lower down and travels to its resting place.
      expect(arriving, greaterThan(settled));
    });

    testWidgets('a downward entrance travels the other way', (tester) async {
      await pumpThemed(
        tester,
        const AppFadeIn.down(child: Text('hello')),
        animations: true,
      );
      final arriving = tester.getTopLeft(find.text('hello')).dy;

      await tester.pumpAndSettle();
      expect(arriving, lessThan(tester.getTopLeft(find.text('hello')).dy));
    });

    testWidgets('a plain fade does not move at all', (tester) async {
      await pumpThemed(
        tester,
        const AppFadeIn(child: Text('hello')),
        animations: true,
      );
      final arriving = tester.getTopLeft(find.text('hello')).dy;

      await tester.pumpAndSettle();
      expect(arriving, tester.getTopLeft(find.text('hello')).dy);
    });
  });

  group('AppDockedColumn', () {
    // Settled before asserting: `Animate` arms a timer on mount, and leaving
    // it pending fails the test at teardown rather than at the assertion.
    Future<void> pumpColumn(WidgetTester tester, {bool animate = true}) async {
      await pumpThemed(
        tester,
        AppDockedColumn(
          animate: animate,
          docked: const Text('action'),
          children: const [Text('one'), Text('two'), Text('three')],
        ),
        animations: true,
      );
      await tester.pumpAndSettle();
    }

    List<AppFadeIn> entrances(WidgetTester tester) =>
        tester.widgetList<AppFadeIn>(find.byType(AppFadeIn)).toList();

    testWidgets('every child and the action get an entrance', (tester) async {
      await pumpColumn(tester);

      expect(entrances(tester), hasLength(4));
    });

    testWidgets('the content arrives top down', (tester) async {
      await pumpColumn(tester);

      final delays = entrances(tester).take(3).map((e) => e.delay).toList();
      expect(delays, [
        AppStagger.delayAt(0),
        AppStagger.delayAt(1),
        AppStagger.delayAt(2),
      ]);
    });

    // The action acts on the content above it, so it has no business landing
    // first.
    testWidgets('the docked action lands last', (tester) async {
      await pumpColumn(tester);

      final all = entrances(tester);
      expect(all.last.delay, greaterThan(all[2].delay));
    });

    testWidgets('a standing layout can opt out', (tester) async {
      await pumpColumn(tester, animate: false);

      expect(find.byType(AppFadeIn), findsNothing);
      expect(find.text('one'), findsOneWidget);
      expect(find.text('action'), findsOneWidget);
    });
  });

  group('SplashView', () {
    testWidgets('names the app while the session is restored', (tester) async {
      await pumpThemed(tester, const SplashView(leaving: false));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('BookNow'), findsOneWidget);
    });

    // The native launch screen shows the tile; an empty navy frame before it
    // grew back in read as a blank blue screen.
    testWidgets('shows the mark on its first frame', (tester) async {
      await pumpThemed(
        tester,
        const SplashView(leaving: false),
        animations: true,
      );

      final mark = find.text('B');
      expect(mark, findsOneWidget);
      expect(
        find.ancestor(of: mark, matching: find.byType(ScaleTransition)),
        findsNothing,
      );
      // Where the launch screen draws its picture: the middle of the screen.
      expect(
        tester.getCenter(find.byType(SplashMark)),
        tester.getCenter(find.byType(SplashView)),
      );
    });

    testWidgets('a queue line does not move the mark', (tester) async {
      await pumpThemed(tester, const SplashView(leaving: false));
      final before = tester.getCenter(find.text('B'));

      await pumpThemed(
        tester,
        const SplashView(leaving: false, queueLine: "You're #3 at Barbieri"),
      );
      await tester.pumpAndSettle();

      expect(find.text("You're #3 at Barbieri"), findsOneWidget);
      expect(tester.getCenter(find.text('B')), before);
    });

    testWidgets('hands over once it has contracted', (tester) async {
      var finished = false;
      Widget view({required bool leaving}) =>
          SplashView(leaving: leaving, onFinished: () => finished = true);

      await pumpThemed(tester, view(leaving: false), animations: true);
      await pumpThemed(tester, view(leaving: true), animations: true);
      await tester.pump(const Duration(seconds: 1));

      expect(finished, isTrue);
    });
  });

  group('OnboardingView entrance', () {
    late PrefsService prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await PrefsService.create();
    });

    Future<void> pumpDeck(WidgetTester tester, {bool animations = false}) =>
        pumpThemed(
          tester,
          BlocProvider(
            create: (_) => OnboardingCubit(prefs),
            child: OnboardingView(onFinished: () {}, onSignInInstead: () {}),
          ),
          animations: animations,
        );

    List<AppFadeIn> entrances(WidgetTester tester) =>
        tester.widgetList<AppFadeIn>(find.byType(AppFadeIn)).toList();

    testWidgets('the whole deck arrives, top down', (tester) async {
      await pumpDeck(tester);

      final delays = entrances(tester).map((e) => e.delay).toList();
      expect(delays, [
        AppStagger.delayAt(0),
        AppStagger.delayAt(1),
        AppStagger.delayAt(2),
        AppStagger.delayAt(3),
      ]);
    });

    // Skip is pinned to the top of the screen, and content anchored there
    // reads wrong travelling up past where it ends.
    testWidgets('skip drops in; everything below it rises', (tester) async {
      await pumpDeck(tester);

      final all = entrances(tester);
      expect(all.first.from, FadeFrom.down);
      expect(all.skip(1).map((e) => e.from), everyElement(FadeFrom.up));
    });

    // This view rebuilds on every page change, and a re-run of the entrance
    // would blink the whole deck mid-swipe. Each wrapper keeps its position
    // and its type, so `Animate` holds its state — which is what this checks,
    // because a surviving state is exactly what "did not re-run" means.
    testWidgets('swiping does not replay the entrance', (tester) async {
      await pumpDeck(tester, animations: true);
      await tester.pumpAndSettle();

      final before = tester
          .stateList<State>(find.byType(Animate))
          .toList(growable: false);

      await tester.tap(find.text(AppLocale.en.buildSync().onboarding.next));
      await tester.pumpAndSettle();

      final after = tester
          .stateList<State>(find.byType(Animate))
          .toList(growable: false);

      expect(after, hasLength(before.length));
      for (var i = 0; i < before.length; i++) {
        expect(
          identical(before[i], after[i]),
          isTrue,
          reason: 'entrance $i remounted',
        );
      }
    });
  });
}

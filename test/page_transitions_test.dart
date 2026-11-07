import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/constants/app_animations.dart';
import 'package:booknow_mobile/routing/app_page_transitions.dart';
import 'package:booknow_mobile/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  group('AppPageTransitions.fade', () {
    /// Runs the builder the way `PageRouteBuilder` would, against a controller
    /// parked at a fixed point — the transition is a pure function of its
    /// animation, so there is no need for a real navigation to exercise it.
    Future<void> pumpTransition(
      WidgetTester tester, {
      required bool animations,
      double at = 0,
    }) => pumpThemed(
      tester,
      _Harness(at: at, builder: AppPageTransitions.fade),
      animations: animations,
    );

    /// Only the fade the builder added. `pumpThemed` mounts a `MaterialApp`,
    /// whose own page route carries four `FadeTransition`s of its own, so an
    /// unscoped finder matches five and proves nothing.
    Finder fade() => find.descendant(
      of: find.byType(_Harness),
      matching: find.byType(FadeTransition),
    );

    double opacityOf(WidgetTester tester) =>
        tester.widget<FadeTransition>(fade()).opacity.value;

    testWidgets('fades the arriving screen in', (tester) async {
      await pumpTransition(tester, animations: true, at: 0);

      expect(fade(), findsOneWidget);
      expect(opacityOf(tester), 0);
    });

    testWidgets('reaches full opacity at the end', (tester) async {
      await pumpTransition(tester, animations: true, at: 1);

      expect(opacityOf(tester), 1);
    });

    // Reduce Motion is a setting the user turned on deliberately, and one
    // screen dissolving into another is exactly what it is for.
    testWidgets('steps out of the way under Reduce Motion', (tester) async {
      await pumpTransition(tester, animations: false, at: 0);

      expect(fade(), findsNothing);
      // Not merely invisible — fully present, from the first frame.
      expect(find.text('arriving'), findsOneWidget);
    });

    test('its duration is a token, not a loose number', () {
      expect(
        AppPageTransitions.duration,
        const Duration(milliseconds: AppAnimations.durationXS),
      );
    });
  });

  // The real risk is not this transition being wrong, it is route number
  // eleven being added without one and quietly falling back to the platform
  // default — which differs between iOS and Android and matches neither.
  group('AppRouter', () {
    test('every route uses the app transition, at the app duration', () {
      final routes = AppRouter().routes;
      expect(routes, isNotEmpty);

      for (final route in routes) {
        final type = route.type;
        expect(
          type,
          isA<CustomRouteType>(),
          reason: '${route.path} falls back to the platform transition',
        );

        final custom = type! as CustomRouteType;
        // A shop screen grows out of its card; everything else fades.
        expect(
          custom.transitionsBuilder,
          route.path == '/book/:shopId' || route.path == '/queue/:shopId'
              ? same(AppPageTransitions.grow)
              : same(AppPageTransitions.fade),
          reason: '${route.path} uses a different transition',
        );
        expect(custom.duration, AppPageTransitions.duration);
        expect(custom.reverseDuration, AppPageTransitions.duration);
      }
    });

    test('exactly one route is the entry point', () {
      final initial = AppRouter().routes.where((route) => route.initial);
      expect(initial, hasLength(1));
      expect(initial.single.path, '/');
    });
  });
}

/// Drives a transition builder at a fixed point on its animation.
class _Harness extends StatefulWidget {
  const _Harness({required this.at, required this.builder});

  final double at;
  final RouteTransitionsBuilder builder;

  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppPageTransitions.duration,
    value: widget.at,
  );
  late final AnimationController _secondary = AnimationController(
    vsync: this,
    duration: AppPageTransitions.duration,
  );

  @override
  void dispose() {
    _controller.dispose();
    _secondary.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _controller, _secondary, const Text('arriving'));
}

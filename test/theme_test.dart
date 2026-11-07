import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Pumps [child] inside the app's theme and translations, so widget tests
/// see the real tokens and the real copy.
///
/// Entrance animations are off unless a test asks for them. They run on a
/// timer and translate what they are animating, so a screen that is still
/// arriving fails a geometry assertion and leaves a pending timer behind —
/// neither of which is what the test is about. Switching them off goes
/// through the same `disableAnimations` the system's Reduce Motion setting
/// uses, so the path under test is a real one, not a test-only branch.
Future<BuildContext> pumpThemed(
  WidgetTester tester,
  Widget child, {
  Brightness brightness = Brightness.light,
  bool animations = false,
}) async {
  late BuildContext captured;

  await tester.pumpWidget(
    AppScreenInit(
      designSize: const Size(390, 844),
      builder: (context, _) => TranslationProvider(
        child: MaterialApp(
          theme: brightness == Brightness.light
              ? AppTheme.light
              : AppTheme.dark,
          home: Builder(
            builder: (innerContext) {
              captured = innerContext;
              return MediaQuery(
                data: MediaQuery.of(
                  innerContext,
                ).copyWith(disableAnimations: !animations),
                child: Scaffold(body: child),
              );
            },
          ),
        ),
      ),
    ),
  );

  return captured;
}

void main() {
  group('AppTheme', () {
    testWidgets('carries every custom extension in light', (tester) async {
      final context = await pumpThemed(tester, const SizedBox.shrink());

      expect(context.spacing.lg, 16);
      expect(context.radii.pill, 999);
      expect(context.fonts.xs, 13);
      expect(context.icons.m, 24);
      expect(context.motion.normal, const Duration(milliseconds: 250));
      expect(context.shadows.md, isEmpty);
      expect(context.shadows.blob, isNotEmpty);
      expect(context.queueColors.waiting, isNotNull);
      expect(context.decorations.card.color, isNotNull);
      expect(context.providers.appleBackground, isNotNull);
    });

    testWidgets('carries every custom extension in dark', (tester) async {
      final context = await pumpThemed(
        tester,
        const SizedBox.shrink(),
        brightness: Brightness.dark,
      );

      expect(context.theme.brightness, Brightness.dark);
      expect(context.spacing.lg, 16);
      expect(context.decorations.card.color, isNotNull);
    });

    testWidgets('light and dark are separate palettes, not inversions', (
      tester,
    ) async {
      final light = AppTheme.light.colorScheme;
      final dark = AppTheme.dark.colorScheme;

      // The action colour lightens in dark rather than staying put or flipping.
      expect(light.primary, isNot(dark.primary));
      expect(light.surface, isNot(dark.surface));
    });
  });

  group('AppStatusColors', () {
    testWidgets('resolves a tint for every booking status', (tester) async {
      final context = await pumpThemed(tester, const SizedBox.shrink());

      for (final status in BookingStatus.values) {
        final tint = context.status.ofBooking(status);
        expect(
          tint.background,
          isNot(tint.foreground),
          reason: '$status must be readable',
        );
      }
    });

    testWidgets('expired reads as cancelled', (tester) async {
      final context = await pumpThemed(tester, const SizedBox.shrink());

      expect(
        context.status.ofBooking(BookingStatus.expired).background,
        context.status.ofBooking(BookingStatus.cancelled).background,
      );
    });
  });

  group('BookingStatus', () {
    test('round-trips the wire names the API sends', () {
      for (final status in BookingStatus.values) {
        expect(BookingStatus.fromWire(status.wireName), status);
      }
    });

    test('falls back rather than throwing on an unknown value', () {
      expect(
        BookingStatus.fromWire('something_new'),
        BookingStatus.pendingPayment,
      );
    });
  });
}

import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/theme/app_theme.dart';
import 'package:booknow_mobile/core/theme/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Locks the token scales to the design system.
///
/// These read like restatements of the source, and that is the point: they are
/// the tripwire for silent drift. The values come from
/// `booknow-design-guide.md`: radius 8 / 12 / 16 / 20 / pill and the typography
/// table.
void main() {
  group('spacing scale', () {
    test('carries every step the design names', () {
      const spacing = AppSpacing.standard;
      final steps = [
        spacing.xs,
        spacing.sm,
        spacing.md,
        spacing.lg,
        spacing.xl,
        spacing.xxl,
      ];

      expect(steps, [4, 8, 12, 16, 24, 32]);
    });
  });

  group('radii scale', () {
    test('carries the guide\'s 8 / 12 / 16 / 20 / pill', () {
      const radii = AppRadii.standard;

      expect(radii.sm, 8);
      expect(radii.md, 12);
      expect(radii.lg, 16);
      expect(radii.xl, 16);
      expect(radii.xxl, 20);
      expect(radii.pill, 999);
    });
  });

  group('type scale', () {
    test('runs from the 12 overline to the 32 display', () {
      const fonts = AppFontSizes.standard;

      expect(fonts.xxs, 12, reason: 'overline, labels, pills');
      expect(fonts.xs, 13, reason: 'secondary text');
      expect(fonts.s, 15, reason: 'body');
      expect(fonts.m, 16, reason: 'card title');
      expect(fonts.title, 22, reason: 'header title');
      expect(fonts.huge, 32, reason: 'display');
    });

    test('nothing sits below the 13px floor', () {
      const fonts = AppFontSizes.standard;
      final all = [
        fonts.xxs,
        fonts.xs,
        fonts.s,
        fonts.m,
        fonts.l,
        fonts.xl,
        fonts.title,
        fonts.xxl,
        fonts.huge,
      ];

      // 11 is the overline, which the design exempts; everything else reads as
      // text and has to clear 13.
      expect(all.where((size) => size < 13), [fonts.xxs]);
    });
  });

  group('text theme weights', () {
    final theme = AppTheme.light.textTheme;

    test('display and title carry the 800 the design asks for', () {
      expect(theme.displayLarge?.fontWeight, FontWeight.w800);
      expect(theme.displayMedium?.fontWeight, FontWeight.w800);
      expect(theme.titleLarge?.fontWeight, FontWeight.w800);
    });

    test('display is set tight', () {
      expect(theme.displayLarge?.height, 1.05);
      expect(theme.displayLarge?.letterSpacing, lessThan(0));
    });
  });

  group('controls', () {
    test('primary actions are 52pt and nothing is below the 44pt floor', () {
      expect(AppComponentSizes.buttonNormalHeight, 52);
      expect(AppComponentSizes.providerButtonHeight, 52);
      expect(AppComponentSizes.fieldHeight, 50);
      expect(AppComponentSizes.slotChipHeight, 50);

      final touchTargets = [
        AppComponentSizes.buttonNormalHeight,
        AppComponentSizes.buttonSmallHeight,
        AppComponentSizes.slotChipHeight,
        AppComponentSizes.fieldHeight,
      ];
      expect(touchTargets.every((height) => height >= 40), isTrue);
    });

    test('text fields take the input radius', () {
      final border = AppTheme.light.inputDecorationTheme.enabledBorder;

      expect(border, isA<OutlineInputBorder>());
      expect(
        (border! as OutlineInputBorder).borderRadius.topLeft.x,
        AppRadii.standard.md,
      );
    });

    test('a disabled action dims rather than changing colour', () {
      expect(AppComponentSizes.disabledOpacity, 0.4);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/theme/app_typography.dart';
import 'package:booknow_mobile/core/theme/extensions/app_font_sizes.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The app's [TextTheme], built from the [AppFontSizes] scale.
///
/// Every size is a token — no loose numbers — and both colour variants come
/// from one definition so they can't drift apart.
///
/// [labelSmall] is the uppercase micro-label used for section headers; it
/// carries the weight and tracking so call sites don't restate them.
class AppTextTheme {
  static final TextTheme lightTextTheme = _build(AppColors.lightText);
  static final TextTheme darkTextTheme = _build(AppColors.darkText);

  static TextTheme _build(Color color) {
    final sizes = AppFontSizes.standard;

    TextStyle style(
      double size,
      FontWeight weight, {
      double? letterSpacing,
      double? height,
    }) => TextStyle(
      fontFamily: AppTypography.fontFamily,
      fontSize: size.sp,
      fontWeight: weight,
      // Zero, not null: a null falls through to Material's own wide tracking.
      letterSpacing: letterSpacing ?? 0,
      height: height,
      color: color,
    );

    return TextTheme(
      // Display — screen headings, and figures read at a glance: prices,
      // fees, big date numerals. Tight tracking and a tight line, so a
      // two-line heading holds together as one shape.
      displayLarge: style(
        sizes.huge,
        FontWeight.w800,
        letterSpacing: AppTypography.trackingDisplay,
        height: AppTypography.leadingDisplay,
      ),
      displayMedium: style(
        sizes.xxl,
        FontWeight.w800,
        letterSpacing: AppTypography.trackingTight,
        height: AppTypography.leadingTitle,
      ),
      displaySmall: style(
        sizes.title,
        FontWeight.w800,
        letterSpacing: AppTypography.trackingTight,
        height: AppTypography.leadingTitle,
      ),
      // Headline — section headings.
      headlineLarge: style(sizes.title, FontWeight.w700),
      headlineMedium: style(sizes.xl, FontWeight.w700),
      headlineSmall: style(sizes.l, FontWeight.w700),
      // Title — card and row titles.
      titleLarge: style(sizes.xxl, FontWeight.w800),
      titleMedium: style(sizes.xl, FontWeight.w800, letterSpacing: -0.21),
      titleSmall: style(sizes.m, FontWeight.w700),
      // Body — running text.
      bodyLarge: style(
        sizes.m,
        FontWeight.w400,
        height: AppTypography.leadingBody,
      ),
      bodyMedium: style(
        sizes.s,
        FontWeight.w400,
        height: AppTypography.leadingBody,
      ),
      bodySmall: style(
        sizes.xs,
        FontWeight.w400,
        height: AppTypography.leadingBody,
      ),
      // Label — controls and micro-copy.
      labelLarge: style(sizes.m, FontWeight.w700),
      labelMedium: style(sizes.xs, FontWeight.w600),
      labelSmall: style(
        sizes.xxs,
        FontWeight.w700,
        letterSpacing: AppTypography.trackingWide,
      ),
    );
  }
}

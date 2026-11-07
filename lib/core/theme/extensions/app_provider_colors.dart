import 'package:flutter/material.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';

/// Colours for the Apple and Google sign-in buttons.
///
/// These are fixed by each provider's brand guidelines, so they live outside
/// the palette: they flip with the theme rather than following it, and must
/// not be retinted to match the app.
@immutable
class AppProviderColors extends ThemeExtension<AppProviderColors> {
  const AppProviderColors({
    required this.appleBackground,
    required this.appleForeground,
    required this.appleBorder,
    required this.googleBackground,
    required this.googleForeground,
    required this.googleBorder,
  });

  final Color appleBackground;
  final Color appleForeground;
  final Color appleBorder;
  final Color googleBackground;
  final Color googleForeground;
  final Color googleBorder;

  @override
  AppProviderColors copyWith({
    Color? appleBackground,
    Color? appleForeground,
    Color? appleBorder,
    Color? googleBackground,
    Color? googleForeground,
    Color? googleBorder,
  }) {
    return AppProviderColors(
      appleBackground: appleBackground ?? this.appleBackground,
      appleForeground: appleForeground ?? this.appleForeground,
      appleBorder: appleBorder ?? this.appleBorder,
      googleBackground: googleBackground ?? this.googleBackground,
      googleForeground: googleForeground ?? this.googleForeground,
      googleBorder: googleBorder ?? this.googleBorder,
    );
  }

  @override
  AppProviderColors lerp(ThemeExtension<AppProviderColors>? other, double t) {
    if (other is! AppProviderColors) return this;
    return AppProviderColors(
      appleBackground: Color.lerp(appleBackground, other.appleBackground, t)!,
      appleForeground: Color.lerp(appleForeground, other.appleForeground, t)!,
      appleBorder: Color.lerp(appleBorder, other.appleBorder, t)!,
      googleBackground: Color.lerp(
        googleBackground,
        other.googleBackground,
        t,
      )!,
      googleForeground: Color.lerp(
        googleForeground,
        other.googleForeground,
        t,
      )!,
      googleBorder: Color.lerp(googleBorder, other.googleBorder, t)!,
    );
  }

  static const AppProviderColors light = AppProviderColors(
    appleBackground: AppColors.lightAppleBg,
    appleForeground: AppColors.lightAppleFg,
    appleBorder: AppColors.lightAppleBorder,
    googleBackground: AppColors.lightGoogleBg,
    googleForeground: AppColors.lightGoogleFg,
    googleBorder: AppColors.lightGoogleBorder,
  );

  static const AppProviderColors dark = AppProviderColors(
    appleBackground: AppColors.darkAppleBg,
    appleForeground: AppColors.darkAppleFg,
    appleBorder: AppColors.darkAppleBorder,
    googleBackground: AppColors.darkGoogleBg,
    googleForeground: AppColors.darkGoogleFg,
    googleBorder: AppColors.darkGoogleBorder,
  );
}

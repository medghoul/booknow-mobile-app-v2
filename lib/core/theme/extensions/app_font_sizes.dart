import 'package:flutter/material.dart';

/// The type scale.
///
/// Reach for `context.textTheme` first; use these tokens only where a widget
/// needs a size the text theme has no style for (badges, chips, numerals).
/// Apply `.sp` at the call site:
///
/// ```dart
/// fontSize: context.fonts.xxs.sp
/// ```
///
/// These eight numbers set the type size of the whole app — `AppTextTheme` is
/// built from them. Adjust the scale here, never at a call site.
@immutable
class AppFontSizes extends ThemeExtension<AppFontSizes> {
  const AppFontSizes({
    this.xxs = 12,
    this.xs = 13,
    this.s = 15,
    this.m = 16,
    this.l = 19,
    this.xl = 21,
    this.title = 22,
    this.xxl = 26,
    this.huge = 32,
  });

  final double xxs;
  final double xs;
  final double s;
  final double m;
  final double l;
  final double xl;
  final double xxl;

  /// Screen and card titles — the design's `title` step.
  final double title;

  /// The display step, used for screen headings.
  final double huge;

  @override
  AppFontSizes copyWith({
    double? xxs,
    double? xs,
    double? s,
    double? m,
    double? l,
    double? xl,
    double? xxl,
    double? title,
    double? huge,
  }) {
    return AppFontSizes(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      title: title ?? this.title,
      huge: huge ?? this.huge,
    );
  }

  @override
  AppFontSizes lerp(ThemeExtension<AppFontSizes>? other, double t) {
    if (other is! AppFontSizes) return this;
    return AppFontSizes(
      xxs: _lerp(xxs, other.xxs, t),
      xs: _lerp(xs, other.xs, t),
      s: _lerp(s, other.s, t),
      m: _lerp(m, other.m, t),
      l: _lerp(l, other.l, t),
      xl: _lerp(xl, other.xl, t),
      xxl: _lerp(xxl, other.xxl, t),
      title: _lerp(title, other.title, t),
      huge: _lerp(huge, other.huge, t),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static const AppFontSizes standard = AppFontSizes();
}

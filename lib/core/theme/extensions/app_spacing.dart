import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The spacing scale: distances *between* components.
///
/// The steps are the design system's — 4 / 8 / 12 / 16 / 24 / 32 — plus [xxs]
/// for hairline gaps and [huge] for full-page breathing room, neither of which
/// the design names but both of which the screens use.
///
/// Apply `.w` / `.h` at the call site so the value scales with the device:
///
/// ```dart
/// SizedBox(height: context.spacing.md.h)
/// ```
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    this.xxs = 2,
    this.xs = 4,
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
    this.xl = 24,
    this.xxl = 32,
    this.huge = 48,
    this.blurSm = 8.0,
    this.blurMd = 12.0,
    this.blurXXL = 30.0,
  });

  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double huge;

  /// Blur radii — no responsive scaling; a blur is an optical value.
  final double blurSm;
  final double blurMd;
  final double blurXXL;

  /// Horizontal gutter between page content and the screen edge.
  ///
  /// Applied once, by `AppScaffold`. Screens must not repeat it on their own
  /// content — two gutters stack and squeeze the layout.
  EdgeInsets get screenGutter => EdgeInsets.symmetric(horizontal: lg.w);

  EdgeInsets get pagePadding => EdgeInsets.all(lg.w);

  EdgeInsets get sectionPadding =>
      EdgeInsets.symmetric(horizontal: lg.w, vertical: xl.h);

  @override
  AppSpacing copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? huge,
    double? blurSm,
    double? blurMd,
    double? blurXXL,
  }) {
    return AppSpacing(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      huge: huge ?? this.huge,
      blurSm: blurSm ?? this.blurSm,
      blurMd: blurMd ?? this.blurMd,
      blurXXL: blurXXL ?? this.blurXXL,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xxs: _lerp(xxs, other.xxs, t),
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      xxl: _lerp(xxl, other.xxl, t),
      huge: _lerp(huge, other.huge, t),
      blurSm: _lerp(blurSm, other.blurSm, t),
      blurMd: _lerp(blurMd, other.blurMd, t),
      blurXXL: _lerp(blurXXL, other.blurXXL, t),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static const AppSpacing standard = AppSpacing();
}

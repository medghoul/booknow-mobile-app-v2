import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The corner-radius scale.
///
/// 8 small pills and snackbars, 12 buttons and inputs, 16 cards ([lg] and [xl]),
/// 20 bottom sheets ([xxl]), [pill] for chips.
@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({
    this.xs = 4,
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
    this.xl = 16,
    this.xxl = 20,
    this.pill = 999,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double pill;

  BorderRadius get xsR => BorderRadius.circular(xs.r);
  BorderRadius get smR => BorderRadius.circular(sm.r);
  BorderRadius get mdR => BorderRadius.circular(md.r);
  BorderRadius get lgR => BorderRadius.circular(lg.r);
  BorderRadius get xlR => BorderRadius.circular(xl.r);
  BorderRadius get xxlR => BorderRadius.circular(xxl.r);
  BorderRadius get pillR => BorderRadius.circular(pill.r);

  // Radius getters — for BorderRadius.only / BorderRadius.vertical.
  Radius get xsRadius => Radius.circular(xs.r);
  Radius get smRadius => Radius.circular(sm.r);
  Radius get mdRadius => Radius.circular(md.r);
  Radius get lgRadius => Radius.circular(lg.r);
  Radius get xlRadius => Radius.circular(xl.r);
  Radius get xxlRadius => Radius.circular(xxl.r);
  Radius get pillRadius => Radius.circular(pill.r);

  @override
  AppRadii copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? pill,
  }) {
    return AppRadii(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      pill: pill ?? this.pill,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) return this;
    return AppRadii(
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      xxl: _lerp(xxl, other.xxl, t),
      pill: _lerp(pill, other.pill, t),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static const AppRadii standard = AppRadii();
}

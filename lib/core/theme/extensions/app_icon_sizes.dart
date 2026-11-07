import 'package:flutter/material.dart';

/// The icon size scale — the dimension *of* a glyph, as opposed to the
/// distance *between* components that `AppSpacing` carries. The two move
/// independently: a denser layout shrinks gaps without shrinking glyphs.
///
/// Apply `.w` at the call site:
///
/// ```dart
/// Icon(Icons.check, size: context.icons.m.w)
/// ```
@immutable
class AppIconSizes extends ThemeExtension<AppIconSizes> {
  const AppIconSizes({
    this.xs = 12,
    this.s = 16,
    this.m = 24,
    this.l = 32,
    this.xl = 48,
    this.xxl = 64,
  });

  final double xs;
  final double s;
  final double m;
  final double l;
  final double xl;
  final double xxl;

  @override
  AppIconSizes copyWith({
    double? xs,
    double? s,
    double? m,
    double? l,
    double? xl,
    double? xxl,
  }) {
    return AppIconSizes(
      xs: xs ?? this.xs,
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  AppIconSizes lerp(ThemeExtension<AppIconSizes>? other, double t) {
    if (other is! AppIconSizes) return this;
    return AppIconSizes(
      xs: _lerp(xs, other.xs, t),
      s: _lerp(s, other.s, t),
      m: _lerp(m, other.m, t),
      l: _lerp(l, other.l, t),
      xl: _lerp(xl, other.xl, t),
      xxl: _lerp(xxl, other.xxl, t),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static const AppIconSizes standard = AppIconSizes();
}

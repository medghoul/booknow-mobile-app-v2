import 'package:flutter/material.dart';

/// Durations and curves for interface motion.
///
/// Longer, choreographed animations (onboarding, success screens) use the
/// millisecond tokens in `AppAnimations` instead; these three are for the
/// everyday transitions widgets run themselves.
@immutable
class AppMotion extends ThemeExtension<AppMotion> {
  const AppMotion({
    this.fast = const Duration(milliseconds: 150),
    this.normal = const Duration(milliseconds: 250),
    this.slow = const Duration(milliseconds: 400),
    this.curve = Curves.easeInOut,
    this.curveEmphasized = Curves.easeOutCubic,
  });

  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Curve curve;
  final Curve curveEmphasized;

  @override
  AppMotion copyWith({
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Curve? curve,
    Curve? curveEmphasized,
  }) {
    return AppMotion(
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      curve: curve ?? this.curve,
      curveEmphasized: curveEmphasized ?? this.curveEmphasized,
    );
  }

  /// Durations and curves are constants in practice; no lerp needed.
  @override
  AppMotion lerp(ThemeExtension<AppMotion>? other, double t) => this;

  static const AppMotion standard = AppMotion();
}

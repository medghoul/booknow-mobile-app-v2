import 'package:flutter/material.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/extensions/color_extension.dart';

/// Elevation presets.
///
/// Borders over shadows: the design has one shadow, under the category blobs
/// on the band ([blob]). The other steps stay so call sites keep compiling and
/// resolve to nothing.
@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({
    this.xs = const [],
    this.sm = const [],
    this.md = const [],
    this.lg = const [],
    this.sheet = const [],
    required this.blob,
  });

  final List<BoxShadow> xs;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> sheet;

  /// `0 8px 16px rgba(15,42,74,0.12)`.
  final List<BoxShadow> blob;

  @override
  AppShadows copyWith({
    List<BoxShadow>? xs,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? sheet,
    List<BoxShadow>? blob,
  }) {
    return AppShadows(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      sheet: sheet ?? this.sheet,
      blob: blob ?? this.blob,
    );
  }

  /// Shadows have no built-in lerp; snapping is fine since the theme switches
  /// instantly rather than animating.
  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) return this;
    return t < 0.5 ? this : other;
  }

  static final AppShadows light = AppShadows(
    blob: [
      BoxShadow(
        color: AppColors.primary.withOpacityValue(0.12),
        blurRadius: 16,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static final AppShadows dark = AppShadows(
    blob: [
      BoxShadow(
        color: AppColors.black.withOpacityValue(0.4),
        blurRadius: 16,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

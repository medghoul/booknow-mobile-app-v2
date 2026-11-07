import 'package:flutter/material.dart';

export 'app_decorations.dart';
export 'app_font_sizes.dart';
export 'app_icon_sizes.dart';
export 'app_motion.dart';
export 'app_provider_colors.dart';
export 'app_radii.dart';
export 'app_shadows.dart';
export 'app_spacing.dart';
export 'app_status_colors.dart';
export 'queue_colors.dart';

import 'app_decorations.dart';
import 'app_font_sizes.dart';
import 'app_icon_sizes.dart';
import 'app_motion.dart';
import 'app_provider_colors.dart';
import 'app_radii.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';
import 'app_status_colors.dart';
import 'queue_colors.dart';

/// One-stop accessor for every custom theme extension.
///
/// ```dart
/// context.spacing.lg.w
/// context.radii.lgR
/// context.fonts.xs.sp
/// context.icons.m.w
/// context.shadows.md
/// context.decorations.card
/// context.motion.normal
/// context.status.ofBooking(booking.status)
/// context.providers.appleBackground
/// ```
extension AppThemeExtensions on BuildContext {
  AppDecorations get decorations => Theme.of(this).extension<AppDecorations>()!;
  AppFontSizes get fonts => Theme.of(this).extension<AppFontSizes>()!;
  AppIconSizes get icons => Theme.of(this).extension<AppIconSizes>()!;
  AppMotion get motion => Theme.of(this).extension<AppMotion>()!;
  AppProviderColors get providers =>
      Theme.of(this).extension<AppProviderColors>()!;
  AppRadii get radii => Theme.of(this).extension<AppRadii>()!;
  AppShadows get shadows => Theme.of(this).extension<AppShadows>()!;
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
  AppStatusColors get status => Theme.of(this).extension<AppStatusColors>()!;
  QueueColors get queueColors => Theme.of(this).extension<QueueColors>()!;
}

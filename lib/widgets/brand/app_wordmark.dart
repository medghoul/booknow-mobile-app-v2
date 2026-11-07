import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The BookNow name, optionally over a spaced-out kicker.
class AppWordmark extends StatelessWidget {
  const AppWordmark({super.key, this.kicker, this.fontSize});

  /// Small uppercase line under the name — "Barber shop" on the splash.
  final String? kicker;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'BookNow',
          style: context.textTheme.displayLarge?.copyWith(
            fontSize: fontSize?.sp ?? context.fonts.huge.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
          ),
        ),
        if (kicker != null) ...[
          SizedBox(height: context.spacing.xs.h),
          Text(
            kicker!.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              letterSpacing: AppTypography.trackingWide * 3.5,
            ),
          ),
        ],
      ],
    );
  }
}

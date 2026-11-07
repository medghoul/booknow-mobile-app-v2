import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A tinted pill carrying an icon and a word.
///
/// The design rule this widget exists to enforce: a status always shows
/// **tint + icon + word**, never colour alone — so both [icon] and [label] are
/// required, and there is no colour-only variant to reach for.
class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.tint,
    required this.icon,
    required this.label,
  });

  /// Resolve this from the theme, e.g.
  /// `context.status.ofBooking(booking.status)`.
  final StatusTint tint;

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppComponentSizes.statusBadgeHorizontalPadding.w,
        vertical: AppComponentSizes.statusBadgeVerticalPadding.h,
      ),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.pillR,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.icons.xs.w, color: tint.foreground),
          SizedBox(width: context.spacing.xs.w + 2),
          Text(
            // Sentence case, not uppercase: the word is one of the three
            // signals the status carries, so it stays readable as a word.
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: tint.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

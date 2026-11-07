import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One notification the user can turn off: what it is, when it arrives, and
/// the switch.
///
/// The subtitle is not decoration. Every row here promises a message at some
/// moment, and "Prossimo cliente" means nothing without "10 minuti prima di
/// ogni appuntamento" under it — the line is how someone decides whether they
/// want it.
class NotificationToggleRow extends StatelessWidget {
  const NotificationToggleRow({
    super.key,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.trailing,
  });

  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  /// Replaces the switch, for a notification that is not the user's to turn
  /// off. Only [NotificationLockedBadge] goes here.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.spacing.md.w),
          trailing ??
              AppSwitch(
                value: value,
                onChanged: onChanged,
                semanticLabel: label,
              ),
        ],
      ),
    );

    return Semantics(
      container: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 64.h),
        child: row,
      ),
    );
  }
}

/// "Attive", with a padlock — the trailing end of a row that has no switch.
///
/// Shown instead of a disabled switch. A greyed-out switch reads as something
/// that is off, or as a bug; a label says the state and the row's subtitle
/// says why it cannot change.
class NotificationLockedBadge extends StatelessWidget {
  const NotificationLockedBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme.labelMedium?.copyWith(
        fontSize: context.fonts.xxs.sp,
        fontWeight: FontWeight.w700,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

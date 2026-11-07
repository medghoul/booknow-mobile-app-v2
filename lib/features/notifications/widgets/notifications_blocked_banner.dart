import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Shown when the phone is blocking notifications: nothing below it can work.
///
/// It names the consequence rather than the setting — an owner reads "new
/// bookings are not reaching you", not "permission denied" — because the cost
/// of ignoring this is different for each role, and for an owner it is missed
/// money.
///
/// The app cannot grant the permission back. Both platforms show the system
/// prompt once and never again, so the only thing this button can do is open
/// Settings.
class NotificationsBlockedBanner extends StatelessWidget {
  const NotificationsBlockedBanner({
    super.key,
    required this.role,
    required this.onOpenSettings,
  });

  final UserRole? role;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final t = context.t.notificationSettings.blocked;
    final tint = context.status.warning;

    return Container(
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.xlR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: context.icons.s.w,
            color: tint.foreground,
          ),
          SizedBox(width: context.spacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: tint.foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: context.spacing.xxs.h),
                Text(
                  role == UserRole.owner ? t.bodyOwner : t.bodyCustomer,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: tint.foreground,
                  ),
                ),
                SizedBox(height: context.spacing.sm.h),
                AppElevatedButton(
                  label: t.action,
                  size: ButtonSize.small,
                  // The banner's own two colours, swapped: the button has to
                  // carry inside a tinted card, and the screen's terracotta
                  // belongs to actions that are about the shop.
                  backgroundColor: tint.foreground,
                  foregroundColor: tint.background,
                  onPressed: onOpenSettings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

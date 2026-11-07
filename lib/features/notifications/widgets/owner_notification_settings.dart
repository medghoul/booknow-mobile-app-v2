import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/notifications/widgets/notification_toggle_row.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// What an owner can be sent: what happens to the agenda, and the one message
/// a day that is a summary rather than an event.
///
/// Both agenda rows are about a slot changing hands — one paid for, one given
/// back. A reminder before each appointment is not here: the owner is already
/// at work looking at the day, and on a full one it is a notification every
/// half hour.
class OwnerNotificationSettings extends StatelessWidget {
  const OwnerNotificationSettings({
    super.key,
    required this.preferences,
    required this.onNewBookingsChanged,
    required this.onCancellationsChanged,
    required this.onDailySummaryChanged,
    required this.onEditSummaryTime,
  });

  final NotificationPreferences preferences;
  final ValueChanged<bool> onNewBookingsChanged;
  final ValueChanged<bool> onCancellationsChanged;
  final ValueChanged<bool> onDailySummaryChanged;
  final VoidCallback onEditSummaryTime;

  @override
  Widget build(BuildContext context) {
    final t = context.t.notificationSettings.owner;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionTitle(context.t.profile.notifications),
        SizedBox(height: 10.h),
        AppSettingsCard(
          children: [
            NotificationToggleRow(
              label: t.newBookings,
              subtitle: t.newBookingsSubtitle,
              value: preferences.newBookings,
              onChanged: onNewBookingsChanged,
            ),
            NotificationToggleRow(
              label: t.cancellations,
              subtitle: t.cancellationsSubtitle,
              value: preferences.cancellations,
              onChanged: onCancellationsChanged,
            ),
            NotificationToggleRow(
              label: t.dailySummary,
              subtitle: t.dailySummarySubtitle,
              value: preferences.dailySummary,
              onChanged: onDailySummaryChanged,
            ),
            _SummaryTimeRow(
              label: t.summaryTime,
              value: preferences.summaryTime,
              // The time belongs to the summary. With the summary off it is
              // still worth showing — it is what will be used when it goes
              // back on — but there is nothing to set it for.
              onTap: preferences.dailySummary ? onEditSummaryTime : null,
            ),
          ],
        ),
      ],
    );
  }
}

/// "Orario di invio · 08:00 ›" — the one row on this screen that opens
/// something instead of flipping.
///
/// No leading icon, unlike a settings row: the rows above it have none either,
/// and an icon here would make it look like it belongs to a different list.
class _SummaryTimeRow extends StatelessWidget {
  const _SummaryTimeRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    final row = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.sm.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: context.spacing.md.w),
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isEnabled
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: context.spacing.xs.w),
          Icon(
            Icons.chevron_right_rounded,
            size: context.icons.s.w,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );

    final sized = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
      child: row,
    );

    if (!isEnabled) {
      return Semantics(
        container: true,
        enabled: false,
        child: Opacity(
          opacity: AppComponentSizes.disabledOpacity,
          child: sized,
        ),
      );
    }

    return Semantics(
      button: true,
      container: true,
      child: AppPressScale.tap(onTap: onTap!, child: sized),
    );
  }
}

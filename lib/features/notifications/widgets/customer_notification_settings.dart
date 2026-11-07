import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/notifications/widgets/notification_toggle_row.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// What a customer can be sent: the reminder before the appointment, and the
/// one message about money that is not theirs to turn off.
///
/// Two groups, and only one switch between them. A confirmed booking sends
/// nothing — the customer is looking at the confirmation screen when it
/// happens and Stripe mails the receipt — and closures from the shop are not
/// here either: reaching a customer who is not booked needs a favourite-shop
/// feature the app does not have, and marketing consent it has not asked for.
class CustomerNotificationSettings extends StatelessWidget {
  const CustomerNotificationSettings({
    super.key,
    required this.preferences,
    required this.onReminderChanged,
    required this.onLeadChanged,
  });

  final NotificationPreferences preferences;
  final ValueChanged<bool> onReminderChanged;
  final ValueChanged<ReminderLead> onLeadChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t.notificationSettings.customer;
    final leads = context.t.notificationSettings.lead;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionTitle(t.reminderSection),
        SizedBox(height: context.spacing.sm.h),
        AppSettingsCard(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NotificationToggleRow(
                  label: t.reminder,
                  subtitle: t.reminderSubtitle,
                  value: preferences.appointmentReminder,
                  onChanged: onReminderChanged,
                ),
                // The timing goes with the reminder: without one, "2 ore
                // before" is a choice about a message that never arrives.
                AnimatedSize(
                  duration: context.motion.fast,
                  alignment: Alignment.topCenter,
                  child: preferences.appointmentReminder
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
                          child: AppSegmentedControl<ReminderLead>(
                            value: preferences.reminderLead,
                            onChanged: onLeadChanged,
                            segments: [
                              AppSegment(
                                value: ReminderLead.oneHour,
                                label: leads.oneHour,
                              ),
                              AppSegment(
                                value: ReminderLead.twoHours,
                                label: leads.twoHours,
                              ),
                              AppSegment(
                                value: ReminderLead.oneDay,
                                label: leads.oneDay,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: context.spacing.lg.h),

        AppSectionTitle(t.bookingsSection),
        SizedBox(height: context.spacing.sm.h),
        AppSettingsCard(
          children: [
            // A shop cancelling, or a refund landing, is the customer's money
            // moving. It is sent whatever the switches say, so the row says
            // so instead of offering one.
            NotificationToggleRow(
              label: t.cancellations,
              subtitle: t.cancellationsSubtitle,
              value: true,
              onChanged: null,
              trailing: NotificationLockedBadge(label: t.cancellationsLocked),
            ),
          ],
        ),
      ],
    );
  }
}

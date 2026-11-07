import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/notifications/cubit/notification_settings_cubit.dart';
import 'package:booknow_mobile/features/notifications/cubit/notification_settings_state.dart';
import 'package:booknow_mobile/features/notifications/widgets/customer_notification_settings.dart';
import 'package:booknow_mobile/features/notifications/widgets/notifications_blocked_banner.dart';
import 'package:booknow_mobile/features/notifications/widgets/owner_notification_settings.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The notification settings screen, for whichever role is signed in.
///
/// Stateful for one reason: the phone's permission can change while the app
/// is in the background — that is exactly what the banner's button sends the
/// user off to do — so the screen re-reads it every time it comes back to the
/// front. Without that, the warning would still be sitting there after the
/// user had just turned notifications on.
class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key, required this.role});

  final UserRole? role;

  @override
  State<NotificationSettingsView> createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<NotificationSettingsCubit>().refreshSystemPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || !mounted) return;

    context.read<NotificationSettingsCubit>().refreshSystemPermission();
  }

  /// The platform's own time picker, as the hours screens use: the one
  /// control everybody already knows how to work.
  ///
  /// It offers every minute and the API takes only the quarter hour, so what
  /// comes back is snapped before it is sent. The row then shows the snapped
  /// time, which is the honest thing to draw: it is what will actually happen.
  Future<void> _editSummaryTime(String current) async {
    final cubit = context.read<NotificationSettingsCubit>();
    final parts = current.split(':');

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 8,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;

    await cubit.setSummaryTime(
      NotificationPreferences.quarterHour(picked.hour, picked.minute),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationSettingsCubit>();

    return BlocListener<NotificationSettingsCubit, NotificationSettingsState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) =>
          AppSnackBar.error(context, state.failure!.localized(context)),
      child: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
        builder: (context, state) {
          final preferences = state.preferences;

          return AppScaffold(
            appBar: AppAppBar(
              title: context.t.notificationSettings.screenTitle,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: context.spacing.lg.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!state.isSystemAllowed) ...[
                    NotificationsBlockedBanner(
                      role: widget.role,
                      onOpenSettings: cubit.openSystemSettings,
                    ),
                    SizedBox(height: context.spacing.lg.h),
                  ],

                  if (widget.role == UserRole.owner)
                    OwnerNotificationSettings(
                      preferences: preferences,
                      onNewBookingsChanged: cubit.setNewBookings,
                      onCancellationsChanged: cubit.setCancellations,
                      onDailySummaryChanged: cubit.setDailySummary,
                      onEditSummaryTime: () =>
                          _editSummaryTime(preferences.summaryTime),
                    )
                  else
                    CustomerNotificationSettings(
                      preferences: preferences,
                      onReminderChanged: cubit.setAppointmentReminder,
                      onLeadChanged: cubit.setReminderLead,
                    ),

                  SizedBox(height: context.spacing.xl.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

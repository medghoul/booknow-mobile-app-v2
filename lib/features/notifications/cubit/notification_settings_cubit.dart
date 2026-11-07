import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/services/launcher/system_settings_service.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/notifications/cubit/notification_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The notification settings screen.
///
/// Every change is saved as it is made — the design gives the screen no Save
/// button, and a settings screen that can be left without saving is a settings
/// screen people leave without saving.
///
/// There is still no loading state, even though these now live on the server:
/// they arrive as part of the profile that `GET /me` already fetched before
/// any screen was built, so the screen opens on the real answer rather than
/// waiting for one. [AuthCubit] is where that profile is held, which is why it
/// is both where this reads from and what it hands the server's reply back to
/// — one copy of the profile, not a second behind this screen.
///
/// Only the system permission is asked for asynchronously, and the screen is
/// useful before that answer arrives.
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit({
    required AuthCubit auth,
    required UserRepository users,
    required PushService push,
    SystemSettingsService settings = const SystemSettingsService(),
  }) : _auth = auth,
       _users = users,
       _push = push,
       _settings = settings,
       super(
         NotificationSettingsState(
           preferences:
               auth.state.profile?.notificationPrefs ??
               const NotificationPreferences(),
         ),
       );

  final AuthCubit _auth;
  final UserRepository _users;
  final PushService _push;
  final SystemSettingsService _settings;

  /// Re-reads the OS permission.
  ///
  /// Called when the screen appears and again every time the app comes back
  /// to the front: the user may have gone to Settings and changed it, and the
  /// banner has to agree with the phone it is talking about.
  Future<void> refreshSystemPermission() async {
    final isAllowed = await _push.hasPermission();
    if (isClosed) return;

    emit(state.copyWith(isSystemAllowed: isAllowed));
  }

  Future<void> openSystemSettings() => _settings.openNotifications();

  // ─── Customer ─────────────────────────────────────────────────────────────

  Future<void> setAppointmentReminder(bool value) => _save(
    state.preferences.copyWith(appointmentReminder: value),
    () => _users.updateNotificationPreferences(reminder: value),
  );

  Future<void> setReminderLead(ReminderLead value) => _save(
    state.preferences.copyWith(reminderLead: value),
    () => _users.updateNotificationPreferences(reminderLead: value),
  );

  // ─── Owner ────────────────────────────────────────────────────────────────

  Future<void> setNewBookings(bool value) => _save(
    state.preferences.copyWith(newBookings: value),
    () => _users.updateNotificationPreferences(newBooking: value),
  );

  Future<void> setCancellations(bool value) => _save(
    state.preferences.copyWith(cancellations: value),
    () => _users.updateNotificationPreferences(cancellation: value),
  );

  Future<void> setDailySummary(bool value) => _save(
    state.preferences.copyWith(dailySummary: value),
    () => _users.updateNotificationPreferences(dailySummary: value),
  );

  Future<void> setSummaryTime(String value) => _save(
    state.preferences.copyWith(summaryTime: value),
    () => _users.updateNotificationPreferences(summaryTime: value),
  );

  /// Shows the change, sends it, and puts it back if it did not land.
  ///
  /// In that order: a switch that waits for the network before moving feels
  /// broken, and on the connection this is used over it would be waiting
  /// visibly. The cost of being optimistic is that a failure has to be
  /// undone, which is what [NotificationSettingsState.failure] is for — a row
  /// that silently goes back to where it was reads as the app ignoring the
  /// tap.
  ///
  /// [send] carries only the field that changed. The server merges, so sending
  /// the whole object on every flip would mean a switch set on another device
  /// could be overwritten by a screen that was opened before it.
  Future<void> _save(
    NotificationPreferences preferences,
    Future<ApiResult<UserProfile>> Function() send,
  ) async {
    final previous = state.preferences;
    emit(state.copyWith(preferences: preferences, failure: null));

    final result = await send();
    if (isClosed) return;

    result.fold(
      onSuccess: (profile) {
        _auth.profileUpdated(profile);
        // The server's answer rather than what was asked for: it fills in the
        // defaults for anything never set, and it is the authority on what
        // the next push will actually obey.
        emit(state.copyWith(preferences: profile.notificationPrefs));
      },
      onFailure: (error) =>
          emit(state.copyWith(preferences: previous, failure: error)),
    );
  }
}

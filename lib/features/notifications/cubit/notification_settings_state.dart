import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_state.freezed.dart';

/// The notification screen: what the user asked for, whether the phone will
/// let any of it through, and whether the last change reached the server.
@freezed
abstract class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState({
    @Default(NotificationPreferences()) NotificationPreferences preferences,

    /// Whether the OS delivers notifications for this app at all.
    ///
    /// Starts true and is corrected by the first check: assuming the worst
    /// would flash a warning banner onto every opening of the screen before
    /// the platform has answered.
    @Default(true) bool isSystemAllowed,

    /// Why the last change did not stick.
    ///
    /// The switch has already gone back by the time this is set, so the
    /// failure explains a row that moved on its own rather than announcing
    /// something the user can see for themselves.
    NetworkException? failure,
  }) = _NotificationSettingsState;

  const NotificationSettingsState._();
}

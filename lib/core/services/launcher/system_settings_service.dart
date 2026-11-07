import 'package:app_settings/app_settings.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';

/// Opens the phone's own settings for this app.
///
/// Needed because notification permission can only be refused once: after
/// that neither platform will show the prompt again, and the only way back is
/// the OS settings page. The app cannot flip the switch itself — it can only
/// take the user to it.
///
/// A class rather than a bare call so a screen can be tested without the
/// plugin's platform channel, which is not there in a widget test.
class SystemSettingsService {
  const SystemSettingsService();

  /// The app's notification settings, falling back to its settings page where
  /// the platform has no notification panel of its own.
  Future<void> openNotifications() async {
    try {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    } catch (error, stackTrace) {
      AppLogger.error('[settings] could not open', error, stackTrace);
    }
  }
}

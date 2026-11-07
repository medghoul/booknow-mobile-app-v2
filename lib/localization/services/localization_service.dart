import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/localization/localization.dart';

/// Chooses and persists the app's language.
///
/// With no stored choice the device locale wins when the app ships in it, and
/// Italian is the fallback — the pilot shop and its customers are in Rome, so
/// defaulting to English would be the wrong guess for almost everyone.
class LocalizationService {
  LocalizationService(this._prefs);

  final PrefsService _prefs;

  AppLanguage get current =>
      AppLanguage.fromCode(LocaleSettings.currentLocale.languageCode);

  /// Applies the stored language, or the device's if there is none yet.
  Future<void> initialize() async {
    final stored = _prefs.localeCode;
    if (stored != null) {
      LocaleSettings.setLocaleRaw(stored);
      return;
    }

    final device = await LocaleSettings.useDeviceLocale();
    await _prefs.setLocaleCode(device.languageCode);
  }

  Future<void> setLanguage(AppLanguage language) async {
    await LocaleSettings.setLocale(language.locale);
    await _prefs.setLocaleCode(language.code);
  }
}

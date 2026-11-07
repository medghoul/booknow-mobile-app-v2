import 'package:booknow_mobile/core/structures/enums/prefs_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Device-local preferences: everything that is a setting rather than a secret.
///
/// The theme choice and the locale override live here on purpose — they are
/// per-device, so the same account can run dark on a phone and light on a
/// tablet, which is what the design calls for.
class PrefsService {
  PrefsService(this._prefs);

  final SharedPreferences _prefs;

  static Future<PrefsService> create() async =>
      PrefsService(await SharedPreferences.getInstance());

  /// The user's theme choice. Defaults to [ThemeMode.system], which is what
  /// the design specifies for a first launch.
  ThemeMode get themeMode =>
      switch (_prefs.getString(PrefsKey.themeMode.value)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(PrefsKey.themeMode.value, mode.name);

  String? get localeCode => _prefs.getString(PrefsKey.locale.value);

  Future<void> setLocaleCode(String code) =>
      _prefs.setString(PrefsKey.locale.value, code);

  bool get onboardingSeen =>
      _prefs.getBool(PrefsKey.onboardingSeen.value) ?? false;

  Future<void> setOnboardingSeen() =>
      _prefs.setBool(PrefsKey.onboardingSeen.value, true);

  /// Whether the app has already asked for notification permission. The system
  /// prompt can only be shown once, so we track it to know when to send the
  /// user to Settings instead.
  bool get notificationsPrompted =>
      _prefs.getBool(PrefsKey.notificationsPrompted.value) ?? false;

  Future<void> setNotificationsPrompted() =>
      _prefs.setBool(PrefsKey.notificationsPrompted.value, true);

  /// The shops opened from search, most recent first.
  List<String> get recentShopIds =>
      _prefs.getStringList(PrefsKey.recentShops.value) ?? const [];

  Future<void> addRecentShop(String shopId) => _prefs.setStringList(
    PrefsKey.recentShops.value,
    [
      shopId,
      ...recentShopIds.where((id) => id != shopId),
    ].take(_recentShopsKept).toList(),
  );

  static const int _recentShopsKept = 5;

  Future<void> clear() => _prefs.clear();
}

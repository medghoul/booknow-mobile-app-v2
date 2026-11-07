import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:flutter/material.dart';

/// Holds and persists the app's theme choice.
///
/// A [ChangeNotifier] in the container, like `LocalizationService` next to
/// it: the choice is one value the whole app reads, it outlives every route,
/// and both the root — which applies it — and the profile — which shows and
/// changes it — have to hear when it moves. Keeping it in the root's `State`
/// meant the profile could only read it by walking for that `State`, which
/// registers no dependency: the colours changed and the control went on
/// showing the choice that was no longer in force.
///
/// Storage goes through [PrefsService] rather than SharedPreferences
/// directly, so every device-local setting is still written in one place. The
/// choice is per device by design — the same account can run dark on a phone
/// and light on a tablet — so it never reaches the API.
class ThemeService extends ChangeNotifier {
  ThemeService(PrefsService prefs)
    : _prefs = prefs,
      _themeMode = prefs.themeMode;

  final PrefsService _prefs;

  ThemeMode _themeMode;

  /// [ThemeMode.system] until the user chooses otherwise, which is what the
  /// design specifies for a first launch.
  ThemeMode get themeMode => _themeMode;

  /// Applies the choice, then stores it.
  ///
  /// Listeners are told before the write: the theme is a tap away from the
  /// user's finger and must not wait on the disk. A failed write costs the
  /// choice on the next launch, not this one.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;

    _themeMode = mode;
    notifyListeners();

    await _prefs.setThemeMode(mode);
  }
}

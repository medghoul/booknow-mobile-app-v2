import 'dart:async';
import 'dart:io';

import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:flutter/services.dart';

/// Android's side of the launch screen, which is drawn before any Dart runs.
///
/// Nothing to do on iOS, where the launch screen always follows the phone and
/// can't be told otherwise.
abstract final class LaunchScreen {
  static const _channel = MethodChannel('com.booknow/launch_screen');

  /// Keeps Android told of the theme chosen in the app, so that from the next
  /// launch its launch screen opens in that theme rather than the phone's.
  static void follow(ThemeService theme) {
    void tell() => _invoke('followTheme', theme.themeMode.name);

    tell();
    theme.addListener(tell);
  }

  /// The splash is done: stop keeping its picture behind the app.
  static void release() => _invoke('release');

  static void _invoke(String method, [Object? arguments]) {
    if (!Platform.isAndroid) return;
    unawaited(_channel.invokeMethod<void>(method, arguments));
  }
}

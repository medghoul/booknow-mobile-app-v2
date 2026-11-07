import 'package:flutter/material.dart';

export 'package:booknow_mobile/core/theme/extensions/theme_extensions.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  NavigatorState get navigator => Navigator.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Height of the on-screen keyboard, or zero when it is closed.
  double get keyboardInset => mediaQuery.viewInsets.bottom;
}

/// The app's "header" colours: navy in light, a dark surface in dark, where the
/// light-blue primary would be far too loud across a whole bar.
extension HeaderColors on BuildContext {
  Color get headerColor =>
      isDarkMode ? colorScheme.surface : colorScheme.primary;

  Color get onHeaderColor =>
      isDarkMode ? colorScheme.onSurface : colorScheme.onPrimary;

  /// The quieter line on the header.
  Color get headerSoftColor =>
      isDarkMode ? const Color(0xFFA3B1C6) : const Color(0xFFDCE6F5);
}

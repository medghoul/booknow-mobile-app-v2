import 'dart:async';

import 'package:flutter/foundation.dart';

/// Delays an action until the caller stops asking for it.
///
/// For anything driven by typing or scrolling — a slot search, a live filter —
/// where acting on every keystroke means a request per character.
///
/// Whoever creates one owns it and must [dispose] it, or the pending timer
/// fires after the widget is gone.
class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 300)});

  final Duration duration;

  Timer? _timer;

  bool get isPending => _timer?.isActive ?? false;

  /// Schedules [action], replacing anything already scheduled.
  ///
  /// [immediate] runs it now and cancels what was pending — for the case where
  /// the user has clearly finished, such as submitting the field.
  void run(VoidCallback action, {bool immediate = false}) {
    _timer?.cancel();

    if (immediate) {
      action();
      return;
    }

    _timer = Timer(duration, action);
  }

  /// Drops anything pending without running it.
  void cancel() => _timer?.cancel();

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

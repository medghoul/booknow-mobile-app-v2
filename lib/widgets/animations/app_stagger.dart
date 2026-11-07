import 'package:booknow_mobile/core/constants/app_animations.dart';
import 'package:booknow_mobile/widgets/animations/app_fade_animations.dart';
import 'package:flutter/widgets.dart';

/// Gives a column's children an entrance, each a beat behind the one above.
///
/// Wrapping every child in the same fade — which is the obvious thing to do,
/// and what the first version of this did — lands them all at once and reads
/// as the whole screen blinking. The delay has to climb for the eye to follow
/// the content down the page.
abstract final class AppStagger {
  /// How much later each child starts than the one before it.
  static const int step = AppAnimations.delayXS;

  /// The last child never starts later than this. Without a ceiling a long
  /// list ends with items trickling in well after the user has started
  /// reading, and on a list that scrolls they arrive off-screen anyway.
  static const int maxDelay = AppAnimations.delayLG;

  /// Wraps [children] in order, climbing from [first] in [step] increments.
  static List<Widget> wrap(
    List<Widget> children, {
    FadeFrom from = FadeFrom.up,
    int first = AppAnimations.delayXS,
    int duration = AppAnimations.durationSM,
  }) {
    return [
      for (final (index, child) in children.indexed)
        AppFadeIn(
          from: from,
          duration: duration,
          delay: delayAt(index, first: first),
          child: child,
        ),
    ];
  }

  /// The delay the child at [index] starts on, capped at [maxDelay].
  static int delayAt(int index, {int first = AppAnimations.delayXS}) {
    final delay = first + index * step;
    return delay > maxDelay ? maxDelay : delay;
  }
}

import 'package:booknow_mobile/core/constants/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Which edge a widget drifts in from.
enum FadeFrom { none, up, down, left, right }

/// How far a drifting widget travels, as a fraction of its own size.
///
/// Fractional rather than absolute, which is what `SlideEffect` takes — so
/// the same token moves a tall card much further than a one-line label. 0.12
/// keeps a button and a paragraph travelling roughly the same distance on
/// screen; the half-height slide the design board sketched reads as a swoop
/// on anything larger than a field.
const double _travel = 0.12;

/// A widget that fades in, optionally drifting from one side.
///
/// The named variants below are what call sites use; this carries the one
/// implementation they share.
///
class AppFadeIn extends StatelessWidget {
  const AppFadeIn({
    super.key,
    required this.child,
    this.from = FadeFrom.none,
    this.duration = AppAnimations.durationSM,
    this.delay = AppAnimations.delayXS,
  });

  /// Fades in while drifting up from below. The default for content that
  /// arrives with the screen.
  const AppFadeIn.up({
    super.key,
    required this.child,
    this.duration = AppAnimations.durationSM,
    this.delay = AppAnimations.delayXS,
  }) : from = FadeFrom.up;

  /// Fades in while dropping from above — headers and anything anchored to
  /// the top of the screen.
  const AppFadeIn.down({
    super.key,
    required this.child,
    this.duration = AppAnimations.durationSM,
    this.delay = AppAnimations.delayXS,
  }) : from = FadeFrom.down;

  const AppFadeIn.left({
    super.key,
    required this.child,
    this.duration = AppAnimations.durationSM,
    this.delay = AppAnimations.delayXS,
  }) : from = FadeFrom.left;

  const AppFadeIn.right({
    super.key,
    required this.child,
    this.duration = AppAnimations.durationSM,
    this.delay = AppAnimations.delayXS,
  }) : from = FadeFrom.right;

  final Widget child;
  final FadeFrom from;

  /// Milliseconds, from [AppAnimations] — never a bare integer.
  final int duration;
  final int delay;

  Offset get _begin => switch (from) {
    FadeFrom.none => Offset.zero,
    FadeFrom.up => const Offset(0, _travel),
    FadeFrom.down => const Offset(0, -_travel),
    FadeFrom.left => const Offset(-_travel, 0),
    FadeFrom.right => const Offset(_travel, 0),
  };

  @override
  Widget build(BuildContext context) {
    // "Reduce Motion" is a system setting a user turned on deliberately, and
    // an entrance that starts at zero opacity is exactly what it is for.
    // Returning the child bare rather than a zero-duration animation keeps
    // the widget out of the tree entirely. Read through the granular accessor
    // rather than `MediaQuery.of`, which would depend on the whole
    // `MediaQueryData` and rebuild on every keyboard open and rotation.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;

    return Animate(
      effects: [
        FadeEffect(delay: delay.ms, duration: duration.ms),
        if (from != FadeFrom.none)
          SlideEffect(
            begin: _begin,
            end: Offset.zero,
            delay: delay.ms,
            duration: duration.ms,
            curve: Curves.easeOutCubic,
          ),
      ],
      child: child,
    );
  }
}

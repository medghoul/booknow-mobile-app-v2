import 'package:booknow_mobile/core/constants/app_animations.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/widgets.dart';

/// How one screen gives way to the next.
///
/// A fade, deliberately with no slide. Every screen in this app already
/// arrives with its own staggered entrance that travels upward, so a route
/// transition that slides as well would put two different motions on the same
/// pixels and read as a lurch. The route hands over; the screen's own
/// entrance supplies the direction.
///
/// The two overlap on purpose rather than queueing: the page is fully opaque
/// at [durationMs] while its first child is still arriving, so the surface
/// settles first and the content lands on top of it.
abstract final class AppPageTransitions {
  /// A compile-time constant because `CustomRoute` takes the duration in its
  /// constructor, where there is no `BuildContext` to read `context.motion`
  /// from — so this is built from the [AppAnimations] token instead.
  static const Duration duration = Duration(
    milliseconds: AppAnimations.durationXS,
  );

  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // "Reduce Motion" is a system setting a user turned on deliberately, and
    // a screen cross-fading into another is exactly what it is for. Returning
    // the child bare rather than a zero-duration fade keeps the opacity layer
    // out of the tree entirely.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: context.motion.curveEmphasized,
      ),
      child: child,
    );
  }

  /// A shop screen growing out of its card, with the photo flying across as a
  /// shared element on top.
  static Widget grow(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;

    final curved = CurvedAnimation(
      parent: animation,
      curve: context.motion.curveEmphasized,
    );

    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
        child: child,
      ),
    );
  }

  /// The same fade, for a tab swap.
  ///
  /// `AutoTabsRouter` hands its builder the child and the animation in the
  /// other order to `CustomRoute`, which is the only reason this is a second
  /// function rather than the same one.
  ///
  /// A tab swap is not a journey — there is no back — so it gets the fade
  /// without any of the entrance the screens run on arrival.
  static Widget tabFade(
    BuildContext context,
    Widget child,
    Animation<double> animation,
  ) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: context.motion.curveEmphasized,
      ),
      child: child,
    );
  }
}

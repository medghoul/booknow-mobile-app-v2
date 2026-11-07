import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Content that scrolls, with an action docked under it.
///
/// The screens in the sign-in journey all have the same shape: copy and fields
/// that vary in height, and one action that must stay reachable. A plain
/// `Column` with a `Spacer` looks right on a tall phone and overflows on a
/// short one — or as soon as the user raises the system text size — so the
/// scrolling half is bounded and the action lives outside it.
class AppDockedColumn extends StatelessWidget {
  const AppDockedColumn({
    super.key,
    required this.children,
    required this.docked,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.animate = true,
  });

  /// The scrolling content.
  final List<Widget> children;

  /// Whether the content arrives with a staggered entrance.
  ///
  /// On by default, because every screen that uses this is one the user has
  /// just navigated to. Switch it off where the content changes under a
  /// standing layout — re-running the entrance on a rebuild reads as a
  /// flicker, not as an arrival.
  final bool animate;

  /// Pinned to the bottom, always visible. Spacing below it — including the
  /// home-indicator inset — is added here, so screens pass the bare action.
  final Widget docked;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: animate ? AppStagger.wrap(children) : children,
            ),
          ),
        ),
        // The docked child clears the home indicator itself. `padding.bottom`
        // rather than `viewPadding.bottom` on purpose: it collapses to zero
        // when the keyboard is up, where the inset is already accounted for
        // and the extra gap would push the action off-screen.
        Padding(
          padding: EdgeInsets.only(
            bottom: context.spacing.lg.h + context.mediaQuery.padding.bottom,
          ),
          // Last in, after the content it acts on. One beat past the cap so
          // it never lands before something above it.
          child: animate
              ? AppFadeIn.up(
                  delay: AppStagger.maxDelay + AppStagger.step,
                  child: docked,
                )
              : docked,
        ),
      ],
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Progress through the deck: the active slide stretches into a bar.
///
/// Decorative — the pager itself is what the screen reader announces — so the
/// dots are hidden from semantics rather than read out as three blank shapes.
class OnboardingDots extends StatelessWidget {
  const OnboardingDots({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  static const double _dotSize = 8;
  static const double _activeWidth = 26;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Row(
        children: List.generate(count, (index) {
          final isActive = index == activeIndex;
          return Padding(
            padding: EdgeInsets.only(right: context.spacing.sm.w),
            child: AnimatedContainer(
              duration: context.motion.normal,
              curve: context.motion.curveEmphasized,
              width: (isActive ? _activeWidth : _dotSize).w,
              height: _dotSize.h,
              decoration: BoxDecoration(
                color: isActive
                    ? context.colorScheme.primary
                    : context.colorScheme.outline,
                borderRadius: context.radii.pillR,
              ),
            ),
          );
        }),
      ),
    );
  }
}

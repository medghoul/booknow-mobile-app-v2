import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One slide: artwork above, heading and body below.
///
/// The slide scrolls rather than centring rigidly, so a large text size or a
/// short screen shrinks the gap instead of clipping the copy.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.artwork,
    required this.title,
    required this.body,
  });

  final Widget artwork;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    // The content is centred in whatever height the pager gives it, and
    // scrolls only once it no longer fits. A fixed fraction of the screen
    // can't do both: it leaves a dead band under the copy on a tall phone and
    // still clips on a short one.
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: artwork),
              SizedBox(height: context.spacing.xxl.h),
              Text(title, style: context.textTheme.displayLarge),
              SizedBox(height: context.spacing.sm.h),
              Text(
                body,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

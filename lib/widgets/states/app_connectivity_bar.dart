import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A banner shown while the device is offline.
///
/// It animates in and out rather than appearing instantly, so it doesn't jolt
/// the layout on a flaky connection that flips repeatedly.
class AppConnectivityBar extends StatelessWidget {
  const AppConnectivityBar({
    super.key,
    required this.isOffline,
    required this.message,
  });

  final bool isOffline;
  final String message;

  @override
  Widget build(BuildContext context) {
    final tint = context.status.warning;

    return AnimatedSize(
      duration: context.motion.normal,
      curve: context.motion.curve,
      child: isOffline
          ? Container(
              width: double.infinity,
              color: tint.background,
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing.lg.w,
                vertical: context.spacing.sm.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: context.icons.xs.w,
                    color: tint.foreground,
                  ),
                  SizedBox(width: context.spacing.xs.w),
                  Text(
                    message,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: tint.foreground,
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

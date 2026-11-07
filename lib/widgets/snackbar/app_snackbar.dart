import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/icons/app_line_icon.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Transient feedback at the bottom of the screen.
///
/// Reserved for things the user does not have to act on. Anything that changes
/// what they can do next — a slot taken out from under them, a failed payment —
/// belongs on the screen itself, because a snackbar can be missed.
abstract final class AppSnackBar {
  static void success(BuildContext context, String message) =>
      _show(context, message);

  static void error(BuildContext context, String message) =>
      _show(context, message, icon: Icons.error_outline_rounded);

  static void info(BuildContext context, String message) =>
      _show(context, message);

  static void _show(BuildContext context, String message, {IconData? icon}) {
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    final background = context.colorScheme.onSurface;
    final foreground = context.theme.scaffoldBackgroundColor;

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: background,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Row(
          children: [
            if (icon != null)
              Icon(icon, size: 18.w, color: foreground)
            else
              AppLineIcon(
                AppLineIcons.check,
                size: 18,
                color: foreground,
                strokeWidth: 2.5,
              ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  color: foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

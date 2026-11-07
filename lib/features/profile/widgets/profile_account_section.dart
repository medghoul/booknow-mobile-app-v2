import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The two ways out, at the foot of the screen.
class ProfileExitButtons extends StatelessWidget {
  const ProfileExitButtons({
    super.key,
    required this.signOutLabel,
    required this.deleteLabel,
    required this.onSignOut,
    this.onDeleteAccount,
  });

  final String signOutLabel;
  final String deleteLabel;
  final VoidCallback onSignOut;
  final VoidCallback? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50.h,
          child: OutlinedButton(
            onPressed: onSignOut,
            style: OutlinedButton.styleFrom(
              minimumSize: Size(0, 50.h),
              backgroundColor: Colors.transparent,
              textStyle: context.textTheme.labelLarge?.copyWith(
                fontSize: context.fonts.s.sp,
              ),
            ),
            child: Text(signOutLabel),
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 44,
          child: TextButton(
            onPressed: onDeleteAccount,
            style: TextButton.styleFrom(
              foregroundColor: context.status.error.foreground,
              textStyle: context.textTheme.labelMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: Text(deleteLabel),
          ),
        ),
      ],
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A low-emphasis action: "Skip", "Not now", inline links in body copy.
///
/// Use this instead of a raw [TextButton] so the colour and type come from the
/// theme in one place.
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.foregroundColor,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? foregroundColor;

  /// Renders in the danger colour — for "Cancel booking", "Delete account".
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final foreground =
        foregroundColor ??
        (isDestructive
            ? context.colorScheme.error
            : context.colorScheme.primary);

    return AppPressScale(
      builder: (context, states) => TextButton(
        onPressed: onPressed,
        statesController: states,
        style: TextButton.styleFrom(foregroundColor: foreground),
        child: icon == null
            ? Text(label)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: context.icons.s.w, color: foreground),
                  SizedBox(width: context.spacing.xs.w),
                  Text(label),
                ],
              ),
      ),
    );
  }
}

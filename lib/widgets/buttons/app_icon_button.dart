import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// How an [AppIconButton] is drawn. One of three, not a set of flags: a
/// button cannot be both filled and outlined, and an enum is what says so.
enum AppIconButtonStyle {
  /// The glyph alone — app bar actions, a clear button inside a field.
  bare,

  /// On a tinted disc, at a fixed size. The back control on the auth screens.
  filled,

  /// On a transparent disc with an edge, at the same fixed size. The quieter
  /// of the two discs: it reads as an action without competing with the one
  /// filled control a screen is allowed.
  outlined,
}

/// A bare icon action — app bar actions, a close button on a sheet.
///
/// [tooltip] is required rather than optional: an icon with no label needs an
/// accessible name, and screen readers announce nothing useful without one.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.color,
    this.size,
    this.style = AppIconButtonStyle.bare,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final Color? color;
  final double? size;
  final AppIconButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? context.colorScheme.onSurface;
    final diameter = Size.square(AppComponentSizes.filledIconButtonSize.w);

    return AppPressScale(
      builder: (context, states) => IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        statesController: states,
        icon: Icon(icon, size: size ?? context.icons.m.w, color: foreground),
        style: switch (style) {
          AppIconButtonStyle.bare => null,
          AppIconButtonStyle.filled => IconButton.styleFrom(
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            minimumSize: diameter,
            fixedSize: diameter,
          ),
          AppIconButtonStyle.outlined => IconButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: context.colorScheme.outline,
                width: AppComponentSizes.outlinedButtonBorderWidth,
              ),
            ),
            padding: EdgeInsets.zero,
            minimumSize: diameter,
            fixedSize: diameter,
          ),
        },
      ),
    );
  }
}

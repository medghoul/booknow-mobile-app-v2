import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/widgets/buttons/app_button_base.dart';
import 'package:flutter/material.dart';

/// The secondary action — same footprint as [AppElevatedButton], no fill.
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.normal,
    this.expand = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.iconAffinity = ButtonIconAffinity.leading,
    this.foregroundColor,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonSize size;

  /// Fills the available width instead of sizing to the label.
  final bool expand;

  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  /// Which side of the label [icon] sits on.
  final ButtonIconAffinity iconAffinity;
  final Color? foregroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final enabled = !isDisabled && !isLoading && onPressed != null;
    // Ink, not terracotta. The design keeps a single action colour: the
    // filled button owns it, and an outlined button sitting next to one must
    // not compete for the same attention.
    final foreground = foregroundColor ?? context.colorScheme.onSurface;

    return AppButtonBase(
      label: label,
      onPressed: enabled ? onPressed : null,
      size: size,
      expand: expand,
      isLoading: isLoading,
      icon: icon,
      iconAffinity: iconAffinity,
      foregroundColor: foreground,
      builder: (context, child, states) => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        statesController: states,
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        child: child,
      ),
    );
  }
}

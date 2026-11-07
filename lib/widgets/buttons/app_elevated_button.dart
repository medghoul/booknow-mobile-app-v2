import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/widgets/buttons/app_button_base.dart';
import 'package:flutter/material.dart';

/// The primary action of a screen — the filled, terracotta one.
///
/// Only one should be visible at a time; the design gives the product a single
/// action colour and a second filled button would compete with it.
///
/// [isLoading] shows the spinner and blocks the tap, so a double submit can't
/// create two bookings while the first is in flight.
class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.normal,
    this.expand = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.iconAffinity = ButtonIconAffinity.leading,
    this.backgroundColor,
    this.foregroundColor,
  }) : _isDanger = false;

  /// The destructive variant — cancelling a booking, marking a no-show.
  ///
  /// A separate constructor rather than a colour argument, so a destructive
  /// action can't be built by accident and reads as one at the call site. It
  /// takes its fill from the theme's error role, which keeps it correct in
  /// both palettes.
  const AppElevatedButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.normal,
    this.expand = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.iconAffinity = ButtonIconAffinity.leading,
  }) : backgroundColor = null,
       foregroundColor = null,
       _isDanger = true;

  final String label;
  final VoidCallback? onPressed;
  final ButtonSize size;

  /// Fills the available width instead of sizing to the label. Use this rather
  /// than wrapping the button in a full-width `SizedBox`.
  final bool expand;

  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  /// Which side of the label [icon] sits on.
  final ButtonIconAffinity iconAffinity;

  /// Overrides the action colour. Prefer [AppElevatedButton.danger] for
  /// destructive actions rather than passing the error colour here.
  final Color? backgroundColor;
  final Color? foregroundColor;

  final bool _isDanger;

  @override
  Widget build(BuildContext context) {
    final enabled = !isDisabled && !isLoading && onPressed != null;
    final scheme = context.colorScheme;

    final background = _isDanger ? scheme.error : backgroundColor;
    final foreground = _isDanger
        ? scheme.onError
        : (foregroundColor ?? scheme.onPrimary);

    return AppButtonBase(
      label: label,
      onPressed: enabled ? onPressed : null,
      size: size,
      expand: expand,
      isLoading: isLoading,
      icon: icon,
      iconAffinity: iconAffinity,
      foregroundColor: foreground,
      builder: (context, child, states) => ElevatedButton(
        onPressed: enabled ? onPressed : null,
        statesController: states,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background?.withOpacityValue(
            AppComponentSizes.disabledOpacity,
          ),
          disabledForegroundColor: foreground.withOpacityValue(
            AppComponentSizes.disabledOpacity,
          ),
        ),
        child: child,
      ),
    );
  }
}

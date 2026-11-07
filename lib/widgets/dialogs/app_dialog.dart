import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/buttons/app_elevated_button.dart';
import 'package:booknow_mobile/widgets/buttons/app_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A centred confirmation dialog.
///
/// The design draws a line between the two modal shapes: a **sheet** means
/// "continue a task", a **centred dialog** means "stop and confirm". Use this
/// only for the second — cancelling a booking, signing out.
///
/// Both actions are full-width buttons, stacked, confirm above cancel. Cancel
/// is an outlined button rather than a quiet text link: it is a real choice,
/// and on a dialog that stops you, the way out should not be the faintest
/// thing on screen.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.message,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
    this.isLoading = false,
    this.icon,
  });

  final String title;
  final String? message;
  final String confirmLabel;

  /// Omit to render a single-action dialog ("Got it").
  final String? cancelLabel;

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  /// Renders the confirm action in the danger colour, and the mark above it
  /// on the danger tint.
  ///
  /// Off by default, and that default matters: signing out costs nothing, so
  /// the design gives it the ordinary terracotta button. Painting every
  /// confirmation red is how red stops meaning anything.
  final bool isDestructive;

  final bool isLoading;
  final IconData? icon;

  /// Shows the dialog and resolves to true when the user confirmed.
  ///
  /// Dismissing it resolves to false rather than null, so a caller cannot
  /// read "tapped away" as an answer.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String confirmLabel,
    String? message,
    String? cancelLabel,
    bool isDestructive = false,
    IconData? icon,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      animationStyle: AnimationStyle(
        duration: context.motion.fast,
        curve: context.motion.curveEmphasized,
        reverseCurve: context.motion.curve,
      ),
      builder: (dialogContext) => AppDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        icon: icon,
        onConfirm: () => Navigator.of(dialogContext).pop(true),
        onCancel: () => Navigator.of(dialogContext).pop(false),
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon == null
          ? null
          : _Mark(icon: icon!, isDestructive: isDestructive),
      title: Text(title, textAlign: TextAlign.center),
      content: message == null
          ? null
          : Text(message!, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            if (isDestructive)
              AppElevatedButton.danger(
                label: confirmLabel,
                expand: true,
                isLoading: isLoading,
                onPressed: onConfirm,
              )
            else
              AppElevatedButton(
                label: confirmLabel,
                expand: true,
                isLoading: isLoading,
                onPressed: onConfirm,
              ),
            if (cancelLabel != null) ...[
              SizedBox(height: context.spacing.sm.h),
              AppOutlinedButton(
                label: cancelLabel!,
                expand: true,
                onPressed: isLoading ? null : onCancel,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// The mark the dialog opens with, on its own disc.
///
/// Decorative: the heading under it says the same thing in words, so a screen
/// reader announcing the glyph first would only be in the way.
class _Mark extends StatelessWidget {
  const _Mark({required this.icon, required this.isDestructive});

  final IconData icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final background = isDestructive
        ? context.status.error.background
        : context.colorScheme.surfaceContainerHighest;
    final foreground = isDestructive
        ? context.status.error.foreground
        : context.colorScheme.onSurface;
    final size = context.icons.xl.w;

    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, size: context.icons.m.w, color: foreground),
      ),
    );
  }
}

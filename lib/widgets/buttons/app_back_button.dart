import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:booknow_mobile/widgets/icons/app_line_icon.dart';
import 'package:flutter/material.dart';

/// The back control, defined once.
///
/// One disc, one chevron, one size, everywhere it appears — the app bar and
/// the shop wizard's own header row both reach for this rather than each
/// rebuilding it, which is how the two had already started to drift apart.
///
/// [onPressed] defaults to popping the current route. Screens that must
/// intercept the gesture — confirming before abandoning a booking mid-payment,
/// stepping back inside a wizard rather than leaving it — pass their own.
class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.tooltip,
    this.color,
    this.raised = false,
  });

  final VoidCallback? onPressed;

  /// Overrides the platform's own "Back" label, which is what a screen reader
  /// announces.
  final String? tooltip;

  /// The disc. The surface colour when null.
  final Color? color;

  /// A soft shadow, for a button floating over a picture.
  final bool raised;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Semantics(
      button: true,
      label: tooltip ?? MaterialLocalizations.of(context).backButtonTooltip,
      excludeSemantics: true,
      child: AppPressScale.tap(
        onTap: onPressed ?? () => Navigator.of(context).maybePop(),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? scheme.surface,
            shape: BoxShape.circle,
            boxShadow: raised
                ? [
                    BoxShadow(
                      color: const Color(0xFF0F2A4A).withValues(alpha: 0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: AppLineIcon(
            AppLineIcons.chevronLeft,
            color: scheme.onSurface,
            strokeWidth: 2.25,
          ),
        ),
      ),
    );
  }
}

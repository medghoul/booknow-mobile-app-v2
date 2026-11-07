import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The app's hairline rule.
///
/// Colour and thickness are not arguments: `AppTheme` already sets them on
/// `DividerThemeData`, and nine call sites were restating both — which is how
/// one of them ends up a shade off when the palette moves.
///
/// What Material's own [Divider] cannot be trusted with is its *height*. Left
/// alone it reserves 16 of vertical space, so a rule between two rows silently
/// adds a gap. Here the line occupies exactly its own thickness and nothing
/// more; a gap around it belongs to whatever is laying the rows out.
class AppDivider extends StatelessWidget {
  /// Edge to edge — under a bar, or either side of a label.
  const AppDivider({super.key}) : _inset = false;

  /// Pulled in from both edges, for a rule *inside* a card: it has to stop
  /// short of the corners or the card reads as separate cards stacked up.
  const AppDivider.inset({super.key}) : _inset = true;

  final bool _inset;

  @override
  Widget build(BuildContext context) {
    final indent = _inset ? context.spacing.lg.w : 0.0;

    return Divider(
      height: context.theme.dividerTheme.thickness,
      indent: indent,
      endIndent: indent,
    );
  }
}

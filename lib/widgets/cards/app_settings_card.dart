import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/dividers/app_divider.dart';
import 'package:flutter/material.dart';

/// A group of settings rows on one elevated surface.
///
/// The card draws the separators itself rather than asking call sites to
/// interleave them: a divider is a property of *being between two rows*, and
/// leaving that to the caller is how a list ends up with a trailing rule under
/// its last row.
///
/// Separators are inset from both edges so the card reads as one surface with
/// rows in it, rather than as separate cards stacked up.
class AppSettingsCard extends StatelessWidget {
  const AppSettingsCard({
    super.key,
    required this.children,
    this.elevated = false,
  });

  final List<Widget> children;

  /// The deeper shadow the design gives the card a screen leads with. Every
  /// other card on a screen sits on the quieter one.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final decoration = context.decorations.card;

    return DecoratedBox(
      decoration: elevated
          ? decoration.copyWith(boxShadow: context.shadows.md)
          : decoration,
      child: ClipRRect(
        // Clipped to the card's own radius so a row's press highlight cannot
        // paint over the rounded corner.
        borderRadius:
            decoration.borderRadius?.resolve(Directionality.of(context)) ??
            context.radii.xlR,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final (index, child) in children.indexed) ...[
              if (index > 0) const AppDivider(),
              child,
            ],
          ],
        ),
      ),
    );
  }
}

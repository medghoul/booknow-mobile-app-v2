import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The BookNow mark: a "B" monogram on a filled circle.
///
/// A monogram rather than a pair of scissors on purpose. The product is meant
/// to outgrow barbers into general service booking, so brand-level assets —
/// icon, splash, logo — carry no trade-specific imagery. (The design file's
/// splash draws scissors; the design system's written decision, which is the
/// later one, picks the monogram.)
class AppBrandMark extends StatelessWidget {
  const AppBrandMark({super.key, this.size = 92, this.backgroundColor});

  final double size;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final diameter = size.w;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: context.shadows.md,
      ),
      alignment: Alignment.center,
      child: Text(
        'B',
        style: context.textTheme.displayLarge?.copyWith(
          // The glyph is sized from the circle rather than the type scale so
          // the mark keeps its proportions at every size it is drawn at.
          fontSize: diameter * 0.52,
          fontWeight: FontWeight.w800,
          color: context.colorScheme.onPrimary,
          height: AppTypography.leadingNone,
        ),
      ),
    );
  }
}

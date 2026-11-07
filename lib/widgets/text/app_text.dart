import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// [Text] with the app's defaults already applied.
///
/// Prefer passing a [TextStyle] from `context.textTheme`; the loose [size],
/// [color] and [weight] overrides exist for the handful of places that need
/// to bend one property of a themed style, not as a way around the type scale.
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.style,
    this.size,
    this.color,
    this.weight,
    this.align,
    this.maxLines,
    this.overflow,
    this.lineThrough = false,
  }) : _useSecondaryColor = false;

  /// Secondary copy — captions, helper text, metadata rows.
  const AppText.secondary(
    this.data, {
    super.key,
    this.style,
    this.size,
    this.weight,
    this.align,
    this.maxLines,
    this.overflow,
    this.lineThrough = false,
  }) : color = null,
       _useSecondaryColor = true;

  final String? data;
  final TextStyle? style;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  /// Struck through — a cancelled booking's time, a superseded price.
  final bool lineThrough;

  final bool _useSecondaryColor;

  @override
  Widget build(BuildContext context) {
    final base = style ?? context.textTheme.bodyMedium ?? const TextStyle();
    final resolvedColor =
        color ??
        (_useSecondaryColor
            ? context.colorScheme.onSurfaceVariant
            : base.color);

    return Text(
      data ?? '',
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: base.copyWith(
        fontSize: size ?? base.fontSize,
        color: resolvedColor,
        fontWeight: weight ?? base.fontWeight,
        decoration: lineThrough ? TextDecoration.lineThrough : base.decoration,
      ),
    );
  }
}

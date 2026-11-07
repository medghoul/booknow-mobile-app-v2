import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Builds the concrete Material button around [child].
///
/// [states] has to be handed to it as its `statesController`: that is how
/// [AppPressScale] learns the button has been pressed.
typedef AppButtonBuilder =
    Widget Function(
      BuildContext context,
      Widget child,
      WidgetStatesController states,
    );

/// Shared geometry and content for the three button variants.
///
/// The variants differ only in their `ButtonStyle`, so height, width
/// constraints, the loading indicator and the icon/label row live here once
/// rather than being repeated — and stay in step when the scale is retuned.
class AppButtonBase extends StatelessWidget {
  const AppButtonBase({
    super.key,
    required this.label,
    required this.onPressed,
    required this.builder,
    required this.foregroundColor,
    this.size = ButtonSize.normal,
    this.expand = false,
    this.isLoading = false,
    this.icon,
    this.iconAffinity = ButtonIconAffinity.leading,
  });

  final String label;
  final VoidCallback? onPressed;

  final AppButtonBuilder builder;

  /// Used by the progress indicator and the icon so they track the label.
  final Color foregroundColor;

  final ButtonSize size;
  final bool expand;
  final bool isLoading;
  final IconData? icon;

  final ButtonIconAffinity iconAffinity;

  double get _height => size == ButtonSize.normal
      ? AppComponentSizes.buttonNormalHeight
      : AppComponentSizes.buttonSmallHeight;

  double get _minWidth => size == ButtonSize.normal
      ? AppComponentSizes.buttonNormalMinWidth
      : AppComponentSizes.buttonSmallMinWidth;

  @override
  Widget build(BuildContext context) {
    return AppPressScale(
      builder: (context, states) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: expand ? 0 : _minWidth.w,
          maxWidth: expand
              ? double.infinity
              : AppComponentSizes.buttonMaxWidth.w,
        ),
        child: SizedBox(
          width: expand ? double.infinity : null,
          height: _height.h,
          child: builder(context, _content(context), states),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    if (isLoading) {
      final indicatorSize =
          _height.h * AppComponentSizes.buttonProgressIndicatorRatio;
      return SizedBox(
        width: indicatorSize,
        height: indicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: AppComponentSizes.progressIndicatorStrokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      );
    }

    final text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );

    if (icon == null) return text;

    final glyph = Icon(icon, size: context.icons.s.w, color: foregroundColor);
    final gap = SizedBox(width: context.spacing.sm.w);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconAffinity == ButtonIconAffinity.leading
          ? [glyph, gap, Flexible(child: text)]
          : [Flexible(child: text), gap, glyph],
    );
  }
}

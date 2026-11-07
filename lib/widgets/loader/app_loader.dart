import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The app's spinner, at a size that suits where it is used.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size, this.color}) : _centered = false;

  /// Centred in the available space — for a screen or a panel that is loading.
  const AppLoader.centered({super.key, this.size, this.color})
    : _centered = true;

  final double? size;
  final Color? color;
  final bool _centered;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox(
      width: size ?? context.icons.l.w,
      height: size ?? context.icons.l.w,
      child: CircularProgressIndicator(
        strokeWidth: AppComponentSizes.progressIndicatorStrokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? context.colorScheme.primary,
        ),
      ),
    );

    return _centered ? Center(child: indicator) : indicator;
  }
}

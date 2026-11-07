import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The row at the top of every wizard step: back, progress, counter.
///
/// The bar is one segment per step rather than a continuous track, so the
/// owner can see how many steps there are before starting — a sliver of a
/// continuous bar says nothing about what is left.
///
/// The review carries no bar at all: it is the check at the end, not a step
/// to fill in, which is why the counter reads 4 and not 5.
class ShopSetupChrome extends StatelessWidget {
  const ShopSetupChrome({super.key, required this.step, required this.onBack});

  final ShopSetupStep step;
  final VoidCallback? onBack;

  static const double _segmentHeight = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBackButton(onPressed: onBack),
        if (step.isCounted) ...[
          SizedBox(width: context.spacing.lg.w),
          Expanded(
            child: Row(
              children: [
                for (final counted in ShopSetupStep.counted)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: context.spacing.sm.w),
                      child: AnimatedContainer(
                        duration: context.motion.normal,
                        curve: context.motion.curve,
                        height: _segmentHeight.h,
                        decoration: BoxDecoration(
                          color: counted.index <= step.index
                              ? context.colorScheme.primary
                              : context.colorScheme.outlineVariant,
                          borderRadius: context.radii.pillR,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: context.spacing.sm.w),
          Text(
            context.t.shopSetup.stepOf(
              current: step.number.toString(),
              total: ShopSetupStep.count.toString(),
            ),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

/// The terracotta overline and the two-line heading each step opens with.
class ShopSetupHeading extends StatelessWidget {
  const ShopSetupHeading({
    super.key,
    this.overline,
    required this.title,
    this.subtitle,
  });

  final String? overline;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (overline != null) ...[
          Text(
            overline!.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
        ],
        Text(title, style: context.textTheme.displayMedium),
        if (subtitle != null) ...[
          SizedBox(height: context.spacing.sm.h),
          Text(
            subtitle!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

/// The dashed area the photo and the map preview both use.
///
/// Dashed rather than solid on purpose: it reads as a placeholder waiting for
/// content, which is exactly what makes skipping the photo feel allowed.
class DashedPanel extends StatelessWidget {
  const DashedPanel({super.key, required this.child, this.height, this.onTap});

  final Widget child;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressScale.tap(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: context.colorScheme.outline,
          radius: context.radii.xl.r,
        ),
        child: SizedBox(
          width: double.infinity,
          height: height?.h,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const double _dash = 6;
  static const double _gap = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacityValue(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    // Walk the outline and draw only the dashes, skipping the gaps.
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + _dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

/// A time, as the pill you tap to change it.
///
/// Shared by the wizard's hours step and the day editor reached from the
/// profile: one shape for "09:00", so a time set during setup and one changed
/// later are the same control.
class ShopTimePill extends StatelessWidget {
  const ShopTimePill({super.key, required this.value, required this.onTap});

  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.spacing.md.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: context.radii.mdR,
          ),
          child: Text(value, style: context.textTheme.titleSmall),
        ),
      ),
    );
  }
}

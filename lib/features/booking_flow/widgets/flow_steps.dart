import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Three bars and a count: where the customer is in the flow.
///
/// Bars rather than numbered circles, because the steps have no names worth
/// printing at that size, and the count beside them answers "how much more of
/// this is there" without one.
class FlowSteps extends StatelessWidget {
  const FlowSteps({super.key, required this.step, this.total = 3});

  /// One-based.
  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 1; index <= total; index++) ...[
          Container(
            width: AppComponentSizes.stepBarWidth.w,
            height: AppComponentSizes.stepBarHeight.h,
            decoration: BoxDecoration(
              color: index <= step
                  ? context.colorScheme.onPrimary
                  : context.colorScheme.onPrimary.withValues(alpha: 0.3),
              borderRadius: context.radii.pillR,
            ),
          ),
          SizedBox(width: context.spacing.xs.w),
        ],
        SizedBox(width: context.spacing.xs.w),
        Text(
          '$step/$total',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

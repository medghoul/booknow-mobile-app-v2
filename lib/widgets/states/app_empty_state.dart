import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The "nothing here yet" state.
///
/// The illustration is a tinted blob with a glyph rather than artwork: the
/// brand must stay trade-neutral, so empty states carry no scissors, chairs or
/// other barber imagery.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? message;

  /// The one thing the user can do from here — usually a primary button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppComponentSizes.emptyStateIconContainerSize.w,
            height: AppComponentSizes.emptyStateIconContainerSize.w,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(
                AppComponentSizes.emptyStateIconContainerRadius.r,
              ),
            ),
            child: Icon(
              icon,
              size: context.icons.xl.w,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.xl.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall,
          ),
          if (message != null) ...[
            SizedBox(height: context.spacing.sm.h),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (action != null) ...[
            SizedBox(height: context.spacing.xl.h),
            action!,
          ],
        ],
      ),
    );
  }
}

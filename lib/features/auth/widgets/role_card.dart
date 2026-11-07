import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_typography.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One of the two role choices.
///
/// Built as a radio rather than a plain tappable card: the choice is exclusive
/// and permanent, so it is announced as a selected/unselected option and the
/// tick is a real second signal, not just a colour change.
/// Thicker than a hairline on purpose: the selected card's ring is the only
/// thing telling two otherwise identical cards apart, and at 1 it reads as a
/// seam rather than as a choice.
const double _selectedBorderWidth = 2.5;

/// The radio dot's ring, which is a control and not a container.
const double _radioBorderWidth = 2.0;

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.isSelected,
    required this.onSelected,
    required this.selectedLabel,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool isSelected;
  final VoidCallback onSelected;

  /// Announced by the screen reader when this card is the chosen one.
  final String selectedLabel;

  static const double _iconContainerSize = 52.0;
  static const double _tickSize = 26.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      label: isSelected ? '$title, $selectedLabel' : title,
      button: true,
      child: AppPressScale.tap(
        onTap: onSelected,
        child: AnimatedContainer(
          duration: context.motion.fast,
          curve: context.motion.curve,
          padding: EdgeInsets.all(context.spacing.lg.w + context.spacing.xs.w),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.surface
                : context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.radii.xxl.r),
            border: Border.all(
              color: isSelected
                  ? context.colorScheme.primary
                  : Colors.transparent,
              width: _selectedBorderWidth,
            ),
            boxShadow: isSelected ? context.shadows.md : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _iconContainerSize.w,
                height: _iconContainerSize.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: context.icons.m.w,
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(width: context.spacing.lg.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: context.spacing.xs.h),
                    Text(
                      body,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        height: AppTypography.leadingBody,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.sm.w),
              _Tick(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tick extends StatelessWidget {
  const _Tick({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RoleCard._tickSize.w,
      height: RoleCard._tickSize.w,
      decoration: BoxDecoration(
        color: isSelected ? context.colorScheme.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: isSelected
            ? null
            : Border.all(
                color: context.colorScheme.outline,
                width: _radioBorderWidth,
              ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Icon(
              Icons.check,
              size: context.icons.xs.w,
              color: context.colorScheme.onPrimary,
            )
          : null,
    );
  }
}

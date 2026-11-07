import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One choice in an [AppSegmentedControl].
@immutable
class AppSegment<T> {
  const AppSegment({required this.value, required this.label, this.badge});

  final T value;

  /// Already localised. The control never reaches for translations itself.
  final String label;

  /// An optional count beside the label, drawn as a filled badge.
  ///
  /// A string rather than an int so a caller can cap it — "9+" is a badge,
  /// `math.min` at the call site is not the control's business.
  final String? badge;
}

/// A short, closed set of choices, all visible at once.
///
/// A segmented control rather than a dropdown because the whole point is that
/// the alternatives are readable without opening anything — three themes and
/// two languages are short enough that hiding them behind a menu costs more
/// than it saves.
///
/// The selected segment is raised onto the elevated surface with a shadow,
/// which is how the design distinguishes it. Weight carries it too, so the
/// state survives when a shadow is hard to see.
class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
  });

  final List<AppSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xs.w),
      decoration: BoxDecoration(
        // The recessed track: the *unelevated* surface, so the selected
        // segment reads as lifted out of it.
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: context.radii.mdR,
      ),
      child: Row(
        children: [
          for (final (index, segment) in segments.indexed) ...[
            if (index > 0) SizedBox(width: context.spacing.xs.w),
            Expanded(
              child: _Segment<T>(
                label: segment.label,
                badge: segment.badge,
                isSelected: segment.value == value,
                onTap: () {
                  HapticFeedback.selectionClick();
                  onChanged(segment.value);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.badge,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: isSelected,
      button: true,
      container: true,
      child: AppPressScale.tap(
        onTap: onTap,
        child: AnimatedContainer(
          duration: context.motion.fast,
          curve: context.motion.curve,
          constraints: BoxConstraints(
            minHeight: AppComponentSizes.segmentMinHeight.h,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? context.colorScheme.surface : null,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF0F2A4A).withValues(alpha: 0.14),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: AnimatedDefaultTextStyle(
            duration: context.motion.fast,
            style:
                context.textTheme.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface,
                ) ??
                const TextStyle(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (badge case final badge?) ...[
                  SizedBox(width: context.spacing.sm.w),
                  _Badge(value: badge, isSelected: isSelected),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The count that rides beside a segment's label.
///
/// It takes the action colour only on the selected segment. On the other one
/// it recedes to the border tint, because a filled terracotta badge sitting on
/// an unselected tab reads as the live one and fights the segment that
/// actually is.
class _Badge extends StatelessWidget {
  const _Badge({required this.value, required this.isSelected});

  final String value;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: AppComponentSizes.segmentBadgeSize.w,
        minHeight: AppComponentSizes.segmentBadgeSize.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xs.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.primary
            : context.colorScheme.outlineVariant,
        borderRadius: context.radii.mdR,
      ),
      child: Text(
        value,
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: context.fonts.xxs.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          color: isSelected
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

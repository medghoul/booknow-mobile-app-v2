import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The four durations the design offers, as a row of pills, plus the service's
/// saved time when it is none of those.
///
/// Shared by the wizard's inline card and by the editor the owner reaches
/// from the services screen: the same four choices with the same look, so a
/// duration set during setup and one changed months later are one control.
///
/// The saved time is its own pill because an accepted suggestion can be 35
/// minutes: without one, the row would show nothing as in force, and tapping
/// away from it could never be undone.
class ServiceDurationChips extends StatelessWidget {
  const ServiceDurationChips({
    super.key,
    required this.selected,
    required this.onSelected,
    this.saved,
    this.isEnabled = true,
  });

  final int selected;
  final ValueChanged<int> onSelected;

  /// What the service holds now. Null for a new one.
  final int? saved;
  final bool isEnabled;

  List<int> get _choices => [
    ...ShopService.durationChoices,
    if (saved case final minutes?
        when !ShopService.durationChoices.contains(minutes))
      minutes,
  ]..sort();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (index, minutes) in _choices.indexed) ...[
          if (index > 0) SizedBox(width: context.spacing.sm.w),
          Expanded(
            child: _DurationChip(
              minutes: minutes,
              isSelected: minutes == selected,
              onTap: isEnabled ? () => onSelected(minutes) : null,
            ),
          ),
        ],
      ],
    );
  }
}

/// One choice. Selected is the filled pill — the only filled thing in the
/// row, which is how the design shows which of four is in force.
class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.minutes,
    required this.isSelected,
    required this.onTap,
  });

  final int minutes;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: context.motion.fast,
          padding: EdgeInsets.symmetric(vertical: context.spacing.md.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.secondary
                : context.colorScheme.surfaceContainerHighest,
            borderRadius: context.radii.mdR,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              context.t.shopSetup.services.minutes(count: minutes.toString()),
              maxLines: 1,
              style: context.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? context.colorScheme.onSecondary
                    : context.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

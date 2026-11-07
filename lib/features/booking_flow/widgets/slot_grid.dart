import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// What one time in the grid is.
///
/// Four states, each distinguishable without colour, because a grid of times
/// where only the tint differs is unreadable to a quarter of the people
/// looking at it: a solid border is free, a filled pill is chosen, a dashed
/// struck one is gone, and a faded one is in the past.
enum SlotState { free, selected, taken, past }

/// One quarter-hour mark the shop could sell.
@immutable
class GridSlot {
  const GridSlot({required this.startUtc, required this.state});

  final DateTime startUtc;
  final SlotState state;
}

/// The times of one day, four to a row.
class SlotGrid extends StatelessWidget {
  const SlotGrid({
    super.key,
    required this.slots,
    required this.timeZone,
    required this.onSelected,
  });

  final List<GridSlot> slots;
  final String timeZone;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: slots.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: context.spacing.sm.h,
        crossAxisSpacing: context.spacing.sm.w,
        mainAxisExtent: 48.h,
      ),
      itemBuilder: (context, index) {
        final slot = slots[index];

        return _SlotTile(
          slot: slot,
          timeZone: timeZone,
          onTap:
              slot.state == SlotState.free || slot.state == SlotState.selected
              ? () => onSelected(slot.startUtc)
              : null,
        );
      },
    );
  }
}

class _SlotTile extends StatelessWidget {
  const _SlotTile({
    required this.slot,
    required this.timeZone,
    required this.onTap,
  });

  final GridSlot slot;
  final String timeZone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final label = ShopClock.hm(slot.startUtc, timeZone, locale);
    final radius = context.radii.mdR;
    final scheme = context.colorScheme;

    final isSelected = slot.state == SlotState.selected;
    final isGone = slot.state == SlotState.taken;
    final isPast = slot.state == SlotState.past;

    final text = context.textTheme.labelMedium?.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: isSelected
          ? scheme.onSecondary
          : isGone || isPast
          ? scheme.onSurfaceVariant
          : scheme.onSurface,
      decoration: isGone ? TextDecoration.lineThrough : null,
      decorationColor: scheme.onSurfaceVariant,
    );

    final tile = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? scheme.secondary : scheme.surface,
        borderRadius: radius,
        border: isGone || isSelected ? null : Border.all(color: scheme.outline),
      ),
      child: Text(label, style: text),
    );

    return Semantics(
      button: onTap != null,
      enabled: onTap != null,
      selected: isSelected,
      child: Opacity(
        opacity: isPast
            ? AppComponentSizes.pastSlotOpacity
            : isGone
            ? 0.6
            : 1,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: isGone
                // Dashed as well as struck: two signals for "somebody else has
                // this", neither of them colour.
                ? AppDashedOutline(
                    radius: 12.r,
                    color: scheme.outline,
                    strokeWidth: 1,
                    child: tile,
                  )
                : tile,
          ),
        ),
      ),
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:flutter/material.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The days a customer can book, starting today (§6.3).
///
/// A closed day is struck through rather than hidden: a gap in the strip reads
/// as a loading bug, and knowing the shop is shut on Sunday is worth a tap.
class FlowDayStrip extends StatelessWidget {
  const FlowDayStrip({
    super.key,
    required this.days,
    required this.selected,
    required this.closedDates,
    required this.onSelected,
    this.today,
  });

  /// Dates as `YYYY-MM-DD`, in the shop's own calendar.
  final List<String> days;
  final String selected;
  final Set<String> closedDates;
  final ValueChanged<String> onSelected;

  /// The date that is labelled Today.
  final String? today;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
      child: Row(
        children: [
          for (final date in days) ...[
            _Day(
              date: date,
              isSelected: date == selected,
              isClosed: closedDates.contains(date),
              isToday: date == today,
              onTap: () => onSelected(date),
            ),
            if (date != days.last) SizedBox(width: context.spacing.sm.w),
          ],
        ],
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({
    required this.date,
    required this.isSelected,
    required this.isClosed,
    required this.isToday,
    required this.onTap,
  });

  final String date;
  final bool isSelected;
  final bool isClosed;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final day = ShopClock.calendarDay(date);
    final radius = context.radii.mdR;
    final scheme = context.colorScheme;
    final color = isSelected ? scheme.onSecondary : scheme.onSurface;

    return Semantics(
      button: true,
      selected: isSelected,
      child: Opacity(
        opacity: isClosed && !isSelected ? 0.5 : 1,
        child: Material(
          color: isSelected ? scheme.secondary : scheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: isSelected
                ? BorderSide.none
                : BorderSide(color: scheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox.square(
              dimension: 62.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isToday
                        ? context.t.home.today
                        : DateFormat.E(locale).format(day),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: context.fonts.xxs.sp,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '${day.day}',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 18.sp,
                      letterSpacing: 0,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Busiest hours, weekday by hour. Only the hours the shop was active, so a
/// phone has room for them.
class StatisticsHeatmap extends StatelessWidget {
  const StatisticsHeatmap({super.key, required this.cells});

  final List<HeatmapCell> cells;

  @override
  Widget build(BuildContext context) {
    if (cells.isEmpty) return const SizedBox.shrink();

    final t = context.t.statistics.detail;
    final scheme = context.colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final first = cells
        .map((cell) => cell.hour)
        .reduce((a, b) => a < b ? a : b);
    final last = cells.map((cell) => cell.hour).reduce((a, b) => a > b ? a : b);
    final hours = [for (var hour = first; hour <= last; hour += 1) hour];
    final top = cells.map((cell) => cell.count).reduce((a, b) => a > b ? a : b);
    final counts = {
      for (final cell in cells) (cell.weekday, cell.hour): cell.count,
    };

    // 1 January 2024 was a Monday.
    String dayName(int weekday) =>
        DateFormat.E(locale).format(DateTime(2024, 1, 1 + weekday));

    final busiest = cells.reduce((a, b) => a.count >= b.count ? a : b);

    Color shade(int count) => count == 0
        ? scheme.surfaceContainerHighest
        : scheme.secondary.withValues(alpha: 0.15 + 0.85 * count / top);

    final labelStyle = context.textTheme.bodySmall?.copyWith(
      fontSize: context.fonts.xxs.sp,
      color: scheme.onSurfaceVariant,
    );
    final labelWidth = 34.w;

    return Semantics(
      label: t.heatmapSummary(
        day: dayName(busiest.weekday),
        hour: '${busiest.hour}:00',
      ),
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(width: labelWidth),
              for (final hour in hours)
                Expanded(
                  child: Text(
                    hour.isEven ? '$hour' : '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    softWrap: false,
                    style: labelStyle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          for (var weekday = 0; weekday < 7; weekday += 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: labelWidth,
                    child: Text(dayName(weekday), style: labelStyle),
                  ),
                  for (final hour in hours)
                    Expanded(
                      child: Container(
                        height: 26.h,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration: BoxDecoration(
                          color: shade(counts[(weekday, hour)] ?? 0),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(t.quiet, style: labelStyle),
              const SizedBox(width: 6),
              for (final level in [0.15, 0.4, 0.7, 1.0])
                Container(
                  width: 16,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    color: scheme.secondary.withValues(alpha: level),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              const SizedBox(width: 6),
              Text(t.busy, style: labelStyle),
            ],
          ),
        ],
      ),
    );
  }
}

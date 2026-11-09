import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_heatmap.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_parts.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The pages a figure on the overview opens.
enum StatisticsSection { services, waits, bookings, busyHours, estimates }

/// One detail page's content, for the range and filters the overview is on.
class StatisticsSectionView extends StatelessWidget {
  const StatisticsSectionView({
    super.key,
    required this.section,
    required this.data,
  });

  final StatisticsSection section;
  final ShopStatistics data;

  @override
  Widget build(BuildContext context) {
    final cards = switch (section) {
      StatisticsSection.services => _services(context),
      StatisticsSection.waits => _waits(context),
      StatisticsSection.bookings => _bookings(context),
      StatisticsSection.busyHours => _busyHours(context),
      StatisticsSection.estimates => _estimates(context),
    };

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
      itemCount: cards.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (_, index) => cards[index],
    );
  }

  List<Widget> _services(BuildContext context) {
    final t = context.t.statistics.detail;
    final format = StatFormat(context);
    final summary = data.summary;

    return [
      StatCard(
        title: t.allServices,
        children: [
          // Averages, because a median across a 15 and a 60 minute service
          // says nothing against the menu's average.
          StatComparisonBars(
            realLabel: t.real,
            real: summary.avgActualMin,
            plannedLabel: t.menu,
            planned: summary.avgPlannedMin,
          ),
          SizedBox(height: 6.h),
          StatRow(label: t.overPlan, value: format.percent(summary.overrunPct)),
          StatRow(
            label: t.estimatedRevenue,
            value: format.money(summary.revenueCents),
          ),
        ],
      ),
      for (final service in data.perService)
        StatCard(
          title: service.name ?? t.deletedService,
          children: [
            StatComparisonBars(
              realLabel: t.real,
              real: service.medianMin,
              plannedLabel: t.menu,
              planned: service.avgPlannedMin,
            ),
            SizedBox(height: 6.h),
            StatRow(label: t.visits, value: format.number(service.completed)),
            StatRow(
              label: t.overPlan,
              value: format.percent(service.overrunPct),
            ),
            StatRow(
              label: t.estimatedRevenue,
              value: format.money(service.revenueCents),
            ),
            if (service.byProvider.isNotEmpty) ...[
              const Divider(height: 20),
              for (final person in service.byProvider)
                StatRow(
                  label: person.name ?? t.formerStaff,
                  value: t.medianOf(
                    real: format.minutes(person.medianMin),
                    visits: format.number(person.completed),
                  ),
                ),
            ],
          ],
        ),
    ];
  }

  List<Widget> _waits(BuildContext context) {
    final t = context.t.statistics.detail;
    final format = StatFormat(context);
    final summary = data.summary;

    return [
      StatCard(
        title: t.walkInWait,
        children: [
          StatRow(label: t.average, value: format.minutes(summary.waitAvgMin)),
          StatRow(label: t.p90, value: format.minutes(summary.waitP90Min)),
          StatRow(label: t.served, value: format.number(summary.waitCount)),
        ],
      ),
      StatCard(
        title: t.lostCustomers,
        children: [
          StatRow(label: t.walkedAway, value: format.number(summary.walkAways)),
          StatRow(
            label: t.turnedAway,
            value: format.number(summary.turnedAway),
          ),
          StatRow(label: t.neverServed, value: format.number(summary.unserved)),
        ],
      ),
      StatCard(
        title: t.lostRevenue,
        children: [
          StatRow(
            label: t.walkedAway,
            value: format.money(summary.lostWalkAwayCents),
          ),
          StatRow(
            label: t.turnedAway,
            value: format.money(summary.lostTurnedAwayCents),
          ),
          StatRow(
            label: t.neverServed,
            value: format.money(summary.lostUnservedCents),
          ),
          const Divider(height: 20),
          StatRow(label: t.total, value: format.money(summary.lostCents)),
          SizedBox(height: 4.h),
          _Note(t.lostNote),
        ],
      ),
    ];
  }

  List<Widget> _bookings(BuildContext context) {
    final t = context.t.statistics.detail;
    final format = StatFormat(context);
    final summary = data.summary;

    return [
      StatCard(
        title: t.punctuality,
        children: [
          StatRow(label: t.onTime, value: format.percent(summary.onTimePct)),
          StatRow(
            label: t.averageDelay,
            value: format.minutes(summary.avgDelayMin),
          ),
          StatRow(
            label: t.started,
            value: format.number(summary.bookingsStarted),
          ),
          SizedBox(height: 4.h),
          _Note(t.onTimeNote),
        ],
      ),
      StatCard(
        title: t.noShows,
        children: [
          StatRow(
            label: t.noShowRate,
            value: format.percent(summary.noShowPct),
          ),
          StatRow(label: t.noShows, value: format.number(summary.noShows)),
          StatRow(label: t.booked, value: format.number(summary.booked)),
          StatRow(label: t.cancelled, value: format.number(summary.cancelled)),
        ],
      ),
    ];
  }

  List<Widget> _busyHours(BuildContext context) {
    final t = context.t.statistics.detail;
    final format = StatFormat(context);
    final summary = data.summary;

    return [
      StatCard(
        title: t.heatmapTitle,
        children: [StatisticsHeatmap(cells: data.heatmap)],
      ),
      StatCard(
        title: t.chairs,
        children: [
          StatRow(
            label: t.utilization,
            value: format.percent(summary.utilizationPct),
          ),
          StatRow(label: t.busyTime, value: format.minutes(summary.busyMin)),
          StatRow(
            label: t.availableTime,
            value: format.minutes(summary.availableMin),
          ),
          StatRow(
            label: t.afterClosing,
            value: format.minutes(summary.afterCloseMin),
          ),
        ],
      ),
    ];
  }

  List<Widget> _estimates(BuildContext context) {
    final t = context.t.statistics.detail;
    final format = StatFormat(context);
    final summary = data.summary;
    final error = summary.estimateAvgErrorMin;

    return [
      StatCard(
        title: t.estimateAccuracy,
        children: [
          StatRow(
            label: t.withinRange,
            value: format.percent(summary.estimateWithinPct),
          ),
          StatRow(
            label: t.typicalMiss,
            value: format.minutes(summary.estimateAvgAbsErrorMin),
          ),
          StatRow(
            label: error != null && error < 0
                ? t.shorterThanShown
                : t.longerThanShown,
            value: format.minutes(error?.abs()),
          ),
          StatRow(label: t.compared, value: format.number(summary.estimates)),
          SizedBox(height: 4.h),
          _Note(t.estimateNote),
        ],
      ),
    ];
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

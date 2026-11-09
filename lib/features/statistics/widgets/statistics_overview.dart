import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_parts.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_sections.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// `1 Oct – 31 Oct`, or one date for a single day.
String statisticsRangeLabel(BuildContext context, String from, String to) {
  final locale = Localizations.localeOf(context).toString();
  final format = DateFormat.MMMd(locale);
  final first = DateTime.tryParse(from);
  final last = DateTime.tryParse(to);
  if (first == null || last == null) return '';
  return from == to
      ? format.format(first)
      : '${format.format(first)} – ${format.format(last)}';
}

/// The range, the filters and the figures.
class StatisticsOverview extends StatelessWidget {
  const StatisticsOverview({super.key, required this.onOpen});

  final ValueChanged<StatisticsSection> onOpen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerStatisticsCubit, OwnerStatisticsState>(
      builder: (context, state) {
        final t = context.t;
        final cubit = context.read<OwnerStatisticsCubit>();
        final data = state.data;

        return RefreshIndicator(
          onRefresh: cubit.load,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
            children: [
              _RangeControl(state: state),
              SizedBox(height: 10.h),
              _Filters(state: state),
              SizedBox(height: 14.h),
              if (data == null && state.isLoading)
                SizedBox(height: 280.h, child: const AppLoader.centered())
              else if (data == null)
                AppErrorState(
                  message: state.failure?.localized(context) ?? '',
                  retryLabel: t.common.retry,
                  onRetry: cubit.load,
                )
              else if (!data.hasData)
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: AppEmptyState(
                    icon: Icons.bar_chart_rounded,
                    title: t.statistics.emptyTitle,
                    message: t.statistics.emptyBody,
                  ),
                )
              else
                AnimatedOpacity(
                  opacity: state.isLoading ? 0.5 : 1,
                  duration: const Duration(milliseconds: 150),
                  child: _Figures(summary: data.summary, onOpen: onOpen),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RangeControl extends StatelessWidget {
  const _RangeControl({required this.state});

  final OwnerStatisticsState state;

  /// Longest range the server will read.
  static const int _maxDays = 92;

  Future<void> _pickCustom(BuildContext context) async {
    final cubit = context.read<OwnerStatisticsCubit>();
    final tooLong = context.t.statistics.rangeTooLong(days: _maxDays);
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2, now.month, now.day),
      lastDate: DateUtils.dateOnly(now),
    );
    if (picked == null || !context.mounted) return;

    if (picked.duration.inDays >= _maxDays) {
      AppSnackBar.error(context, tooLong);
      return;
    }

    final format = DateFormat('yyyy-MM-dd');
    await cubit.chooseCustom(
      format.format(picked.start),
      format.format(picked.end),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;

    return AppSegmentedControl<StatisticsPreset>(
      segments: [
        AppSegment(value: StatisticsPreset.today, label: t.today),
        AppSegment(value: StatisticsPreset.week, label: t.sevenDays),
        AppSegment(value: StatisticsPreset.month, label: t.thirtyDays),
        AppSegment(value: StatisticsPreset.custom, label: t.custom),
      ],
      value: state.preset,
      onChanged: (preset) {
        if (preset == StatisticsPreset.custom) {
          _pickCustom(context);
        } else {
          context.read<OwnerStatisticsCubit>().choosePreset(preset);
        }
      },
    );
  }
}

/// Everyone and every service, or one of each.
class _Filters extends StatelessWidget {
  const _Filters({required this.state});

  final OwnerStatisticsState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final data = state.data;
    if (data == null) return const SizedBox.shrink();

    final cubit = context.read<OwnerStatisticsCubit>();
    String nameIn(
      List<StatisticsFilterOption> options,
      String? id,
      String all,
    ) => options.where((option) => option.id == id).firstOrNull?.name ?? all;

    return Row(
      children: [
        // Off, the server tells nothing apart by employee.
        if (data.personStatsEnabled) ...[
          Expanded(
            child: _FilterButton(
              label: nameIn(data.providers, state.providerId, t.everyone),
              onTap: () => _FilterSheet.open(
                context,
                title: t.staffFilter,
                allLabel: t.everyone,
                options: data.providers,
                selected: state.providerId,
                onChosen: cubit.filterProvider,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: _FilterButton(
            label: nameIn(data.services, state.serviceId, t.allServices),
            onTap: () => _FilterSheet.open(
              context,
              title: t.serviceFilter,
              allLabel: t.allServices,
              options: data.services,
              selected: state.serviceId,
              onChosen: cubit.filterService,
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(44),
        foregroundColor: scheme.onSurface,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        textStyle: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          AppLineIcon(
            AppLineIcons.chevronDown,
            size: 16,
            color: scheme.onSurfaceVariant,
            strokeWidth: 2.25,
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet({
    required this.allLabel,
    required this.options,
    required this.selected,
    required this.onChosen,
  });

  final String allLabel;
  final List<StatisticsFilterOption> options;
  final String? selected;
  final ValueChanged<String?> onChosen;

  static Future<void> open(
    BuildContext context, {
    required String title,
    required String allLabel,
    required List<StatisticsFilterOption> options,
    required String? selected,
    required ValueChanged<String?> onChosen,
  }) => AppBottomSheet.show<void>(
    context,
    title: title,
    builder: (_) => _FilterSheet(
      allLabel: allLabel,
      options: options,
      selected: selected,
      onChosen: onChosen,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget row(String label, String? id) => ListTile(
      minTileHeight: 48,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: id == selected
          ? AppLineIcon(
              AppLineIcons.check,
              color: context.colorScheme.secondary,
            )
          : null,
      onTap: () {
        Navigator.of(context).pop();
        if (id != selected) onChosen(id);
      },
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        row(allLabel, null),
        for (final option in options) row(option.name, option.id),
      ],
    );
  }
}

class _Figures extends StatelessWidget {
  const _Figures({required this.summary, required this.onOpen});

  final StatisticsSummary summary;
  final ValueChanged<StatisticsSection> onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final format = StatFormat(context);
    final gap = SizedBox(height: 10.h);

    Widget pair(Widget left, Widget right) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: left),
          const SizedBox(width: 10),
          Expanded(child: right),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        pair(
          StatKpiCard(
            label: t.kpi.wait,
            value: format.minutes(summary.waitAvgMin),
            detail: t.kpi.waitDetail(p90: format.minutes(summary.waitP90Min)),
            onTap: () => onOpen(StatisticsSection.waits),
          ),
          StatKpiCard(
            label: t.kpi.lost,
            value: format.money(summary.lostCents),
            detail: t.kpi.lostDetail(
              left: format.number(summary.walkAways + summary.unserved),
              away: format.number(summary.turnedAway),
            ),
            onTap: () => onOpen(StatisticsSection.waits),
          ),
        ),
        gap,
        pair(
          StatKpiCard(
            label: t.kpi.onTime,
            value: format.percent(summary.onTimePct),
            detail: t.kpi.onTimeDetail(
              delay: format.minutes(summary.avgDelayMin),
            ),
            onTap: () => onOpen(StatisticsSection.bookings),
          ),
          StatKpiCard(
            label: t.kpi.utilization,
            value: format.percent(summary.utilizationPct),
            detail: t.kpi.utilizationDetail(
              after: format.minutes(summary.afterCloseMin),
            ),
            onTap: () => onOpen(StatisticsSection.busyHours),
          ),
        ),
        gap,
        pair(
          StatKpiCard(
            label: t.kpi.overruns,
            value: format.percent(summary.overrunPct),
            detail: t.kpi.overrunsDetail(
              real: format.minutes(summary.avgActualMin),
              plan: format.minutes(summary.avgPlannedMin),
            ),
            onTap: () => onOpen(StatisticsSection.services),
          ),
          StatKpiCard(
            label: t.kpi.revenue,
            value: format.money(summary.revenueCents),
            detail: t.kpi.revenueDetail(
              visits: format.number(summary.completed),
            ),
            onTap: () => onOpen(StatisticsSection.services),
          ),
        ),
        gap,
        StatKpiCard(
          label: t.kpi.estimates,
          value: format.percent(summary.estimateWithinPct),
          detail: t.kpi.estimatesDetail(
            miss: format.minutes(summary.estimateAvgAbsErrorMin),
          ),
          onTap: () => onOpen(StatisticsSection.estimates),
        ),
      ],
    );
  }
}

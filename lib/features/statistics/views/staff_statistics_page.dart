import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/statistics/cubit/statistics_lists_cubits.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_parts.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One person's real times, utilization and overruns against the shop.
@RoutePage()
class StaffStatisticsPage extends StatelessWidget {
  const StaffStatisticsPage({
    super.key,
    required this.providerId,
    required this.name,
    this.days,
    this.from,
    this.to,
  });

  final String providerId;
  final String name;
  final int? days;
  final String? from;
  final String? to;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StaffStatisticsCubit(
        di<StatisticsRepository>(),
        providerId: providerId,
        days: days,
        from: from,
        to: to,
      )..load(),
      child: AppScaffold(
        padding: EdgeInsets.zero,
        appBar: AppAppBar(title: name, backTooltip: context.t.common.back),
        body: const StaffStatisticsView(),
      ),
    );
  }
}

class StaffStatisticsView extends StatelessWidget {
  const StaffStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      StaffStatisticsCubit,
      StatisticsLoadState<StaffStatistics>
    >(
      builder: (context, state) {
        final t = context.t;
        final data = state.data;

        if (data == null) {
          return state.isLoading
              ? const AppLoader.centered()
              : AppErrorState(
                  message: state.failure?.localized(context) ?? '',
                  retryLabel: t.common.retry,
                  onRetry: context.read<StaffStatisticsCubit>().load,
                );
        }
        if (!data.hasData) {
          return AppEmptyState(
            icon: Icons.bar_chart_rounded,
            title: t.statistics.staff.emptyTitle,
            message: t.statistics.staff.emptyBody,
          );
        }
        return _Figures(data: data);
      },
    );
  }
}

class _Figures extends StatelessWidget {
  const _Figures({required this.data});

  final StaffStatistics data;

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final staff = t.staff;
    final format = StatFormat(context);
    final mine = data.summary;
    final shop = data.shop;

    Widget compare(String label, String own, String theirs) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(label)),
          Expanded(
            flex: 3,
            child: Text(
              own,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(flex: 3, child: Text(theirs, textAlign: TextAlign.end)),
        ],
      ),
    );

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
      children: [
        StatCard(
          title: staff.compared,
          children: [
            compare('', staff.them, staff.shop),
            compare(
              staff.typicalTime,
              format.minutes(mine.avgActualMin),
              format.minutes(shop.avgActualMin),
            ),
            compare(
              staff.overPlan,
              format.percent(mine.overrunPct),
              format.percent(shop.overrunPct),
            ),
            compare(
              staff.utilization,
              format.percent(mine.utilizationPct),
              format.percent(shop.utilizationPct),
            ),
            compare(
              staff.visits,
              format.number(mine.completed),
              format.number(shop.completed),
            ),
          ],
        ),
        for (final service in data.perService) ...[
          SizedBox(height: 12.h),
          StatCard(
            title: service.name ?? t.detail.deletedService,
            children: [
              StatComparisonBars(
                realLabel: staff.real,
                real: service.medianMin,
                plannedLabel: staff.average,
                planned: service.shopMedianMin,
              ),
              SizedBox(height: 6.h),
              StatRow(
                label: staff.menu,
                value: format.minutes(service.menuMin),
              ),
              StatRow(
                label: staff.visits,
                value: format.number(service.completed),
              ),
              StatRow(
                label: staff.overPlan,
                value: format.percent(service.overrunPct),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

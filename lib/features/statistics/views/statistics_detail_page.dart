import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_sections.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// One figure, explained, on the overview's own range and filters.
@RoutePage()
class StatisticsDetailPage extends StatelessWidget {
  const StatisticsDetailPage({
    super.key,
    required this.section,
    required this.cubit,
  });

  final StatisticsSection section;

  /// The overview's, so this page cannot disagree with the card that opened it.
  final OwnerStatisticsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final titles = t.statistics.detail;

    return BlocProvider.value(
      value: cubit,
      child: AppScaffold(
        padding: EdgeInsets.zero,
        appBar: AppAppBar(
          title: switch (section) {
            StatisticsSection.services => titles.servicesTitle,
            StatisticsSection.waits => titles.waitsTitle,
            StatisticsSection.bookings => titles.bookingsTitle,
            StatisticsSection.busyHours => titles.busyTitle,
            StatisticsSection.estimates => titles.estimatesTitle,
          },
          backTooltip: t.common.back,
        ),
        body: BlocBuilder<OwnerStatisticsCubit, OwnerStatisticsState>(
          builder: (context, state) {
            final data = state.data;
            if (data == null) {
              return state.isLoading
                  ? const AppLoader.centered()
                  : AppErrorState(
                      message: state.failure?.localized(context) ?? '',
                      retryLabel: t.common.retry,
                      onRetry: cubit.load,
                    );
            }
            if (!data.hasData) {
              return AppEmptyState(
                icon: Icons.bar_chart_rounded,
                title: t.statistics.emptyTitle,
                message: t.statistics.emptyBody,
              );
            }
            return StatisticsSectionView(section: section, data: data);
          },
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_overview.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The owner's statistics tab: how the shop is really doing (statistics §6).
@RoutePage()
class OwnerStatisticsPage extends StatelessWidget {
  const OwnerStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerStatisticsCubit>()..load(),
      child: Builder(
        builder: (context) => RefreshWhenShown(
          routeName: OwnerStatisticsRoute.name,
          onShown: context.read<OwnerStatisticsCubit>().load,
          child: const _Screen(),
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen();

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final cubit = context.read<OwnerStatisticsCubit>();

    return AppScaffold(
      padding: EdgeInsets.zero,
      useSafeArea: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OwnerHeader(
              child: BlocBuilder<OwnerStatisticsCubit, OwnerStatisticsState>(
                builder: (context, state) {
                  final data = state.data;
                  return OwnerHeaderTitle(
                    title: t.title,
                    line: data == null
                        ? ''
                        : statisticsRangeLabel(context, data.from, data.to),
                  );
                },
              ),
            ),
            Expanded(
              child: StatisticsOverview(
                onOpen: (section) => context.router.push(
                  StatisticsDetailRoute(section: section, cubit: cubit),
                ),
                // What these two do changes the counts on the overview.
                onOpenSuggestions: () => context.router
                    .push(const SuggestionsRoute())
                    .then((_) => cubit.load()),
                onOpenReview: () => context.router
                    .push(const NeedsReviewRoute())
                    .then((_) => cubit.load()),
                onOpenStaff: (person) {
                  final state = cubit.state;
                  final custom = state.preset == StatisticsPreset.custom;
                  context.router.push(
                    StaffStatisticsRoute(
                      providerId: person.id,
                      name: person.name,
                      days: state.preset.days,
                      from: custom ? state.customFrom : null,
                      to: custom ? state.customTo : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

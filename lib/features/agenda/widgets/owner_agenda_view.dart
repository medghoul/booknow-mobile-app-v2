import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_date_strip.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_provider_filter.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_row_actions.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_row_tile.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The owner's Calendar: the header, the strip of days, then the day.
///
/// The strip stays put and only the day scrolls, so which day this is never
/// needs scrolling back up to.
class OwnerAgendaView extends StatelessWidget {
  const OwnerAgendaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerAgendaCubit, OwnerAgendaState>(
      builder: (context, state) {
        final t = context.t;
        final day = state.day;
        final shopName = di<AuthCubit>().state.shop?.name ?? t.nav.calendar;

        return AppScaffold(
          padding: EdgeInsets.zero,
          useSafeArea: false,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OwnerHeader(
                  child: OwnerHeaderTitle(
                    title: shopName,
                    line: t.nav.calendar,
                  ),
                ),
                if (day != null)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AgendaDateStrip(
                            days: day.days,
                            selected: state.date ?? day.date,
                            today: ShopClock.dateOf(state.now, state.timeZone),
                            onSelected: (date) => context
                                .read<OwnerAgendaCubit>()
                                .load(date: date),
                          ),
                          if (AgendaProviderFilter.showsFor(state)) ...[
                            SizedBox(height: 8.h),
                            const AgendaProviderFilter(),
                          ],
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: switch (state) {
                    OwnerAgendaState(isLoading: true) =>
                      const AppLoader.centered(),
                    OwnerAgendaState(failure: final error?) when day == null =>
                      AppErrorState(
                        message: error.localized(context),
                        retryLabel: t.common.retry,
                        onRetry: () => context.read<OwnerAgendaCubit>().load(),
                      ),
                    OwnerAgendaState(day: final day?) => _Timeline(
                      day: day,
                      state: state,
                    ),
                    // No day, no error, not loading: only reachable for the
                    // instant between construction and the first load.
                    _ => const AppLoader.centered(),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The day, in the order it is drawn.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.day, required this.state});

  final AgendaDay day;
  final OwnerAgendaState state;

  DateTime get now => state.now;

  @override
  Widget build(BuildContext context) {
    final t = context.t.agenda;

    if (day.rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day.closed ? t.closedTitle : t.emptyTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text(
                day.closed
                    ? (day.closure ? t.closureBody : t.closedBody)
                    : t.emptyBody,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<OwnerAgendaCubit>().load(refresh: true),
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
        itemCount: day.rows.length,
        separatorBuilder: (_, _) => const SizedBox(height: 6),
        itemBuilder: (context, index) {
          final row = day.rows[index];
          return AgendaRowTile(
            row: row,
            timeZone: day.timeZone,
            now: now,
            providerName: AgendaProviderFilter.labelFor(state, row),
            onTap: agendaRowTap(
              context,
              row: row,
              timeZone: day.timeZone,
              now: now,
              providerName: day.hasTeam ? day.nameOf(row.providerId) : null,
            ),
          );
        },
      ),
    );
  }
}

import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_provider_filter.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_row_actions.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Today for a shop that takes bookings: the chairs, then what is still to come.
///
/// Calendar is for planning; this is for working. It only ever shows today, and
/// time already over drops off the list. [board] is the chairs themselves.
class OwnerTodayView extends StatelessWidget {
  const OwnerTodayView({super.key, required this.board});

  final Widget board;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerAgendaCubit, OwnerAgendaState>(
      listenWhen: (before, after) =>
          before.failure != after.failure && after.day != null,
      listener: (context, state) {
        if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context));
        }
      },
      builder: (context, state) {
        final t = context.t;
        final day = state.day;
        final shopName = di<AuthCubit>().state.shop?.name ?? t.nav.today;
        final summary = day?.summary;

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
                    line: summary == null
                        ? ''
                        : [
                            t.agenda.booked(n: summary.booked),
                            if (day?.openingHours.lastOrNull case final last?)
                              t.today.untilTime(
                                time: ShopClock.hm(
                                  last.toUtc,
                                  day!.timeZone,
                                  Localizations.localeOf(context).toString(),
                                ),
                              ),
                          ].join(' · '),
                  ),
                ),
                Expanded(
                  child: switch (state) {
                    OwnerAgendaState(failure: final error?) when day == null =>
                      AppErrorState(
                        message: error.localized(context),
                        retryLabel: t.common.retry,
                        onRetry: () => context.read<OwnerAgendaCubit>().load(),
                      ),
                    _ when day == null => const AppLoader.centered(),
                    _ => _Day(day: day, state: state, board: board),
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

class _Day extends StatelessWidget {
  const _Day({required this.day, required this.state, required this.board});

  final AgendaDay day;
  final OwnerAgendaState state;
  final Widget board;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final now = state.now;
    final cubit = context.read<OwnerAgendaCubit>();
    // Free runs and blocks are for planning, on Calendar. This is the people.
    // Someone already in the chair is on the board above.
    final upcoming = day.rows
        .whereType<AgendaBookingRow>()
        .where(
          (row) =>
              row.endUtc.isAfter(now) &&
              (row.status == BookingStatus.confirmed ||
                  (row.status == BookingStatus.arrived &&
                      row.startUtc.isAfter(now))),
        )
        .toList();

    return RefreshIndicator(
      onRefresh: () => cubit.load(refresh: true),
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
        children: [
          // Today is worked one chair at a time: with a team, the owner picks
          // whose day this is, and "Everyone" shows the shop's next booking.
          if (AgendaProviderFilter.showsFor(state)) ...[
            const AgendaProviderFilter(padding: EdgeInsets.zero),
            SizedBox(height: 14.h),
          ],
          board,
          if (upcoming.isEmpty) ...[
            SizedBox(height: 32.h),
            AppEmptyState(
              icon: day.closed
                  ? Icons.door_front_door_outlined
                  : Icons.event_available_outlined,
              title: day.closed
                  ? t.agenda.closedTitle
                  : t.today.nothingLeftTitle,
              message: day.closed
                  ? (day.closure ? t.agenda.closureBody : t.agenda.closedBody)
                  : t.today.nothingLeftBody,
            ),
          ],
          if (upcoming.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Text(t.today.comingUp, style: context.textTheme.headlineSmall),
            SizedBox(height: 10.h),
            for (final row in upcoming) ...[
              TodayRow(
                lead: ShopClock.hm(
                  row.startUtc,
                  day.timeZone,
                  Localizations.localeOf(context).toString(),
                ),
                leadAmber: false,
                name: row.customerName ?? t.agenda.customerFallback,
                line: [
                  row.serviceName,
                  ?AgendaProviderFilter.labelFor(state, row),
                ].join(' · '),
                tag: row.status == BookingStatus.arrived
                    ? row.status.label(t)
                    : t.today.bookedTag,
                tagTint: context.status.ofBooking(row.status),
                onTap: agendaRowTap(
                  context,
                  row: row,
                  timeZone: day.timeZone,
                  now: now,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ],
      ),
    );
  }
}

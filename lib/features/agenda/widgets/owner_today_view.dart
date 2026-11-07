import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_booking_sheet.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_row_actions.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The booking in progress, or the next one still to come.
///
/// A booking that was cancelled or missed is over as far as the day goes, so it
/// is never what the owner is told to look at.
AgendaBookingRow? todayFocus(List<AgendaRow> rows, DateTime now) {
  bool isLive(AgendaBookingRow row) =>
      row.status == BookingStatus.confirmed ||
      row.status == BookingStatus.arrived;

  final bookings = rows.whereType<AgendaBookingRow>().where(isLive).toList();

  for (final booking in bookings) {
    if (!now.isBefore(booking.startUtc) && now.isBefore(booking.endUtc)) {
      return booking;
    }
  }
  for (final booking in bookings) {
    if (booking.startUtc.isAfter(now)) return booking;
  }
  return null;
}

/// Today for a shop that takes bookings: what is happening, then what is next.
///
/// Calendar is for planning; this is for working. It only ever shows today, and
/// time already over drops off the list.
class OwnerTodayView extends StatelessWidget {
  const OwnerTodayView({super.key});

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
                    _ => _Day(day: day, state: state),
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
  const _Day({required this.day, required this.state});

  final AgendaDay day;
  final OwnerAgendaState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final now = state.now;
    final cubit = context.read<OwnerAgendaCubit>();
    final focus = todayFocus(day.rows, now);
    // Free runs and blocks are for planning, on Calendar. This is the people.
    final upcoming = day.rows
        .whereType<AgendaBookingRow>()
        .where((row) => row != focus && row.endUtc.isAfter(now))
        .where(
          (row) =>
              row.status == BookingStatus.confirmed ||
              row.status == BookingStatus.arrived,
        )
        .toList();

    return RefreshIndicator(
      onRefresh: () => cubit.load(refresh: true),
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
        children: [
          if (focus != null)
            _Focus(row: focus, timeZone: day.timeZone, state: state)
          else ...[
            SizedBox(height: 48.h),
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
                line: row.serviceName,
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

class _Focus extends StatelessWidget {
  const _Focus({
    required this.row,
    required this.timeZone,
    required this.state,
  });

  final AgendaBookingRow row;
  final String timeZone;
  final OwnerAgendaState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final now = state.now;
    final isNow = !now.isBefore(row.startUtc);
    final start = ShopClock.hm(row.startUtc, timeZone, locale);
    final name = row.customerName ?? t.agenda.customerFallback;
    final cubit = context.read<OwnerAgendaCubit>();
    final total = row.endUtc.difference(row.startUtc).inSeconds;
    final gone = now.difference(row.startUtc).inSeconds.clamp(0, total);
    final left = ((total - gone) / 60).ceil();
    final initial = name.trim().isEmpty
        ? '•'
        : name.trim().substring(0, 1).toUpperCase();

    return TodayChairCard(
      initial: initial,
      overline: isNow ? t.today.nowLabel : t.today.nextLabel,
      title: '$name · ${row.serviceName}',
      meta: isNow ? t.queue.owner.minutesLeft(minutes: left) : start,
      progress: isNow && total > 0 ? gone / total : null,
      actions: row.status == BookingStatus.confirmed
          ? TodayActionButton(
              label: t.agenda.sheet.markArrived,
              isLoading: state.isSaving,
              onPressed: () async {
                HapticFeedback.mediumImpact();
                final done = await cubit.markArrived(row.id);
                if (done && context.mounted) {
                  AppSnackBar.success(
                    context,
                    t.today.markedArrived(name: name),
                  );
                }
              },
            )
          : TodayActionButton(
              navy: true,
              label: t.today.details,
              onPressed: () => AgendaBookingSheet.open(
                context,
                row: row,
                timeZone: timeZone,
                now: now,
              ),
            ),
    );
  }
}

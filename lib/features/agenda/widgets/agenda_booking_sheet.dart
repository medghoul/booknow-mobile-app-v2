import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// How long after the start a customer becomes a no-show (§10.3).
///
/// The design's own sample says ten minutes. Fifteen is what the booking rules
/// say and what the server enforces, and a button that unlocks before the API
/// will accept it is a button that fails.
const int _noShowAfterMinutes = 15;

/// One booking, opened from its row.
///
/// A sheet rather than a dialog because it continues the day instead of
/// stopping it: the owner glances at it between two clients and dismisses it
/// without deciding anything.
class AgendaBookingSheet extends StatelessWidget {
  const AgendaBookingSheet({
    super.key,
    required this.row,
    required this.timeZone,
    required this.now,
  });

  final AgendaBookingRow row;
  final String timeZone;
  final DateTime now;

  static Future<void> open(
    BuildContext context, {
    required AgendaBookingRow row,
    required String timeZone,
    required DateTime now,
  }) => AppBottomSheet.show<void>(
    context,
    builder: (_) => BlocProvider.value(
      value: context.read<OwnerAgendaCubit>(),
      child: AgendaBookingSheet(row: row, timeZone: timeZone, now: now),
    ),
  );

  /// When the no-show button unlocks. Stated on the button itself while it is
  /// disabled, so a greyed control says why rather than just refusing.
  DateTime get _noShowFrom =>
      row.startUtc.add(const Duration(minutes: _noShowAfterMinutes));

  @override
  Widget build(BuildContext context) {
    final t = context.t.agenda.sheet;
    final locale = Localizations.localeOf(context).toString();
    final name = row.customerName ?? context.t.agenda.customerFallback;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    t.timeLine(
                      from: ShopClock.hm(row.startUtc, timeZone, locale),
                      to: ShopClock.hm(row.endUtc, timeZone, locale),
                      service: row.serviceName,
                      minutes: row.durationMinutes,
                    ),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            AppStatusBadge(
              tint: context.status.ofBooking(row.status),
              icon: row.status.icon,
              label: row.status.label(context.t),
            ),
          ],
        ),
        SizedBox(height: context.spacing.lg.h),
        _MoneyCard(priceCents: row.priceCents, feeCents: row.feeCents),
        SizedBox(height: context.spacing.lg.h),
        if (row.customerPhone case final phone?) ...[
          AppOutlinedButton(
            label: t.call(name: name.split(RegExp(r'\s+')).first),
            icon: Icons.phone_outlined,
            expand: true,
            onPressed: () => _call(context, phone),
          ),
          SizedBox(height: context.spacing.md.h),
        ],
        TodayActionButton(
          label: t.markArrived,
          onPressed: row.status == BookingStatus.confirmed
              ? () => _markArrived(context, name)
              : null,
        ),
        SizedBox(height: context.spacing.md.h),
        AppOutlinedButton(
          label: now.isBefore(_noShowFrom)
              ? t.noShowFrom(time: ShopClock.hm(_noShowFrom, timeZone, locale))
              : t.noShow,
          icon: Icons.person_off_outlined,
          expand: true,
          // Disabled until it is actually a no-show. A customer four minutes
          // late who is parking is not one, and this is irreversible.
          isDisabled:
              now.isBefore(_noShowFrom) ||
              row.status != BookingStatus.confirmed,
          onPressed: () => _markNoShow(context, name),
        ),
        AppTextButton(
          label: t.cancel,
          isDestructive: true,
          onPressed: row.status == BookingStatus.confirmed
              ? () => _cancel(context, name)
              : null,
        ),
      ],
    );
  }

  Future<void> _call(BuildContext context, String phone) async {
    final opened = await di<LinkService>().open(
      Uri(scheme: 'tel', path: phone),
    );
    if (opened || !context.mounted) return;

    AppSnackBar.error(context, context.t.agenda.sheet.noDialler);
  }

  Future<void> _markArrived(BuildContext context, String name) => _run(
    context,
    (cubit) => cubit.markArrived(row.id),
    context.t.today.markedArrived(name: name),
  );

  Future<void> _markNoShow(BuildContext context, String name) async {
    final t = context.t.today;
    final confirmed = await AppDialog.show(
      context,
      title: t.noShowTitle(name: name),
      message: t.noShowBody,
      confirmLabel: context.t.agenda.sheet.noShow,
      cancelLabel: context.t.common.cancel,
      icon: Icons.person_off_outlined,
    );
    if (!confirmed || !context.mounted) return;

    await _run(
      context,
      (cubit) => cubit.markNoShow(row.id),
      t.markedNoShow(name: name),
    );
  }

  Future<void> _cancel(BuildContext context, String name) async {
    final t = context.t.today;
    final confirmed = await AppDialog.show(
      context,
      title: t.cancelTitle(name: name),
      message: t.cancelBody,
      confirmLabel: context.t.agenda.sheet.cancel,
      cancelLabel: context.t.common.cancel,
      icon: Icons.event_busy_outlined,
    );
    if (!confirmed || !context.mounted) return;

    await _run(context, (cubit) => cubit.cancelBooking(row.id), t.cancelled);
  }

  /// Closes the sheet once it has landed, and says so on the screen beneath.
  Future<void> _run(
    BuildContext context,
    Future<bool> Function(OwnerAgendaCubit cubit) action,
    String success,
  ) async {
    final cubit = context.read<OwnerAgendaCubit>();
    final navigator = Navigator.of(context);
    final messenger = navigator.context;

    final done = await action(cubit);
    if (!context.mounted) return;

    if (done) {
      navigator.pop();
      AppSnackBar.success(messenger, success);
    } else if (cubit.state.failure case final failure?) {
      AppSnackBar.error(context, failure.localized(context));
    }
  }
}

/// What is still to be collected, over what has already been paid.
class _MoneyCard extends StatelessWidget {
  const _MoneyCard({required this.priceCents, required this.feeCents});

  final int priceCents;
  final int feeCents;

  @override
  Widget build(BuildContext context) {
    final t = context.t.agenda.sheet;

    return Container(
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: context.decorations.cardFlat.copyWith(
        borderRadius: BorderRadius.circular(context.radii.xl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.toCollect,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  Money.formatCents(priceCents),
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),
          ),
          SizedBox(width: context.spacing.md.w),
          Flexible(
            child: Text(
              t.holdPaid(amount: Money.formatCents(feeCents)),
              textAlign: TextAlign.end,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

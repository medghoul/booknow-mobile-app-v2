import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_booking_sheet.dart';
import 'package:booknow_mobile/features/agenda/widgets/block_time_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What a row does when tapped, or null when it does nothing. Shared by Today
/// and Calendar, so a row behaves the same on both.
///
/// Nothing is the right answer for time that is already over: a free run in
/// the past cannot be blocked and the server would refuse it, so the row is
/// read-only rather than offering an action that fails.
VoidCallback? agendaRowTap(
  BuildContext context, {
  required AgendaRow row,
  required String timeZone,
  required DateTime now,
}) {
  final isPast = row.endUtc.isBefore(now);

  return switch (row) {
    final AgendaBookingRow booking => () => AgendaBookingSheet.open(
      context,
      row: booking,
      timeZone: timeZone,
      now: now,
    ),
    final AgendaFreeRow free when !isPast => () => BlockTimeSheet.open(
      context,
      startUtc: free.startUtc,
      endUtc: free.endUtc,
      timeZone: timeZone,
    ),
    final AgendaBlockRow block when !isPast => () => _confirmUnblock(
      context,
      block,
    ),
    _ => null,
  };
}

/// Giving a block back is a dialog, not a sheet: it stops the owner and asks
/// them to confirm, and the time becomes bookable by customers again the
/// moment they do.
Future<void> _confirmUnblock(BuildContext context, AgendaBlockRow block) async {
  final t = context.t.agenda.block;
  final cubit = context.read<OwnerAgendaCubit>();

  final confirmed = await AppDialog.show(
    context,
    title: t.removeTitle,
    message: t.removeBody,
    confirmLabel: t.remove,
    cancelLabel: context.t.common.cancel,
    icon: Icons.lock_open_rounded,
  );
  if (!confirmed || !context.mounted) return;

  final removed = await cubit.unblockTime(block.id);
  if (!context.mounted) return;

  if (removed) {
    AppSnackBar.success(context, t.unblocked);
  } else if (cubit.state.failure case final failure?) {
    AppSnackBar.error(context, failure.localized(context));
  }
}

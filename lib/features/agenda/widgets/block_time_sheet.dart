import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Takes time off the grid: a break, an errand, a client with no booking.
///
/// Opened from a free row and pre-filled with that run, which is the whole
/// interaction — the owner taps the gap they can see and adjusts one end at
/// most. The v2 design has no sheet for this; the rules do, and a timeline
/// with no way to block an hour is a timeline the owner works around.
class BlockTimeSheet extends StatefulWidget {
  const BlockTimeSheet({
    super.key,
    required this.startUtc,
    required this.endUtc,
    required this.timeZone,
    this.providerId,
    this.providerName,
  });

  final DateTime startUtc;
  final DateTime endUtc;
  final String timeZone;

  /// Whose time is blocked: the free row's own person.
  final String? providerId;

  /// Their name, said under the times when the shop has a team, so the owner
  /// sees whose hour they are taking.
  final String? providerName;

  /// Resolves to true once the server has the block.
  static Future<bool?> open(
    BuildContext context, {
    required DateTime startUtc,
    required DateTime endUtc,
    required String timeZone,
    String? providerId,
    String? providerName,
  }) => AppBottomSheet.show<bool>(
    context,
    title: context.t.agenda.block.title,
    builder: (_) => BlocProvider.value(
      value: context.read<OwnerAgendaCubit>(),
      child: BlockTimeSheet(
        startUtc: startUtc,
        endUtc: endUtc,
        timeZone: timeZone,
        providerId: providerId,
        providerName: providerName,
      ),
    ),
  );

  @override
  State<BlockTimeSheet> createState() => _BlockTimeSheetState();
}

class _BlockTimeSheetState extends State<BlockTimeSheet> {
  /// Both ends as wall-clock times, which is what the owner picked and what
  /// the pickers show. They become instants once, on the way out.
  late TimeOfDay _from;
  late TimeOfDay _to;

  final TextEditingController _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    final from = ShopClock.wallTime(widget.startUtc, widget.timeZone);
    final to = ShopClock.wallTime(widget.endUtc, widget.timeZone);
    _from = TimeOfDay(hour: from.hour, minute: from.minute);
    _to = TimeOfDay(hour: to.hour, minute: to.minute);
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  int get _fromMinutes => _from.hour * 60 + _from.minute;
  int get _toMinutes => _to.hour * 60 + _to.minute;

  /// What is wrong with the draft, in the owner's words, or null when nothing
  /// is. The rules are [TimeBlock]'s; only the copy for them is here.
  String? get _problem =>
      switch (TimeBlock.problemFor(_fromMinutes, _toMinutes)) {
        BlockProblem.backwards => context.t.agenda.block.backwards,
        BlockProblem.tooLong => context.t.agenda.block.tooLong,
        null => null,
      };

  Future<void> _pick({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _from : _to,
    );
    if (picked == null) return;

    setState(() {
      final onGrid = TimeBlock.onGrid(picked.hour * 60 + picked.minute);
      final floored = TimeOfDay(hour: onGrid ~/ 60, minute: onGrid % 60);

      if (isStart) {
        _from = floored;
      } else {
        _to = floored;
      }
    });
  }

  Future<void> _save() async {
    final cubit = context.read<OwnerAgendaCubit>();
    final day = ShopClock.wallTime(widget.startUtc, widget.timeZone);

    final blocked = await cubit.blockTime(
      startUtc: ShopClock.instantOf(
        day,
        _from.hour,
        _from.minute,
        widget.timeZone,
      ),
      endUtc: ShopClock.instantOf(day, _to.hour, _to.minute, widget.timeZone),
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      providerId: widget.providerId,
    );
    if (!mounted) return;

    if (!blocked) {
      final failure = cubit.state.failure;
      if (failure != null) {
        AppSnackBar.error(context, failure.localized(context));
      }
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.agenda.block;
    final locale = Localizations.localeOf(context).toString();
    final problem = _problem;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _TimeField(
                label: t.from,
                value: _from.format(context),
                onTap: () => _pick(isStart: true),
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            Expanded(
              child: _TimeField(
                label: t.to,
                value: _to.format(context),
                onTap: () => _pick(isStart: false),
              ),
            ),
          ],
        ),
        if (problem != null)
          Padding(
            padding: EdgeInsets.only(top: context.spacing.sm.h),
            child: Text(
              problem,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
        SizedBox(height: context.spacing.lg.h),
        AppTextField(
          controller: _note,
          label: t.note,
          hint: t.noteHint,
          maxLength: TimeBlock.noteMaxLength,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: context.spacing.lg.h),
        // The day this lands on, spelled out: the sheet only shows two clock
        // times, and the strip may be days away from today.
        Text(
          [
            DateFormat(
              'EEEE d MMMM',
              locale,
            ).format(ShopClock.wallTime(widget.startUtc, widget.timeZone)),
            ?widget.providerName,
          ].join(' · '),
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        BlocSelector<OwnerAgendaCubit, OwnerAgendaState, bool>(
          selector: (state) => state.isSaving,
          builder: (context, isSaving) => AppElevatedButton(
            label: t.save,
            icon: Icons.block_rounded,
            expand: true,
            isLoading: isSaving,
            isDisabled: problem != null,
            onPressed: _save,
          ),
        ),
      ],
    );
  }
}

/// A read-only field that opens a time picker. Not an [AppTextField] with a
/// keyboard: a time is picked, never typed.
class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: label),
        SizedBox(height: context.spacing.xs.h),
        InkWell(
          onTap: onTap,
          borderRadius: context.radii.pillR,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.lg.w,
              vertical: context.spacing.md.h,
            ),
            decoration: context.decorations.input,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: context.textTheme.labelLarge),
                Icon(
                  Icons.schedule_rounded,
                  size: context.icons.s.w,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

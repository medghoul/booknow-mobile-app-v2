import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/extensions/weekday_extension.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_setup_chrome.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One day's hours: open or shut, its time slots, and who else gets them.
///
/// A sheet rather than a route so it shares the one [ShopSetupCubit] with the
/// week behind it — saving goes through that cubit, which re-reads the shop,
/// so the row underneath is already correct when this closes.
///
/// Everything in here is a draft until Salva. That is the difference from the
/// wizard's step, where a day's switch writes straight into the step's own
/// state: here the owner is changing hours customers are already booking
/// against, so a mis-tapped switch has to be recoverable by dismissing.
class DayHoursSheet extends StatefulWidget {
  const DayHoursSheet({super.key, required this.day});

  final Weekday day;

  /// Opens the editor and resolves to true once the server has the hours.
  static Future<bool?> open(BuildContext context, Weekday day) =>
      AppBottomSheet.show<bool>(
        context,
        builder: (_) => BlocProvider.value(
          value: context.read<ShopSetupCubit>(),
          child: DayHoursSheet(day: day),
        ),
      );

  @override
  State<DayHoursSheet> createState() => _DayHoursSheetState();
}

class _DayHoursSheetState extends State<DayHoursSheet> {
  late List<TimeRange> _ranges;

  /// The days this one's hours are being copied onto, if any.
  final Set<Weekday> _copyTo = {};

  bool _isCopyOpen = false;

  @override
  void initState() {
    super.initState();
    final hours =
        context.read<ShopSetupCubit>().state.shop?.openingHours ??
        const OpeningHours();
    _ranges = [...hours.rangesOn(widget.day)];
  }

  bool get _isOpen => _ranges.isNotEmpty;

  /// What is wrong with the draft, in the owner's words, or null when nothing
  /// is. Both cases are reachable from the time picker alone, so the sheet
  /// says which one it is rather than only greying out Salva.
  String? get _problem {
    final t = context.t.shopSetup.hours;
    if (_ranges.any((range) => !range.isValid)) return t.backwards;

    for (var i = 0; i < _ranges.length; i++) {
      for (var j = i + 1; j < _ranges.length; j++) {
        if (_ranges[i].overlaps(_ranges[j])) return t.overlap;
      }
    }
    return null;
  }

  void _toggleOpen(bool isOpen) => setState(() {
    _ranges = isOpen ? [...TimeRange.defaultDay] : [];
    if (!isOpen) {
      _copyTo.clear();
      _isCopyOpen = false;
    }
  });

  /// Adds a slot after the last one, an hour long, so the owner adjusts a real
  /// range rather than filling two empty fields.
  void _addRange() => setState(() {
    final last = _ranges.lastOrNull;
    final from = last == null ? '09:00' : last.to;
    _ranges = [..._ranges, TimeRange(from: from, to: _plusHour(from))];
  });

  static String _plusHour(String time) {
    final parts = time.split(':');
    final hour = (int.tryParse(parts.first) ?? 9) + 1;
    final minute = parts.length > 1 ? parts[1] : '00';
    return '${hour.clamp(0, 23).toString().padLeft(2, '0')}:$minute';
  }

  Future<void> _pickTime(int index, {required bool isStart}) async {
    final range = _ranges[index];
    final parts = (isStart ? range.from : range.to).split(':');

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 9,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;

    final value =
        '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';

    setState(() {
      _ranges = [
        for (final (i, existing) in _ranges.indexed)
          if (i == index)
            isStart
                ? existing.copyWith(from: value)
                : existing.copyWith(to: value)
          else
            existing,
      ];
    });
  }

  void _removeRange(int index) =>
      setState(() => _ranges = [..._ranges]..removeAt(index));

  Future<void> _save() async {
    final cubit = context.read<ShopSetupCubit>();
    final hours = cubit.state.shop?.openingHours ?? const OpeningHours();

    final saved = await cubit.saveOpeningHours(
      hours.setDay(widget.day, _ranges).copyDay(widget.day, _copyTo),
    );

    if (!saved || !mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.hours;
    final isSaving = context.watch<ShopSetupCubit>().state.isSaving;
    final problem = _problem;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // A day can hold more slots than the sheet is tall, and the keyboard
        // is not even involved — so the editable half scrolls and Salva stays
        // where it is.
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.day.fullName(context.t),
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      t.open,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: context.spacing.sm.w),
                    AppSwitch(
                      value: _isOpen,
                      onChanged: isSaving ? null : _toggleOpen,
                    ),
                  ],
                ),

                if (_isOpen) ...[
                  SizedBox(height: context.spacing.lg.h),
                  AppFieldLabel(label: t.slots),
                  for (final (index, range) in _ranges.indexed) ...[
                    if (index > 0) SizedBox(height: context.spacing.sm.h),
                    Row(
                      children: [
                        Expanded(
                          child: ShopTimePill(
                            value: range.from,
                            onTap: isSaving
                                ? null
                                : () => _pickTime(index, isStart: true),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacing.md.w,
                          ),
                          child: Text('–', style: context.textTheme.titleSmall),
                        ),
                        Expanded(
                          child: ShopTimePill(
                            value: range.to,
                            onTap: isSaving
                                ? null
                                : () => _pickTime(index, isStart: false),
                          ),
                        ),
                        SizedBox(width: context.spacing.xs.w),
                        AppIconButton(
                          icon: Icons.close_rounded,
                          tooltip: t.removeSlot,
                          size: context.icons.s.w,
                          onPressed: isSaving
                              ? null
                              : () => _removeRange(index),
                        ),
                      ],
                    ),
                  ],
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppTextButton(
                      label: t.addSlot,
                      icon: Icons.add_rounded,
                      onPressed: isSaving ? null : _addRange,
                    ),
                  ),
                  SizedBox(height: context.spacing.sm.h),
                  _CopyRow(
                    selected: _copyTo,
                    isExpanded: _isCopyOpen,
                    source: widget.day,
                    onToggleExpanded: () =>
                        setState(() => _isCopyOpen = !_isCopyOpen),
                    onToggleDay: (day) => setState(() {
                      if (!_copyTo.remove(day)) _copyTo.add(day);
                    }),
                  ),
                ],
              ],
            ),
          ),
        ),

        if (problem != null) ...[
          SizedBox(height: context.spacing.sm.h),
          Text(
            problem,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.error,
            ),
          ),
        ],

        SizedBox(height: context.spacing.lg.h),
        AppElevatedButton(
          label: context.t.common.save,
          expand: true,
          isLoading: isSaving,
          isDisabled: problem != null,
          onPressed: _save,
        ),
      ],
    );
  }
}

/// "Copia su altri giorni", and the days to copy onto.
///
/// The picker opens inside the sheet rather than on top of it: a second modal
/// over the first would put the hours being copied behind two scrims, and the
/// owner is choosing days *for* those hours.
class _CopyRow extends StatelessWidget {
  const _CopyRow({
    required this.selected,
    required this.isExpanded,
    required this.source,
    required this.onToggleExpanded,
    required this.onToggleDay,
  });

  final Set<Weekday> selected;
  final bool isExpanded;

  /// The day whose hours are being copied; never one of the choices.
  final Weekday source;

  final VoidCallback onToggleExpanded;
  final ValueChanged<Weekday> onToggleDay;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.hours;
    final days = Weekday.values.where((day) => day != source);

    final value = selected.isEmpty
        ? t.copyNone
        : (days.where(selected.contains).map((day) => day.shortName(context.t)))
              .join(', ');

    return Container(
      decoration: context.decorations.cardFlat,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AppPressScale(
            builder: (context, states) => InkWell(
              onTap: onToggleExpanded,
              statesController: states,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacing.lg.w,
                  vertical: context.spacing.md.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.copy_outlined,
                      size: context.icons.s.w,
                      color: context.colorScheme.secondary,
                    ),
                    SizedBox(width: context.spacing.md.w),
                    Expanded(
                      child: Text(
                        t.copyTo,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    SizedBox(width: context.spacing.sm.w),
                    Text(
                      value,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: context.spacing.xs.w),
                    AnimatedRotation(
                      turns: isExpanded ? 0.25 : 0,
                      duration: context.motion.fast,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: context.icons.s.w,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.spacing.lg.w,
                0,
                context.spacing.lg.w,
                context.spacing.md.h,
              ),
              child: Row(
                children: [
                  for (final day in days) ...[
                    if (day != days.first)
                      SizedBox(width: context.spacing.xs.w),
                    Expanded(
                      child: _DayChip(
                        day: day,
                        isSelected: selected.contains(day),
                        onTap: () => onToggleDay(day),
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final Weekday day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: context.motion.fast,
          padding: EdgeInsets.symmetric(vertical: context.spacing.sm.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.secondary
                : context.colorScheme.surfaceContainerHighest,
            borderRadius: context.radii.smR,
          ),
          child: Text(
            day.shortName(context.t),
            style: context.textTheme.labelMedium?.copyWith(
              color: isSelected
                  ? context.colorScheme.onSecondary
                  : context.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

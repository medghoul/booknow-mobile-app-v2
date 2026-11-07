import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/extensions/weekday_extension.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/day_hours_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The whole week on one card, one row per day.
///
/// All seven days, including the closed ones, because the question an owner
/// opens this screen with is "when am I open" and a week with days missing
/// cannot answer it. There is no Save: a day is edited in a sheet that saves
/// it on its own, so the card is always what the server holds.
class ShopHoursList extends StatelessWidget {
  const ShopHoursList({super.key, this.onDone});

  /// During first setup: finishes the step, once at least one day is open.
  final VoidCallback? onDone;

  /// "09:00–13:00 · 15:00–19:30", or null for a closed day.
  ///
  /// A day with one range says so in words — "08:30–18:00 · orario
  /// continuato" — because one range and two ranges look alike at a glance
  /// and the difference is whether the shop shuts for lunch.
  static String? summaryOf(List<TimeRange> ranges, Translations t) {
    if (ranges.isEmpty) return null;

    return ranges.map((r) => '${r.from}–${r.to}').join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.hours;
    final state = context.watch<ShopSetupCubit>().state;
    final hours = state.shop?.openingHours ?? const OpeningHours();

    final week = [
      if (!hours.hasAnyOpenDay) ...[
        _TypicalWeek(onUse: state.isSaving ? null : () => _useTypical(context)),
        SizedBox(height: context.spacing.lg.h),
      ],
      AppSectionTitle(t.weekly),
      SizedBox(height: context.spacing.sm.h),
      AppSettingsCard(
        children: [
          for (final day in Weekday.values)
            ShopDayRow(
              day: day,
              ranges: hours.rangesOn(day),
              onTap: state.isSaving ? null : () => _edit(context, day),
            ),
        ],
      ),
      SizedBox(height: context.spacing.xl.h),
    ];

    final done = onDone;
    if (done == null) {
      return ListView(children: week);
    }

    return AppDockedColumn(
      animate: false,
      docked: AppElevatedButton(
        label: context.t.shopSetup.checklist.done,
        expand: true,
        isDisabled: !hours.hasAnyOpenDay || !hours.isValid,
        onPressed: done,
      ),
      children: week,
    );
  }

  /// Most shops are close to this, so editing one or two days beats filling in
  /// seven.
  Future<void> _useTypical(BuildContext context) async {
    final cubit = context.read<ShopSetupCubit>();
    var hours = cubit.state.shop?.openingHours ?? const OpeningHours();
    for (final day in _typicalDays) {
      hours = hours.setDay(day, TimeRange.defaultDay);
    }
    await cubit.saveOpeningHours(hours);
  }

  static const List<Weekday> _typicalDays = [
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
  ];

  Future<void> _edit(BuildContext context, Weekday day) async {
    final saved = await DayHoursSheet.open(context, day);
    if (!(saved ?? false) || !context.mounted) return;

    AppSnackBar.success(context, context.t.shopSetup.hours.saved);
  }
}

/// Offered while the whole week is closed: one tap to a sensible start.
class _TypicalWeek extends StatelessWidget {
  const _TypicalWeek({required this.onUse});

  final VoidCallback? onUse;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final tint = context.status.confirmed;
    final hours = ShopHoursList.summaryOf(TimeRange.defaultDay, t) ?? '';

    return Container(
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.lgR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.shopSetup.checklist.typicalTitle,
            style: context.textTheme.titleSmall?.copyWith(
              color: tint.foreground,
            ),
          ),
          SizedBox(height: context.spacing.xxs.h),
          Text(
            t.shopSetup.checklist.typicalBody(hours: hours),
            style: context.textTheme.bodySmall?.copyWith(
              color: tint.foreground,
            ),
          ),
          SizedBox(height: context.spacing.md.h),
          AppElevatedButton(
            label: t.shopSetup.checklist.typicalCta,
            onPressed: onUse,
          ),
        ],
      ),
    );
  }
}

/// One day: its name, its hours, and the way into editing them.
///
/// Public so a team member's own week reads exactly like the shop's.
class ShopDayRow extends StatelessWidget {
  const ShopDayRow({
    super.key,
    required this.day,
    required this.ranges,
    required this.onTap,
  });

  final Weekday day;
  final List<TimeRange> ranges;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final summary = ShopHoursList.summaryOf(ranges, t);

    return AppPressScale(
      builder: (context, states) => InkWell(
        onTap: onTap,
        statesController: states,
        child: Container(
          constraints: BoxConstraints(minHeight: 52.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          child: Row(
            children: [
              SizedBox(
                width: 44.w,
                child: Text(
                  day.shortName(t),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: context.fonts.s.sp,
                    // A closed day reads quieter than an open one, so the
                    // week's shape is visible before any of it is read.
                    color: summary == null
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(width: context.spacing.sm.w),
              Expanded(
                child: Text(
                  summary ?? t.shopSetup.hours.closed,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: summary == null
                        ? FontWeight.w500
                        : FontWeight.w600,
                    color: summary == null
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.onSurface,
                  ),
                ),
              ),
              if (onTap != null) ...[
                SizedBox(width: context.spacing.sm.w),
                AppLineIcon(
                  AppLineIcons.chevronRight,
                  size: 18,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

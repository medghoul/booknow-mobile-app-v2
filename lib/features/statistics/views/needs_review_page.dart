import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/statistics/cubit/statistics_lists_cubits.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Visits whose times cannot be believed, for the owner to correct.
@RoutePage()
class NeedsReviewPage extends StatelessWidget {
  const NeedsReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocProvider(
      create: (_) => NeedsReviewCubit(di<StatisticsRepository>())..load(),
      child: AppScaffold(
        padding: EdgeInsets.zero,
        appBar: AppAppBar(
          title: t.statistics.review.title,
          backTooltip: t.common.back,
        ),
        body: const NeedsReviewView(),
      ),
    );
  }
}

class NeedsReviewView extends StatelessWidget {
  const NeedsReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NeedsReviewCubit, StatisticsLoadState<ReviewList>>(
      listenWhen: (before, after) =>
          before.failure != after.failure && after.data != null,
      listener: (context, state) {
        if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context));
        }
      },
      builder: (context, state) {
        final t = context.t;
        final list = state.data;

        if (list == null) {
          return state.isLoading
              ? const AppLoader.centered()
              : AppErrorState(
                  message: state.failure?.localized(context) ?? '',
                  retryLabel: t.common.retry,
                  onRetry: context.read<NeedsReviewCubit>().load,
                );
        }
        if (list.items.isEmpty) {
          return AppEmptyState(
            icon: Icons.check_circle_outline_rounded,
            title: t.statistics.review.emptyTitle,
            message: t.statistics.review.emptyBody,
          );
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
          itemCount: list.items.length,
          separatorBuilder: (_, _) => SizedBox(height: 10.h),
          itemBuilder: (_, index) => _ReviewCard(
            item: list.items[index],
            timeZone: list.timeZone,
            busy: state.busy,
          ),
        );
      },
    );
  }
}

String _flagLabel(BuildContext context, ReviewFlag flag) {
  final t = context.t.statistics.review;
  return switch (flag) {
    ReviewFlag.forgottenDone => t.forgottenDone,
    ReviewFlag.tooShort => t.tooShort,
    ReviewFlag.neverStarted => t.neverStarted,
  };
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.item,
    required this.timeZone,
    required this.busy,
  });

  final ReviewItem item;
  final String timeZone;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics.review;
    final scheme = context.colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final day = DateTime.tryParse(item.localDate);
    String clock(DateTime at) => ShopClock.hm(at, timeZone, locale);

    final times = [
      if (item.startedAt case final at?)
        t.started(time: clock(at))
      else
        t.noStart,
      if (item.finishedAt case final at?)
        t.finished(time: clock(at))
      else
        t.noFinish,
      if (item.plannedMin case final minutes?) t.planned(minutes: minutes),
    ].join(' · ');

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: context.decorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  [
                    item.serviceName ?? t.otherService,
                    ?item.providerName,
                  ].join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
              ),
              if (day != null) ...[
                const SizedBox(width: 8),
                Text(
                  DateFormat.MMMd(locale).format(day),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            _flagLabel(context, item.flag),
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.status.pending.foreground,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            times,
            style: context.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 10.h),
          OutlinedButton(
            onPressed: busy
                ? null
                : () => _CorrectionSheet.open(context, item, timeZone),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              foregroundColor: scheme.onSurface,
              textStyle: context.textTheme.labelLarge?.copyWith(
                fontSize: context.fonts.s.sp,
              ),
            ),
            child: Text(t.fix),
          ),
        ],
      ),
    );
  }
}

/// The start and the finish, on the shop's own clock.
class _CorrectionSheet extends StatefulWidget {
  const _CorrectionSheet({
    required this.item,
    required this.timeZone,
    required this.cubit,
  });

  final ReviewItem item;
  final String timeZone;
  final NeedsReviewCubit cubit;

  static Future<void> open(
    BuildContext context,
    ReviewItem item,
    String timeZone,
  ) {
    final cubit = context.read<NeedsReviewCubit>();

    return AppBottomSheet.show<void>(
      context,
      title: context.t.statistics.review.sheetTitle,
      builder: (_) =>
          _CorrectionSheet(item: item, timeZone: timeZone, cubit: cubit),
    );
  }

  @override
  State<_CorrectionSheet> createState() => _CorrectionSheetState();
}

class _CorrectionSheetState extends State<_CorrectionSheet> {
  late DateTime? _start = widget.item.startedAt;

  /// A forgotten Done is usually an end nobody believes, so it starts empty.
  late DateTime? _finish = widget.item.flag == ReviewFlag.forgottenDone
      ? null
      : widget.item.finishedAt;

  bool get _backwards =>
      _start != null && _finish != null && !_finish!.isAfter(_start!);

  /// What is new compared with what the server already holds.
  bool get _changedStart => _start != null && _start != widget.item.startedAt;
  bool get _changedFinish =>
      _finish != null && _finish != widget.item.finishedAt;

  bool get _canSave =>
      !_backwards &&
      _start != null &&
      _finish != null &&
      (_changedStart || _changedFinish);

  Future<void> _pick({required bool isStart}) async {
    final current = isStart ? _start : (_finish ?? _start);
    final wall = current == null
        ? null
        : ShopClock.wallTime(current, widget.timeZone);
    final picked = await showTimePicker(
      context: context,
      initialTime: wall == null
          ? const TimeOfDay(hour: 12, minute: 0)
          : TimeOfDay(hour: wall.hour, minute: wall.minute),
    );
    final date = DateTime.tryParse(widget.item.localDate);
    if (picked == null || date == null || !mounted) return;

    final instant = ShopClock.instantOf(
      date,
      picked.hour,
      picked.minute,
      widget.timeZone,
    );
    setState(() {
      if (isStart) {
        _start = instant;
      } else {
        _finish = instant;
      }
    });
  }

  Future<void> _save() async {
    final t = context.t.statistics.review;
    final saved = await widget.cubit.correct(
      widget.item,
      startedAt: _changedStart ? _start : null,
      finishedAt: _changedFinish ? _finish : null,
    );
    if (!mounted) return;
    Navigator.of(context).pop();
    if (saved) AppSnackBar.success(context, t.saved);
  }

  Future<void> _leave() async {
    final t = context.t.statistics.review;
    final left = await widget.cubit.leave(widget.item);
    if (!mounted) return;
    Navigator.of(context).pop();
    if (left) AppSnackBar.success(context, t.left);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics.review;
    final scheme = context.colorScheme;
    final locale = Localizations.localeOf(context).toString();
    String show(DateTime? at) =>
        at == null ? t.notSet : ShopClock.hm(at, widget.timeZone, locale);

    Widget field(String label, DateTime? value, VoidCallback onTap) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.mdR,
          side: BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 52),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(label, style: context.textTheme.bodyMedium),
                ),
                Text(show(value), style: context.textTheme.titleSmall),
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        field(t.start, _start, () => _pick(isStart: true)),
        field(t.finish, _finish, () => _pick(isStart: false)),
        if (_backwards)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              t.backwards,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.status.error.foreground,
              ),
            ),
          ),
        TodayActionButton(
          navy: true,
          label: t.save,
          onPressed: _canSave ? _save : null,
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: _leave,
          style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: Text(t.leave),
        ),
        Text(
          t.leaveNote,
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

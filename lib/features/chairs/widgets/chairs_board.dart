import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/chairs.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/chairs/cubit/owner_chairs_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One card per chair: who is in it, how it is going, and what comes next.
///
/// Built for someone with busy hands: every card has at most one Done and one
/// Start, and starting the next customer closes the one before.
class ChairsBoard extends StatelessWidget {
  const ChairsBoard({super.key, required this.showTurnedAway});

  /// Whether this shop runs a line, and so can turn somebody away.
  final bool showTurnedAway;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerChairsCubit, OwnerChairsState>(
      builder: (context, state) {
        final t = context.t;
        final board = state.board;

        if (board == null) {
          return state.isLoading
              ? SizedBox(height: 200.h, child: const AppLoader.centered())
              : AppErrorState(
                  message: state.failure?.localized(context) ?? '',
                  retryLabel: t.common.retry,
                  onRetry: context.read<OwnerChairsCubit>().load,
                );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final chair in board.chairs) ...[
              _ChairCard(chair: chair, timeZone: board.timeZone, state: state),
              SizedBox(height: 12.h),
            ],
            if (showTurnedAway) _TurnedAwayButton(busy: state.busy),
          ],
        );
      },
    );
  }
}

String _initial(String? name) => name == null || name.trim().isEmpty
    ? '•'
    : name.trim().substring(0, 1).toUpperCase();

String _first(String name) => name.trim().split(RegExp(r'\s+')).first;

class _ChairCard extends StatelessWidget {
  const _ChairCard({
    required this.chair,
    required this.timeZone,
    required this.state,
  });

  final Chair chair;
  final String timeZone;
  final OwnerChairsState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final owner = t.queue.owner;
    final locale = Localizations.localeOf(context).toString();
    final cubit = context.read<OwnerChairsCubit>();
    final current = chair.current;
    final called = chair.called;
    final next = chair.nextVisit;
    final who = chair.name ?? owner.chair;

    String nameOf(ChairVisit visit) => visit.customerName ?? owner.walkInName;

    final plannedEnd = current?.plannedEnd;
    final overBy = plannedEnd == null
        ? 0
        : state.now.difference(plannedEnd).inMinutes;
    final isOver = overBy >= 1;
    final total = (current?.plannedMinutes ?? 0) * 60;
    final gone = current?.startedAt == null
        ? 0
        : state.now.difference(current!.startedAt!).inSeconds.clamp(0, total);

    final doneButton = current == null
        ? null
        : TodayActionButton(
            navy: true,
            label: t.chairs.done,
            isLoading: state.busy,
            onPressed: () {
              HapticFeedback.mediumImpact();
              cubit.done(chair, current);
            },
          );

    final nextButton = next == null
        ? null
        : TodayActionButton(
            label: chair.nextAction == ChairNextAction.call
                ? t.today.callName(name: _first(nameOf(next)))
                : t.chairs.startName(name: _first(nameOf(next))),
            isLoading: state.busy,
            onPressed: () {
              HapticFeedback.mediumImpact();
              if (chair.nextAction == ChairNextAction.call) {
                cubit.call(chair);
              } else {
                cubit.start(chair, next);
              }
            },
          );

    return TodayChairCard(
      initial: _initial(who),
      overline: current == null ? who : [owner.inChair, who].join(' · '),
      title: current != null
          ? '${nameOf(current)} · ${current.serviceName}'
          : called != null
          ? owner.calledName(name: nameOf(called))
          : t.chairs.free,
      meta: plannedEnd == null
          ? null
          : isOver
          ? t.chairs.overPlan(minutes: overBy)
          : t.chairs.until(time: ShopClock.hm(plannedEnd, timeZone, locale)),
      metaColor: isOver ? context.status.error.foreground : null,
      progress: current == null || total == 0 ? null : gone / total,
      progressColor: isOver ? context.status.error.foreground : null,
      actions: switch ((doneButton, nextButton)) {
        (final Widget done, final Widget start) => Row(
          children: [
            Expanded(child: done),
            const SizedBox(width: 8),
            Expanded(child: start),
          ],
        ),
        (final Widget done, null) => done,
        (null, final Widget start) => start,
        (null, null) => null,
      },
      footer: _Footer(
        chair: chair,
        timeZone: timeZone,
        state: state,
        nameOf: nameOf,
      ),
    );
  }
}

/// The no-show button when someone was called, and what is next for this chair.
class _Footer extends StatelessWidget {
  const _Footer({
    required this.chair,
    required this.timeZone,
    required this.state,
    required this.nameOf,
  });

  final Chair chair;
  final String timeZone;
  final OwnerChairsState state;
  final String Function(ChairVisit) nameOf;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final called = chair.called;
    final inQueue = chair.nextInQueue;
    final booking = chair.nextBooking;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (called != null)
          _NoShowButton(visit: called, now: state.now, busy: state.busy),
        if (inQueue != null)
          _NextLine(
            label: t.chairs.nextInLine,
            value: '${nameOf(inQueue)} · ${inQueue.serviceName}',
          ),
        if (booking != null)
          _NextLine(
            label: t.chairs.nextBooking,
            value: [
              if (booking.scheduledAt case final at?)
                ShopClock.hm(at, timeZone, locale),
              nameOf(booking),
              booking.serviceName,
            ].join(' · '),
          ),
      ],
    );
  }
}

class _NoShowButton extends StatelessWidget {
  const _NoShowButton({
    required this.visit,
    required this.now,
    required this.busy,
  });

  final ChairVisit visit;
  final DateTime now;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue.owner;
    final scheme = context.colorScheme;
    final left = visit.noShowFrom?.difference(now);
    final locked = left != null && !left.isNegative;
    final clock = locked
        ? '${left.inMinutes}:${(left.inSeconds % 60).toString().padLeft(2, '0')}'
        : '';

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: OutlinedButton(
        onPressed: busy || locked
            ? null
            : () => context.read<OwnerChairsCubit>().noShow(visit),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          foregroundColor: context.status.error.foreground,
          disabledForegroundColor: scheme.onSurfaceVariant,
          textStyle: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(locked ? t.noShowIn(time: clock) : t.noShow),
      ),
    );
  }
}

class _NextLine extends StatelessWidget {
  const _NextLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TurnedAwayButton extends StatelessWidget {
  const _TurnedAwayButton({required this.busy});

  final bool busy;

  @override
  Widget build(BuildContext context) {
    final t = context.t.chairs;

    return OutlinedButton(
      onPressed: busy
          ? null
          : () async {
              HapticFeedback.lightImpact();
              final recorded = await context
                  .read<OwnerChairsCubit>()
                  .turnedAway();
              if (recorded && context.mounted) {
                AppSnackBar.success(context, t.turnedAwayRecorded);
              }
            },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        foregroundColor: context.colorScheme.onSurfaceVariant,
        textStyle: context.textTheme.labelLarge?.copyWith(
          fontSize: context.fonts.s.sp,
        ),
      ),
      child: Text(t.turnedAway),
    );
  }
}

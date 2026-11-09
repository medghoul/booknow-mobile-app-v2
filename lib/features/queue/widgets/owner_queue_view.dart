import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/owner_queue_cubit.dart';
import 'package:booknow_mobile/features/queue/widgets/live_bar.dart';
import 'package:booknow_mobile/features/queue/widgets/walk_in_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Today for a shop that runs a queue: the chairs, who waits, and the state of
/// the line (queue spec §5).
///
/// Built for someone at the counter with busy hands: adding a walk-in is always
/// in reach of the thumb. [board] is the chairs themselves.
///
/// Times are shown on the phone's clock: an owner runs the queue from inside
/// the shop, where the two are the same.
class OwnerQueueView extends StatelessWidget {
  const OwnerQueueView({super.key, required this.board});

  final Widget board;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerQueueCubit, OwnerQueueState>(
      listenWhen: (before, after) => before.failure != after.failure,
      listener: (context, state) {
        if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context));
        }
      },
      builder: (context, state) {
        final queue = state.queue;
        if (queue == null) {
          return AppScaffold(
            body: state.isLoading
                ? const AppLoader.centered()
                : AppErrorState(
                    message: state.failure?.localized(context) ?? '',
                    retryLabel: context.t.common.retry,
                    onRetry: context.read<OwnerQueueCubit>().load,
                  ),
          );
        }

        return AppScaffold(
          padding: EdgeInsets.zero,
          useSafeArea: false,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: _Body(state: state, queue: queue, board: board),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.queue, required this.board});

  final OwnerQueueState state;
  final OwnerQueue queue;
  final Widget board;

  Future<void> _addWalkIn(BuildContext context) async {
    final cubit = context.read<OwnerQueueCubit>();
    final choice = await WalkInSheet.ask(context, services: state.services);
    if (choice != null) {
      await cubit.addWalkIn(serviceId: choice.serviceId, name: choice.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final owner = t.queue.owner;
    final cubit = context.read<OwnerQueueCubit>();
    final waiting = queue.waiting;
    final until = queue.emptiesAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OwnerHeader(
          child: OwnerHeaderTitle(
            title: di<AuthCubit>().state.shop?.name ?? t.nav.today,
            line: until == null
                ? owner.summaryEmpty
                : t.today.queueLine(
                    n: queue.waitingCount,
                    time: DateFormat.Hm().format(until.toLocal()),
                  ),
            trailing: _StateButton(queue: queue, busy: state.busy),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: cubit.refresh,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      14.h,
                      16.w,
                      // Clear of the floating walk-in button.
                      84.h,
                    ),
                    children: [
                      if (queue.state != QueueState.open) ...[
                        _NotOpenBanner(queue: queue, busy: state.busy),
                        SizedBox(height: 20.h),
                      ],
                      board,
                      SizedBox(height: 20.h),
                      Text(
                        t.today.comingUp,
                        style: context.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 10.h),
                      for (final (index, entry) in waiting.indexed) ...[
                        _WaitingRow(
                          number: index + 1,
                          entry: entry,
                          busy: state.busy,
                          name: entry.customerName ?? owner.walkInName,
                          // Only someone who asked for a person has one yet.
                          askedFor: queue.hasTeam ? entry.providerName : null,
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (waiting.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            owner.nobodyWaiting,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 16.h,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF0F2A4A,
                          ).withValues(alpha: 0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: FilledButton.icon(
                      onPressed: state.busy ? null : () => _addWalkIn(context),
                      icon: AppLineIcon(
                        AppLineIcons.plus,
                        color: context.colorScheme.onSecondary,
                        strokeWidth: 2.5,
                      ),
                      label: Text(owner.walkInFab),
                      style: FilledButton.styleFrom(
                        minimumSize: Size(136.w, 50.h),
                        backgroundColor: context.colorScheme.secondary,
                        foregroundColor: context.colorScheme.onSecondary,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        textStyle: context.textTheme.labelLarge,
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Open, paused or closed: always visible, one tap to change.
class _StateButton extends StatelessWidget {
  const _StateButton({required this.queue, required this.busy});

  final OwnerQueue queue;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue;
    final (label, dot, background, foreground) = switch (queue.state) {
      QueueState.open => (
        context.t.today.stateOpenTitle,
        const Color(0xFF4ADE80),
        Colors.white.withValues(alpha: 0.14),
        context.onHeaderColor,
      ),
      QueueState.paused => (
        t.statePaused,
        const Color(0xFFFBBF24),
        context.status.pending.background,
        context.status.pending.foreground,
      ),
      QueueState.closed => (
        t.stateClosed,
        const Color(0xFFF87171),
        context.status.error.background,
        context.status.error.foreground,
      ),
    };

    return Material(
      color: background,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: busy ? null : () => _QueueStateSheet.open(context, queue),
        child: Container(
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LivePulse(color: dot),
              SizedBox(width: context.spacing.sm.w),
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
              SizedBox(width: context.spacing.sm.w),
              AppLineIcon(
                AppLineIcons.chevronDown,
                size: 16,
                color: foreground,
                strokeWidth: 2.25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// What each state of the queue means, stated before choosing it.
class _QueueStateSheet extends StatelessWidget {
  const _QueueStateSheet({required this.queue, required this.cubit});

  final OwnerQueue queue;
  final OwnerQueueCubit cubit;

  static Future<void> open(BuildContext context, OwnerQueue queue) {
    final cubit = context.read<OwnerQueueCubit>();

    return AppBottomSheet.show<void>(
      context,
      title: context.t.today.stateTitle,
      builder: (_) => _QueueStateSheet(queue: queue, cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    void choose(Future<void> Function() action) {
      Navigator.of(context).pop();
      action();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // Closing is for the rest of the day, but nothing about it is final:
      // the end-of-day job refunds whoever is still waiting either way, so
      // the owner can open again if they closed by mistake or stay late.
      children: [
        _StateOption(
          title: t.today.stateOpenTitle,
          body: t.today.stateOpenBody,
          selected: queue.state == QueueState.open,
          onTap: () => choose(cubit.resume),
        ),
        const SizedBox(height: 14),
        _StateOption(
          title: t.queue.owner.pause,
          body: t.today.statePauseBody,
          selected: queue.state == QueueState.paused,
          onTap: () => choose(cubit.pause),
        ),
        const SizedBox(height: 14),
        _StateOption(
          title: t.queue.owner.closeToday,
          body: t.today.stateCloseBody(n: queue.waitingCount),
          selected: queue.state == QueueState.closed,
          onTap: () => choose(cubit.closeForToday),
        ),
      ],
    );
  }
}

class _StateOption extends StatelessWidget {
  const _StateOption({
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.mdR,
          side: BorderSide(
            color: selected ? scheme.secondary : scheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: selected ? null : onTap,
          child: Container(
            constraints: BoxConstraints(minHeight: 70.h),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: context.fonts.s.sp,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotOpenBanner extends StatelessWidget {
  const _NotOpenBanner({required this.queue, required this.busy});

  final OwnerQueue queue;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final paused = queue.state == QueueState.paused;
    final tint = context.status.pending;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.mdR,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              paused ? t.today.pausedBanner : t.today.closedBanner,
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 14.sp,
                color: tint.foreground,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            height: 44,
            child: FilledButton(
              onPressed: busy ? null : context.read<OwnerQueueCubit>().resume,
              style: FilledButton.styleFrom(
                backgroundColor: tint.foreground,
                foregroundColor: tint.background,
                minimumSize: const Size(0, 44),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: context.textTheme.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(t.queue.owner.reopen),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaitingRow extends StatelessWidget {
  const _WaitingRow({
    required this.number,
    required this.entry,
    required this.busy,
    required this.name,
    this.askedFor,
  });

  final int number;
  final OwnerQueueEntry entry;
  final bool busy;
  final String name;

  /// The person they are waiting for, when they asked for one.
  final String? askedFor;

  bool get _isWalkIn => entry.kind == QueueEntryKind.walkIn;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue.owner;

    return TodayRow(
      lead: '#$number',
      leadAmber: true,
      name: name,
      line: [entry.serviceName, ?askedFor].join(' · '),
      tag: _isWalkIn ? t.kindWalkIn : t.kindApp,
      tagTint: context.status.pending,
      onTap: busy ? null : () => _openRow(context),
    );
  }

  /// What can be done about one person in line, and what it costs them.
  Future<void> _openRow(BuildContext context) async {
    final t = context.t.queue.owner;
    final cubit = context.read<OwnerQueueCubit>();
    final tag = _isWalkIn ? t.kindWalkIn : t.kindApp;
    final remove = await AppBottomSheet.show<bool>(
      context,
      builder: (sheet) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: sheet.textTheme.titleMedium),
          const SizedBox(height: 2),
          Text(
            '${entry.serviceName} · $tag',
            style: sheet.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: sheet.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () => Navigator.of(sheet).pop(true),
            style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(50.h),
              foregroundColor: sheet.status.error.foreground,
              textStyle: sheet.textTheme.labelLarge?.copyWith(
                fontSize: sheet.fonts.s.sp,
              ),
            ),
            child: Text(t.removeFromLine),
          ),
          const SizedBox(height: 14),
          Text(
            _isWalkIn ? t.rowNoteWalkIn : t.rowNoteApp,
            style: sheet.textTheme.bodySmall?.copyWith(
              color: sheet.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
    if (remove ?? false) await cubit.remove(entry.id);
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:booknow_mobile/features/queue/widgets/leave_queue_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The customer in line: waiting ("Sei in coda"), called ("È il tuo turno"),
/// or in the chair.
class QueueLineView extends StatelessWidget {
  const QueueLineView({super.key, required this.state});

  final QueueFlowState state;

  @override
  Widget build(BuildContext context) {
    final entry = state.entry;
    if (entry == null) return const AppLoader.centered();

    if (state.isServing) return _Serving(entry: entry);
    if (state.isCalled) return _Called(entry: entry, left: state.turnLeft);
    return _Waiting(entry: entry, isBusy: state.isBusy);
  }
}

class _Waiting extends StatelessWidget {
  const _Waiting({required this.entry, required this.isBusy});

  final QueueEntry entry;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue;
    final ahead = entry.aheadCount ?? 0;
    final almost = ahead <= 1;
    final estimate = entry.estimate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: context.read<QueueFlowCubit>().refresh,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppStatusBadge(
                    tint: almost
                        ? context.status.pending
                        : context.status.confirmed,
                    icon: Icons.schedule_rounded,
                    label: almost ? t.almost : t.inQueue,
                  ),
                ),
                SizedBox(height: context.spacing.lg.h),
                Text(
                  [
                    entry.shopName,
                    entry.serviceName,
                  ].whereType<String>().join(' · ').toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    letterSpacing: 1.6,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      t.position(n: entry.position ?? ahead + 1),
                      style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 96,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: context.spacing.sm.w),
                    Text(t.inLine, style: context.textTheme.titleLarge),
                  ],
                ),
                Text(
                  [
                    if (ahead == 0) t.next else t.ahead(n: ahead),
                    if (estimate != null)
                      '${t.turnIn} ${t.range(from: estimate.fromMin, to: estimate.toMin)}',
                  ].join(' · '),
                  style: context.textTheme.bodyLarge,
                ),
                SizedBox(height: context.spacing.xl.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      size: context.icons.s.w,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: context.spacing.sm.w),
                    Expanded(
                      child: Text(
                        t.waitAnywhere,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                entry.refundIfLeaving ? t.leaveRefund : t.leaveNoRefund,
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.spacing.sm.h),
              AppOutlinedButton(
                label: t.leave,
                expand: true,
                isLoading: isBusy,
                onPressed: () => _leave(context),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
      ],
    );
  }

  Future<void> _leave(BuildContext context) async {
    final cubit = context.read<QueueFlowCubit>();
    if (await LeaveQueueSheet.ask(context, entry: entry)) {
      await cubit.leave();
    }
  }
}

class _Called extends StatelessWidget {
  const _Called({required this.entry, required this.left});

  final QueueEntry entry;
  final Duration? left;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue;
    final remaining = left ?? const Duration(minutes: 10);
    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;
    final progress =
        remaining.inSeconds / const Duration(minutes: 10).inSeconds;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text(
            (entry.shopName ?? '').toUpperCase(),
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              letterSpacing: 1.6,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            t.turnTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall,
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            t.turnBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.xl.h),
          Center(
            child: Semantics(
              label:
                  '$minutes:${seconds.toString().padLeft(2, '0')} ${t.turnLeft}',
              excludeSemantics: true,
              child: SizedBox.square(
                dimension: 200.w,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: progress.clamp(0, 1),
                      strokeWidth: 16.w,
                      backgroundColor:
                          context.colorScheme.surfaceContainerHighest,
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$minutes:${seconds.toString().padLeft(2, '0')}',
                            style: context.textTheme.displayMedium?.copyWith(
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                          Text(
                            t.turnLeft,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            t.turnLate,
            textAlign: TextAlign.center,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.lg.h),
        ],
      ),
    );
  }
}

class _Serving extends StatelessWidget {
  const _Serving({required this.entry});

  final QueueEntry entry;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue;

    return Padding(
      padding: EdgeInsets.all(context.spacing.lg.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_seat_outlined,
            size: context.icons.xl.w,
            color: context.colorScheme.primary,
          ),
          SizedBox(height: context.spacing.lg.h),
          Text(t.servingTitle, style: context.textTheme.headlineMedium),
          SizedBox(height: context.spacing.sm.h),
          Text(
            t.servingBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

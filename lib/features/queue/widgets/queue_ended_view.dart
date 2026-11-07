import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Out of line: the customer left, or their turn is over.
///
/// After a leave the server's refund verdict is known and shown. Otherwise the
/// app only knows the place is gone — served, removed or the day closed — and
/// the push that came with it says which.
class QueueEndedView extends StatelessWidget {
  const QueueEndedView({super.key, required this.state, required this.onDone});

  final QueueFlowState state;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue;
    final left = state.leftRefunded != null;
    final fee = Money.formatCents(state.entry?.feeCents ?? 0);

    final title = left ? t.leftTitle : t.endedTitle;
    final body = switch (state.leftRefunded) {
      true => t.leftRefunded(fee: fee),
      false => t.leftKept,
      null => t.endedBody,
    };

    return Padding(
      padding: EdgeInsets.all(context.spacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            left ? Icons.logout_rounded : Icons.check_circle_outline_rounded,
            size: context.icons.xl.w,
            color: context.colorScheme.primary,
          ),
          SizedBox(height: context.spacing.lg.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium,
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            body,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          AppElevatedButton(label: t.done, expand: true, onPressed: onDone),
        ],
      ),
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "Lasciare la coda?" — the refund verdict, before the tap (queue spec §8).
///
/// Built like the booking cancel sheet: the verdict is the server's, stated
/// in advance, and the buttons stay where they are whichever it is.
class LeaveQueueSheet extends StatelessWidget {
  const LeaveQueueSheet._({required this.entry});

  final QueueEntry entry;

  /// Returns true when the customer confirmed.
  static Future<bool> ask(
    BuildContext context, {
    required QueueEntry entry,
  }) async {
    final confirmed = await AppBottomSheet.show<bool>(
      context,
      builder: (_) => LeaveQueueSheet._(entry: entry),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue.leaveSheet;
    final refund = entry.refundIfLeaving;
    final fee = Money.formatCents(entry.feeCents ?? 0);
    final tint = refund ? context.status.confirmed : context.status.warning;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(t.title, style: context.textTheme.headlineSmall),
        SizedBox(height: context.spacing.sm.h),
        Text(
          t.body(shop: entry.shopName ?? ''),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        Container(
          padding: EdgeInsets.all(context.spacing.lg.w),
          decoration: BoxDecoration(
            color: tint.background,
            borderRadius: context.radii.xlR,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                refund
                    ? Icons.check_circle_outline_rounded
                    : Icons.warning_amber_rounded,
                size: context.icons.s.w,
                color: tint.foreground,
              ),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Text(
                  refund ? t.refund(fee: fee) : t.noRefund(fee: fee),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: tint.foreground,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        AppElevatedButton.danger(
          label: refund ? t.confirm : t.confirmNoRefund,
          expand: true,
          onPressed: () => Navigator.of(context).pop(true),
        ),
        SizedBox(height: context.spacing.sm.h),
        AppOutlinedButton(
          label: t.stay,
          expand: true,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Before paying for a place: the fee now, the service in the shop, and when
/// the fee comes back, over the shop screen.
class QueueSummary extends StatelessWidget {
  const QueueSummary({super.key, required this.state});

  final QueueFlowState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopScreen;
    final queueText = context.t.queue;
    final cubit = context.read<QueueFlowCubit>();
    final service = state.service;
    final queue = state.queue;
    if (service == null || queue == null) return const SizedBox.shrink();

    // The server's number: the app carries no copy of the fee.
    final fee = state.join?.feeCents ?? queue.feeCents;
    final busy = state.isBusy || state.step == QueueStep.paying;
    final declined = state.step == QueueStep.declined;

    return PayPanel(
      onDismiss: busy ? null : cubit.back,
      children: [
        Text(
          t.joinTitle(shop: state.shop?.name ?? ''),
          style: context.textTheme.titleMedium,
        ),
        if (state.shop?.providerName(state.providerId) case final name?) ...[
          const SizedBox(height: 2),
          Text(
            t.withWhom(name: name),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 14),
        PayRows(
          rows: [
            PayRow(
              title: t.feeLabel,
              subtitle: t.feeWhen,
              amount: Money.shortCents(fee),
              strong: true,
            ),
            PayRow(
              title: service.name,
              subtitle: t.serviceWhen,
              amount: Money.shortCents(service.priceCents),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          queueText.refundRule,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        if (declined) ...[
          const SizedBox(height: 14),
          PayDeclined(message: t.declined),
        ],
        const SizedBox(height: 14),
        PayButton(
          busy: busy,
          busyLabel: t.paying,
          label: declined ? t.tryAgain : t.payFee(fee: Money.shortCents(fee)),
          onPressed: declined ? cubit.retry : cubit.payAndJoin,
        ),
      ],
    );
  }
}

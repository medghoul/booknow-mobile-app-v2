import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_state.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/slot_picker.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What is about to be booked, and what it costs, over the shop screen.
///
/// The service is paid in the shop and the fee is paid now: that difference is
/// the one thing customers get wrong, so they are two rows and the button names
/// the amount. With no fee there is nothing to pay and it simply confirms.
class BookingSummary extends StatelessWidget {
  const BookingSummary({super.key, required this.state});

  final BookingFlowState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopScreen;
    final flow = context.t.flow;
    final cubit = context.read<BookingFlowCubit>();
    final zone = state.availability?.timeZone ?? 'Europe/Rome';
    final service = state.service;
    final start = state.start;
    if (service == null || start == null) return const SizedBox.shrink();

    // The server's number, from the shop page or from the hold it issued.
    final fee = state.hold?.feeCents ?? state.shop?.feeCents;
    final isFree = fee == 0;
    final busy = state.isBusy || state.step == BookingStep.paying;
    final declined = state.step == BookingStep.declined;
    final when = flowWhen(context, start, zone);
    final left = state.holdLeft;

    return PayPanel(
      onDismiss: busy ? null : cubit.backToSlots,
      children: [
        Text(t.bookTitle(when: when), style: context.textTheme.titleMedium),
        if (state.shop?.providerName(state.providerId) case final name?) ...[
          const SizedBox(height: 2),
          Text(
            t.withWhom(name: name),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (left != null && left > Duration.zero) ...[
          const SizedBox(height: 14),
          HoldPill(label: t.heldFor(time: _clock(left))),
        ],
        const SizedBox(height: 14),
        PayRows(
          rows: [
            PayRow(
              title: isFree ? t.noFee : t.feeLabel,
              subtitle: t.feeWhen,
              amount: Money.shortCents(fee ?? 0),
              strong: !isFree,
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
          flow.terms,
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
          label: declined
              ? t.tryAgain
              : isFree
              ? t.confirmFree
              : fee == null
              ? flow.payAndConfirmNoFee
              : t.payFee(fee: Money.shortCents(fee)),
          onPressed: declined ? cubit.retry : cubit.payAndConfirm,
        ),
      ],
    );
  }

  static String _clock(Duration left) =>
      '${left.inMinutes}:${(left.inSeconds % 60).toString().padLeft(2, '0')}';
}

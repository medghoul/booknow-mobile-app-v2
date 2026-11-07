import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/widgets/sign_in_sheet.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/provider_choice.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:booknow_mobile/features/queue/widgets/live_bar.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The shop page of a shop in queue mode (design: "Pagina negozio · coda").
///
/// The live card answers the two questions a walk-in asks at the door — how
/// many are waiting, and how long — before anything asks for money.
class QueueOverview extends StatelessWidget {
  const QueueOverview({super.key, required this.state, this.overlay});

  final QueueFlowState state;

  /// Payment, rising over the screen.
  final Widget? overlay;

  Future<void> _continue(BuildContext context) async {
    final t = context.t.guest;
    final cubit = context.read<QueueFlowCubit>();
    final what = [
      state.shop?.name,
      state.service?.name,
    ].whereType<String>().join(' · ');
    final signedIn = await ensureSignedIn(
      context,
      title: t.gateJoin,
      body: t.gateBody(what: what),
    );
    if (signedIn) cubit.review();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final cubit = context.read<QueueFlowCubit>();
    final queue = state.queue;
    final service = state.service;
    final fee = queue?.feeCents ?? state.shop?.feeCents;
    final price = service == null ? '' : Money.shortCents(service.priceCents);

    return ShopScaffold(
      shopId: state.shopId,
      shop: state.shop,
      overlay: overlay,
      bottomBar: ShopBottomBar(
        title: service == null
            ? t.shopScreen.whatLike
            : t.shopScreen.joinNow(service: service.name),
        line: service == null
            ? t.queue.pickService
            : fee == null
            ? t.shopScreen.sumShop(price: price)
            : t.shopScreen.sumShopFee(price: price, fee: Money.shortCents(fee)),
        cta: _ctaLabel(context, queue),
        onPressed: state.canJoin ? () => _continue(context) : null,
      ),
      slivers: [
        if (queue != null)
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            sliver: SliverToBoxAdapter(child: _LiveCard(queue: queue)),
          ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.shopScreen.whatLike,
                  style: context.textTheme.titleSmall,
                ),
                for (final option in state.services) ...[
                  const SizedBox(height: 8),
                  ServiceOption(
                    service: option,
                    selected: option.id == service?.id,
                    onTap: () => cubit.chooseService(option),
                  ),
                ],
                if (ProviderChoice.offers(state.shop, service)) ...[
                  SizedBox(height: 20.h),
                  ProviderChoice(
                    providers: state.shop!.providersFor(service!.id),
                    selected: state.providerId,
                    onSelected: cubit.chooseProvider,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _ctaLabel(BuildContext context, ShopQueue? queue) {
    final t = context.t.queue;
    return switch (queue?.closedReason) {
      null => t.join,
      QueueClosedReason.paused => t.statePaused,
      QueueClosedReason.full => t.stateFull,
      QueueClosedReason.closed => t.stateClosed,
      QueueClosedReason.outsideHours => t.stateOutside,
    };
  }
}

/// How many are waiting and how long it would take, or why it is shut.
class _LiveCard extends StatelessWidget {
  const _LiveCard({required this.queue});

  final ShopQueue queue;

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue;
    final home = context.t.home;
    final free = queue.waitingCount == 0;
    final (tint, label, value) = switch (queue.closedReason) {
      null => (
        free ? context.status.arrived : context.status.pending,
        t.liveNow,
        free
            ? home.noWait
            : home.waiting(
                n: queue.waitingCount,
                from: queue.estimate.fromMin,
                to: queue.estimate.toMin,
              ),
      ),
      QueueClosedReason.paused => (
        context.status.pending,
        t.statePaused,
        t.pausedBody,
      ),
      QueueClosedReason.full => (
        context.status.pending,
        t.stateFull,
        t.fullBody,
      ),
      QueueClosedReason.closed => (
        context.status.cancelled,
        t.stateClosed,
        t.closedBody,
      ),
      QueueClosedReason.outsideHours => (
        context.status.cancelled,
        t.stateOutside,
        t.outsideBody,
      ),
    };
    final isOpen = queue.closedReason == null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.lgR,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: context.fonts.xxs.sp,
                    color: tint.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: isOpen
                      ? context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: tint.foreground,
                        )
                      : context.textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: tint.foreground,
                        ),
                ),
              ],
            ),
          ),
          if (isOpen) ...[
            SizedBox(width: context.spacing.md.w),
            LivePulse(color: tint.foreground),
          ],
        ],
      ),
    );
  }
}

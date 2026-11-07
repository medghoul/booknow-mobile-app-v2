import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_state.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/day_plan.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/flow_day_strip.dart';
import 'package:booknow_mobile/features/auth/widgets/sign_in_sheet.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/slot_grid.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Choosing a service, a day and a time on the shop screen.
class SlotPicker extends StatelessWidget {
  const SlotPicker({super.key, required this.state, this.overlay});

  final BookingFlowState state;

  /// Payment, rising over the screen.
  final Widget? overlay;

  /// How far ahead a customer may book (§6.3).
  static const int _horizonDays = 30;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopScreen;
    final shop = state.shop;
    final zone = state.availability?.timeZone ?? 'Europe/Rome';
    final locale = Localizations.localeOf(context).toString();

    final plan = shop == null
        ? null
        : DayPlan.from(
            shop: shop,
            date: state.date,
            timeZone: zone,
            availability: state.availability,
            selected: state.start,
            now: state.now,
          );

    return ShopScaffold(
      shopId: state.shopId,
      shop: shop,
      overlay: overlay,
      bottomBar: _Bar(state: state),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
          sliver: SliverToBoxAdapter(child: _Services(state: state)),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverToBoxAdapter(
            child: Text(t.when, style: context.textTheme.titleSmall),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverToBoxAdapter(
          child: FlowDayStrip(
            days: _days(),
            today: _days().first,
            selected: state.date,
            closedDates: _closedDates(shop),
            onSelected: (date) =>
                context.read<BookingFlowCubit>().loadDay(date),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 24.h),
          sliver: SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: context.motion.fast,
              child: switch ((state.isLoading, plan)) {
                (true, _) => Padding(
                  key: const ValueKey('loading'),
                  padding: EdgeInsets.all(context.spacing.xl.h),
                  child: const AppLoader.centered(),
                ),
                (_, null) => const SizedBox.shrink(),
                (_, final day?) when day.closed => _NoTimes(
                  key: const ValueKey('closed'),
                  message: t.closedDay(
                    day: DateFormat(
                      'EEEE',
                      locale,
                    ).format(ShopClock.calendarDay(state.date)),
                  ),
                ),
                (_, final day?) when day.upcoming.isEmpty => _NoTimes(
                  key: const ValueKey('empty'),
                  message: t.noTimes,
                ),
                (_, final day?) => Padding(
                  key: ValueKey(state.date),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SlotGrid(
                    slots: day.upcoming,
                    timeZone: zone,
                    onSelected: context.read<BookingFlowCubit>().chooseStart,
                  ),
                ),
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Today and the next thirty days, in the shop's calendar.
  List<String> _days() => [
    for (var offset = 0; offset <= _horizonDays; offset++)
      ShopClock.dateOf(
        state.now.add(Duration(days: offset)),
        state.availability?.timeZone ?? 'Europe/Rome',
      ),
  ];

  /// The dates the strip strikes through: the shop's own closures, plus the
  /// weekdays it never opens.
  Set<String> _closedDates(Shop? shop) {
    if (shop == null) return const {};

    return {
      ...shop.closures,
      for (final date in _days())
        if (shop.openingHours
            .rangesOn(_weekdayOf(date))
            .where((range) => range.isValid)
            .isEmpty)
          date,
    };
  }

  static Weekday _weekdayOf(String date) =>
      Weekday.values[ShopClock.calendarDay(date).weekday - 1];
}

class _Services extends StatelessWidget {
  const _Services({required this.state});

  final BookingFlowState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.t.shopScreen.whatLike,
          style: context.textTheme.titleSmall,
        ),
        for (final service in state.services) ...[
          const SizedBox(height: 8),
          ServiceOption(
            service: service,
            selected: service.id == state.service?.id,
            onTap: () =>
                context.read<BookingFlowCubit>().chooseService(service),
          ),
        ],
      ],
    );
  }
}

/// What is chosen, what it costs, and the way on. Signing in happens here, at
/// the moment it matters, with the choice still on screen behind it.
class _Bar extends StatelessWidget {
  const _Bar({required this.state});

  final BookingFlowState state;

  Future<void> _continue(BuildContext context, String when) async {
    final t = context.t.guest;
    final cubit = context.read<BookingFlowCubit>();
    final what = [
      state.shop?.name,
      state.service?.name,
      when,
    ].whereType<String>().join(' · ');
    final signedIn = await ensureSignedIn(
      context,
      title: t.gateBook,
      body: t.gateBody(what: what),
    );
    if (signedIn) cubit.review();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopScreen;
    final zone = state.availability?.timeZone ?? 'Europe/Rome';
    final service = state.service;
    final start = state.start;
    final fee = state.shop?.feeCents;
    final when = start == null ? '' : flowWhen(context, start, zone);
    final price = service == null ? '' : Money.shortCents(service.priceCents);

    return ShopBottomBar(
      title: [
        service?.name,
        if (when.isNotEmpty) when,
      ].whereType<String>().join(' · '),
      line: start == null
          ? t.sumPick
          : fee == null || fee == 0
          ? t.sumShop(price: price)
          : t.sumShopFee(price: price, fee: Money.shortCents(fee)),
      cta: t.continue_,
      onPressed: start == null ? null : () => _continue(context, when),
    );
  }
}

/// A day with nothing to choose, said plainly in place of the times.
class _NoTimes extends StatelessWidget {
  const _NoTimes({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: context.radii.mdR,
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: 14.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// "Today 17:30", "Fri 6 17:30": the same words on the bar and in the sheet.
String flowWhen(BuildContext context, DateTime start, String zone) {
  final locale = Localizations.localeOf(context).toString();
  final isToday =
      ShopClock.dateOf(start, zone) ==
      ShopClock.dateOf(DateTime.now().toUtc(), zone);
  final day = isToday
      ? context.t.home.today
      : DateFormat('E d', locale).format(ShopClock.wallTime(start, zone));

  return '$day ${ShopClock.hm(start, zone, locale)}';
}

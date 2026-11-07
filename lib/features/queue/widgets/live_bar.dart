import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/bookings/widgets/open_shop_map.dart';
import 'package:booknow_mobile/features/home/widgets/shop_summary_card.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/next_booking_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The bar above the tabs while the customer is in a queue.
///
/// It stays on every tab, because the question it answers does not depend on
/// which screen they are on. It rises in when a place appears and turns green
/// at their turn, with a haptic, since they may not be looking.
class LiveBar extends StatelessWidget {
  const LiveBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveStatusCubit, QueueEntry?>(
      bloc: di<LiveStatusCubit>(),
      listenWhen: (before, after) =>
          before?.status != after?.status ||
          before?.position != after?.position,
      listener: (context, entry) {
        if (entry == null) return;
        entry.status == QueueEntryStatus.called
            ? HapticFeedback.heavyImpact()
            : HapticFeedback.selectionClick();
      },
      builder: (context, entry) => BlocBuilder<NextBookingCubit, Booking?>(
        bloc: di<NextBookingCubit>(),
        builder: (context, booking) => AnimatedSize(
          duration: context.motion.normal,
          curve: context.motion.curveEmphasized,
          alignment: Alignment.bottomCenter,
          child: entry != null
              ? _Bar(key: ValueKey(entry.id), entry: entry)
              : booking != null
              ? _BookingBar(key: ValueKey(booking.id), booking: booking)
              : const SizedBox(width: double.infinity),
        ),
      ),
    );
  }
}

class _Bar extends StatefulWidget {
  const _Bar({super.key, required this.entry});

  final QueueEntry entry;

  @override
  State<_Bar> createState() => _BarState();
}

class _BarState extends State<_Bar> {
  /// Where they started, so the line along the foot can show how far they came.
  late final int _start = widget.entry.position ?? 1;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final t = context.t;
    final called = entry.status == QueueEntryStatus.called;
    final serving = entry.status == QueueEntryStatus.serving;
    final background = called
        ? context.status.arrived.background
        : context.headerColor;
    final foreground = called
        ? context.status.arrived.foreground
        : context.onHeaderColor;
    final dot = called ? context.queueColors.yourTurn : const Color(0xFFFBBF24);
    final estimate = entry.estimate;
    final position = entry.position ?? _start;
    final progress = called || serving
        ? 1.0
        : ((_start - position + 1) / (_start + 1)).clamp(0.0, 1.0);

    final title = called
        ? t.queue.turnTitle
        : serving
        ? t.live.inChair
        : entry.shopName ?? '';
    final line = called
        ? t.live.headInAt(shop: entry.shopName ?? '')
        : serving
        ? entry.shopName ?? ''
        : [
            t.home.inLine,
            if (estimate != null)
              t.queue.range(from: estimate.fromMin, to: estimate.toMin),
          ].join(' · ');

    return Semantics(
      button: true,
      label: '$title, $line',
      excludeSemantics: true,
      child: Material(
        color: background,
        child: InkWell(
          onTap: () => LiveSheet.show(context),
          child: SizedBox(
            height: 60.h,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      LivePulse(color: dot),
                      SizedBox(width: 12.w),
                      if (entry.position case final position?
                          when !called && !serving) ...[
                        RollingNumber(
                          text: t.queue.position(n: position),
                          value: position,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: foreground,
                          ),
                        ),
                        SizedBox(width: 12.w),
                      ],
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: foreground,
                              ),
                            ),
                            Text(
                              line,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: context.fonts.xxs.sp,
                                fontWeight: FontWeight.w500,
                                color: foreground.withValues(alpha: 0.85),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppLineIcon(
                        AppLineIcons.chevronUp,
                        color: foreground,
                        strokeWidth: 2.25,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 550),
                      curve: context.motion.curveEmphasized,
                      widthFactor: progress,
                      child: Container(height: 3, color: dot),
                    ),
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

/// The next visit, when there is no line to follow.
class _BookingBar extends StatelessWidget {
  const _BookingBar({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final foreground = context.onHeaderColor;
    const dot = Color(0xFF5EEAD4);
    final when = liveBookingWhen(context, booking);
    final title = [?booking.shopName, when].join(' · ');
    final line = [
      booking.serviceName,
      t.queue.inShop(price: Money.shortCents(booking.priceCents)),
    ].join(' · ');

    return Semantics(
      button: true,
      label: '$title, $line',
      excludeSemantics: true,
      child: Material(
        color: context.headerColor,
        child: InkWell(
          onTap: () => LiveBookingSheet.show(context),
          child: SizedBox(
            height: 60.h,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      const LivePulse(color: dot),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: foreground,
                              ),
                            ),
                            Text(
                              line,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: context.fonts.xxs.sp,
                                fontWeight: FontWeight.w500,
                                color: foreground.withValues(alpha: 0.85),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppLineIcon(
                        AppLineIcons.chevronUp,
                        color: foreground,
                        strokeWidth: 2.25,
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(height: 3, child: ColoredBox(color: dot)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "Sat 14 · 10:30", or "Today · 17:30".
String liveBookingWhen(BuildContext context, Booking booking) {
  final locale = Localizations.localeOf(context).toString();
  final zone = booking.timeZone;
  final isToday =
      ShopClock.dateOf(booking.startUtc, zone) ==
      ShopClock.dateOf(DateTime.now().toUtc(), zone);
  final day = isToday
      ? context.t.home.today
      : DateFormat(
          'E d',
          locale,
        ).format(ShopClock.wallTime(booking.startUtc, zone));

  return '$day · ${ShopClock.hm(booking.startUtc, zone, locale)}';
}

/// A number that rolls when it changes: the old one slides away upward, so
/// moving forward in line reads as moving forward.
class RollingNumber extends StatelessWidget {
  const RollingNumber({
    super.key,
    required this.text,
    required this.value,
    this.style,
  });

  final String text;
  final int value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSwitcher(
        duration: context.motion.normal,
        switchInCurve: context.motion.curveEmphasized,
        switchOutCurve: context.motion.curveEmphasized,
        transitionBuilder: (child, animation) {
          final entering = child.key == ValueKey(value);

          return SlideTransition(
            position: Tween(
              begin: Offset(0, entering ? 1 : -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: Text(text, key: ValueKey(value), style: style),
      ),
    );
  }
}

/// The small dot that says this is happening now.
class LivePulse extends StatefulWidget {
  const LivePulse({super.key, required this.color});

  final Color color;

  @override
  State<LivePulse> createState() => _LivePulseState();
}

class _LivePulseState extends State<LivePulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Container(
        width: 10.w,
        height: 10.w,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: 1 - _controller.value),
              spreadRadius: 9 * _controller.value,
            ),
          ],
        ),
      ),
    );
  }
}

/// The full status: place, wait, and the way out of the line, with the server's
/// refund verdict stated before the tap.
class LiveSheet extends StatefulWidget {
  const LiveSheet._();

  static Future<void> show(BuildContext context) =>
      AppBottomSheet.show<void>(context, builder: (_) => const LiveSheet._());

  @override
  State<LiveSheet> createState() => _LiveSheetState();
}

class _LiveSheetState extends State<LiveSheet> {
  bool _confirmingLeave = false;
  bool _leaving = false;

  Future<void> _leave(QueueEntry entry) async {
    final t = context.t.live;
    final navigator = Navigator.of(context);
    setState(() => _leaving = true);

    final left = await di<LiveStatusCubit>().leave(entry.id);
    if (!mounted) return;

    if (left == null) {
      setState(() => _leaving = false);
      AppSnackBar.error(context, t.leaveFailed);
      return;
    }

    AppSnackBar.success(
      context,
      left.refunded ? t.leftRefunded : t.leftNoRefund,
    );
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveStatusCubit, QueueEntry?>(
      bloc: di<LiveStatusCubit>(),
      listenWhen: (_, entry) => entry == null && !_leaving,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, entry) {
        if (entry == null) return const SizedBox.shrink();

        return AnimatedSwitcher(
          duration: context.motion.fast,
          child: _confirmingLeave
              ? _confirm(context, entry)
              : _status(context, entry),
        );
      },
    );
  }

  /// A place in line only knows the shop's name, so the address is read first.
  /// Without it the name alone still gets a maps app most of the way there.
  Future<void> _directions(QueueEntry entry) async {
    final result = await di<ShopDirectoryRepository>().byId(entry.shopId);
    if (!mounted) return;

    await openShopMap(
      context,
      name: entry.shopName,
      address: result is Success<Shop> ? result.data.address?.line : null,
    );
  }

  Widget _status(BuildContext context, QueueEntry entry) {
    final t = context.t;
    final scheme = context.colorScheme;
    final called = entry.status == QueueEntryStatus.called;
    final serving = entry.status == QueueEntryStatus.serving;
    final estimate = entry.estimate;
    final position = entry.position;
    final overlineColor = called
        ? context.status.arrived.foreground
        : context.status.pending.foreground;

    return Column(
      key: const ValueKey('status'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (called
                            ? t.queue.turnTitleShort
                            : serving
                            ? t.live.inChair
                            : t.live.overline)
                        .toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: overlineColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.shopName ?? '',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.serviceName,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            ClipRRect(
              borderRadius: context.radii.mdR,
              child: SizedBox.square(
                dimension: 52.w,
                child: const ShopPhoto(url: null),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (called)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: context.status.arrived.background,
              borderRadius: context.radii.lgR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.queue.turnTitle,
                  style: context.textTheme.displayMedium?.copyWith(
                    color: context.status.arrived.foreground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.live.headIn,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.status.arrived.foreground,
                  ),
                ),
              ],
            ),
          )
        else if (serving)
          Text(t.live.inChair, style: context.textTheme.displayMedium)
        else ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                if (position != null) ...[
                  RollingNumber(
                    text: t.queue.position(n: position),
                    value: position,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 60.sp,
                      height: 1.2,
                      letterSpacing: -1.8,
                      color: scheme.primary,
                    ),
                  ),
                  SizedBox(width: 18.w),
                ],
                if (estimate != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.queue.turnIn,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.queue.range(
                          from: estimate.fromMin,
                          to: estimate.toMin,
                        ),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (position != null) ...[
            const SizedBox(height: 14),
            _LineDots(position: position),
          ],
          const SizedBox(height: 14),
          Text(
            t.queue.waitAnywhere,
            style: context.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
        if (!serving) ...[
          const SizedBox(height: 18),
          SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: () => _directions(entry),
              child: Text(t.live.directions),
            ),
          ),
          const SizedBox(height: 8),
          _LeaveButton(
            label: t.live.leave,
            onPressed: () => setState(() => _confirmingLeave = true),
          ),
        ],
      ],
    );
  }

  Widget _confirm(BuildContext context, QueueEntry entry) {
    final t = context.t.live;
    final tint = entry.refundIfLeaving
        ? context.status.arrived
        : context.status.pending;

    return Column(
      key: const ValueKey('confirm'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.leaveTitle, style: context.textTheme.titleMedium),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: tint.background,
            borderRadius: context.radii.mdR,
          ),
          child: Text(
            entry.refundIfLeaving ? t.refundYes : t.refundNo,
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: 14.sp,
              color: tint.foreground,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => setState(() => _confirmingLeave = false),
            child: Text(t.keep),
          ),
        ),
        const SizedBox(height: 12),
        _LeaveButton(
          label: t.leaveConfirm,
          onPressed: _leaving ? null : () => _leave(entry),
        ),
      ],
    );
  }
}

/// The next visit in full: when, until when it is free to cancel, how to get
/// there, and the way out, with the refund stated before the tap.
class LiveBookingSheet extends StatefulWidget {
  const LiveBookingSheet._();

  static Future<void> show(BuildContext context) => AppBottomSheet.show<void>(
    context,
    builder: (_) => const LiveBookingSheet._(),
  );

  @override
  State<LiveBookingSheet> createState() => _LiveBookingSheetState();
}

class _LiveBookingSheetState extends State<LiveBookingSheet> {
  bool _confirming = false;
  bool _cancelling = false;

  Future<void> _cancel(Booking booking) async {
    final t = context.t.live;
    final navigator = Navigator.of(context);
    setState(() => _cancelling = true);

    final cancelled = await di<NextBookingCubit>().cancel(booking.id);
    if (!mounted) return;

    if (cancelled == null) {
      setState(() => _cancelling = false);
      AppSnackBar.error(context, t.cancelFailed);
      return;
    }

    AppSnackBar.success(
      context,
      cancelled.refunded
          ? t.cancelledRefunded(fee: Money.shortCents(booking.feeCents))
          : t.cancelledNoRefund,
    );
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NextBookingCubit, Booking?>(
      bloc: di<NextBookingCubit>(),
      builder: (context, booking) {
        if (booking == null) return const SizedBox.shrink();

        return AnimatedSwitcher(
          duration: context.motion.fast,
          child: _confirming
              ? _confirm(context, booking)
              : _status(context, booking),
        );
      },
    );
  }

  Widget _status(BuildContext context, Booking booking) {
    final t = context.t;
    final scheme = context.colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final zone = booking.timeZone;
    final until = booking.freeCancellationUntilUtc;
    final now = DateTime.now().toUtc();

    return Column(
      key: const ValueKey('status'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.live.overlineBooked.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.status.confirmed.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    booking.shopName ?? '',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    booking.serviceName,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            ClipRRect(
              borderRadius: context.radii.mdR,
              child: SizedBox.square(
                dimension: 52.w,
                child: const ShopPhoto(url: null),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          liveBookingWhen(context, booking),
          style: context.textTheme.displayLarge?.copyWith(
            color: scheme.primary,
          ),
        ),
        if (booking.refundableAt(now)) ...[
          const SizedBox(height: 2),
          Text(
            t.live.freeUntil(when: ShopClock.hm(until, zone, locale)),
            style: context.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 18),
        SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => openShopMap(
              context,
              name: booking.shopName,
              address: booking.shopAddressLine,
            ),
            child: Text(t.live.directions),
          ),
        ),
        const SizedBox(height: 8),
        _LeaveButton(
          label: t.live.cancelBooking,
          onPressed: () => setState(() => _confirming = true),
        ),
      ],
    );
  }

  Widget _confirm(BuildContext context, Booking booking) {
    final t = context.t.live;
    final isFree = booking.feeCents == 0;
    final refundable = isFree || booking.refundableAt(DateTime.now().toUtc());
    final tint = refundable ? context.status.arrived : context.status.pending;
    final fee = Money.shortCents(booking.feeCents);

    return Column(
      key: const ValueKey('confirm'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.cancelTitle, style: context.textTheme.titleMedium),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: tint.background,
            borderRadius: context.radii.mdR,
          ),
          child: Text(
            isFree
                ? t.refundFree
                : refundable
                ? t.refundYes2(fee: fee)
                : t.refundNo2(fee: fee),
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: 14.sp,
              color: tint.foreground,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => setState(() => _confirming = false),
            child: Text(t.keepBooking),
          ),
        ),
        const SizedBox(height: 12),
        _LeaveButton(
          label: t.yesCancel,
          onPressed: _cancelling ? null : () => _cancel(booking),
        ),
      ],
    );
  }
}

/// The quiet red way out of the line.
class _LeaveButton extends StatelessWidget {
  const _LeaveButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: context.status.error.foreground,
          overlayColor: context.status.error.foreground,
          textStyle: context.textTheme.labelLarge?.copyWith(
            fontSize: context.fonts.s.sp,
          ),
          shape: RoundedRectangleBorder(borderRadius: context.radii.mdR),
        ),
        child: Text(label),
      ),
    );
  }
}

/// The line drawn from the chair to the customer, who is the larger dot.
class _LineDots extends StatelessWidget {
  const _LineDots({required this.position});

  final int position;

  /// Past this the dots stop saying anything the number does not.
  static const int _most = 8;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final dots = position.clamp(1, _most);

    return ExcludeSemantics(
      child: Row(
        children: [
          Text(
            context.t.live.chair,
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: context.fonts.xxs.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
          for (var i = 0; i < dots; i++) ...[
            const SizedBox(width: 6),
            Container(
              width: i == dots - 1 ? 18 : 12,
              height: i == dots - 1 ? 18 : 12,
              decoration: BoxDecoration(
                color: i == dots - 1 ? scheme.secondary : scheme.outline,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

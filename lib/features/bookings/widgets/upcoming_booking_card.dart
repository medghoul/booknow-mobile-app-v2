import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A booking the customer can still act on.
///
/// The footer is the point of the card: one line stating the single thing at
/// stake. For a confirmed booking that is the exact date free cancellation
/// ends — a deadline somebody can act on, rather than "cancellable soon". For
/// an unpaid one it is the countdown and the button, because a hold quietly
/// lapsing is the worst outcome in the product, which is also why that card
/// gets the heavier shadow.
class UpcomingBookingCard extends StatelessWidget {
  const UpcomingBookingCard({
    super.key,
    required this.booking,
    required this.now,
    required this.onTap,
    required this.onPay,
  });

  final Booking booking;
  final DateTime now;
  final VoidCallback onTap;
  final VoidCallback onPay;

  bool get _isPending => booking.status == BookingStatus.pendingPayment;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final zone = booking.timeZone;
    final wall = ShopClock.wallTime(booking.startUtc, zone);
    final scheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: context.radii.xlR,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: context.decorations.card.copyWith(
          boxShadow: _isPending ? context.shadows.md : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  Container(
                    width: 52.w,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: context.radii.mdR,
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('E', locale).format(wall).toUpperCase(),
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: context.fonts.xxs.sp,
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                        Text(
                          DateFormat('d', locale).format(wall),
                          style: context.textTheme.titleMedium?.copyWith(
                            height: 1.1,
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${booking.shopName ?? booking.serviceName} · '
                          '${ShopClock.hm(booking.startUtc, zone, locale)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontSize: context.fonts.s.sp,
                          ),
                        ),
                        Text(
                          '${booking.serviceName} · ${_money(context)}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.spacing.sm.w),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: context.status
                          .ofBooking(booking.status)
                          .background,
                      borderRadius: context.radii.smR,
                    ),
                    child: Text(
                      booking.status.label(context.t),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: context.fonts.xxs.sp,
                        fontWeight: FontWeight.w700,
                        color: context.status
                            .ofBooking(booking.status)
                            .foreground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Only an unpaid booking has something still to do on the card.
            if (_isPending) _Footer(booking: booking, now: now, onPay: onPay),
          ],
        ),
      ),
    );
  }

  /// What is at stake on this card: the fee while it is unpaid, the price in
  /// the shop once it is confirmed.
  String _money(BuildContext context) => _isPending
      ? Money.shortCents(booking.feeCents)
      : context.t.bookings.inShop(price: Money.shortCents(booking.priceCents));
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.booking,
    required this.now,
    required this.onPay,
  });

  final Booking booking;
  final DateTime now;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final locale = Localizations.localeOf(context).toString();
    final left = booking.holdLeftAt(now);

    if (left != null) {
      return Container(
        width: double.infinity,
        color: context.colorScheme.surfaceContainerHighest,
        padding: EdgeInsets.fromLTRB(
          context.spacing.md.w,
          context.spacing.sm.h,
          context.spacing.md.w,
          context.spacing.md.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                left == Duration.zero
                    ? t.holdLapsed
                    : t.expiresIn(n: left.inMinutes + 1),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.status.pending.foreground,
                ),
              ),
            ),
            AppElevatedButton(label: t.payNow, onPressed: onPay),
          ],
        ),
      );
    }

    if (!booking.refundableAt(now)) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: context.colorScheme.surfaceContainerHighest,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.sm.h + 2,
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            size: context.icons.s.w,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: context.spacing.sm.w),
          Expanded(
            child: Text(
              t.freeUntil(
                when: DateFormat('E d MMM, HH:mm', locale).format(
                  ShopClock.wallTime(
                    booking.freeCancellationUntilUtc,
                    booking.timeZone,
                  ),
                ),
              ),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

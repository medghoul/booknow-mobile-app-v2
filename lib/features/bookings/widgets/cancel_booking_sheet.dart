import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "Annullare il taglio?" — the refund verdict, before the tap.
///
/// The two-hour rule is the one that costs real money, so the sheet states the
/// outcome in advance rather than reporting it afterwards: a refund in the
/// success tint with the card it goes back to, or a warning that the fee stays
/// with the shop. The buttons do not move between the two, so nobody confirms
/// one thing while looking at the other.
class CancelBookingSheet extends StatelessWidget {
  const CancelBookingSheet._({required this.booking, required this.now});

  final Booking booking;
  final DateTime now;

  /// Returns true when the customer confirmed.
  static Future<bool> ask(
    BuildContext context, {
    required Booking booking,
    required DateTime now,
  }) async {
    final confirmed = await AppBottomSheet.show<bool>(
      context,
      builder: (_) => CancelBookingSheet._(booking: booking, now: now),
    );

    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings.cancel;
    final locale = Localizations.localeOf(context).toString();
    final refundable = booking.refundableAt(now);

    final when = DateFormat(
      'EEEE d MMMM',
      locale,
    ).format(ShopClock.wallTime(booking.startUtc, booking.timeZone));
    final time = ShopClock.hm(booking.startUtc, booking.timeZone, locale);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(t.title, style: context.textTheme.headlineSmall),
        SizedBox(height: context.spacing.sm.h),
        Text(
          t.subtitle(when: when, time: time, shop: booking.shopName ?? ''),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        _Verdict(booking: booking, refundable: refundable),
        SizedBox(height: context.spacing.md.h),
        Text(
          t.slotFreed,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        AppElevatedButton.danger(
          label: t.confirm,
          expand: true,
          onPressed: () => Navigator.of(context).pop(true),
        ),
        SizedBox(height: context.spacing.sm.h),
        AppOutlinedButton(
          label: t.keep,
          expand: true,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}

class _Verdict extends StatelessWidget {
  const _Verdict({required this.booking, required this.refundable});

  final Booking booking;
  final bool refundable;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings.cancel;
    final tint = refundable ? context.status.confirmed : context.status.pending;
    final fee = Money.formatCents(booking.feeCents);
    final card = booking.cardLast4;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.lg.h,
      ),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.xlR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            refundable
                ? Icons.check_circle_outline_rounded
                : Icons.info_outline_rounded,
            size: context.icons.s.w,
            color: tint.foreground,
          ),
          SizedBox(width: context.spacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  refundable ? t.refundTitle(fee: fee) : t.noRefundTitle,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: tint.foreground,
                  ),
                ),
                SizedBox(height: context.spacing.xxs.h),
                Text(
                  refundable
                      ? (card == null
                            ? t.refundBody
                            : t.refundBodyCard(card: card))
                      : t.noRefundBody(fee: fee),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: tint.foreground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// History, quiet on purpose.
///
/// The only sane action on something that already happened is booking it
/// again, so every row carries that and nothing else. Terminal statuses keep
/// their own word: a no-show is on the record without being shouted about.
class PastBookingsList extends StatelessWidget {
  const PastBookingsList({
    super.key,
    required this.bookings,
    required this.onRepeat,
    required this.onTap,
  });

  final List<Booking> bookings;
  final ValueChanged<Booking> onRepeat;
  final ValueChanged<Booking> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final booking in bookings) ...[
          _PastRow(
            booking: booking,
            onRepeat: () => onRepeat(booking),
            onTap: () => onTap(booking),
          ),
          SizedBox(height: 10.h),
        ],
      ],
    );
  }
}

class _PastRow extends StatelessWidget {
  const _PastRow({
    required this.booking,
    required this.onRepeat,
    required this.onTap,
  });

  final Booking booking;
  final VoidCallback onRepeat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final locale = Localizations.localeOf(context).toString();
    final scheme = context.colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.shopName ?? booking.serviceName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: context.fonts.s.sp,
                      ),
                    ),
                    Text(
                      _line(context, locale),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              SizedBox(
                height: 44,
                child: OutlinedButton(
                  onPressed: onRepeat,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    side: BorderSide(color: scheme.outline),
                    textStyle: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(t.repeat),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// "Fade · 22 Oct · €20". A visit that did not happen says so instead of the
  /// price: a cancellation names who did it and whether the fee came back.
  String _line(BuildContext context, String locale) {
    final t = context.t.bookings;
    final day = DateFormat(
      'd MMM',
      locale,
    ).format(ShopClock.wallTime(booking.startUtc, booking.timeZone));
    final head = '${booking.serviceName} · $day';

    return switch (booking.status) {
      BookingStatus.completed || BookingStatus.confirmed =>
        '$head · ${Money.shortCents(booking.priceCents)}',
      BookingStatus.cancelled =>
        '$head · ${booking.status.label(context.t)} '
            '${booking.cancelledBy == 'owner' ? t.byShop : t.byYou} · '
            '${booking.refunded ? t.refunded : t.notRefunded}',
      _ => '$head · ${booking.status.label(context.t)}',
    };
  }
}

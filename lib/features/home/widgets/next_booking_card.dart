import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The one booking the customer is most likely to be looking for, in the same
/// shape as the active queue card. Only on screen when there is one.
class NextBookingCard extends StatelessWidget {
  const NextBookingCard({
    super.key,
    required this.booking,
    required this.onDetails,
  });

  final Booking booking;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final zone = booking.timeZone;
    final scheme = context.colorScheme;
    final day = DateFormat(
      'E d MMM',
      locale,
    ).format(ShopClock.wallTime(booking.startUtc, zone));

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onDetails,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.lg.w,
            vertical: 14.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.home.nextBooking.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: scheme.secondary,
                ),
              ),
              SizedBox(height: context.spacing.md.h),
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: context.radii.mdR,
                    ),
                    child: CategoryPicture(
                      category: ShopCategory.barber,
                      size: 36.w,
                    ),
                  ),
                  SizedBox(width: context.spacing.md.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(day, style: context.textTheme.titleSmall),
                            SizedBox(width: context.spacing.sm.w),
                            Text(
                              ShopClock.hm(booking.startUtc, zone, locale),
                              style: context.textTheme.titleSmall?.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.spacing.xxs.h),
                        Text(
                          [
                            booking.shopName,
                            booking.serviceName,
                          ].whereType<String>().join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.spacing.sm.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(height: context.spacing.md.h),
              AppStatusBadge(
                tint: context.status.ofBooking(booking.status),
                icon: booking.status.icon,
                label: booking.status.label(context.t),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

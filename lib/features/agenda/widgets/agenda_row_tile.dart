import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One line of the day: the time outside the card, the card beside it, and the
/// card's height following its length, so 15 and 45 minutes look different
/// without a number being read.
class AgendaRowTile extends StatelessWidget {
  const AgendaRowTile({
    super.key,
    required this.row,
    required this.timeZone,
    required this.now,
    required this.onTap,
  });

  final AgendaRow row;
  final String timeZone;

  /// The clock the past state is decided against. Passed in rather than read
  /// here so every row in a build agrees on the minute.
  final DateTime now;

  final VoidCallback? onTap;

  bool get _isPast => row.endUtc.isBefore(now);

  double get _minHeight {
    final minutes = row.durationMinutes.clamp(0, 60);
    return (minutes * 1.5).clamp(52, double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final scheme = context.colorScheme;
    final t = context.t.agenda;
    final radius = context.radii.mdR;

    final (title, line, weight, color) = switch (row) {
      final AgendaBookingRow booking => (
        booking.customerName ?? t.customerFallback,
        [
          booking.serviceName,
          // A plain confirmed booking needs no word; anything else does.
          if (booking.status != BookingStatus.confirmed)
            booking.status.label(context.t),
        ].join(' · '),
        FontWeight.w700,
        scheme.onSurface,
      ),
      final AgendaBlockRow block => (
        block.note ?? t.blockedLabel,
        t.blockedLabel,
        FontWeight.w600,
        scheme.onSurface,
      ),
      final AgendaFreeRow free => (
        t.freeLabel,
        free.freedBy != null
            ? t.cancelledBy(name: free.freedBy!)
            : t.freeLine(length: _length(context, free.durationMinutes)),
        FontWeight.w600,
        scheme.onSurfaceVariant,
      ),
    };

    final content = Container(
      constraints: BoxConstraints(minHeight: _minHeight.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      alignment: Alignment.centerLeft,
      decoration: switch (row) {
        AgendaBookingRow() => BoxDecoration(
          color: scheme.surface,
          borderRadius: radius,
          border: Border.all(color: scheme.outlineVariant),
        ),
        AgendaBlockRow() => BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: radius,
          border: Border.all(color: scheme.outlineVariant),
        ),
        AgendaFreeRow() => null,
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: context.fonts.s.sp,
              fontWeight: weight,
              color: color,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            line,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );

    final card = row is AgendaFreeRow
        ? AppDashedOutline(
            color: scheme.outline,
            radius: 12.r,
            strokeWidth: 1,
            child: content,
          )
        : content;

    return Opacity(
      opacity: _isPast ? AppComponentSizes.agendaPastRowOpacity : 1,
      child: Row(
        // Top-aligned, not stretched: a list hands its children an unbounded
        // height, and the card is what sets the row's.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44.w,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                ShopClock.hm(row.startUtc, timeZone, locale),
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: onTap == null
                ? card
                : Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: radius,
                      child: card,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// "30 min", "1 h", "1 h 30".
  String _length(BuildContext context, int minutes) {
    final t = context.t.agenda;
    if (minutes < 60) return t.minutes(count: minutes);
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return rest == 0 ? t.hours(count: hours) : '${t.hours(count: hours)} $rest';
  }
}

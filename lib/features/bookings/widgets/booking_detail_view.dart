import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/booking_status_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/bookings/cubit/booking_detail_cubit.dart';
import 'package:booknow_mobile/features/bookings/widgets/cancel_booking_sheet.dart';
import 'package:booknow_mobile/features/bookings/widgets/open_shop_map.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One booking, ordered by what you would open it for: when, where, what it
/// costs.
///
/// Cancelling is a text button under the calendar one — reachable, never the
/// thing a thumb lands on first.
class BookingDetailView extends StatelessWidget {
  const BookingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocBuilder<BookingDetailCubit, BookingDetailState>(
      builder: (context, state) {
        final booking = state.booking;

        return AppScaffold(
          appBar: AppAppBar(title: t.bookings.detailTitle),
          body: switch ((booking, state.failure)) {
            (null, final failure?) => AppErrorState(
              message: failure.localized(context),
              retryLabel: t.common.retry,
              onRetry: () => context.read<BookingDetailCubit>().load(''),
            ),
            (null, _) => const AppLoader.centered(),
            (final found?, _) => _Content(booking: found),
          },
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();

    return ListView(
      children: [
        _When(booking: booking),
        SizedBox(height: context.spacing.lg.h),
        _Where(booking: booking),
        SizedBox(height: context.spacing.lg.h),
        _Money(booking: booking),
        SizedBox(height: context.spacing.xl.h),
        AppOutlinedButton(
          label: context.t.bookings.addToCalendar,
          icon: Icons.event_outlined,
          expand: true,
          onPressed: () => _addToCalendar(context),
        ),
        if (booking.cancellableAt(now)) ...[
          SizedBox(height: context.spacing.sm.h),
          Center(
            child: AppTextButton(
              label: context.t.bookings.cancel.action,
              isDestructive: true,
              onPressed: () => _cancel(context, now),
            ),
          ),
        ],
        SizedBox(height: context.spacing.lg.h),
      ],
    );
  }

  Future<void> _cancel(BuildContext context, DateTime now) async {
    final cubit = context.read<BookingDetailCubit>();
    final t = context.t.bookings;

    final confirmed = await CancelBookingSheet.ask(
      context,
      booking: booking,
      now: now,
    );
    if (!confirmed || !context.mounted) return;

    final cancelled = await cubit.cancel(booking.id);
    if (!context.mounted) return;

    if (cancelled == null) {
      final failure = cubit.state.failure;
      AppSnackBar.error(
        context,
        failure?.localized(context) ?? t.cancel.failed,
      );
      return;
    }

    AppSnackBar.success(
      context,
      cancelled.refunded
          ? t.cancel.doneRefunded(fee: Money.formatCents(cancelled.feeCents))
          : t.cancel.done,
    );
    if (context.mounted) context.router.maybePop();
  }

  /// Opens the phone's calendar with the appointment filled in.
  ///
  /// A template URL rather than a generated `.ics`: writing a file and handing
  /// it to the system needs `path_provider` and `share_plus`, and this is one
  /// button on one screen. The swap is a single method if the two packages
  /// ever arrive for another reason.
  Future<void> _addToCalendar(BuildContext context) async {
    final stamp = DateFormat("yyyyMMdd'T'HHmmss'Z'");
    final title = Uri.encodeComponent(
      '${booking.serviceName} · ${booking.shopName ?? ''}'.trim(),
    );
    final where = Uri.encodeComponent(booking.shopAddressLine ?? '');
    final dates =
        '${stamp.format(booking.startUtc.toUtc())}/'
        '${stamp.format(booking.endUtc.toUtc())}';

    final opened = await di<LinkService>().open(
      Uri.parse(
        'https://calendar.google.com/calendar/render'
        '?action=TEMPLATE&text=$title&dates=$dates&location=$where',
      ),
    );

    if (!opened && context.mounted) {
      AppSnackBar.error(context, context.t.bookings.calendarFailed);
    }
  }
}

/// The hero card: status, the day, the hour, and how long it takes.
class _When extends StatelessWidget {
  const _When({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final zone = booking.timeZone;

    return Container(
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: context.decorations.card.copyWith(
        boxShadow: context.shadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStatusBadge(
            tint: context.status.ofBooking(booking.status),
            icon: booking.status.icon,
            label: booking.status.label(context.t),
          ),
          SizedBox(height: context.spacing.md.h),
          Text(
            DateFormat(
              'EEEE d MMMM',
              locale,
            ).format(ShopClock.wallTime(booking.startUtc, zone)),
            style: context.textTheme.displaySmall,
          ),
          Text(
            '${ShopClock.hm(booking.startUtc, zone, locale)} – '
            '${ShopClock.hm(booking.endUtc, zone, locale)}',
            style: context.textTheme.displaySmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: context.spacing.md.h),
          Row(
            children: [
              Icon(
                Icons.content_cut_rounded,
                size: context.icons.s.w,
                color: context.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: context.spacing.sm.w),
              Flexible(
                child: Text(
                  [
                    context.t.bookings.serviceLine(
                      service: booking.serviceName,
                      minutes: booking.durationMinutes,
                    ),
                    if (booking.withWhom case final name?)
                      context.t.shopScreen.withWhom(name: name),
                  ].join(' · '),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Where it is, and how to reach them.
class _Where extends StatelessWidget {
  const _Where({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final phone = booking.shopPhone;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: context.decorations.card,
      child: Column(
        children: [
          _Row(
            icon: Icons.storefront_outlined,
            title: booking.shopName ?? '',
            subtitle: booking.shopAddressLine,
            trailing: AppOutlinedButton(
              label: t.map,
              onPressed: () => _openMap(context),
            ),
          ),
          if (phone != null) ...[
            const AppDivider(),
            _Row(
              icon: Icons.call_outlined,
              title: t.callShop,
              subtitle: phone,
              onTap: () => _call(context, phone),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openMap(BuildContext context) => openShopMap(
    context,
    name: booking.shopName,
    address: booking.shopAddressLine,
  );

  Future<void> _call(BuildContext context, String phone) async {
    final opened = await di<LinkService>().open(
      Uri(scheme: 'tel', path: phone),
    );

    if (!opened && context.mounted) {
      AppSnackBar.error(context, context.t.agenda.sheet.noDialler);
    }
  }
}

/// A row with a square glyph, two lines, and either a button or a chevron.
///
/// Not `AppSettingsRow`: that one is a settings line — label on the left, its
/// current value on the right — and cannot carry an action button beside the
/// text, which is exactly what the shop row is for.
class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.lg.w,
          vertical: context.spacing.md.h,
        ),
        child: Row(
          children: [
            Container(
              width: context.icons.l.w,
              height: context.icons.l.w,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: context.radii.mdR,
              ),
              child: Icon(
                icon,
                size: context.icons.s.w,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall,
                  ),
                  if (subtitle case final line?) ...[
                    SizedBox(height: context.spacing.xxs.h),
                    Text(
                      line,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            if (trailing case final widget?)
              widget
            else if (onTap != null)
              Icon(
                Icons.chevron_right_rounded,
                color: context.colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

/// The two amounts, kept apart.
///
/// The same pattern as the booking summary: the service is paid in the shop,
/// the BookNow fee was paid in the app — and the card it went on is named, so
/// "pagato" is not something the customer has to take on trust.
class _Money extends StatelessWidget {
  const _Money({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.sm.h,
      ),
      decoration: context.decorations.card,
      child: Column(
        children: [
          _Line(
            title: booking.serviceName,
            subtitle: t.payInShop,
            amount: Money.formatCents(booking.priceCents),
          ),
          // Free to book: nothing was paid in the app, so no line for it.
          if (booking.feeCents > 0) ...[
            const AppDivider(),
            _Line(
              title: t.bookNowService,
              subtitle: booking.refunded
                  ? t.refunded
                  : booking.cardLast4 == null
                  ? t.paid
                  : t.paidWithCard(card: booking.cardLast4!),
              subtitleColor: context.status.confirmed.foreground,
              amount: Money.formatCents(booking.feeCents),
            ),
          ],
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.title,
    required this.subtitle,
    required this.amount,
    this.subtitleColor,
  });

  final String title;
  final String subtitle;
  final String amount;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacing.md.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.titleSmall),
                SizedBox(height: context.spacing.xxs.h),
                Text(
                  subtitle,
                  style: context.textTheme.labelMedium?.copyWith(
                    color:
                        subtitleColor ?? context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.spacing.md.w),
          Text(amount, style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_cubit.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_state.dart';
import 'package:booknow_mobile/features/bookings/widgets/past_bookings_list.dart';
import 'package:booknow_mobile/features/bookings/widgets/upcoming_booking_card.dart';
import 'package:booknow_mobile/features/home/widgets/shop_summary_card.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/features/queue/widgets/live_bar.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Everything the customer has with a shop, in the order it matters: what is
/// happening now, what is coming, and what they might want to do again.
///
/// One scroll rather than tabs: the three are rarely long, and a place in line
/// must never sit behind a tab.
class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) => AppScaffold(body: _Body(state: state)),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final BookingsState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final cubit = context.read<BookingsCubit>();
    final live = di<LiveStatusCubit>();
    final hasBookings = state.upcoming.isNotEmpty || state.past.isNotEmpty;

    if (state.isLoading && !hasBookings) return const AppLoader.centered();

    if (state.failure case final failure? when !hasBookings) {
      return AppErrorState(
        message: failure.localized(context),
        retryLabel: t.common.retry,
        onRetry: cubit.loadAll,
      );
    }

    return BlocBuilder<LiveStatusCubit, QueueEntry?>(
      bloc: live,
      builder: (context, entry) => RefreshIndicator(
        onRefresh: () async {
          await Future.wait([cubit.loadAll(refresh: true), live.refresh()]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 18.h, bottom: 24.h),
          children: [
            Text(t.nav.activity, style: context.textTheme.displayMedium),
            SizedBox(height: 24.h),
            if (entry != null) ...[
              AppSectionTitle(t.bookings.rightNow),
              SizedBox(height: 10.h),
              _LiveRow(entry: entry),
              SizedBox(height: 24.h),
            ],
            if (entry == null && !hasBookings) ...[
              SizedBox(height: context.spacing.huge.h),
              AppEmptyState(
                icon: Icons.event_available_outlined,
                title: t.bookings.emptyTitle,
                message: t.bookings.emptyBody,
              ),
            ] else ...[
              AppSectionTitle(t.bookings.upcoming),
              SizedBox(height: 10.h),
              if (state.upcoming.isEmpty)
                Text(
                  t.bookings.emptyTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                )
              else ...[
                for (final booking in state.upcoming) ...[
                  UpcomingBookingCard(
                    booking: booking,
                    now: state.now,
                    onTap: () => _openDetail(context, booking),
                    onPay: () => _resume(context, booking),
                  ),
                  SizedBox(height: 10.h),
                ],
              ],
              if (state.past.isNotEmpty) ...[
                SizedBox(height: 14.h),
                AppSectionTitle(t.bookings.past),
                SizedBox(height: 10.h),
                PastBookingsList(
                  bookings: state.past,
                  onRepeat: (booking) => _repeat(context, booking),
                  onTap: (booking) => _openDetail(context, booking),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, Booking booking) => context.router
      .push(BookingDetailRoute(bookingId: booking.id, initial: booking));

  /// "Pay now" goes back into the flow for the same slot: the hold is still
  /// live, so the server answers with the payment that is already open.
  void _resume(BuildContext context, Booking booking) => context.router.push(
    BookingFlowRoute(
      shopId: booking.shopId,
      serviceId: booking.serviceId,
      startUtc: booking.startUtc,
    ),
  );

  /// Reopens the picker on the same shop and service: the same time of day is
  /// rarely free again, so the day is where it starts, not the hour.
  void _repeat(BuildContext context, Booking booking) => context.router.push(
    BookingFlowRoute(shopId: booking.shopId, serviceId: booking.serviceId),
  );
}

/// The customer's place in a line, opening the same sheet as the live bar.
class _LiveRow extends StatelessWidget {
  const _LiveRow({required this.entry});

  final QueueEntry entry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = context.colorScheme;
    final called = entry.status == QueueEntryStatus.called;
    final serving = entry.status == QueueEntryStatus.serving;
    final tint = called ? context.status.arrived : context.status.pending;
    final position = entry.position;
    final estimate = entry.estimate;
    final range = estimate == null
        ? null
        : t.queue.range(from: estimate.fromMin, to: estimate.toMin);
    final line = called
        ? t.live.headInAt(shop: entry.shopName ?? '')
        : serving
        ? entry.serviceName
        : [t.home.inLine, ?range].join(' · ');
    final label = called
        ? t.queue.turnTitle
        : serving
        ? t.live.inChair
        : position != null
        ? [t.queue.position(n: position), ?range].join(' · ')
        : null;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => LiveSheet.show(context),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: context.radii.mdR,
                child: SizedBox.square(
                  dimension: 52.w,
                  child: const ShopPhoto(url: null),
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.shopName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: context.fonts.s.sp,
                      ),
                    ),
                    Text(
                      line,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (label != null) ...[
                SizedBox(width: context.spacing.sm.w),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: tint.background,
                    borderRadius: context.radii.smR,
                  ),
                  child: Text(
                    label,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: tint.foreground,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

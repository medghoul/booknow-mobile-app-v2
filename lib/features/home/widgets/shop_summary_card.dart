import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One shop in the Discover feed.
///
/// The facts that decide a visit are the buttons: the wait is what you tap to
/// join, the next time is what you tap to book. Anything the server did not
/// say is simply not claimed.
class ShopFeedCard extends StatelessWidget {
  const ShopFeedCard({
    super.key,
    required this.shop,
    required this.onOpen,
    required this.onJoin,
    required this.onBook,
    this.queue,
    this.nextSlot,
    this.tomorrow = false,
  });

  final ShopSummary shop;
  final VoidCallback onOpen;

  final VoidCallback onJoin;
  final VoidCallback onBook;
  final ShopQueue? queue;
  final FreeSlot? nextSlot;

  /// The feed is showing tomorrow, so the tile says so.
  final bool tomorrow;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final kind = shopKind(context, shop);

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: onOpen,
              borderRadius: context.radii.mdR,
              child: Row(
                children: [
                  Hero(
                    tag: shopPhotoTag(shop.id),
                    child: ClipRRect(
                      borderRadius: context.radii.mdR,
                      child: SizedBox.square(
                        dimension: 64.w,
                        child: ShopPhoto(
                          url: shop.photoUrl,
                          category: categoryOf(shop.category),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: context.spacing.md.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 3),
                        if (kind.isNotEmpty)
                          Text(
                            kind,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        const SizedBox(height: 3),
                        _OpenLine(shop: shop),
                      ],
                    ),
                  ),
                  AppLineIcon(
                    AppLineIcons.chevronRight,
                    size: 18,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            Row(
              children: [
                if (shop.mode.runsQueue && !tomorrow)
                  Expanded(child: _joinTile(context)),
                if (shop.mode == ShopMode.both && !tomorrow)
                  SizedBox(width: context.spacing.sm.w),
                if (shop.mode.takesBookings)
                  Expanded(child: _bookTile(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _joinTile(BuildContext context) {
    final t = context.t.home;
    final queue = this.queue;
    final tint = switch (queue) {
      null => context.status.pending,
      final q when !q.isAccepting => context.status.cancelled,
      final q when q.waitingCount == 0 => context.status.arrived,
      _ => context.status.pending,
    };
    final value = switch (queue) {
      null => t.seeLine,
      final q when !q.isAccepting => t.queueClosed,
      final q when q.waitingCount == 0 => t.noWait,
      final q => t.waitShort(
        n: q.waitingCount,
        from: q.estimate.fromMin,
        to: q.estimate.toMin,
      ),
    };

    return _ActionTile(
      label: t.joinLine,
      value: value,
      tint: tint,
      onTap: onJoin,
    );
  }

  Widget _bookTile(BuildContext context) {
    final t = context.t.home;
    final slot = nextSlot;
    final value = tomorrow
        ? t.intentTomorrow
        : slot == null
        ? t.seeTimes
        : t.nextAt(
            time: ShopClock.hm(
              slot.startUtc,
              'Europe/Rome',
              Localizations.localeOf(context).toString(),
            ),
          );

    return _ActionTile(
      label: t.bookTime,
      value: value,
      tint: context.status.confirmed,
      onTap: onBook,
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.label,
    required this.value,
    required this.tint,
    required this.onTap,
  });

  final String label;
  final String value;
  final StatusTint tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tint.background,
      borderRadius: context.radii.mdR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md.w),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: context.fonts.s.sp,
                  fontWeight: FontWeight.w800,
                  color: tint.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OpenLine extends StatelessWidget {
  const _OpenLine({required this.shop});

  final ShopSummary shop;

  @override
  Widget build(BuildContext context) {
    final t = context.t.home;
    final label = switch ((shop.openNow, shop.closesAt, shop.opensAt)) {
      (true, final closes?, _) => t.openUntil(time: closes),
      (true, _, _) => t.openNow,
      (false, _, final opens?) => t.closedUntil(time: opens),
      _ => t.closedNow,
    };

    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.bodySmall?.copyWith(
        fontSize: context.fonts.xxs.sp,
        fontWeight: FontWeight.w600,
        color: shop.openNow
            ? context.status.arrived.foreground
            : context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

/// "Barber · 800 m": what the shop is and how far, or its address until shops
/// carry a category.
String shopKind(BuildContext context, ShopSummary shop) {
  final category = categoryOf(shop.category);
  if (category == null) return shopWhere(context, shop);

  return [
    category.label(context.t),
    ?shopDistance(context, shop.distanceMeters),
  ].join(' · ');
}

/// The distance as it is read: "800 m", "1,2 km".
String? shopDistance(BuildContext context, int? metres) => metres == null
    ? null
    : metres < 1000
    ? context.t.home.metresAway(metres: metres)
    : context.t.home.kilometresAway(
        km: (metres / 1000).toStringAsFixed(1).replaceAll('.', ','),
      );

/// Address, and the distance when the customer shared where they are.
/// The way into a shop: its line, or its times.
///
/// Without [line] it opens on the line when there is one, the quickest way in.
PageRouteInfo<dynamic> shopRoute(
  ShopSummary shop, {
  bool? line,
  FreeSlot? slot,
  String? initialDate,
}) => (line ?? shop.mode.runsQueue)
    ? QueueFlowRoute(
        shopId: shop.id,
        category: categoryOf(shop.category),
        distanceMeters: shop.distanceMeters,
      )
    : BookingFlowRoute(
        shopId: shop.id,
        category: categoryOf(shop.category),
        distanceMeters: shop.distanceMeters,
        serviceId: slot?.serviceId,
        startUtc: slot?.startUtc,
        initialDate: initialDate,
      );

String shopWhere(BuildContext context, ShopSummary shop) => [
  shop.addressLine ?? shop.city ?? '',
  ?shopDistance(context, shop.distanceMeters),
].where((part) => part.isNotEmpty).join(' · ');

/// The shared-element tag between a shop's card and its screen.
String shopPhotoTag(String shopId) => 'shop-photo-$shopId';

/// A shop's photo, or a clay picture on a soft tint: a shop with no photo, or
/// one that will not load, still has to look like somewhere to go.
class ShopPhoto extends StatelessWidget {
  const ShopPhoto({super.key, required this.url, this.category});

  final String? url;

  /// Its picture while there is no photo. A shop with none known gets the
  /// neutral one, never another trade's.
  final ShopCategory? category;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: context.colorScheme.primaryContainer,
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: CategoryPicture(
            category: category ?? ShopCategory.more,
            size: constraints.biggest.shortestSide * 0.72,
          ),
        ),
      ),
    );
    final url = this.url;

    return url == null
        ? placeholder
        : Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, _, _) => placeholder,
          );
  }
}

/// The category the server named, when the app knows it.
ShopCategory? categoryOf(String? asset) => ShopCategory.values
    .where((category) => category.asset == asset)
    .firstOrNull;

/// A small tinted fact. Always carries a word, so a state is never told by
/// colour alone.
class HomePill extends StatelessWidget {
  const HomePill({super.key, required this.tint, required this.label});

  final StatusTint tint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm.w,
        vertical: context.spacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.smR,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          fontSize: context.fonts.xxs.sp,
          color: tint.foreground,
        ),
      ),
    );
  }
}

/// The wait as a pill: "3 waiting · 20–30 min", "No wait", or closed.
class QueuePill extends StatelessWidget {
  const QueuePill({super.key, required this.queue});

  final ShopQueue queue;

  @override
  Widget build(BuildContext context) {
    final t = context.t.home;

    if (!queue.isAccepting) {
      return HomePill(tint: context.status.cancelled, label: t.queueClosed);
    }
    if (queue.waitingCount == 0) {
      return HomePill(tint: context.status.arrived, label: t.noWait);
    }
    return HomePill(
      tint: context.status.pending,
      label: t.waiting(
        n: queue.waitingCount,
        from: queue.estimate.fromMin,
        to: queue.estimate.toMin,
      ),
    );
  }
}

/// The feed's loading shape: the same card, gently pulsing.
class ShopFeedSkeleton extends StatefulWidget {
  const ShopFeedSkeleton({super.key});

  @override
  State<ShopFeedSkeleton> createState() => _ShopFeedSkeletonState();
}

class _ShopFeedSkeletonState extends State<ShopFeedSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
    lowerBound: 0.5,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (!reduce && !_controller.isAnimating) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fill = context.colorScheme.surfaceContainer;
    Widget box(double? width, double height, BorderRadius radius) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: fill, borderRadius: radius),
    );

    return FadeTransition(
      opacity: _controller,
      child: Column(
        children: [
          for (var i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.only(bottom: context.spacing.md.h),
              padding: EdgeInsets.all(context.spacing.md.w),
              decoration: context.decorations.card,
              child: Column(
                children: [
                  Row(
                    children: [
                      box(64.w, 64.w, context.radii.mdR),
                      SizedBox(width: context.spacing.md.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            box(160.w, 14.h, context.radii.smR),
                            SizedBox(height: context.spacing.sm.h),
                            box(220.w, 12.h, context.radii.smR),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacing.md.h),
                  Row(
                    children: [
                      Expanded(child: box(null, 54.h, context.radii.mdR)),
                      SizedBox(width: context.spacing.sm.w),
                      Expanded(child: box(null, 54.h, context.radii.mdR)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

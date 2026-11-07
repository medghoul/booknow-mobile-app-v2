import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home/cubit/shop_map_cubit.dart';
import 'package:booknow_mobile/features/home/widgets/home_filters.dart';
import 'package:booknow_mobile/features/home/widgets/shop_summary_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Discover's map: the feed's shops with a known point, each a pill saying how
/// soon you can be seen, and the one tapped as a card.
class ShopMapView extends StatelessWidget {
  const ShopMapView({
    super.key,
    required this.shops,
    required this.queues,
    required this.nextSlots,
    required this.intent,
    required this.onOpen,
  });

  /// What the feed is showing now, so the two never disagree.
  final List<ShopSummary> shops;
  final Map<String, ShopQueue> queues;
  final Map<String, FreeSlot> nextSlots;
  final HomeIntent intent;
  final ValueChanged<ShopSummary> onOpen;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShopMapCubit(di())..load(),
      child: BlocBuilder<ShopMapCubit, ShopMapState>(
        builder: (context, state) => switch (state) {
          ShopMapLoading() => const AppLoader.centered(),
          ShopMapFailure(:final error) => AppErrorState(
            message: error.localized(context),
            retryLabel: context.t.common.retry,
            onRetry: () => context.read<ShopMapCubit>().load(),
          ),
          ShopMapLoaded(:final pins) when pins.isEmpty => Center(
            child: Text(
              context.t.home.noShops,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ShopMapLoaded(:final pins) => _ShopMap(
            pins: pins,
            shops: shops,
            queues: queues,
            nextSlots: nextSlots,
            intent: intent,
            onOpen: onOpen,
          ),
        },
      ),
    );
  }
}

class _ShopMap extends StatefulWidget {
  const _ShopMap({
    required this.pins,
    required this.shops,
    required this.queues,
    required this.nextSlots,
    required this.intent,
    required this.onOpen,
  });

  final List<ShopPin> pins;
  final List<ShopSummary> shops;
  final Map<String, ShopQueue> queues;
  final Map<String, FreeSlot> nextSlots;
  final HomeIntent intent;
  final ValueChanged<ShopSummary> onOpen;

  @override
  State<_ShopMap> createState() => _ShopMapState();
}

class _ShopMapState extends State<_ShopMap> {
  String? _selectedId;

  String _time(FreeSlot slot) => ShopClock.hm(
    slot.startUtc,
    'Europe/Rome',
    Localizations.localeOf(context).toString(),
  );

  /// The one fact that decides a visit, for what the feed is showing.
  String _label(ShopSummary shop) {
    final t = context.t.home;
    final queue = widget.queues[shop.id];
    final next = widget.nextSlots[shop.id];
    final fallback = shop.mode.runsQueue ? t.join : t.book;

    return switch (widget.intent) {
      // The home only knows today's times.
      HomeIntent.tomorrow => t.book,
      HomeIntent.today => next == null ? fallback : _time(next),
      HomeIntent.now => switch (queue) {
        null => fallback,
        final q when q.waitingCount == 0 => t.mapNow,
        final q => t.mapWait(from: q.estimate.fromMin, to: q.estimate.toMin),
      },
    };
  }

  String _summary(ShopSummary shop) {
    final t = context.t.home;
    final queue = widget.queues[shop.id];
    final next = widget.nextSlots[shop.id];
    final parts = [
      if (queue != null && queue.isAccepting)
        queue.waitingCount == 0
            ? t.noWait
            : t.waitShort(
                n: queue.waitingCount,
                from: queue.estimate.fromMin,
                to: queue.estimate.toMin,
              ),
      if (next != null && widget.intent != HomeIntent.tomorrow)
        t.nextAt(time: _time(next)),
    ];

    return parts.isEmpty ? shopKind(context, shop) : parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final byId = {for (final shop in widget.shops) shop.id: shop};
    final visible =
        [
          for (final pin in widget.pins)
            if (byId.containsKey(pin.shop.id)) pin,
        ]..sort(
          (a, b) => (a.shop.id == _selectedId ? 1 : 0).compareTo(
            b.shop.id == _selectedId ? 1 : 0,
          ),
        );
    final selected = byId[_selectedId];
    // The camera starts on every shop, so changing a filter does not move it.
    final points = [
      for (final pin in widget.pins) LatLng(pin.latitude, pin.longitude),
    ];

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCameraFit: points.length > 1
                ? CameraFit.coordinates(
                    coordinates: points,
                    padding: EdgeInsets.all(72.w),
                    maxZoom: 16,
                  )
                : null,
            initialCenter: points.first,
            initialZoom: 15,
            onTap: (_, _) => setState(() => _selectedId = null),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'app.booknow.mobile',
            ),
            MarkerLayer(
              markers: [
                for (final pin in visible)
                  Marker(
                    point: LatLng(pin.latitude, pin.longitude),
                    width: 120,
                    height: 44,
                    child: Center(
                      child: _Pill(
                        label: _label(byId[pin.shop.id]!),
                        name: pin.shop.name,
                        selected: pin.shop.id == _selectedId,
                        onTap: () => setState(() => _selectedId = pin.shop.id),
                      ),
                    ),
                  ),
              ],
            ),
            // OpenStreetMap's licence requires attribution to be visible.
            const SimpleAttributionWidget(
              source: Text('OpenStreetMap contributors'),
            ),
          ],
        ),
        if (selected != null)
          Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 68,
            child: _MapCard(
              shop: selected,
              summary: _summary(selected),
              onOpen: () => widget.onOpen(selected),
            ),
          ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String? name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Semantics(
      button: true,
      label: name,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: selected ? scheme.primary : scheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: scheme.surface, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x330F2A4A),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              label,
              maxLines: 1,
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: selected ? scheme.onPrimary : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  const _MapCard({
    required this.shop,
    required this.summary,
    required this.onOpen,
  });

  final ShopSummary shop;
  final String summary;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: context.radii.lgR,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: context.radii.mdR,
            child: SizedBox.square(
              dimension: 52,
              child: ShopPhoto(
                url: shop.photoUrl,
                category: categoryOf(shop.category),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall?.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: scheme.primary,
            borderRadius: context.radii.mdR,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onOpen,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Text(
                  context.t.home.view,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 14,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

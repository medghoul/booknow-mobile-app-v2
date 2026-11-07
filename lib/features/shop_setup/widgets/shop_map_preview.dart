import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Close enough to recognise the street without being so close that the
/// surrounding block disappears.
const double _zoom = 16.5;

/// OpenStreetMap asks every client to identify itself, and will block ones
/// that do not.
const String _userAgent = 'app.booknow.mobile';

/// Where the shop sits, once the server has resolved an address to a point.
///
/// Read-only on purpose. The coordinates are whatever `GetPlace` returned —
/// the app never sends a position — so there is nothing here for the owner to
/// move, and a map that pans under a finger would suggest otherwise.
///
/// Zoomed in far enough to read a street, which is the only question the owner
/// is actually being asked: is this the right door.
class ShopMapPreview extends StatefulWidget {
  const ShopMapPreview({super.key, required this.address, this.height});

  final ShopAddress address;
  final double? height;

  @override
  State<ShopMapPreview> createState() => _ShopMapPreviewState();
}

class _ShopMapPreviewState extends State<ShopMapPreview> {
  /// `initialCenter` is read once, when the map is built. Rebuilding with new
  /// coordinates does not move the camera — the marker jumps and the view
  /// stays behind — so picking a second address needs an imperative move.
  final MapController _controller = MapController();

  @override
  void didUpdateWidget(ShopMapPreview oldWidget) {
    super.didUpdateWidget(oldWidget);

    final previous = oldWidget.address;
    final next = widget.address;
    if (previous.latitude == next.latitude &&
        previous.longitude == next.longitude) {
      return;
    }

    _controller.move(LatLng(next.latitude!, next.longitude!), _zoom);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Close enough to recognise the street without being so close that the
  /// surrounding block disappears.

  /// OpenStreetMap asks every client to identify itself, and will block ones
  /// that do not.

  @override
  Widget build(BuildContext context) {
    final point = LatLng(widget.address.latitude!, widget.address.longitude!);

    return ClipRRect(
      borderRadius: context.radii.lgR,
      child: SizedBox(
        height: widget.height ?? 180.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FlutterMap(
              mapController: _controller,
              options: MapOptions(
                initialCenter: point,
                initialZoom: _zoom,
                // A preview, not a map: every gesture is off, so the pin can
                // never drift away from the address underneath it.
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: _userAgent,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: context.icons.xl.w,
                      height: context.icons.xl.w,
                      // Anchored at the tip, so the point of the pin is the
                      // coordinate rather than the middle of the icon.
                      alignment: Alignment.topCenter,
                      child: _Pin(),
                    ),
                  ],
                ),
              ],
            ),
            // OpenStreetMap's licence requires attribution to be visible.
            Positioned(right: 0, bottom: 0, child: const _Attribution()),
          ],
        ),
      ),
    );
  }
}

class _Pin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.location_pin,
      size: context.icons.xl.w,
      color: context.colorScheme.primary,
      shadows: context.shadows.sm,
    );
  }
}

class _Attribution extends StatelessWidget {
  const _Attribution();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.xs.w,
        vertical: context.spacing.xxs.h,
      ),
      color: context.colorScheme.surface.withOpacityValue(0.7),
      child: Text(
        '© OpenStreetMap',
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: context.fonts.xxs.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

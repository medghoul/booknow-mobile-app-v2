import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  _recentring();

  const geocoded = ShopAddress(
    line: 'Via dei Coronari 18',
    city: 'Roma',
    zip: '00186',
    country: 'IT',
    latitude: 41.9028,
    longitude: 12.4964,
  );

  testWidgets('centres on the coordinates the server resolved', (tester) async {
    await pumpThemed(tester, const ShopMapPreview(address: geocoded));

    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    expect(map.options.initialCenter, const LatLng(41.9028, 12.4964));
  });

  testWidgets('drops a marker on that exact point', (tester) async {
    await pumpThemed(tester, const ShopMapPreview(address: geocoded));

    final layer = tester.widget<MarkerLayer>(find.byType(MarkerLayer));
    expect(layer.markers, hasLength(1));
    expect(layer.markers.single.point, const LatLng(41.9028, 12.4964));
  });

  // The app never sends a position — `GetPlace` decides it — so a map the
  // owner could pan would imply an edit that has nowhere to go.
  testWidgets('every gesture is disabled', (tester) async {
    await pumpThemed(tester, const ShopMapPreview(address: geocoded));

    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    expect(map.options.interactionOptions.flags, InteractiveFlag.none);
  });

  // OpenStreetMap's licence requires it, and their tile policy requires the
  // user agent — losing either silently is how you get blocked.
  testWidgets('keeps the OpenStreetMap attribution and user agent', (
    tester,
  ) async {
    await pumpThemed(tester, const ShopMapPreview(address: geocoded));

    expect(find.text('© OpenStreetMap'), findsOneWidget);

    final tiles = tester.widget<TileLayer>(find.byType(TileLayer));
    expect(
      tiles.tileProvider.headers['User-Agent'],
      contains('app.booknow.mobile'),
    );
  });
}

// `initialCenter` is read once. Before the controller, picking a second
// address moved the marker but left the camera on the first one.
void _recentring() {
  const moved = ShopAddress(
    line: 'Via Giulia 2',
    city: 'Roma',
    zip: '00186',
    country: 'IT',
    latitude: 41.8955,
    longitude: 12.4663,
  );

  testWidgets('follows the pin when the address changes', (tester) async {
    const first = ShopAddress(
      line: 'Via dei Coronari 18',
      city: 'Roma',
      zip: '00186',
      country: 'IT',
      latitude: 41.9028,
      longitude: 12.4964,
    );

    late StateSetter setAddress;
    var address = first;

    await pumpThemed(
      tester,
      StatefulBuilder(
        builder: (context, setState) {
          setAddress = setState;
          return ShopMapPreview(address: address);
        },
      ),
    );

    final controller = tester
        .widget<FlutterMap>(find.byType(FlutterMap))
        .mapController!;
    expect(controller.camera.center, const LatLng(41.9028, 12.4964));

    setAddress(() => address = moved);
    await tester.pump();

    expect(controller.camera.center, const LatLng(41.8955, 12.4663));
    expect(
      tester.widget<MarkerLayer>(find.byType(MarkerLayer)).markers.single.point,
      const LatLng(41.8955, 12.4663),
    );
  });
}

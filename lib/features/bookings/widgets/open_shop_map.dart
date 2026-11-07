import 'dart:io';

import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';

/// Opens a shop in the customer's maps app.
///
/// Apple Maps on iOS, the platform chooser on Android: a `geo:` URI there opens
/// whichever maps app the customer actually uses.
Future<void> openShopMap(
  BuildContext context, {
  required String? name,
  required String? address,
}) async {
  final query = Uri.encodeComponent(
    [name, address].whereType<String>().join(', '),
  );
  final uri = Platform.isIOS
      ? Uri.parse('https://maps.apple.com/?q=$query')
      : Uri.parse('geo:0,0?q=$query');

  final opened = await di<LinkService>().open(uri);
  if (!opened && context.mounted) {
    AppSnackBar.error(context, context.t.bookings.mapFailed);
  }
}

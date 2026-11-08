// Draws the native launch screen pictures from SplashMark itself, so the first
// Flutter frame matches them exactly.
//
//   flutter test tool/render_splash.dart
//   dart run flutter_native_splash:create
//
// Run both after any change to SplashMark.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:booknow_mobile/core/theme/app_theme.dart';
import 'package:booknow_mobile/features/splash/widgets/splash_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Android 12+ draws the launch icon on a 288dp canvas, centred, and the
/// plugin wants it at 4x. The other platforms centre whatever they're given,
/// so they get the same picture.
const double _canvas = 288;
const double _ratio = 4;

void main() {
  setUpAll(() async {
    final inter = FontLoader('Inter');
    for (final weight in ['Regular', 'Bold', 'ExtraBold']) {
      final bytes = File('assets/fonts/Inter-$weight.ttf').readAsBytesSync();
      inter.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await inter.load();
  });

  for (final (theme, suffix) in [
    (AppTheme.light, 'light'),
    (AppTheme.dark, 'dark'),
  ]) {
    testWidgets('renders the $suffix launch screen', (tester) async {
      final boundary = GlobalKey();
      await tester.pumpWidget(
        Theme(
          data: theme,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: RepaintBoundary(
                key: boundary,
                child: const SizedBox.square(
                  dimension: _canvas,
                  // The name is left out: Android 12+ has no room for it, and
                  // every platform should open on the same picture.
                  child: Center(
                    child: SplashMark(name: kAlwaysDismissedAnimation),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.runAsync(() async {
        final render =
            boundary.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        final image = await render.toImage(pixelRatio: _ratio);
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        for (final name in ['splash_$suffix', 'splash_a12_$suffix']) {
          File(
            'assets/splash/$name.png',
          ).writeAsBytesSync(png!.buffer.asUint8List());
        }
      });
    });
  }
}

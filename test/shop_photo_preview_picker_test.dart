import 'dart:io';

import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:image_picker/image_picker.dart';

import 'theme_test.dart' show pumpThemed;

/// A 1x1 PNG, so `Image.file` has something real to decode.
const _png = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];

void main() {
  final t = LocaleSettings.currentLocale.buildSync().shopSetup.shop;

  // The chip on the preview reads `common.edit`; `photoReplace` is the
  // sheet's own label.
  final edit = LocaleSettings.currentLocale.buildSync().common.edit;

  late Directory tempDir;
  late XFile photo;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('booknow_photo');
    final file = File('${tempDir.path}/shop.png')..writeAsBytesSync(_png);
    photo = XFile(file.path);
  });

  tearDown(() => tempDir.deleteSync(recursive: true));

  testWidgets('with no photo it shows the empty prompt', (tester) async {
    await pumpThemed(
      tester,
      ShopPhotoPreviewPicker(onPicked: (_) {}, onRemoved: () {}),
    );

    expect(find.text(t.photoAdd), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  testWidgets('with a photo it shows the image and the replace chip', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      ShopPhotoPreviewPicker(
        localPath: photo.path,
        onPicked: (_) {},
        onRemoved: () {},
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.text(t.photoAdd), findsNothing);
    expect(find.text(edit), findsOneWidget);
  });

  testWidgets('the sheet offers remove only once there is a photo', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      ShopPhotoPreviewPicker(onPicked: (_) {}, onRemoved: () {}),
    );

    await tester.tap(find.text(t.photoAdd));
    await tester.pumpAndSettle();

    expect(find.text(t.photoCamera), findsOneWidget);
    expect(find.text(t.photoGallery), findsOneWidget);
    expect(find.text(t.photoRemove), findsNothing);
  });

  testWidgets('removing calls back', (tester) async {
    var removed = false;

    await pumpThemed(
      tester,
      ShopPhotoPreviewPicker(
        localPath: photo.path,
        onPicked: (_) {},
        onRemoved: () => removed = true,
      ),
    );

    await tester.tap(find.text(edit));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(t.photoRemove));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.photoRemove));
    await tester.pumpAndSettle();

    expect(removed, isTrue);
  });

  testWidgets('a disabled picker does not open the sheet', (tester) async {
    await pumpThemed(
      tester,
      ShopPhotoPreviewPicker(
        isDisabled: true,
        onPicked: (_) {},
        onRemoved: () {},
      ),
    );

    await tester.tap(find.text(t.photoAdd));
    await tester.pumpAndSettle();

    expect(find.text(t.photoCamera), findsNothing);
  });
}

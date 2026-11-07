import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// The redesigned source sheet: a heading, two source cards, the tips panel
/// and a cancel. Everything the design calls for has to be on screen.
void main() {
  final t = LocaleSettings.currentLocale.buildSync().shopSetup.shop;

  // The sheet scrolls, so anything below the first fold has to be brought
  // into view before it can be tapped.
  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  final common = LocaleSettings.currentLocale.buildSync().common;
  final cancel = common.cancel;

  Future<void> openSheet(WidgetTester tester, {required bool hasPhoto}) async {
    await pumpThemed(
      tester,
      ShopPhotoPreviewPicker(
        localPath: hasPhoto ? '/tmp/missing.jpg' : null,
        onPicked: (_) {},
        onRemoved: () {},
      ),
    );
    await tester.tap(find.text(hasPhoto ? common.edit : t.photoAdd));
    await tester.pumpAndSettle();
  }

  testWidgets('shows the heading, both sources and the tips', (tester) async {
    await openSheet(tester, hasPhoto: false);

    expect(find.text(t.photoSource), findsOneWidget);
    expect(find.text(t.photoSourceBody), findsOneWidget);
    expect(find.text(t.photoCamera), findsOneWidget);
    expect(find.text(t.photoGallery), findsOneWidget);
    expect(find.text(t.photoTipsTitle.toUpperCase()), findsOneWidget);
    expect(find.text(t.photoTipLight), findsOneWidget);
    expect(find.text(t.photoTipLandscape), findsOneWidget);
    expect(find.text(t.photoTipFaces), findsOneWidget);
    expect(
      find.text(LocaleSettings.currentLocale.buildSync().common.cancel),
      findsOneWidget,
    );
  });

  testWidgets('cancel closes without choosing anything', (tester) async {
    await openSheet(tester, hasPhoto: false);

    await tapVisible(tester, find.text(cancel));

    expect(find.text(t.photoCamera), findsNothing);
  });

  // The design has no remove in it, because it shows the empty case. With a
  // photo there has to be a way out of it.
  testWidgets('remove appears only with a photo', (tester) async {
    await openSheet(tester, hasPhoto: false);
    expect(find.text(t.photoRemove), findsNothing);

    await tapVisible(tester, find.text(cancel));

    await openSheet(tester, hasPhoto: true);
    expect(find.text(t.photoRemove), findsOneWidget);
  });

  // With a photo the sheet is a different thing: a thumbnail of what is
  // already there, and three alternatives in one grouped list.
  group('with a photo', () {
    testWidgets('shows the thumbnail, the subtitle and three actions', (
      tester,
    ) async {
      await openSheet(tester, hasPhoto: true);

      expect(find.text(t.photoSource), findsOneWidget);
      expect(find.text(t.photoVisible), findsOneWidget);
      expect(find.text(t.photoCameraNew), findsOneWidget);
      expect(find.text(t.photoGallery), findsOneWidget);
      expect(find.text(t.photoRemove), findsOneWidget);
      expect(find.text(cancel), findsOneWidget);
    });

    testWidgets('does not show the first-photo copy', (tester) async {
      await openSheet(tester, hasPhoto: true);

      expect(find.text(t.photoSourceBody), findsNothing);
      expect(find.text(t.photoTipsTitle.toUpperCase()), findsNothing);
      expect(find.text(t.photoCamera), findsNothing);
    });

    testWidgets('the remove row reads as destructive', (tester) async {
      await openSheet(tester, hasPhoto: true);

      final context = tester.element(find.text(t.photoRemove));
      final style = tester.widget<Text>(find.text(t.photoRemove)).style;
      expect(style?.color, Theme.of(context).colorScheme.error);
    });
  });

  testWidgets('the sheet fits a short phone without overflowing', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await openSheet(tester, hasPhoto: true);

    expect(tester.takeException(), isNull);
  });
}

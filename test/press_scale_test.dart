import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/features/auth/widgets/role_card.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:booknow_mobile/widgets/buttons/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// The press feedback on the button family.
///
/// What is worth pinning down is where the press comes from: the button's own
/// `statesController`, not a gesture detector wrapped around it. That is what
/// makes it behave inside a scroll view, survive a button being disabled
/// mid-press, and leave the tap itself alone.
void main() {
  const pressed = AppComponentSizes.pressedScale;

  /// The scale [AppPressScale] is currently painting at.
  ///
  /// Its `Transform` is the outermost one in the subtree — the Material
  /// button itself contributes none, which the Reduce Motion case asserts.
  ///
  /// Read off the x axis rather than with `getMaxScaleOnAxis`, which takes the
  /// largest of the three and so reports the untouched z axis' 1.0 for every
  /// shrink.
  double paintedScale(WidgetTester tester) {
    final transform = tester.widget<Transform>(
      find
          .descendant(
            of: find.byType(AppPressScale),
            matching: find.byType(Transform),
          )
          .first,
    );
    return transform.transform.entry(0, 0);
  }

  /// The scale of the [AppPressScale] that encloses [inner].
  ///
  /// Needed once more than one is on screen, where `paintedScale`'s `.first`
  /// would read whichever happens to come first in the tree.
  double scaleAround(WidgetTester tester, Finder inner) {
    final scope = find
        .ancestor(of: inner, matching: find.byType(AppPressScale))
        .first;
    final transform = tester.widget<Transform>(
      find.descendant(of: scope, matching: find.byType(Transform)).first,
    );
    return transform.transform.entry(0, 0);
  }

  /// Runs a scale that has just been set going to its end.
  ///
  /// Two pumps, not one: the first frame after an `AnimationController` starts
  /// only establishes the ticker's start time, so its value is still the one
  /// it had before. `pumpAndSettle` is not an option — half these cases have a
  /// `CircularProgressIndicator` on screen, which never settles.
  Future<void> finishScale(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
  }

  /// Holds the finger down and lets the press register and the scale run.
  ///
  /// `TapGestureRecognizer` only reports a tap-down once it has won the arena
  /// or sat out `kPressTimeout`, so the scale cannot be read on the frame the
  /// gesture starts.
  Future<TestGesture> press(WidgetTester tester, Finder target) async {
    final gesture = await tester.startGesture(tester.getCenter(target));
    await tester.pump(kPressTimeout);
    await finishScale(tester);
    return gesture;
  }

  Future<void> release(WidgetTester tester, TestGesture gesture) async {
    await gesture.up();
    await finishScale(tester);
  }

  group('AppPressScale', () {
    testWidgets('shrinks the button while it is held, and lets it back up', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        AppElevatedButton(label: 'Continue', onPressed: () {}),
        animations: true,
      );

      expect(paintedScale(tester), 1);

      final gesture = await press(tester, find.byType(AppElevatedButton));
      expect(paintedScale(tester), closeTo(pressed, 0.001));

      await release(tester, gesture);
      expect(paintedScale(tester), closeTo(1, 0.001));
    });

    testWidgets('a disabled button never reports a press', (tester) async {
      await pumpThemed(
        tester,
        const AppElevatedButton(label: 'Continue', onPressed: null),
        animations: true,
      );

      final gesture = await press(tester, find.byType(AppElevatedButton));
      expect(paintedScale(tester), 1);

      await release(tester, gesture);
    });

    testWidgets('a loading button never reports a press', (tester) async {
      await pumpThemed(
        tester,
        AppElevatedButton(label: 'Continue', onPressed: () {}, isLoading: true),
        animations: true,
      );

      final gesture = await press(tester, find.byType(AppElevatedButton));
      expect(paintedScale(tester), 1);

      await release(tester, gesture);
    });

    // The whole reason the press is read off the button rather than off a
    // `Listener` wrapped around it: a finger that lands on a button and then
    // drags is scrolling, and the button has to let go of the press.
    testWidgets('a scroll that starts on the button releases it', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        ListView(
          children: [
            AppElevatedButton(label: 'Continue', onPressed: () {}),
            const SizedBox(height: 1200),
          ],
        ),
        animations: true,
      );

      final gesture = await press(tester, find.byType(AppElevatedButton));
      expect(paintedScale(tester), closeTo(pressed, 0.001));

      // Past the drag threshold, so the scrollable takes the gesture.
      await gesture.moveBy(const Offset(0, -80));
      await finishScale(tester);
      expect(paintedScale(tester), closeTo(1, 0.001));

      await release(tester, gesture);
    });

    // Driving an `AnimationController` rather than calling `setState`: both
    // `InkResponse` and `ButtonStyleButton` clear `pressed` from their own
    // `didUpdateWidget`, which runs inside the build phase where `setState`
    // would throw.
    testWidgets('a button disabled mid-press does not throw', (tester) async {
      var loading = false;

      await pumpThemed(
        tester,
        StatefulBuilder(
          builder: (context, setState) => AppElevatedButton(
            label: 'Continue',
            isLoading: loading,
            onPressed: () => setState(() => loading = true),
          ),
        ),
        animations: true,
      );

      final gesture = await press(tester, find.byType(AppElevatedButton));
      await release(tester, gesture);

      expect(tester.takeException(), isNull);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(paintedScale(tester), closeTo(1, 0.001));
    });

    testWidgets('Reduce Motion drops the transform entirely', (tester) async {
      await pumpThemed(
        tester,
        AppElevatedButton(label: 'Continue', onPressed: () {}),
      );

      expect(
        find.descendant(
          of: find.byType(AppPressScale),
          matching: find.byType(Transform),
        ),
        findsNothing,
      );

      final gesture = await press(tester, find.byType(AppElevatedButton));
      await release(tester, gesture);
      expect(tester.takeException(), isNull);
    });
  });

  group('the button family', () {
    // One wrap per variant, so none of them is left without the feedback.
    testWidgets('every variant carries the press feedback', (tester) async {
      await pumpThemed(
        tester,
        Column(
          children: [
            AppElevatedButton(label: 'Primary', onPressed: () {}),
            AppOutlinedButton(label: 'Secondary', onPressed: () {}),
            AppTextButton(label: 'Skip', onPressed: () {}),
            AppIconButton(
              icon: Icons.close,
              tooltip: 'Close',
              onPressed: () {},
            ),
            AppProviderButton(
              provider: AuthProviderKind.google,
              label: 'Continue with Google',
              onPressed: () {},
            ),
          ],
        ),
      );

      expect(find.byType(AppPressScale), findsNWidgets(5));
    });

    // The back control is an `AppIconButton`, so it inherits the feedback
    // rather than carrying its own copy.
    testWidgets('the back button inherits it', (tester) async {
      await pumpThemed(tester, const AppBackButton());

      expect(find.byType(AppPressScale), findsOneWidget);
    });

    // The feedback is painted around the tap, never over it.
    testWidgets('the tap still reaches onPressed', (tester) async {
      var taps = 0;

      await pumpThemed(
        tester,
        AppElevatedButton(label: 'Continue', onPressed: () => taps++),
        animations: true,
      );

      await tester.tap(find.byType(AppElevatedButton));
      await finishScale(tester);

      expect(taps, 1);
    });

    // `Transform.scale` paints smaller without relaying out, so a pressed
    // button keeps the footprint it had before the feedback existed and
    // nothing around it shifts.
    testWidgets('the press does not move anything around it', (tester) async {
      await pumpThemed(
        tester,
        AppElevatedButton(label: 'Continue', onPressed: () {}, expand: true),
        animations: true,
      );

      final before = tester.getSize(find.byType(AppElevatedButton));

      final gesture = await press(tester, find.byType(AppElevatedButton));
      expect(paintedScale(tester), closeTo(pressed, 0.001));
      expect(tester.getSize(find.byType(AppElevatedButton)), before);

      await release(tester, gesture);
    });
  });

  // Cards and rows have no `statesController` of their own, so the `.tap`
  // form owns the gesture instead. The behaviour has to match the buttons'.
  group('cards and rows', () {
    Widget roleCard({VoidCallback? onTap}) => RoleCard(
      icon: Icons.content_cut,
      title: 'Barbiere',
      body: 'Gestisci la tua agenda.',
      isSelected: false,
      selectedLabel: 'selezionato',
      onSelected: onTap ?? () {},
    );

    testWidgets('a card shrinks while held, and comes back up', (tester) async {
      await pumpThemed(tester, roleCard(), animations: true);

      expect(paintedScale(tester), 1);

      final gesture = await press(tester, find.byType(RoleCard));
      expect(paintedScale(tester), closeTo(pressed, 0.001));

      await release(tester, gesture);
      expect(paintedScale(tester), closeTo(1, 0.001));
    });

    testWidgets('the tap still reaches the card', (tester) async {
      var taps = 0;
      await pumpThemed(tester, roleCard(onTap: () => taps++), animations: true);

      await tester.tap(find.byType(RoleCard));
      await finishScale(tester);

      expect(taps, 1);
    });

    // Same reason as the buttons: a finger that lands on a card and drags is
    // scrolling. The recogniser loses the arena, `onTapCancel` fires, and the
    // card has to let go.
    testWidgets('a scroll that starts on a card releases it', (tester) async {
      var taps = 0;
      await pumpThemed(
        tester,
        ListView(
          children: [
            roleCard(onTap: () => taps++),
            const SizedBox(height: 1200),
          ],
        ),
        animations: true,
      );

      final gesture = await press(tester, find.byType(RoleCard));
      expect(paintedScale(tester), closeTo(pressed, 0.001));

      await gesture.moveBy(const Offset(0, -80));
      await finishScale(tester);
      expect(paintedScale(tester), closeTo(1, 0.001));

      await release(tester, gesture);
      // A scroll is not a tap.
      expect(taps, 0);
    });

    testWidgets('an untappable panel never scales', (tester) async {
      await pumpThemed(
        tester,
        const DashedPanel(onTap: null, child: Text('Aggiungi una foto')),
        animations: true,
      );

      final gesture = await press(tester, find.byType(DashedPanel));
      expect(paintedScale(tester), 1);

      await release(tester, gesture);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a tappable panel does scale', (tester) async {
      await pumpThemed(
        tester,
        DashedPanel(onTap: () {}, child: const Text('Aggiungi una foto')),
        animations: true,
      );

      final gesture = await press(tester, find.byType(DashedPanel));
      expect(paintedScale(tester), closeTo(pressed, 0.001));

      await release(tester, gesture);
    });

    // The source sheet is a column of rows and two cards; every one of them
    // is a tap target, so every one of them gets the feedback.
    testWidgets('every row in the photo source sheet carries it', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        ShopPhotoPreviewPicker(
          localPath: null,
          onPicked: (_) {},
          onRemoved: () {},
        ),
      );

      final before = find.byType(AppPressScale).evaluate().length;

      await tester.tap(find.byType(DashedPanel));
      await tester.pumpAndSettle();

      // Two source cards, plus the cancel button already covered as a button.
      expect(find.byType(AppPressScale).evaluate().length, greaterThan(before));
    });

    // Presence is not function: a row can carry an `AppPressScale` and still
    // never report a press if the `statesController` is not handed over. This
    // presses a real row inside a real sheet.
    testWidgets('a source card in the sheet actually responds', (tester) async {
      final t = LocaleSettings.currentLocale.buildSync().shopSetup.shop;

      await pumpThemed(
        tester,
        ShopPhotoPreviewPicker(
          localPath: null,
          onPicked: (_) {},
          onRemoved: () {},
        ),
        animations: true,
      );

      await tester.tap(find.text(t.photoAdd));
      await tester.pumpAndSettle();

      final card = find.text(t.photoCamera);
      expect(card, findsOneWidget);
      expect(scaleAround(tester, card), closeTo(1, 0.001));

      final gesture = await press(tester, card);
      expect(scaleAround(tester, card), closeTo(pressed, 0.001));

      await release(tester, gesture);
    });
  });
}

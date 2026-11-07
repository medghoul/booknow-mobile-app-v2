import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_typography.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  const customerTabs = [
    AppNavTab(icon: AppLineIcons.search, label: 'Home'),
    AppNavTab(icon: AppLineIcons.calendar, label: 'Bookings'),
    AppNavTab(icon: AppLineIcons.person, label: 'Profile'),
  ];

  Future<List<int>> pumpBar(
    WidgetTester tester, {
    int currentIndex = 0,
    List<AppNavTab> tabs = customerTabs,
  }) async {
    final taps = <int>[];
    await pumpThemed(
      tester,
      AppBottomNavBar(tabs: tabs, currentIndex: currentIndex, onTap: taps.add),
    );
    return taps;
  }

  group('AppBottomNavBar', () {
    testWidgets('renders one item per tab, labelled', (tester) async {
      await pumpBar(tester);

      for (final tab in customerTabs) {
        expect(find.text(tab.label), findsOneWidget);
      }
    });

    testWidgets('reports the index that was tapped', (tester) async {
      final taps = await pumpBar(tester);

      await tester.tap(find.text('Bookings'));
      await tester.pump();
      await tester.tap(find.text('Profile'));
      await tester.pump();

      expect(taps, [1, 2]);
    });

    // Labels sit at the `s` token, sentence case. They used to be the design's
    // 11 — smaller than body — and `f9f4138` bumped icon and label sizes
    // together: at 11 the words under the enlarged icons read as a caption
    // rather than as the bar's own labels. The size is pinned to the token it
    // comes from rather than to a literal, because `.sp` scales it by the
    // window the test happens to run in.
    //
    // What the rest of the test protects has not moved: the family and tracking
    // come from `labelMedium`, not `labelSmall`, which is the same 11 but is
    // the *uppercase* micro-label and carries wide tracking with it — on a
    // sentence-case word like "Prenotazioni" that reads as spaced-out rather
    // than as a label.
    testWidgets(
      'labels are at the label token size, without the micro-label tracking',
      (tester) async {
        late TextStyle labelMedium;
        late double labelSize;
        await pumpThemed(
          tester,
          Builder(
            builder: (context) {
              labelMedium = context.textTheme.labelMedium!;
              labelSize = context.fonts.xxs.sp;
              return const AppBottomNavBar(
                tabs: customerTabs,
                currentIndex: 0,
                onTap: _ignore,
              );
            },
          ),
        );

        // Scoped to the bar: `pumpThemed` mounts a `Scaffold`, which carries an
        // `AnimatedDefaultTextStyle` of its own at body size.
        final styles = tester
            .widgetList<AnimatedDefaultTextStyle>(
              find.descendant(
                of: find.byType(AppBottomNavBar),
                matching: find.byType(AnimatedDefaultTextStyle),
              ),
            )
            .map((widget) => widget.style)
            .toList();

        expect(styles, hasLength(customerTabs.length));
        for (final style in styles) {
          expect(style.fontSize, labelSize);
          expect(style.fontFamily, labelMedium.fontFamily);
          expect(
            style.letterSpacing ?? 0,
            lessThan(AppTypography.trackingWide),
          );
        }
        expect(styles.first.fontWeight, FontWeight.w700);
        expect(styles.last.fontWeight, FontWeight.w500);
      },
    );

    testWidgets('a screen reader hears which tab is selected', (tester) async {
      await pumpBar(tester, currentIndex: 2);

      final handle = tester.ensureSemantics();
      expect(
        tester.getSemantics(find.text('Profile')),
        matchesSemantics(
          label: 'Profile',
          isSelected: true,
          hasSelectedState: true,
          isButton: true,
          hasTapAction: true,
        ),
      );
      handle.dispose();
    });

    // A bar that crashes the app over a stale index is the worse failure.
    testWidgets('an out-of-range index selects nothing rather than throwing', (
      tester,
    ) async {
      await pumpBar(tester, currentIndex: 7);

      expect(tester.takeException(), isNull);
      expect(find.byType(AppLineIcon), findsNWidgets(customerTabs.length));
    });

    testWidgets('every tab clears the platform touch target', (tester) async {
      await pumpBar(tester);

      for (final tab in customerTabs) {
        final size = tester.getSize(
          find
              .ancestor(
                of: find.text(tab.label),
                matching: find.byType(ConstrainedBox),
              )
              .first,
        );
        expect(
          size.height,
          greaterThanOrEqualTo(AppComponentSizes.bottomNavItemMinHeight),
        );
      }
    });

    /// The tab's own slot, not the label inside it — a `Text` sizes to its
    /// glyphs and would read the same whatever share of the bar it sits in.
    double slotWidth(WidgetTester tester, String label) => tester
        .getSize(
          find
              .ancestor(
                of: find.text(label),
                matching: find.byType(ConstrainedBox),
              )
              .first,
        )
        .width;

    testWidgets('tabs share the bar evenly, so fewer means wider', (
      tester,
    ) async {
      await pumpBar(tester);
      final customerWidth = slotWidth(tester, 'Home');

      await pumpBar(
        tester,
        tabs: const [
          AppNavTab(icon: AppLineIcons.calendar, label: 'Home'),
          AppNavTab(icon: AppLineIcons.person, label: 'Profile'),
        ],
      );

      // Same label, more room.
      expect(slotWidth(tester, 'Home'), greaterThan(customerWidth));
    });
  });
}

void _ignore(int _) {}

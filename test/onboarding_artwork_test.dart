import 'package:booknow_mobile/features/onboarding/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// The sample figures on the onboarding slides are copy, so they live in the
/// translation files. They used to be string literals in the widget, which
/// meant the English build still read "Marco R." and "€18,00".
void main() {
  for (final locale in AppLocale.values) {
    group(locale.languageTag, () {
      setUp(() => LocaleSettings.setLocale(locale));
      tearDown(() => LocaleSettings.setLocale(AppLocale.it));

      testWidgets('the price slide reads its amounts from the translations', (
        tester,
      ) async {
        await pumpThemed(tester, const Center(child: PriceArtwork()));
        final t = locale.buildSync().onboarding.slideTwo;

        expect(find.text(t.serviceAmount), findsOneWidget);
        expect(find.text(t.feeAmount), findsOneWidget);
      });

      testWidgets('the agenda slide reads its rows from the translations', (
        tester,
      ) async {
        await pumpThemed(tester, const Center(child: AgendaArtwork()));
        final t = locale.buildSync().onboarding.slideThree;

        expect(find.text(t.agendaBookedTime), findsOneWidget);
        expect(find.text(t.agendaBookedName), findsOneWidget);
        expect(find.text(t.agendaFreeTime), findsOneWidget);
        expect(find.text(t.agendaFree), findsOneWidget);
      });
    });
  }

  test('the two locales really do differ, so the test could fail', () {
    expect(
      AppLocale.it.buildSync().onboarding.slideTwo.feeAmount,
      isNot(AppLocale.en.buildSync().onboarding.slideTwo.feeAmount),
    );
  });
}

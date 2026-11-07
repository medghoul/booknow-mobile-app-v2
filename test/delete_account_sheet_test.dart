import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/profile/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  final t = AppLocale.en.buildSync();
  final sheet = t.profile.deleteSheet;

  const shop = Shop(
    id: 'shop-1',
    status: ShopStatus.active,
    name: 'Barbieri Navona',
    openingHours: OpeningHours({}),
    services: [],
  );

  const owner = UserProfile(
    id: 'u1',
    name: 'Marco Rinaldi',
    email: 'marco@example.com',
    role: UserRole.owner,
  );

  /// Pumps a button that raises the sheet, and records what it resolved to.
  Future<List<bool>> pumpSheet(
    WidgetTester tester, {
    required List<DeleteConsequence> consequences,
  }) async {
    final answers = <bool>[];

    await pumpThemed(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () async => answers.add(
            await DeleteAccountSheet.confirm(
              context,
              consequences: consequences,
            ),
          ),
          child: const Text('open'),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    return answers;
  }

  group('DeleteAccountSheet', () {
    final consequences = [
      DeleteConsequence.loss(
        sheet.shopLost(name: 'Barbieri Navona'),
        emphasis: 'Barbieri Navona',
      ),
      DeleteConsequence.loss(sheet.historyLost),
      const DeleteConsequence.fact('The €1.49 already paid is not refunded.'),
    ];

    // The whole reason this is a sheet and not a "are you sure?" alert: it
    // says what is about to be lost, so the answer is not always yes.
    testWidgets('spells out every consequence', (tester) async {
      await pumpSheet(tester, consequences: consequences);

      expect(find.text(sheet.title), findsOneWidget);
      expect(find.textContaining(sheet.body), findsOneWidget);
      expect(find.text(sheet.confirm), findsOneWidget);
      expect(find.text(sheet.keep), findsOneWidget);

      for (final consequence in consequences) {
        expect(
          find.textContaining(consequence.text, findRichText: true),
          findsOneWidget,
          reason: 'missing: ${consequence.text}',
        );
      }
    });

    testWidgets('confirming resolves true', (tester) async {
      final answers = await pumpSheet(tester, consequences: consequences);

      await tester.tap(find.text(sheet.confirm));
      await tester.pumpAndSettle();

      expect(answers, [true]);
    });

    testWidgets('cancelling resolves false', (tester) async {
      final answers = await pumpSheet(tester, consequences: consequences);

      await tester.tap(find.text(sheet.keep));
      await tester.pumpAndSettle();

      expect(answers, [false]);
    });

    // A dragged-away sheet is a no, not an unanswered question — a caller
    // that forgot a null check must not read a dismissal as consent.
    testWidgets('dismissing resolves false, never null', (tester) async {
      final answers = await pumpSheet(tester, consequences: consequences);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(answers, [false]);
    });
  });

  group('ProfileView.deleteConsequences', () {
    Future<List<DeleteConsequence>> consequencesFor(
      WidgetTester tester, {
      required UserProfile user,
      Shop? shop,
    }) async {
      late List<DeleteConsequence> consequences;

      final view = ProfileView(
        user: user,
        shop: shop,
        notificationsEnabled: true,
        themeMode: ThemeMode.system,
        onThemeModeChanged: (_) {},
        onSignOut: () {},
      );

      await pumpThemed(
        tester,
        Builder(
          builder: (context) {
            consequences = view.deleteConsequences(context);
            return const SizedBox.shrink();
          },
        ),
      );

      return consequences;
    }

    testWidgets('an owner is told their shop goes, by name', (tester) async {
      final consequences = await consequencesFor(
        tester,
        user: owner,
        shop: shop,
      );

      expect(consequences.first.text, contains('Barbieri Navona'));
      expect(consequences.first.emphasis, 'Barbieri Navona');
      expect(consequences.last.text, sheet.historyLost);
    });

    testWidgets('an unnamed draft shop still counts as a shop', (tester) async {
      final consequences = await consequencesFor(
        tester,
        user: owner,
        shop: const Shop(
          id: 'shop-1',
          status: ShopStatus.draft,
          openingHours: OpeningHours({}),
          services: [],
        ),
      );

      expect(consequences.first.text, sheet.shopLostUnnamed);
      expect(consequences.first.emphasis, isNull);
    });

    // A name that is only spaces is no name. Without the trim the sentence
    // reads "Il negozio  e tutte le sue prenotazioni…" with a hole in it.
    testWidgets('a blank name is no name', (tester) async {
      final consequences = await consequencesFor(
        tester,
        user: owner,
        shop: const Shop(
          id: 'shop-1',
          status: ShopStatus.draft,
          name: '   ',
          openingHours: OpeningHours({}),
          services: [],
        ),
      );

      expect(consequences.first.text, sheet.shopLostUnnamed);
      expect(consequences.first.emphasis, isNull);
    });

    // A customer has no shop, so nothing should promise them one is going.
    testWidgets('a customer is never told about a shop', (tester) async {
      final consequences = await consequencesFor(
        tester,
        user: const UserProfile(
          id: 'u2',
          name: 'Giulia Conti',
          email: 'giulia@example.com',
          role: UserRole.customer,
        ),
      );

      expect(consequences, hasLength(1));
      expect(consequences.single.text, sheet.historyLost);
    });

    testWidgets('an owner who has not started a shop loses no shop', (
      tester,
    ) async {
      final consequences = await consequencesFor(tester, user: owner);

      expect(consequences.single.text, sheet.historyLost);
    });
  });

  group('the delete row', () {
    var deletions = 0;

    /// The row is the last one on the screen, so it starts below the fold of
    /// the test viewport.
    Future<void> tapDelete(WidgetTester tester) async {
      final row = find.text(t.profile.deleteAccount);
      await tester.scrollUntilVisible(row, 200);
      await tester.pumpAndSettle();
      await tester.tap(row);
      await tester.pumpAndSettle();
    }

    Future<void> pumpProfile(WidgetTester tester) async {
      deletions = 0;

      await pumpThemed(
        tester,
        ProfileView(
          user: owner,
          shop: shop,
          notificationsEnabled: true,
          themeMode: ThemeMode.system,
          onThemeModeChanged: (_) {},
          onSignOut: () {},
          onDeleteAccount: () => deletions++,
        ),
      );
    }

    // The sheet is raised by the view, not left to the caller: there is no
    // way to reach `onDeleteAccount` without having been shown the cost.
    testWidgets('asks before it deletes anything', (tester) async {
      await pumpProfile(tester);
      await tapDelete(tester);

      expect(find.text(sheet.title), findsOneWidget);
      expect(deletions, 0);
    });

    testWidgets('names the shop that is about to go', (tester) async {
      await pumpProfile(tester);
      await tapDelete(tester);

      expect(
        find.textContaining('Barbieri Navona', findRichText: true),
        findsWidgets,
      );
    });

    testWidgets('cancelling deletes nothing', (tester) async {
      await pumpProfile(tester);
      await tapDelete(tester);

      await tester.tap(find.text(sheet.keep));
      await tester.pumpAndSettle();

      expect(find.text(sheet.title), findsNothing);
      expect(deletions, 0);
    });

    testWidgets('confirming deletes, once', (tester) async {
      await pumpProfile(tester);
      await tapDelete(tester);

      await tester.tap(find.text(sheet.confirm));
      await tester.pumpAndSettle();

      expect(deletions, 1);
    });

    // A row with nowhere to go stays inert, and must not raise a sheet that
    // asks about something it cannot do.
    testWidgets('stays inert while there is nothing to delete to', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        ProfileView(
          user: owner,
          shop: shop,
          notificationsEnabled: true,
          themeMode: ThemeMode.system,
          onThemeModeChanged: (_) {},
          onSignOut: () {},
        ),
      );
      await tapDelete(tester);

      expect(find.text(sheet.title), findsNothing);
    });
  });
}

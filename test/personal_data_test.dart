import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/profile/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

void main() {
  final t = AppLocale.en.buildSync();
  final copy = t.profile.personal;

  const customer = UserProfile(
    id: 'u1',
    name: 'Marco Rinaldi',
    email: 'marco.rinaldi@icloud.com',
    role: UserRole.customer,
    phone: '347 8821 940',
  );

  final owner = customer.copyWith(role: UserRole.owner);

  Future<List<({String name, String phone})>> pumpForm(
    WidgetTester tester, {
    UserProfile? user,
    AuthProviderKind? provider = AuthProviderKind.apple,
    String? shopName,
    List<VoidCallback>? cancels,
  }) async {
    final saves = <({String name, String phone})>[];

    await pumpThemed(
      tester,
      PersonalDataView(
        user: user ?? customer,
        provider: provider,
        shopName: shopName,
        onSaved: ({required name, required phone}) =>
            saves.add((name: name, phone: phone)),
        onCancel: () => cancels?.add(() {}),
      ),
    );

    return saves;
  }

  group('PersonalDataView · copy', () {
    testWidgets('a customer is told the phone is optional and who sees it', (
      tester,
    ) async {
      await pumpForm(tester);

      expect(find.text(copy.phoneLabelCustomer), findsOneWidget);
      expect(find.text(copy.phoneHelperCustomer), findsOneWidget);
      expect(find.text(copy.initialsNote), findsOneWidget);
      expect(find.text(copy.phoneLabelOwner), findsNothing);
    });

    // An owner's own number is not the shop's, and the shop's is edited on a
    // different screen. Saying so is the whole point of the second variant.
    testWidgets('an owner is told this number is not the shop one', (
      tester,
    ) async {
      await pumpForm(tester, user: owner, shopName: 'Barbieri Navona');

      expect(find.text(copy.phoneLabelOwner), findsOneWidget);
      expect(find.text(copy.phoneHelperOwner), findsOneWidget);
      expect(find.text(copy.ownerOf(shop: 'Barbieri Navona')), findsOneWidget);
      expect(find.text(copy.phoneLabelCustomer), findsNothing);
    });

    // Mid-wizard: they are an owner of nothing yet, so there is no shop to
    // be titolare of.
    testWidgets('an owner without a shop falls back to the initials note', (
      tester,
    ) async {
      await pumpForm(tester, user: owner);

      expect(find.text(copy.initialsNote), findsOneWidget);
    });

    testWidgets('the email names the provider that manages it', (tester) async {
      await pumpForm(tester, provider: AuthProviderKind.google);
      expect(find.text(copy.emailGoogle), findsOneWidget);

      await pumpForm(tester, provider: null);
      expect(find.text(copy.emailProvider), findsOneWidget);
    });
  });

  group('PersonalDataView · fields', () {
    testWidgets('the email is shown and cannot be edited', (tester) async {
      await pumpForm(tester);

      final email = tester.widget<TextFormField>(
        find.ancestor(
          of: find.text('marco.rinaldi@icloud.com'),
          matching: find.byType(TextFormField),
        ),
      );

      expect(email.enabled, isFalse, reason: 'the address is the provider\'s');
    });

    // The dial code is drawn, never typed, so it must not come back as part
    // of the number.
    testWidgets('the phone shows +39 without it being in the value', (
      tester,
    ) async {
      final saves = await pumpForm(tester);

      expect(find.text('+39'), findsOneWidget);

      await tester.tap(find.text(t.common.save));
      await tester.pump();

      expect(saves.single.phone, '347 8821 940');
    });
  });

  group('PersonalDataView · saving', () {
    testWidgets('save reports the trimmed name and phone', (tester) async {
      final saves = await pumpForm(tester);

      await tester.enterText(
        find.byType(TextFormField).first,
        '  Marco Rinaldi  ',
      );
      await tester.tap(find.text(t.common.save));
      await tester.pump();

      expect(saves.single.name, 'Marco Rinaldi');
    });

    // Emptying the field is how the number is removed, so it has to reach the
    // caller as an empty string rather than being dropped on the way.
    testWidgets('clearing the phone reports an empty one, not nothing', (
      tester,
    ) async {
      final saves = await pumpForm(tester);

      await tester.enterText(find.text('347 8821 940'), '');
      await tester.tap(find.text(t.common.save));
      await tester.pump();

      expect(saves.single.phone, isEmpty);
    });

    testWidgets('a blank name is refused before anything is sent', (
      tester,
    ) async {
      final saves = await pumpForm(tester);

      await tester.enterText(find.byType(TextFormField).first, '   ');
      await tester.tap(find.text(t.common.save));
      await tester.pump();

      expect(saves, isEmpty);
      expect(find.text(copy.nameRequired), findsOneWidget);
    });

    testWidgets('cancel reports without saving', (tester) async {
      final cancels = <VoidCallback>[];
      final saves = await pumpForm(tester, cancels: cancels);

      await tester.tap(find.text(t.common.cancel));
      await tester.pump();

      expect(cancels, hasLength(1));
      expect(saves, isEmpty);
    });
  });
}

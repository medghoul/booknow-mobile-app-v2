import 'package:booknow_mobile/core/services/launcher/link_service.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/support/support_message.dart';
import 'package:booknow_mobile/features/support/widgets/help_contacts_list.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

const _supportEmail = 'supporto@booknow.app';

const _configured =
    'SUPPORT_EMAIL=$_supportEmail\n'
    'TERMS_URL=https://booknow.app/termini\n'
    'PRIVACY_URL=https://booknow.app/privacy';

/// Records what the screen asked the phone to open, and whether the phone
/// took it. The real one reaches for a platform channel that is not there in
/// a test.
class _FakeLinks extends LinkService {
  _FakeLinks({this.succeeds = true});

  final bool succeeds;
  final List<Uri> opened = [];

  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    return succeeds;
  }
}

/// The subject and body as the mail app would read them.
Map<String, String> partsOf(Uri mailto) {
  return {
    for (final pair in mailto.query.split('&'))
      pair.split('=').first: Uri.decodeComponent(pair.split('=').last),
  };
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final t = AppLocale.en.buildSync();
  final help = t.help;

  setUp(() => dotenv.loadFromString(envString: _configured));
  tearDown(dotenv.clean);

  group('SupportMessage', () {
    const message = SupportMessage(
      topic: SupportTopic.payment,
      body: '  Il rimborso non è arrivato  ',
      from: 'marco@icloud.com',
      role: UserRole.customer,
      appVersion: '0.1.0',
    );

    test('addresses support and names the topic in the subject', () {
      final uri = message.mailto(_supportEmail, t);

      expect(uri.scheme, 'mailto');
      expect(uri.path, _supportEmail);
      expect(partsOf(uri)['subject'], help.mail.subject(topic: 'Payment'));
    });

    // `Uri(queryParameters:)` encodes a space as `+`, which mail clients show
    // literally — the subject would arrive as "BookNow+—+Payment".
    test('spaces reach the mail app as spaces, not plusses', () {
      final uri = message.mailto(_supportEmail, t);

      expect(uri.query, isNot(contains('+')));
      expect(partsOf(uri)['subject'], contains(' '));
    });

    // Support has no ticket to look any of this up in, so it travels with the
    // message or not at all.
    test('the body carries the account, the role and the build', () {
      final body = partsOf(message.mailto(_supportEmail, t))['body']!;

      expect(body, startsWith('Il rimborso non è arrivato'));
      expect(body, contains('${help.mail.account}: marco@icloud.com'));
      expect(body, contains('${help.mail.role}: ${help.mail.roleCustomer}'));
      expect(body, contains('${help.mail.appVersion}: 0.1.0'));
    });

    test('an owner is labelled as one', () {
      const owner = SupportMessage(
        topic: SupportTopic.account,
        body: 'ciao',
        role: UserRole.owner,
      );

      final body = partsOf(owner.mailto(_supportEmail, t))['body']!;

      expect(body, contains('${help.mail.role}: ${help.mail.roleOwner}'));
    });

    test('a message with nothing to attach is only the message', () {
      const bare = SupportMessage(topic: SupportTopic.other, body: 'ciao');

      expect(partsOf(bare.mailto(_supportEmail, t))['body'], 'ciao');
    });
  });

  group('HelpContactsList', () {
    late _FakeLinks links;

    Future<void> pumpHelp(
      WidgetTester tester, {
      String? shopPhone,
      String? appVersion = '0.1.0',
      bool succeeds = true,
    }) async {
      links = _FakeLinks(succeeds: succeeds);

      await pumpThemed(
        tester,
        HelpContactsList(
          appVersion: appVersion,
          shopPhone: shopPhone,
          replyTo: 'marco@icloud.com',
          role: UserRole.customer,
          links: links,
        ),
      );
    }

    testWidgets('opens on the first answer, with the rest folded away', (
      tester,
    ) async {
      await pumpHelp(tester);

      expect(find.text(help.faq.feeQuestion), findsOneWidget);
      expect(find.text(help.faq.feeAnswer), findsOneWidget);
      expect(find.text(help.faq.cancelQuestion), findsOneWidget);
      expect(find.text(help.faq.cancelAnswer), findsNothing);
    });

    // One answer at a time: four open answers is a page of prose, not a list
    // of questions.
    testWidgets('opening an answer closes the one before it', (tester) async {
      await pumpHelp(tester);

      await tester.tap(find.text(help.faq.refundQuestion));
      await tester.pumpAndSettle();

      expect(find.text(help.faq.refundAnswer), findsOneWidget);
      expect(find.text(help.faq.feeAnswer), findsNothing);
    });

    testWidgets('tapping the open question closes it', (tester) async {
      await pumpHelp(tester);

      await tester.tap(find.text(help.faq.feeQuestion));
      await tester.pumpAndSettle();

      expect(find.text(help.faq.feeAnswer), findsNothing);
    });

    // A row with nothing behind it is not shown greyed out — it is not shown.
    testWidgets('there is no call row without a shop to call', (tester) async {
      await pumpHelp(tester);

      expect(find.text(help.callShop), findsNothing);
      expect(find.text(help.needMore.toUpperCase()), findsOneWidget);
      expect(find.text(help.writeUs), findsOneWidget);
    });

    testWidgets('the call row dials the number without its spacing', (
      tester,
    ) async {
      await pumpHelp(tester, shopPhone: '+39 06 6880 1234');

      await tester.tap(find.text(help.callShop));
      await tester.pumpAndSettle();

      expect(links.opened.single, Uri.parse('tel:+390668801234'));
    });

    testWidgets('a phone that will not dial says so', (tester) async {
      await pumpHelp(tester, shopPhone: '06 6880 1234', succeeds: false);

      await tester.tap(find.text(help.callShop));
      await tester.pumpAndSettle();

      expect(find.text(help.callFailed), findsOneWidget);
    });

    testWidgets('the footer names the build and links the two documents', (
      tester,
    ) async {
      await pumpHelp(tester);

      expect(find.text(help.version(version: '0.1.0')), findsOneWidget);

      await tester.tap(find.text(help.terms));
      await tester.pumpAndSettle();

      expect(links.opened.single, Uri.parse('https://booknow.app/termini'));
    });

    // An app that shows "Termini" and opens nothing is worse than one that
    // shows only its version.
    testWidgets('an unconfigured build shows no links and no contact', (
      tester,
    ) async {
      // A build that was never told the addresses: the keys are absent.
      dotenv.loadFromString(envString: 'ENVIRONMENT=test');
      await pumpHelp(tester);

      expect(find.text(help.terms), findsNothing);
      expect(find.text(help.privacy), findsNothing);
      expect(find.text(help.writeUs), findsNothing);
      // The heading goes with the card: no rows, no empty rounded box.
      expect(find.text(help.needMore.toUpperCase()), findsNothing);
      expect(find.text(help.version(version: '0.1.0')), findsOneWidget);
    });
  });

  group('ContactSupportSheet', () {
    late _FakeLinks links;

    Future<void> openSheet(WidgetTester tester, {bool succeeds = true}) async {
      links = _FakeLinks(succeeds: succeeds);

      await pumpThemed(
        tester,
        HelpContactsList(
          appVersion: '0.1.0',
          replyTo: 'marco@icloud.com',
          role: UserRole.customer,
          links: links,
        ),
      );

      await tester.tap(find.text(help.writeUs));
      await tester.pumpAndSettle();
    }

    testWidgets('writing to support continues the task, in a sheet', (
      tester,
    ) async {
      await openSheet(tester);

      expect(find.byType(AppBottomSheet), findsOneWidget);
      expect(
        find.text(help.write.replyTo(email: 'marco@icloud.com')),
        findsOneWidget,
      );
    });

    // The design shows "Pagamento" already selected. A prefilled topic is the
    // one nobody corrects, and it decides who reads the mail.
    testWidgets('Invia waits for a topic as well as a message', (tester) async {
      await openSheet(tester);

      await tester.enterText(
        find.byType(TextFormField),
        'Non vedo il rimborso',
      );
      await tester.pump();
      await tester.tap(find.text(help.write.send));
      await tester.pumpAndSettle();

      expect(links.opened, isEmpty);

      await tester.tap(find.text(help.topics.booking));
      await tester.pump();
      await tester.tap(find.text(help.write.send));
      await tester.pumpAndSettle();

      expect(links.opened, hasLength(1));
    });

    // The design wraps the four topics two to a row. A chip that stretches
    // to the full width reads as a list of options, and it pushes the message
    // field and Invia off the bottom of the sheet.
    testWidgets('topics sit beside each other, not one per row', (
      tester,
    ) async {
      await openSheet(tester);

      final payment = find.widgetWithText(
        AnimatedContainer,
        help.topics.payment,
      );
      final booking = find.widgetWithText(
        AnimatedContainer,
        help.topics.booking,
      );

      expect(tester.getTopLeft(payment).dy, tester.getTopLeft(booking).dy);
      expect(
        tester.getSize(payment).width,
        lessThan(tester.getSize(find.byType(Wrap)).width / 2),
      );
    });

    testWidgets('the chosen topic is what support sees', (tester) async {
      await openSheet(tester);

      await tester.enterText(
        find.byType(TextFormField),
        'Non vedo il rimborso',
      );
      await tester.tap(find.text(help.topics.account));
      await tester.pump();
      await tester.tap(find.text(help.write.send));
      await tester.pumpAndSettle();

      final sent = partsOf(links.opened.single);
      expect(links.opened.single.path, _supportEmail);
      expect(sent['subject'], help.mail.subject(topic: help.topics.account));
      expect(sent['body'], startsWith('Non vedo il rimborso'));
    });

    testWidgets('a sent message closes the sheet and says where it went', (
      tester,
    ) async {
      await openSheet(tester);

      await tester.enterText(find.byType(TextFormField), 'Ciao');
      await tester.tap(find.text(help.topics.other));
      await tester.pump();
      await tester.tap(find.text(help.write.send));
      await tester.pumpAndSettle();

      expect(find.byType(AppBottomSheet), findsNothing);
      expect(find.text(help.write.opened), findsOneWidget);
    });

    // Closing on failure would throw away what the user wrote in exchange for
    // an error message.
    testWidgets('no mail app keeps the message in the sheet', (tester) async {
      await openSheet(tester, succeeds: false);

      await tester.enterText(find.byType(TextFormField), 'Ciao');
      await tester.tap(find.text(help.topics.payment));
      await tester.pump();
      await tester.tap(find.text(help.write.send));
      await tester.pumpAndSettle();

      expect(find.byType(AppBottomSheet), findsOneWidget);
      expect(find.text('Ciao'), findsOneWidget);
      expect(
        find.text(help.write.noMailApp(email: _supportEmail)),
        findsOneWidget,
      );
    });
  });
}

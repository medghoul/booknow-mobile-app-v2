import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/profile/cubit/profile_cubit.dart';
import 'package:booknow_mobile/features/profile/widgets/index.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// A customer's repository: no shop, no failure.
class _NoShopRepository implements ShopRepository {
  @override
  Future<ApiResult<Shop?>> getMyShop() async => const ApiResult.success(null);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Answers for the OS without a platform channel.
class _FakePush extends PushService {
  _FakePush({required this.isAllowed});

  final bool isAllowed;

  int reads = 0;

  @override
  Future<bool> hasPermission() async {
    reads++;
    return isAllowed;
  }
}

void main() {
  final t = AppLocale.en.buildSync();

  const openWeek = OpeningHours({
    Weekday.tuesday: [TimeRange(from: '09:00', to: '13:00')],
    Weekday.wednesday: [TimeRange(from: '09:00', to: '13:00')],
    Weekday.thursday: [TimeRange(from: '09:00', to: '13:00')],
    Weekday.friday: [TimeRange(from: '09:00', to: '13:00')],
    Weekday.saturday: [TimeRange(from: '09:00', to: '13:00')],
  });

  final shop = Shop(
    id: 'shop-1',
    status: ShopStatus.active,
    name: 'Barbieri Navona',
    phone: '+39 06 6880 1234',
    address: const ShopAddress(
      line: 'Via dei Coronari 18',
      city: 'Roma',
      zip: '00186',
      country: 'IT',
    ),
    openingHours: openWeek,
    services: const [
      ShopService(
        id: 's1',
        name: 'Taglio',
        durationMinutes: 30,
        priceCents: 2000,
      ),
      ShopService(
        id: 's2',
        name: 'Barba',
        durationMinutes: 20,
        priceCents: 1500,
      ),
    ],
  );

  group('ProfileHeader.initialsOf', () {
    test('takes the first letter of the first two words', () {
      expect(ProfileHeader.initialsOf('Marco Rinaldi'), 'MR');
    });

    test('a single name gives one letter, not the same one twice', () {
      expect(ProfileHeader.initialsOf('Marco'), 'M');
    });

    test('extra words past the second are ignored', () {
      expect(ProfileHeader.initialsOf('Maria Teresa De Luca'), 'MT');
    });

    // A blank name must not be an index error on the one screen that always
    // renders it.
    test('a blank name gives nothing rather than throwing', () {
      expect(ProfileHeader.initialsOf('   '), '');
      expect(ProfileHeader.initialsOf(''), '');
    });

    test('collapses runs of whitespace', () {
      expect(ProfileHeader.initialsOf('  Marco   Rinaldi '), 'MR');
    });
  });

  group('ProfileShopSection.detailsOf', () {
    test('joins the address and the phone', () {
      expect(
        ProfileShopSection.detailsOf(shop),
        'Via dei Coronari 18 · +39 06 6880 1234',
      );
    });

    // A dangling separator is how a half-finished shop looks broken rather
    // than unfinished.
    test('drops the separator when only one half is there', () {
      expect(
        ProfileShopSection.detailsOf(shop.copyWith(phone: null)),
        'Via dei Coronari 18',
      );
      expect(
        ProfileShopSection.detailsOf(shop.copyWith(address: null)),
        '+39 06 6880 1234',
      );
    });

    test('a shop with neither reads as nothing at all', () {
      expect(
        ProfileShopSection.detailsOf(shop.copyWith(address: null, phone: null)),
        isNull,
      );
    });
  });

  group('ProfileShopSection.openDaysLabel', () {
    test('a run of days compresses to a range', () {
      expect(ProfileShopSection.openDaysLabel(openWeek, t), 'Tue–Sat');
    });

    // A barber closed on Wednesday is not "Tue–Sat", and saying so would be a
    // lie about when the shop is open.
    test('a gap in the week is listed, never compressed', () {
      final withGap = openWeek.closeDay(Weekday.wednesday);
      expect(
        ProfileShopSection.openDaysLabel(withGap, t),
        'Tue, Thu, Fri, Sat',
      );
    });

    test('one open day is named, not turned into a range', () {
      const single = OpeningHours({
        Weekday.monday: [TimeRange(from: '09:00', to: '13:00')],
      });
      expect(ProfileShopSection.openDaysLabel(single, t), 'Mon');
    });

    test('a shop with no hours yet has no label', () {
      expect(ProfileShopSection.openDaysLabel(const OpeningHours(), t), isNull);
    });
  });

  group('ProfileShopSection', () {
    Future<void> pumpSection(
      WidgetTester tester, {
      Shop? override,
      bool withBookingRules = true,
    }) => pumpThemed(
      tester,
      ProfileShopSection(
        shop: override ?? shop,
        onOpenShop: () {},
        onOpenServices: () {},
        onOpenHours: () {},
        onOpenBookingRules: withBookingRules ? () {} : null,
      ),
    );

    testWidgets('lists the shop and its three settings', (tester) async {
      await pumpSection(tester);

      expect(find.text('Barbieri Navona'), findsOneWidget);
      expect(find.text(t.profile.services), findsOneWidget);
      expect(find.text(t.profile.hours), findsOneWidget);
      expect(find.text(t.profile.bookingRules), findsOneWidget);
    });

    // The design stacks the shop's name over its address and phone; the rows
    // under it put their value on the right instead. Reading them the same
    // way loses which one the card is about.
    testWidgets('the shop name sits above its details, not beside them', (
      tester,
    ) async {
      await pumpSection(tester);

      final name = find.text('Barbieri Navona');
      final details = find.text(ProfileShopSection.detailsOf(shop)!);

      expect(
        tester.getTopLeft(details).dy,
        greaterThan(tester.getTopLeft(name).dy),
        reason: 'under the name',
      );
      expect(
        tester.getTopLeft(details).dx,
        tester.getTopLeft(name).dx,
        reason: 'and starting at the same edge, not pushed to the right',
      );
    });

    testWidgets('counts only the services that are still offered', (
      tester,
    ) async {
      await pumpSection(
        tester,
        override: shop.copyWith(
          services: [
            ...shop.services,
            const ShopService(
              id: 's3',
              name: 'Vecchio',
              durationMinutes: 10,
              priceCents: 500,
              isActive: false,
            ),
          ],
        ),
      );

      expect(find.text(t.profile.servicesCount(n: 2)), findsOneWidget);
    });

    testWidgets('a shop with no name falls back rather than showing blank', (
      tester,
    ) async {
      await pumpSection(tester, override: shop.copyWith(name: null));

      expect(find.text(t.profile.shopNameMissing), findsOneWidget);
    });

    testWidgets('an unset week says so instead of leaving the row empty', (
      tester,
    ) async {
      await pumpSection(
        tester,
        override: shop.copyWith(openingHours: const OpeningHours()),
      );

      expect(find.text(t.profile.hoursNone), findsOneWidget);
    });
  });

  group('ProfileIdentityCard', () {
    Future<void> pumpCard(
      WidgetTester tester, {
      AuthProviderKind? provider = AuthProviderKind.apple,
      VoidCallback? onEdit,
      String name = 'Marco Rinaldi',
    }) => pumpThemed(
      tester,
      ProfileIdentityCard(
        name: name,
        email: 'marco.rinaldi@icloud.com',
        provider: provider,
        onEdit: onEdit,
      ),
    );

    testWidgets('names the account, its address and its provider', (
      tester,
    ) async {
      await pumpCard(tester);

      expect(find.text('MR'), findsOneWidget);
      expect(find.text('Marco Rinaldi'), findsOneWidget);
      expect(find.text('marco.rinaldi@icloud.com'), findsOneWidget);
      expect(
        find.text(t.profile.signedInWith(provider: 'Apple')),
        findsOneWidget,
      );
    });

    // With Apple's private relay the address alone does not say which account
    // this is, so the provider line is the half that identifies it — and a
    // restored session that cannot name one must leave it out, not guess.
    testWidgets('says nothing at all when the provider is unknown', (
      tester,
    ) async {
      await pumpCard(tester, provider: null);

      expect(
        find.text(t.profile.signedInWith(provider: 'Apple')),
        findsNothing,
      );
      expect(
        find.text(t.profile.signedInWith(provider: 'Google')),
        findsNothing,
      );
      expect(find.text('marco.rinaldi@icloud.com'), findsOneWidget);
    });

    // Same rule as the settings rows' chevron: a control that leads nowhere
    // is a promise the screen does not keep.
    testWidgets('has no arrow while it has nowhere to go', (tester) async {
      await pumpCard(tester);
      expect(find.byType(AppLineIcon), findsNothing);

      await pumpCard(tester, onEdit: () {});
      expect(find.byType(AppLineIcon), findsOneWidget);
    });

    testWidgets('the whole card opens editing', (tester) async {
      var taps = 0;
      await pumpCard(tester, onEdit: () => taps++);

      await tester.tap(find.text('Marco Rinaldi'));
      await tester.pumpAndSettle();

      expect(taps, 1);
    });

    // The design stacks the three lines beside the avatar. Laid out in a row
    // instead they would each be clipped to a third of the width, and the
    // relay address is the first thing to go.
    testWidgets('the address and provider stack under the name', (
      tester,
    ) async {
      await pumpCard(tester);

      final name = tester.getTopLeft(find.text('Marco Rinaldi'));
      final email = tester.getTopLeft(find.text('marco.rinaldi@icloud.com'));
      final provider = tester.getTopLeft(
        find.text(t.profile.signedInWith(provider: 'Apple')),
      );

      expect(email.dy, greaterThan(name.dy));
      expect(provider.dy, greaterThan(email.dy));
      expect(email.dx, name.dx);
    });

    testWidgets('a long address is cut rather than overflowing the card', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        const ProfileIdentityCard(
          name: 'Maria Teresa De Luca',
          email: 'maria.teresa.de.luca.1990@a-very-long-mail-domain.example',
          provider: AuthProviderKind.google,
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });

  group('ProfileView', () {
    Future<void> pumpView(WidgetTester tester, UserRole role) => pumpThemed(
      tester,
      ProfileView(
        user: UserProfile(
          id: 'u1',
          name: 'Marco Rinaldi',
          email: 'marco@example.com',
          role: role,
        ),
        provider: AuthProviderKind.apple,
        notificationsEnabled: true,
        themeMode: ThemeMode.system,
        onThemeModeChanged: (_) {},
        onSignOut: () {},
      ),
    );

    testWidgets('a customer sees no shop section', (tester) async {
      await pumpView(tester, UserRole.customer);

      expect(find.byType(ProfileShopSection), findsNothing);
      expect(find.byType(ProfileAppearanceSection), findsOneWidget);
      expect(find.byType(ProfileExitButtons), findsOneWidget);
    });

    // Two different tops for the same screen: the owner's is compressed to
    // one line because the shop card leads, the customer's has the room.
    testWidgets('a customer leads with the identity card', (tester) async {
      await pumpView(tester, UserRole.customer);

      expect(find.byType(ProfileIdentityCard), findsOneWidget);
      expect(find.byType(ProfileHeader), findsNothing);
      expect(find.text(t.profile.title), findsOneWidget);
      expect(find.text('marco@example.com'), findsOneWidget);
    });

    testWidgets('an owner leads with the shop, and finds themselves after', (
      tester,
    ) async {
      await pumpView(tester, UserRole.owner);

      expect(find.byType(ProfileIdentityCard), findsNothing);
      expect(find.text(t.profile.shopTitle), findsOneWidget);
      expect(find.text(t.profile.yourAccount.toUpperCase()), findsOneWidget);
    });

    // `GET /me/shop` is still in flight when the tab is first built, so the
    // slot has to carry the change rather than cut: mid-transition the
    // spinner is still mounted, fading out under the card fading in.
    testWidgets('the shop card cross-fades in over the spinner', (
      tester,
    ) async {
      Future<void> pumpOwner({Shop? loaded, required bool isLoading}) =>
          pumpThemed(
            tester,
            ProfileView(
              user: UserProfile(
                id: 'u1',
                name: 'Marco Rinaldi',
                email: 'marco@example.com',
                role: UserRole.owner,
              ),
              shop: loaded,
              isLoadingShop: isLoading,
              notificationsEnabled: true,
              themeMode: ThemeMode.system,
              onThemeModeChanged: (_) {},
              onSignOut: () {},
            ),
            animations: true,
          );

      await pumpOwner(isLoading: true);

      expect(find.byType(AppLoader), findsOneWidget);
      expect(find.byType(ProfileShopSection), findsNothing);

      await pumpOwner(loaded: shop, isLoading: false);
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.byType(AppLoader),
        findsOneWidget,
        reason: 'the spinner is still fading out, not dropped on the frame',
      );
      expect(find.byType(ProfileShopSection), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(AppLoader), findsNothing);
      expect(find.byType(ProfileShopSection), findsOneWidget);
    });
  });

  group('ProfileAppearanceSection', () {
    Future<List<ThemeMode>> pumpAppearance(
      WidgetTester tester, {
      ThemeMode themeMode = ThemeMode.light,
    }) async {
      final chosen = <ThemeMode>[];
      await pumpThemed(
        tester,
        ProfileAppearanceSection(
          themeMode: themeMode,
          onThemeModeChanged: chosen.add,
        ),
      );
      return chosen;
    }

    testWidgets('offers light and dark, and reports the choice', (
      tester,
    ) async {
      final chosen = await pumpAppearance(tester);

      expect(find.text(t.profile.themeLight), findsOneWidget);
      await tester.tap(find.text(t.profile.themeDark));
      expect(chosen, [ThemeMode.dark]);
    });

    testWidgets('following the phone shows what it currently is', (
      tester,
    ) async {
      await pumpAppearance(tester, themeMode: ThemeMode.system);

      expect(find.text(t.profile.themeLight), findsOneWidget);
      expect(find.text(t.profile.themeDark), findsOneWidget);
    });
  });

  group('ProfileCubit', () {
    test('the notification row follows the phone, not the token', () async {
      final push = _FakePush(isAllowed: false);
      final cubit = ProfileCubit(_NoShopRepository(), push);

      expect(
        cubit.state.notificationsEnabled,
        isNull,
        reason: 'nothing is claimed before the OS has answered',
      );

      await cubit.refreshNotifications();

      expect(cubit.state.notificationsEnabled, isFalse);
      expect(push.reads, 1);
    });

    // The permission is revocable in the OS settings while the app is in the
    // background, so the screen asks again rather than keeping the answer.
    test('coming back to the screen asks the phone again', () async {
      final push = _FakePush(isAllowed: true);
      final cubit = ProfileCubit(_NoShopRepository(), push);

      await cubit.refreshNotifications();
      await cubit.refreshNotifications();

      expect(push.reads, 2);
      expect(cubit.state.notificationsEnabled, isTrue);
    });
  });
}

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_shop_section.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// The owner's team: who works in the shop (providers §9, §10).

const _cut = ShopService(
  id: 'cut',
  name: 'Taglio',
  durationMinutes: 30,
  priceCents: 1800,
);
const _beard = ShopService(
  id: 'beard',
  name: 'Barba',
  durationMinutes: 15,
  priceCents: 1000,
);

/// The owner's own provider, as the server resolves it: the shop's name.
const _owner = ShopProvider(id: 'shop-1', name: 'Barbieri Navona');
const _marco = ShopProvider(
  id: 'marco',
  name: 'Marco',
  serviceIds: ['cut'],
  timeOff: ['2099-12-27', '2099-12-28'],
  order: 1,
);
const _luca = ShopProvider(id: 'luca', name: 'Luca', isActive: false, order: 2);

class _Shops implements ShopRepository {
  _Shops(this.providers, {this.failWith});

  List<ShopProvider> providers;
  final NetworkException? failWith;

  final List<Map<String, Object?>> calls = [];

  Shop get _shop => Shop(
    id: 'shop-1',
    status: ShopStatus.active,
    name: 'Barbieri Navona',
    openingHours: const OpeningHours({
      Weekday.tuesday: [TimeRange(from: '09:00', to: '19:00')],
    }),
    services: const [_cut, _beard],
    providers: providers,
  );

  @override
  Future<ApiResult<Shop?>> getMyShop() async => ApiResult.success(_shop);

  @override
  Future<ApiResult<ShopProvider>> addProvider({
    required String name,
    required ProviderType type,
    required List<String>? serviceIds,
    required OpeningHours? openingHours,
    required List<String> timeOff,
  }) async {
    calls.add({
      'call': 'add',
      'name': name,
      'type': type,
      'serviceIds': serviceIds,
      'openingHours': openingHours,
      'timeOff': timeOff,
    });
    final added = ShopProvider(id: 'new', name: name, order: 9);
    providers = [...providers, added];
    return ApiResult.success(added);
  }

  @override
  Future<ApiResult<ShopProvider>> updateProvider(
    String providerId, {
    String? name,
    ProviderType? type,
    required List<String>? serviceIds,
    required OpeningHours? openingHours,
    required List<String> timeOff,
  }) async {
    calls.add({
      'call': 'update',
      'id': providerId,
      'name': name,
      'type': type,
      'serviceIds': serviceIds,
      'openingHours': openingHours,
      'timeOff': timeOff,
    });
    return ApiResult.success(providers.firstWhere((p) => p.id == providerId));
  }

  @override
  Future<ApiResult<void>> removeProvider(String providerId) async {
    calls.add({'call': 'remove', 'id': providerId});
    final failure = failWith;
    if (failure != null) return ApiResult.failure(failure);
    providers = [
      for (final p in providers)
        p.id == providerId ? p.copyWith(isActive: false) : p,
    ];
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<ShopProvider>> restoreProvider(String providerId) async {
    calls.add({'call': 'restore', 'id': providerId});
    providers = [
      for (final p in providers)
        p.id == providerId ? p.copyWith(isActive: true) : p,
    ];
    return ApiResult.success(providers.firstWhere((p) => p.id == providerId));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();
  final team = t.shopSetup.team;

  late _Shops shops;
  late ShopSetupCubit cubit;

  Future<void> pumpTeam(
    WidgetTester tester, {
    List<ShopProvider> providers = const [_owner, _marco, _luca],
    NetworkException? failWith,
  }) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    shops = _Shops(providers, failWith: failWith);
    cubit = ShopSetupCubit(shops);
    await cubit.start();
    addTearDown(cubit.close);

    await pumpThemed(
      tester,
      BlocProvider.value(value: cubit, child: const TeamList()),
    );
  }

  group('the team list', () {
    testWidgets('shows the owner first, marked, with nothing to remove', (
      tester,
    ) async {
      await pumpTeam(tester);

      expect(find.text('Barbieri Navona'), findsOneWidget);
      expect(find.text(team.you), findsOneWidget);
      // Only Marco has a menu: the owner's own provider cannot be removed,
      // and the server would refuse it.
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      expect(find.byTooltip(team.actionsFor(name: 'Marco')), findsOneWidget);
    });

    testWidgets('says what sets each person apart from the shop', (
      tester,
    ) async {
      await pumpTeam(tester);

      expect(
        find.text('${team.everyService} · ${team.shopHours}'),
        findsOneWidget,
      );
      expect(
        find.text(
          '${team.servicesCount(n: 1)} · ${team.shopHours} · '
          '${team.daysOff(n: 2)}',
        ),
        findsOneWidget,
      );
    });

    testWidgets('lists the removed apart, with the way back', (tester) async {
      await pumpTeam(tester);

      expect(find.text(team.removedSection.toUpperCase()), findsOneWidget);
      await tester.tap(find.text(team.restore));
      await tester.pumpAndSettle();

      expect(shops.calls.single, {'call': 'restore', 'id': 'luca'});
      expect(find.text(team.restored(name: 'Luca')), findsOneWidget);
      expect(find.text(team.removedSection.toUpperCase()), findsNothing);
    });

    testWidgets('removing asks first, then takes them off', (tester) async {
      await pumpTeam(tester);

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text(team.remove));
      await tester.pumpAndSettle();

      expect(find.text(team.removeTitle(name: 'Marco')), findsOneWidget);
      expect(shops.calls, isEmpty);

      await tester.tap(find.text(team.remove).last);
      await tester.pumpAndSettle();

      expect(shops.calls.single, {'call': 'remove', 'id': 'marco'});
      expect(find.text(team.removed(name: 'Marco')), findsOneWidget);
    });

    testWidgets('a refused removal says why and keeps them', (tester) async {
      await pumpTeam(
        tester,
        failWith: const Conflict(ApiErrorCode.providerInUse, null),
      );

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text(team.remove));
      await tester.pumpAndSettle();
      await tester.tap(find.text(team.remove).last);
      await tester.pumpAndSettle();

      expect(cubit.state.failure?.code, ApiErrorCode.providerInUse);
      expect(find.text(team.removed(name: 'Marco')), findsNothing);
      expect(find.text('Marco'), findsOneWidget);
    });
  });

  group('the editor', () {
    Future<void> save(WidgetTester tester, String label) async {
      final button = find.text(label);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
    }

    testWidgets('adds someone who does everything on the shop hours', (
      tester,
    ) async {
      await pumpTeam(tester, providers: const [_owner]);

      await tester.tap(find.text(team.add));
      await tester.pumpAndSettle();
      expect(find.text(team.newTitle), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Giulia');
      await save(tester, team.save);

      expect(shops.calls.single, {
        'call': 'add',
        'name': 'Giulia',
        'type': ProviderType.person,
        'serviceIds': null,
        'openingHours': null,
        'timeOff': <String>[],
      });
      expect(find.text(team.added), findsOneWidget);
    });

    testWidgets('a name is required', (tester) async {
      await pumpTeam(tester, providers: const [_owner]);

      await tester.tap(find.text(team.add));
      await tester.pumpAndSettle();
      await save(tester, team.save);

      expect(shops.calls, isEmpty);
    });

    // The owner's provider shows the shop's name until it is given one, and
    // sending it back unchanged would pin a copy a rename leaves behind.
    testWidgets("leaves the owner's name alone unless it changed", (
      tester,
    ) async {
      await pumpTeam(tester);

      await tester.tap(find.text('Barbieri Navona'));
      await tester.pumpAndSettle();
      await save(tester, team.saveChanges);

      final call = shops.calls.single;
      expect(call['call'], 'update');
      expect(call['id'], 'shop-1');
      expect(call['name'], isNull);
      expect(call['type'], isNull);
      expect(call['serviceIds'], isNull);
      expect(find.text(team.saved), findsOneWidget);
    });

    testWidgets('chooses services one by one', (tester) async {
      await pumpTeam(tester, providers: const [_owner]);

      await tester.tap(find.text(team.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Giulia');

      // Off "every service": everything starts chosen, and the owner takes
      // away what this person does not do.
      await tester.tap(find.byType(AppSwitch).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilterChip, 'Taglio'));
      await tester.pumpAndSettle();
      await save(tester, team.save);

      expect(shops.calls.single['serviceIds'], ['beard']);
    });

    testWidgets('refuses a person with no services chosen', (tester) async {
      await pumpTeam(tester, providers: const [_owner]);

      await tester.tap(find.text(team.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Giulia');
      await tester.tap(find.byType(AppSwitch).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilterChip, 'Taglio'));
      await tester.tap(find.widgetWithText(FilterChip, 'Barba'));
      await tester.pumpAndSettle();
      await save(tester, team.save);

      expect(find.text(team.noService), findsOneWidget);
      expect(shops.calls, isEmpty);
    });

    // Their own week starts from the shop's, so the owner trims rather than
    // building seven days from nothing.
    testWidgets("own hours start as a copy of the shop's", (tester) async {
      await pumpTeam(tester, providers: const [_owner]);

      await tester.tap(find.text(team.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Giulia');
      final same = find.byType(AppSwitch).last;
      await tester.ensureVisible(same);
      await tester.tap(same);
      await tester.pumpAndSettle();

      expect(find.text('09:00–19:00'), findsOneWidget);
      await save(tester, team.save);

      final hours = shops.calls.single['openingHours'] as OpeningHours?;
      expect(hours?.rangesOn(Weekday.tuesday), const [
        TimeRange(from: '09:00', to: '19:00'),
      ]);
    });

    testWidgets('keeps days off and drops the one taken away', (tester) async {
      await pumpTeam(tester);

      await tester.tap(find.text('Marco'));
      await tester.pumpAndSettle();
      final chip = find.byType(InputChip);
      expect(chip, findsNWidgets(2));

      final delete = find.descendant(
        of: chip.first,
        matching: find.byIcon(Icons.clear),
      );
      await tester.ensureVisible(delete);
      await tester.tap(delete);
      await tester.pumpAndSettle();
      await save(tester, team.saveChanges);

      expect(shops.calls.single['timeOff'], ['2099-12-28']);
      expect(shops.calls.single['serviceIds'], ['cut']);
    });
  });

  group('the profile row', () {
    testWidgets('reads "Just you" until someone else works there', (
      tester,
    ) async {
      final profile = t.profile;
      await pumpThemed(
        tester,
        SingleChildScrollView(
          child: ProfileShopSection(
            shop: const Shop(
              id: 'shop-1',
              status: ShopStatus.active,
              providers: [_owner, _luca],
            ),
            onOpenTeam: () {},
          ),
        ),
      );

      expect(find.text(profile.team), findsOneWidget);
      expect(find.text(profile.teamJustYou), findsOneWidget);
    });

    testWidgets('counts the people working', (tester) async {
      await pumpThemed(
        tester,
        SingleChildScrollView(
          child: ProfileShopSection(
            shop: const Shop(
              id: 'shop-1',
              status: ShopStatus.active,
              providers: [_owner, _marco, _luca],
            ),
            onOpenTeam: () {},
          ),
        ),
      );

      expect(find.text(t.profile.teamCount(n: 2)), findsOneWidget);
    });
  });

  group('reading providers', () {
    test('keeps "every service" and "the shop\'s hours" apart from empty', () {
      final providers = providersFrom([
        {
          'providerId': 'marco',
          'name': 'Marco',
          'type': 'resource',
          'serviceIds': <String>[],
          'openingHours': <String, dynamic>{},
          'timeOff': ['2026-12-27'],
          'active': false,
          'order': 2,
        },
        {
          'providerId': 'shop-1',
          'name': 'Barbieri Navona',
          'serviceIds': null,
          'openingHours': null,
          'order': 0,
        },
      ]);

      expect(providers.map((p) => p.id), ['shop-1', 'marco']);

      final [owner, marco] = providers;
      expect(owner.doesEveryService, isTrue);
      expect(owner.hasOwnHours, isFalse);
      expect(owner.type, ProviderType.person);
      expect(owner.isActive, isTrue);

      expect(marco.serviceIds, isEmpty);
      expect(marco.does('cut'), isFalse);
      expect(marco.hasOwnHours, isTrue);
      expect(marco.openingHours?.hasAnyOpenDay, isFalse);
      expect(marco.type, ProviderType.resource);
      expect(marco.timeOff, ['2026-12-27']);
      expect(marco.isActive, isFalse);
    });

    test("the customer's shop page lists who can be chosen", () {
      final shop = ShopDto.fromJson({
        'shopId': 'shop-1',
        'status': 'active',
        'name': 'Barbieri Navona',
        'providers': [
          {
            'providerId': 'shop-1',
            'name': 'Barbieri Navona',
            'type': 'person',
            'serviceIds': ['cut', 'beard'],
          },
          {
            'providerId': 'marco',
            'name': 'Marco',
            'type': 'person',
            'serviceIds': ['cut'],
          },
        ],
      }).toDomain();

      expect(shop.hasTeam, isTrue);
      expect(shop.providersFor('beard').map((p) => p.id), ['shop-1']);
      expect(shop.providerName('marco'), 'Marco');
    });

    test('a shop from before providers has no team', () {
      final shop = ShopDto.fromJson({
        'shopId': 'shop-1',
        'status': 'active',
      }).toDomain();

      expect(shop.providers, isEmpty);
      expect(shop.hasTeam, isFalse);
    });
  });
}

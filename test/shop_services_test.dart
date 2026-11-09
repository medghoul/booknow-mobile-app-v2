import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

const _cut = ShopService(
  id: 'cut',
  name: 'Taglio uomo',
  durationMinutes: 30,
  priceCents: 1800,
);

const _beard = ShopService(
  id: 'beard',
  name: 'Barba',
  durationMinutes: 15,
  priceCents: 1000,
);

Shop _shopWith(List<ShopService> services) => Shop(
  id: 's',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  services: services,
);

class _FakeShopRepository implements ShopRepository {
  _FakeShopRepository({
    List<ShopService> services = const [_cut, _beard],
    this.failWrites = false,
  }) : _services = [...services];

  final bool failWrites;
  List<ShopService> _services;

  int reads = 0;
  int addCalls = 0;
  int updateCalls = 0;
  int deleteCalls = 0;

  String? lastName;
  int? lastDuration;
  int? lastPriceCents;
  String? lastServiceId;
  String? lastDeletedId;

  @override
  Future<ApiResult<Shop?>> getMyShop() async {
    reads++;
    return ApiResult.success(_shopWith(_services));
  }

  @override
  Future<ApiResult<ShopService>> addService({
    required String name,
    required int durationMinutes,
    required int priceCents,
  }) async {
    addCalls++;
    lastName = name;
    lastDuration = durationMinutes;
    lastPriceCents = priceCents;

    if (failWrites) return const ApiResult.failure(NoInternetConnection());

    final added = ShopService(
      id: 'new',
      name: name,
      durationMinutes: durationMinutes,
      priceCents: priceCents,
    );
    _services = [..._services, added];
    return ApiResult.success(added);
  }

  @override
  Future<ApiResult<ShopService>> updateService(
    String serviceId, {
    String? name,
    int? durationMinutes,
    int? priceCents,
  }) async {
    updateCalls++;
    lastServiceId = serviceId;
    lastName = name;
    lastDuration = durationMinutes;
    lastPriceCents = priceCents;

    if (failWrites) return const ApiResult.failure(NoInternetConnection());

    _services = [
      for (final service in _services)
        if (service.id == serviceId)
          service.copyWith(
            name: name ?? service.name,
            durationMinutes: durationMinutes ?? service.durationMinutes,
            priceCents: priceCents ?? service.priceCents,
          )
        else
          service,
    ];
    return ApiResult.success(
      _services.firstWhere((service) => service.id == serviceId),
    );
  }

  @override
  Future<ApiResult<void>> deleteService(String serviceId) async {
    deleteCalls++;
    lastDeletedId = serviceId;

    if (failWrites) return const ApiResult.failure(NoInternetConnection());

    _services = [
      for (final service in _services)
        if (service.id == serviceId)
          service.copyWith(isActive: false)
        else
          service,
    ];
    return const ApiResult.success(null);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();
  final services = t.shopSetup.services;

  group('saveServiceDetails', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> build({bool failWrites = false}) async {
      shops = _FakeShopRepository(failWrites: failWrites);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.services);
      await cubit.start();
    }

    tearDown(() => cubit.close());

    test('no id means a new service', () async {
      await build();

      final saved = await cubit.saveServiceDetails(
        name: 'Taglio e barba',
        durationMinutes: 45,
        priceCents: 2500,
      );

      expect(saved, isTrue);
      expect(shops.addCalls, 1);
      expect(shops.updateCalls, 0);
      expect(shops.lastName, 'Taglio e barba');
      expect(shops.lastDuration, 45);
      expect(shops.lastPriceCents, 2500);
    });

    test('an id edits that service', () async {
      await build();

      final saved = await cubit.saveServiceDetails(
        serviceId: 'cut',
        name: 'Taglio uomo',
        durationMinutes: 45,
        priceCents: 2000,
      );

      expect(saved, isTrue);
      expect(shops.updateCalls, 1);
      expect(shops.addCalls, 0);
      expect(shops.lastServiceId, 'cut');
    });

    // The screen shows what the server holds, not what the app guessed.
    test('the shop is re-read once the service has landed', () async {
      await build();
      final readsBefore = shops.reads;

      await cubit.saveServiceDetails(
        serviceId: 'cut',
        name: 'Taglio uomo',
        durationMinutes: 45,
        priceCents: 2000,
      );

      expect(shops.reads, readsBefore + 1);
      expect(
        cubit.state.shop?.services.firstWhere((s) => s.id == 'cut').priceCents,
        2000,
      );
      expect(cubit.state.isSaving, isFalse);
    });

    test('a failure is reported, not swallowed', () async {
      await build(failWrites: true);

      final saved = await cubit.saveServiceDetails(
        name: 'Taglio e barba',
        durationMinutes: 45,
        priceCents: 2500,
      );

      expect(saved, isFalse);
      expect(cubit.state.failure, isNotNull);
      expect(cubit.state.isSaving, isFalse);
    });

    // Two taps on Save must not become two services.
    test('a second save while one is in flight is ignored', () async {
      await build();

      final first = cubit.saveServiceDetails(
        name: 'A',
        durationMinutes: 30,
        priceCents: 100,
      );
      final second = cubit.saveServiceDetails(
        name: 'B',
        durationMinutes: 30,
        priceCents: 200,
      );

      expect(await Future.wait([first, second]), [true, false]);
      expect(shops.addCalls, 1);
    });
  });

  group('removeService', () {
    test('deletes and says so', () async {
      final shops = _FakeShopRepository();
      final cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.services);
      await cubit.start();
      addTearDown(cubit.close);

      final removed = await cubit.removeService('cut');

      expect(removed, isTrue);
      expect(shops.lastDeletedId, 'cut');
      expect(cubit.state.shop?.activeServices.map((s) => s.id), ['beard']);
    });

    test('a failed delete reports back rather than looking done', () async {
      final shops = _FakeShopRepository(failWrites: true);
      final cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.services);
      await cubit.start();
      addTearDown(cubit.close);

      final removed = await cubit.removeService('cut');

      expect(removed, isFalse);
      expect(cubit.state.failure, isNotNull);
      expect(cubit.state.isSaving, isFalse);
    });
  });

  group('ShopServicesList', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> pumpList(
      WidgetTester tester, {
      List<ShopService> services = const [_cut, _beard],
      bool failWrites = false,
    }) async {
      shops = _FakeShopRepository(services: services, failWrites: failWrites);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.services);
      await cubit.start();

      await pumpThemed(
        tester,
        BlocProvider.value(value: cubit, child: const ShopServicesList()),
      );
    }

    tearDown(() => cubit.close());

    testWidgets('lists every service with its length and price', (
      tester,
    ) async {
      await pumpList(tester);

      expect(find.text('Taglio uomo'), findsOneWidget);
      expect(find.text(services.minutes(count: '30')), findsOneWidget);
      expect(find.text('€18,00'), findsOneWidget);
      expect(find.text('Barba'), findsOneWidget);
      expect(find.text('€10,00'), findsOneWidget);
    });

    testWidgets('a shop with no services offers the first one', (tester) async {
      await pumpList(tester, services: const []);

      expect(find.text(services.emptyTitle), findsOneWidget);
      expect(find.text(services.add), findsOneWidget);
    });

    // The design's reading of the list: the row is the edit, the three dots
    // are for the rarer things.
    testWidgets('tapping a row opens the editor on that service', (
      tester,
    ) async {
      await pumpList(tester);

      await tester.tap(find.text('Taglio uomo'));
      await tester.pumpAndSettle();

      expect(find.text(services.editTitle), findsOneWidget);
      expect(find.text(services.saveChanges), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Taglio uomo'), findsOneWidget);
    });

    // Editing a service continues what the list started, so it comes up as a
    // sheet over the list rather than taking the screen.
    testWidgets('the editor is a sheet over the list', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text('Taglio uomo'));
      await tester.pumpAndSettle();

      expect(find.byType(AppBottomSheet), findsOneWidget);
      expect(find.text('Taglio uomo'), findsNWidgets(2));
    });

    // Dismissing is not a quiet Save: the typed name goes nowhere and the row
    // behind still reads what the server holds.
    testWidgets('dismissing the editor saves nothing', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text('Taglio uomo'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Rasatura');
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(shops.updateCalls, 0);
      expect(find.text('Taglio uomo'), findsOneWidget);
    });

    testWidgets('Add opens an empty editor', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text(services.add));
      await tester.pumpAndSettle();

      expect(find.text(services.newService), findsOneWidget);
      expect(find.text(services.saveChanges), findsNothing);
    });

    testWidgets('the three dots open the actions', (tester) async {
      await pumpList(tester);

      await tester.tap(find.byIcon(Icons.more_vert).first);
      await tester.pumpAndSettle();

      // The actions are a sheet; the editor they lead to is not.
      expect(find.byType(AppBottomSheet), findsOneWidget);
      expect(find.text(services.edit), findsOneWidget);
      expect(find.text(services.delete), findsOneWidget);
      // The three dots sit inside the row that opens the editor; the button
      // has to swallow the tap rather than let both fire.
      expect(find.text(services.editTitle), findsNothing);
    });

    /// Deleting is two steps on purpose: nothing restores a service, so the
    /// question comes before the delete rather than as an undo after it.
    Future<void> openDelete(WidgetTester tester) async {
      await tester.tap(find.byIcon(Icons.more_vert).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text(services.delete));
      await tester.pumpAndSettle();
    }

    testWidgets('deleting asks first, naming the service', (tester) async {
      await pumpList(tester);
      await openDelete(tester);

      expect(
        find.text(services.deleteTitle(name: 'Taglio uomo')),
        findsOneWidget,
      );
      expect(shops.deleteCalls, 0);
    });

    testWidgets('cancelling the question keeps the service', (tester) async {
      await pumpList(tester);
      await openDelete(tester);

      await tester.tap(find.text(t.common.cancel));
      await tester.pumpAndSettle();

      expect(shops.deleteCalls, 0);
      expect(find.text('Taglio uomo'), findsOneWidget);
    });

    testWidgets('confirming deletes it, once', (tester) async {
      await pumpList(tester);
      await openDelete(tester);

      await tester.tap(find.text(services.delete).last);
      await tester.pumpAndSettle();

      expect(shops.deleteCalls, 1);
      expect(shops.lastDeletedId, 'cut');
      expect(find.text(services.deleted), findsOneWidget);
      // The server keeps it for the bookings that point at it; the owner's
      // list is only the services a customer can still book.
      expect(find.text('Taglio uomo'), findsNothing);
    });

    testWidgets('editing from the actions opens the same editor', (
      tester,
    ) async {
      await pumpList(tester);

      await tester.tap(find.byIcon(Icons.more_vert).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text(services.edit));
      await tester.pumpAndSettle();

      expect(find.text(services.editTitle), findsOneWidget);
    });
  });

  group('ServiceEditorSheet', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> pumpEditor(
      WidgetTester tester, {
      ShopService? service,
      bool failWrites = false,
    }) async {
      shops = _FakeShopRepository(failWrites: failWrites);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.services);
      await cubit.start();

      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: ServiceEditorSheet(service: service),
        ),
      );
    }

    tearDown(() => cubit.close());

    testWidgets('opens on what the service already holds', (tester) async {
      await pumpEditor(tester, service: _cut);

      expect(find.widgetWithText(TextFormField, 'Taglio uomo'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, '18,00'), findsOneWidget);
    });

    testWidgets('offers a saved time that is none of the four', (tester) async {
      await pumpEditor(tester, service: _cut.copyWith(durationMinutes: 35));

      final chip = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.text(services.minutes(count: '35')),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(chip.properties.selected, isTrue);
      expect(find.text(services.minutes(count: '15')), findsOne);
      expect(find.text(services.minutes(count: '60')), findsOne);
      expect(tester.takeException(), isNull);
    });

    testWidgets('keeps that time on offer after tapping another', (
      tester,
    ) async {
      await pumpEditor(tester, service: _cut.copyWith(durationMinutes: 35));

      await tester.tap(find.text(services.minutes(count: '45')));
      await tester.pumpAndSettle();
      expect(find.text(services.minutes(count: '35')), findsOne);
    });

    testWidgets('shows only the four when the time is one of them', (
      tester,
    ) async {
      await pumpEditor(tester, service: _cut);

      expect(
        find.descendant(
          of: find.byType(ServiceDurationChips),
          matching: find.byType(Expanded),
        ),
        findsNWidgets(4),
      );
    });

    testWidgets('fits five on a small phone, with a long time', (tester) async {
      tester.view.physicalSize = const Size(960, 1600);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await pumpEditor(tester, service: _cut.copyWith(durationMinutes: 125));

      expect(find.text(services.minutes(count: '125')), findsOne);
      expect(tester.takeException(), isNull);
    });

    testWidgets('saves the edited fields against that service', (tester) async {
      await pumpEditor(tester, service: _cut);

      await tester.enterText(find.byType(TextFormField).first, ' Taglio  ');
      await tester.tap(find.text(services.minutes(count: '45')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(services.saveChanges));
      await tester.pumpAndSettle();

      expect(shops.lastServiceId, 'cut');
      expect(shops.lastName, 'Taglio');
      expect(shops.lastDuration, 45);
      expect(shops.lastPriceCents, 1800);
    });

    testWidgets('a new service is added, not updated', (tester) async {
      await pumpEditor(tester);

      await tester.enterText(find.byType(TextFormField).first, 'Shampoo');
      await tester.enterText(find.byType(TextFormField).last, '7,50');
      await tester.tap(find.text(services.save));
      await tester.pumpAndSettle();

      expect(shops.addCalls, 1);
      expect(shops.lastName, 'Shampoo');
      expect(shops.lastPriceCents, 750);
      // The duration the design preselects.
      expect(shops.lastDuration, 30);
    });

    testWidgets('an empty name is refused before it reaches the server', (
      tester,
    ) async {
      await pumpEditor(tester);

      await tester.enterText(find.byType(TextFormField).last, '10,00');
      await tester.tap(find.text(services.save));
      await tester.pumpAndSettle();

      expect(shops.addCalls, 0);
    });

    // Changing a price is the slip worth catching before Save.
    testWidgets('a changed price keeps the old one in view', (tester) async {
      await pumpEditor(tester, service: _cut);

      expect(find.text('€18,00'), findsNothing);

      await tester.enterText(find.byType(TextFormField).last, '20,00');
      await tester.pump();

      expect(find.text('€18,00'), findsOneWidget);
      // Struck through, or it reads as the price the service is changing to.
      expect(_struck, findsOneWidget);
    });

    testWidgets('typing the same price back removes the old one', (
      tester,
    ) async {
      await pumpEditor(tester, service: _cut);

      await tester.enterText(find.byType(TextFormField).last, '20,00');
      await tester.pump();
      await tester.enterText(find.byType(TextFormField).last, '18,00');
      await tester.pump();

      expect(find.text('€18,00'), findsNothing);
    });

    testWidgets('a new service has no old price to strike', (tester) async {
      await pumpEditor(tester);

      await tester.enterText(find.byType(TextFormField).last, '20,00');
      await tester.pump();

      expect(_struck, findsNothing);
    });
  });
}

/// Any text the editor has struck through — the old price, when there is one.
final _struck = find.byWidgetPredicate(
  (widget) =>
      widget is Text && widget.style?.decoration == TextDecoration.lineThrough,
);

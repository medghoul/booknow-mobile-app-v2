import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

const _shop = Shop(
  id: 's',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  phone: '328 559 8856',
  address: ShopAddress(
    line: 'Via dei Coronari 18',
    city: 'Roma',
    zip: '00186',
    country: 'IT',
    latitude: 41.9028,
    longitude: 12.4964,
  ),
);

const _unpinned = ShopAddress(
  line: 'Via dei Coronari 18',
  city: 'Roma',
  zip: '00186',
  country: 'IT',
);

class _FakeShopRepository implements ShopRepository {
  _FakeShopRepository({this.failSave = false});

  final bool failSave;

  String? lastName;
  String? lastPhone;
  int updateCalls = 0;

  @override
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    String? placeId,
    OpeningHours? openingHours,
    List<String>? closures,
  }) async {
    updateCalls++;
    lastName = name;
    lastPhone = phone;

    if (failSave) {
      return const ApiResult.failure(NoInternetConnection());
    }
    return ApiResult.success(_shop.copyWith(name: name, phone: phone));
  }

  @override
  Future<ApiResult<Shop?>> getMyShop() async => const ApiResult.success(_shop);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();
  final details = t.shopSetup.details;

  group('saveShopInfo', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    Future<void> build({bool failSave = false}) async {
      shops = _FakeShopRepository(failSave: failSave);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.shop);
      await cubit.start();
    }

    tearDown(() => cubit.close());

    test('saves the details and says so', () async {
      await build();

      final saved = await cubit.saveShopInfo(
        name: 'Il salotto',
        phone: '328 559 8856',
      );

      expect(saved, isTrue);
      expect(shops.lastName, 'Il salotto');
      expect(shops.lastPhone, '328 559 8856');
      expect(cubit.state.shop?.name, 'Il salotto');
      expect(cubit.state.isSaving, isFalse);
    });

    // The edit screen is not a step. Advancing would drop the owner into the
    // address step of a wizard they never opened.
    test('stays where it is instead of advancing a wizard', () async {
      await build();
      await cubit.saveShopInfo(name: 'Il salotto', phone: '1');

      expect(cubit.state.step, ShopSetupStep.shop);
    });

    test('a failure is reported, not swallowed', () async {
      await build(failSave: true);

      final saved = await cubit.saveShopInfo(name: 'Il salotto', phone: '1');

      expect(saved, isFalse);
      expect(cubit.state.failure, isNotNull);
      expect(cubit.state.isSaving, isFalse);
    });

    // Two taps on Save must not become two PATCHes.
    test('a second save while one is in flight is ignored', () async {
      await build();

      final first = cubit.saveShopInfo(name: 'A', phone: '1');
      final second = cubit.saveShopInfo(name: 'B', phone: '2');

      expect(await Future.wait([first, second]), [true, false]);
      expect(shops.updateCalls, 1);
    });
  });

  group('ShopAddressField', () {
    Future<void> pumpField(
      WidgetTester tester, {
      ShopAddress? address,
      VoidCallback? onTap,
    }) => pumpThemed(tester, ShopAddressField(address: address, onTap: onTap));

    testWidgets('shows the line over the place and the pin', (tester) async {
      await pumpField(tester, address: _shop.address, onTap: () {});

      expect(find.text('Via dei Coronari 18'), findsOneWidget);
      expect(
        find.text('00186 Roma · ${details.addressPinned}'),
        findsOneWidget,
      );
    });

    // A shop with no coordinates cannot be found by a customer, so the row
    // has to say the pin is missing rather than look finished.
    testWidgets('an address with no pin says so', (tester) async {
      await pumpField(tester, address: _unpinned, onTap: () {});

      expect(
        find.text('00186 Roma · ${details.addressNotPinned}'),
        findsOneWidget,
      );
    });

    testWidgets('no address at all reads as something to do', (tester) async {
      await pumpField(tester, onTap: () {});

      expect(find.text(details.addressMissing), findsOneWidget);
      expect(find.text(details.addressMissingHelper), findsOneWidget);
    });

    testWidgets('opens the picker when tapped', (tester) async {
      var taps = 0;
      await pumpField(tester, address: _shop.address, onTap: () => taps++);

      await tester.tap(find.byType(ShopAddressField));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('a row with nowhere to go shows no chevron', (tester) async {
      await pumpField(tester, address: _shop.address);

      expect(find.byIcon(Icons.chevron_right_rounded), findsNothing);
    });
  });

  group('ShopDetailsView', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;
    var saves = 0;

    Future<void> pumpView(WidgetTester tester, {bool failSave = false}) async {
      saves = 0;
      shops = _FakeShopRepository(failSave: failSave);
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.shop);
      await cubit.start();

      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: ShopDetailsView(onSaved: () => saves++),
        ),
      );
    }

    tearDown(() => cubit.close());

    testWidgets('opens on what the shop already holds', (tester) async {
      await pumpView(tester);

      expect(find.text('Barbieri Navona'), findsOneWidget);
      expect(find.text('328 559 8856'), findsOneWidget);
      expect(find.text('Via dei Coronari 18'), findsOneWidget);
    });

    // The design puts this above Save because two of the four fields have
    // already saved themselves by the time the owner gets there.
    testWidgets('warns that changes are live before offering Save', (
      tester,
    ) async {
      await pumpView(tester);

      final note = tester.getTopLeft(find.text(details.liveNote));
      final save = tester.getTopLeft(find.text(t.common.save));

      expect(note.dy, lessThan(save.dy));
    });

    testWidgets('saving sends the edited fields', (tester) async {
      await pumpView(tester);

      await tester.enterText(find.byType(TextFormField).first, 'Il salotto');
      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.lastName, 'Il salotto');
    });

    testWidgets('saving reports back so the screen can leave', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(saves, 1);
    });

    // Leaving on a failed save would look like it worked.
    testWidgets('a failed save stays on the screen', (tester) async {
      await pumpView(tester, failSave: true);

      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(saves, 0);
    });

    testWidgets('an empty name is refused before it reaches the server', (
      tester,
    ) async {
      await pumpView(tester);

      await tester.enterText(find.byType(TextFormField).first, '   ');
      await tester.tap(find.text(t.common.save));
      await tester.pumpAndSettle();

      expect(shops.updateCalls, 0);
    });
  });
}

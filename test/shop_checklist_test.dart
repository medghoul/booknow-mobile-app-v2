import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_shop_section.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/shop_setup_checklist.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

final _t = AppLocale.en.buildSync();

class _Auth extends Cubit<AuthState> implements AuthCubit {
  _Auth() : super(const AuthState());
  @override
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

class _Shops implements ShopRepository {
  _Shops(this.shop);

  Shop? shop;
  bool published = false;

  @override
  Future<ApiResult<Shop?>> getMyShop() async => Success(shop);

  @override
  Future<ApiResult<Shop>> publish() async {
    published = true;
    return Success(shop!.copyWith(status: ShopStatus.active));
  }

  @override
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    OpeningHours? openingHours,
    List<String>? closures,
    String? placeId,
  }) async {
    shop = shop!.copyWith(
      name: name ?? shop!.name,
      phone: phone ?? shop!.phone,
    );
    return Success(shop!);
  }

  @override
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

const _empty = Shop(id: 's', status: ShopStatus.draft);

void main() {
  setUp(() async {
    await di.reset();
    di.registerSingleton<AuthCubit>(_Auth());
  });

  group('the cubit in checklist mode', () {
    ShopSetupCubit checklist(_Shops shops) => ShopSetupCubit(
      shops,
      startAt: ShopSetupStep.review,
      returnToChecklist: true,
    );

    test('opens on the checklist, whatever is missing', () async {
      final cubit = checklist(_Shops(_empty));
      await cubit.start();

      expect(cubit.state.step, ShopSetupStep.review);
    });

    test('saving a step comes back to the checklist', () async {
      final cubit = checklist(_Shops(_empty));
      await cubit.start();
      cubit.goTo(ShopSetupStep.shop);

      await cubit.saveShopDetails(name: 'Old Town', phone: '+39 02 000');

      expect(cubit.state.step, ShopSetupStep.review);
      expect(cubit.state.shop?.hasShopDetails, isTrue);
    });

    test('a step with its own Continue comes back too', () async {
      final cubit = checklist(_Shops(_empty));
      await cubit.start();
      cubit.goTo(ShopSetupStep.address);

      cubit.goToServices();

      expect(cubit.state.step, ShopSetupStep.review);
    });

    test('without it, the steps still run in order', () async {
      final cubit = ShopSetupCubit(_Shops(_empty), startAt: ShopSetupStep.shop);
      await cubit.start();

      await cubit.saveShopDetails(name: 'Old Town', phone: '+39 02 000');

      expect(cubit.state.step, ShopSetupStep.address);
    });
  });

  group('the checklist', () {
    Future<ShopSetupCubit> pump(WidgetTester tester, Shop shop) async {
      final cubit = ShopSetupCubit(
        _Shops(shop),
        startAt: ShopSetupStep.review,
        returnToChecklist: true,
      );
      await cubit.start();
      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: ShopSetupChecklist(shop: shop),
        ),
      );
      return cubit;
    }

    testWidgets('its button opens the first thing still missing', (
      tester,
    ) async {
      final cubit = await pump(tester, _empty);
      final next = _t.shopSetup.checklist.continueWith(
        step: _t.shopSetup.checklist.shop,
      );

      await tester.scrollUntilVisible(find.text(next), 200);
      await tester.pump();
      await tester.tap(find.text(next));

      expect(cubit.state.step, ShopSetupStep.shop);
    });

    testWidgets('says how many steps are left', (tester) async {
      await pump(tester, _empty);

      expect(find.text(_t.shopSetup.checklist.left(n: 4)), findsOneWidget);
    });
  });

  group('the Shop tab', () {
    testWidgets('says the shop is live and offers the customer view', (
      tester,
    ) async {
      var previewed = false;
      await pumpThemed(
        tester,
        SingleChildScrollView(
          child: ProfileShopSection(
            shop: const Shop(id: 's', status: ShopStatus.active, name: 'Old'),
            onPreview: () => previewed = true,
          ),
        ),
      );

      expect(find.text(_t.profile.shopLive), findsOneWidget);

      await tester.tap(find.text(_t.profile.seeAsCustomer));

      expect(previewed, isTrue);
    });
  });
}

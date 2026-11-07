import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/provider_choice.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// Choosing who to book or wait for (providers §4, §7.1).

const _cut = ShopService(
  id: 'cut',
  name: 'Taglio',
  durationMinutes: 30,
  priceCents: 1800,
);
const _colour = ShopService(
  id: 'colour',
  name: 'Colore',
  durationMinutes: 60,
  priceCents: 4000,
);

const _team = Shop(
  id: 'shop-1',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  mode: ShopMode.both,
  services: [_cut, _colour],
  providers: [
    ShopProvider(id: 'shop-1', name: 'Barbieri Navona'),
    // Marco does cuts only.
    ShopProvider(id: 'marco', name: 'Marco', serviceIds: ['cut'], order: 1),
  ],
);

class _Shops implements ShopDirectoryRepository {
  _Shops(this.shop);

  final Shop shop;

  @override
  Future<ApiResult<Shop>> byId(String shopId) async => Success(shop);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Bookings implements BookingRepository {
  final asked = <String?>[];
  String? heldFor = 'none';

  @override
  Future<ApiResult<Availability>> availability({
    required String shopId,
    required String serviceId,
    required String date,
    String? providerId,
  }) async {
    asked.add(providerId);
    return Success(
      Availability(
        date: date,
        timeZone: 'Europe/Rome',
        durationMinutes: 30,
        starts: [DateTime.utc(2099, 1, 2, 9)],
      ),
    );
  }

  @override
  Future<ApiResult<BookingHold>> hold({
    required String shopId,
    required String serviceId,
    required DateTime startUtc,
    String? providerId,
  }) async {
    heldFor = providerId;
    // Refused, so the test stops before any payment.
    return const Failure(NoInternetConnection());
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Queue implements QueueRepository {
  String? joinedFor = 'none';

  @override
  Future<ApiResult<ShopQueue>> shopQueue(String shopId) async =>
      const Failure(NoInternetConnection());

  @override
  Future<ApiResult<QueueJoin>> join({
    required String shopId,
    required String serviceId,
    String? providerId,
  }) async {
    joinedFor = providerId;
    return const Failure(NoInternetConnection());
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();

  group('who is offered', () {
    test('everyone who does the service, when more than one does', () {
      expect(ProviderChoice.offers(_team, _cut), isTrue);
      expect(_team.providersFor('cut').map((p) => p.id), ['shop-1', 'marco']);
    });

    // Only the owner colours, so there is nobody to choose between.
    test('nothing when one person does it', () {
      expect(ProviderChoice.offers(_team, _colour), isFalse);
    });

    test('nothing for a shop of one', () {
      const solo = Shop(id: 's', status: ShopStatus.active, services: [_cut]);
      expect(ProviderChoice.offers(solo, _cut), isFalse);
    });

    testWidgets('anyone first, then each person by name', (tester) async {
      String? picked = 'unset';
      await pumpThemed(
        tester,
        ProviderChoice(
          providers: _team.providersFor('cut'),
          selected: null,
          onSelected: (id) => picked = id,
        ),
      );

      expect(find.text(t.shopScreen.whoLike), findsOneWidget);
      expect(
        tester.widget<ChoiceChip>(find.byType(ChoiceChip).first).selected,
        isTrue,
      );

      await tester.tap(find.text('Marco'));
      expect(picked, 'marco');
      await tester.tap(find.text(t.shopScreen.anyone));
      expect(picked, isNull);
    });
  });

  group('booking', () {
    late _Bookings bookings;
    late BookingFlowCubit cubit;

    setUp(() async {
      bookings = _Bookings();
      cubit = BookingFlowCubit(
        bookings: bookings,
        shops: _Shops(_team),
        payments: PaymentService(),
        shopId: 'shop-1',
        serviceId: 'cut',
        initialDate: '2099-01-02',
      );
      await cubit.start();
    });

    tearDown(() => cubit.close());

    test("asks for anyone's times until someone is chosen", () async {
      await cubit.chooseProvider('marco');
      await cubit.chooseProvider(null);

      expect(bookings.asked, [null, 'marco', null]);
    });

    test('holds the time with the person chosen', () async {
      await cubit.chooseProvider('marco');
      cubit.chooseStart(DateTime.utc(2099, 1, 2, 9));
      await cubit.payAndConfirm();

      expect(bookings.heldFor, 'marco');
    });

    test('lets anyone take it when nobody is chosen', () async {
      cubit.chooseStart(DateTime.utc(2099, 1, 2, 9));
      await cubit.payAndConfirm();

      expect(bookings.heldFor, isNull);
    });

    test('drops the person for a service they do not do', () async {
      await cubit.chooseProvider('marco');
      await cubit.chooseService(_colour);

      expect(cubit.state.providerId, isNull);
      expect(bookings.asked.last, isNull);
    });
  });

  group('the queue', () {
    late _Queue queue;
    late QueueFlowCubit cubit;

    setUp(() async {
      queue = _Queue();
      cubit = QueueFlowCubit(
        queue: queue,
        shops: _Shops(_team),
        payments: PaymentService(),
        shopId: 'shop-1',
      );
      await cubit.start();
    });

    tearDown(() => cubit.close());

    test('joins to wait for the person chosen', () async {
      cubit.chooseProvider('marco');
      await cubit.payAndJoin();

      expect(queue.joinedFor, 'marco');
    });

    test('joins for whoever is free first by default', () async {
      await cubit.payAndJoin();

      expect(queue.joinedFor, isNull);
    });

    test('drops the person for a service they do not do', () {
      cubit.chooseProvider('marco');
      cubit.chooseService(_colour);

      expect(cubit.state.providerId, isNull);
    });
  });
}

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_state.dart';
import 'package:booknow_mobile/features/bookings/widgets/cancel_booking_sheet.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// A fee of 0: no Stripe call, and nothing on screen that says otherwise
/// (providers §12). The app has to handle it before the API's fee becomes
/// configurable.

const _cut = ShopService(
  id: 'cut',
  name: 'Taglio',
  durationMinutes: 30,
  priceCents: 1800,
);

const _shop = Shop(
  id: 'shop-1',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  mode: ShopMode.both,
  services: [_cut],
);

Map<String, dynamic> _bookingJson({
  String status = 'confirmed',
  int fee = 0,
  String start = '2099-01-02T09:00:00.000Z',
}) => {
  'bookingId': 'booking-1',
  'status': status,
  'startUtc': start,
  'endUtc': '2099-01-02T09:30:00.000Z',
  'durationMin': 30,
  'timeZone': 'Europe/Rome',
  'shopId': 'shop-1',
  'shopName': 'Barbieri Navona',
  'serviceId': 'cut',
  'serviceName': 'Taglio',
  'priceCents': 1800,
  'feeAmountCents': fee,
  'freeCancellationUntilUtc': '2099-01-02T07:00:00.000Z',
  'refunded': false,
};

Map<String, dynamic> _entryJson({int fee = 0}) => {
  'entryId': 'entry-1',
  'shopId': 'shop-1',
  'status': 'waiting',
  'serviceId': 'cut',
  'serviceName': 'Taglio',
  'durationMin': 30,
  'priceCents': 1800,
  'feeAmountCents': fee,
  'position': 1,
  'aheadCount': 0,
  'refundIfLeaving': false,
  'refunded': false,
};

class _Shops implements ShopDirectoryRepository {
  @override
  Future<ApiResult<Shop>> byId(String shopId) async => const Success(_shop);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Any payment opened here fails the test: there must be none.
class _NoPayments implements PaymentService {
  int opened = 0;

  @override
  Future<PaymentOutcome> pay({
    required String clientSecret,
    required String merchantName,
  }) async {
    opened++;
    return PaymentOutcome.failed;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Bookings implements BookingRepository {
  int reads = 0;

  @override
  Future<ApiResult<Availability>> availability({
    required String shopId,
    required String serviceId,
    required String date,
    String? providerId,
  }) async => Success(
    Availability(
      date: date,
      timeZone: 'Europe/Rome',
      durationMinutes: 30,
      starts: [DateTime.utc(2099, 1, 2, 9)],
    ),
  );

  @override
  Future<ApiResult<BookingHold>> hold({
    required String shopId,
    required String serviceId,
    required DateTime startUtc,
    String? providerId,
  }) async => Success(
    BookingHoldDto.fromJson({
      'booking': _bookingJson(),
      'clientSecret': null,
      'feeAmountCents': 0,
    }).toDomain()!,
  );

  @override
  Future<ApiResult<Booking>> byId(String bookingId) async {
    reads++;
    return const Failure(NoInternetConnection());
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Queue implements QueueRepository {
  bool joined = false;

  @override
  Future<ApiResult<ShopQueue>> shopQueue(String shopId) async => Success(
    ShopQueue(
      shopId: shopId,
      state: QueueState.open,
      closedReason: null,
      waitingCount: joined ? 1 : 0,
      inChair: false,
      estimate: const WaitRange(fromMin: 0, toMin: 0),
      feeCents: 0,
      myEntry: joined ? QueueEntryDto.fromJson(_entryJson()).toDomain() : null,
    ),
  );

  @override
  Future<ApiResult<QueueJoin>> join({
    required String shopId,
    required String serviceId,
    String? providerId,
  }) async {
    joined = true;
    return Success(
      QueueJoinDto.fromJson({
        'entry': _entryJson(),
        'clientSecret': null,
        'feeAmountCents': 0,
      }).toDomain()!,
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();

  group('reading', () {
    test('a free place in line has no payment and is kept', () {
      final join = QueueJoinDto.fromJson({
        'entry': _entryJson(),
        'clientSecret': null,
        'feeAmountCents': 0,
      }).toDomain();

      expect(join, isNotNull);
      expect(join!.clientSecret, isEmpty);
      expect(join.feeCents, 0);
    });

    test('a charged place with no payment is still refused', () {
      final join = QueueJoinDto.fromJson({
        'entry': _entryJson(fee: 149),
        'clientSecret': null,
        'feeAmountCents': 149,
      }).toDomain();

      expect(join, isNull);
    });
  });

  group('booking for free', () {
    test('lands on done without a payment or a wait', () async {
      final bookings = _Bookings();
      final payments = _NoPayments();
      final cubit = BookingFlowCubit(
        bookings: bookings,
        shops: _Shops(),
        payments: payments,
        shopId: 'shop-1',
        serviceId: 'cut',
        initialDate: '2099-01-02',
      );
      addTearDown(cubit.close);
      await cubit.start();

      cubit.chooseStart(DateTime.utc(2099, 1, 2, 9));
      await cubit.payAndConfirm();

      expect(cubit.state.step, BookingStep.done);
      expect(cubit.state.booking?.id, 'booking-1');
      expect(payments.opened, 0);
      // Confirmed in the hold's own answer, so nothing is read back.
      expect(bookings.reads, 0);
    });
  });

  group('joining for free', () {
    test('takes the place without a payment', () async {
      final payments = _NoPayments();
      final cubit = QueueFlowCubit(
        queue: _Queue(),
        shops: _Shops(),
        payments: payments,
        shopId: 'shop-1',
      );
      addTearDown(cubit.close);
      await cubit.start();

      await cubit.payAndJoin();

      expect(cubit.state.step, QueueStep.inLine);
      expect(payments.opened, 0);
    });
  });

  group('cancelling a free booking', () {
    testWidgets('says there is nothing to refund, even late', (tester) async {
      final free = BookingDto.fromJson(_bookingJson()).toDomain()!;
      late BuildContext context;
      await pumpThemed(
        tester,
        Builder(
          builder: (inner) {
            context = inner;
            return const SizedBox.shrink();
          },
        ),
      );

      // Past the free-cancellation time: a paid booking would lose its fee.
      CancelBookingSheet.ask(
        context,
        booking: free,
        now: DateTime.utc(2099, 1, 2, 8, 30),
      );
      await tester.pumpAndSettle();

      expect(find.text(t.bookings.cancel.freeTitle), findsOneWidget);
      expect(find.text(t.bookings.cancel.noRefundTitle), findsNothing);
    });
  });
}

import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/queue/cubit/owner_queue_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:flutter_test/flutter_test.dart';

/// The queue flows without a server: joining, leaving, and the owner's
/// buttons (docs/queue/queue.md §4, §5, §8).

const _cut = ShopService(
  id: 'cut',
  name: 'Taglio uomo',
  durationMinutes: 30,
  priceCents: 1800,
);

const _shop = Shop(
  id: 'shop-1',
  status: ShopStatus.active,
  name: 'Barbieri Navona',
  services: [_cut],
  mode: ShopMode.queue,
);

QueueEntry _entry({
  QueueEntryStatus status = QueueEntryStatus.waiting,
  bool refundIfLeaving = true,
  bool refunded = false,
}) => QueueEntry(
  id: 'e-1',
  shopId: 'shop-1',
  shopName: 'Barbieri Navona',
  status: status,
  serviceId: 'cut',
  serviceName: 'Taglio uomo',
  durationMinutes: 30,
  priceCents: 1800,
  feeCents: 149,
  position: 4,
  aheadCount: 3,
  estimate: const WaitRange(fromMin: 40, toMin: 50),
  refundIfLeaving: refundIfLeaving,
  holdExpiresAt: null,
  calledAt: null,
  noShowFrom: null,
  refunded: refunded,
);

ShopQueue _queue({QueueEntry? mine, QueueClosedReason? closed}) => ShopQueue(
  shopId: 'shop-1',
  state: QueueState.open,
  closedReason: closed,
  waitingCount: 3,
  inChair: true,
  estimate: const WaitRange(fromMin: 95, toMin: 120),
  feeCents: 149,
  myEntry: mine,
);

const _ownerQueue = OwnerQueue(
  localDate: '2026-11-03',
  state: QueueState.open,
  waitingCount: 1,
  emptiesAt: null,
  entries: [],
);

class _Queue implements QueueRepository {
  /// What `shopQueue` answers, in order; the last one repeats.
  List<ShopQueue> reads = [_queue()];
  ApiResult<QueueJoin>? joinResult;
  ApiResult<QueueEntry>? leaveResult;
  ApiResult<OwnerQueue> ownerResult = const Success(_ownerQueue);
  final calls = <String>[];

  @override
  Future<ApiResult<ShopQueue>> shopQueue(String shopId) async {
    calls.add('shopQueue');
    final next = reads.length > 1 ? reads.removeAt(0) : reads.first;
    return Success(next);
  }

  @override
  Future<ApiResult<QueueJoin>> join({
    required String shopId,
    required String serviceId,
    String? providerId,
  }) async {
    calls.add('join');
    return joinResult!;
  }

  @override
  Future<ApiResult<QueueEntry>> leave(String entryId) async {
    calls.add('leave');
    return leaveResult!;
  }

  @override
  Future<ApiResult<OwnerQueue>> ownerQueue() async {
    calls.add('ownerQueue');
    return const Success(_ownerQueue);
  }

  @override
  Future<ApiResult<OwnerQueue>> callNext({String? providerId}) async {
    calls.add('callNext');
    return ownerResult;
  }

  @override
  Future<ApiResult<OwnerQueue>> remove(String entryId) async {
    calls.add('remove:$entryId');
    return ownerResult;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Shops implements ShopDirectoryRepository {
  @override
  Future<ApiResult<Shop>> byId(String shopId) async => const Success(_shop);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _OwnerShop implements ShopRepository {
  @override
  Future<ApiResult<Shop?>> getMyShop() async => const Success(_shop);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Pay implements PaymentService {
  _Pay(this.outcome);

  final PaymentOutcome outcome;

  @override
  Future<PaymentOutcome> pay({
    required String clientSecret,
    required String merchantName,
  }) async => outcome;
}

void main() {
  QueueFlowCubit flow(
    _Queue queue, {
    PaymentOutcome pay = PaymentOutcome.paid,
  }) => QueueFlowCubit(
    queue: queue,
    shops: _Shops(),
    payments: _Pay(pay),
    shopId: 'shop-1',
  );

  group('customer', () {
    test('opens on the live line, with the only service chosen', () async {
      final cubit = flow(_Queue());
      await cubit.start();

      expect(cubit.state.step, QueueStep.overview);
      expect(cubit.state.service, _cut);
      expect(cubit.state.canJoin, isTrue);
      await cubit.close();
    });

    test('resumes a place the customer already holds', () async {
      final cubit = flow(_Queue()..reads = [_queue(mine: _entry())]);
      await cubit.start();

      expect(cubit.state.step, QueueStep.inLine);
      expect(cubit.state.entry?.position, 4);
      await cubit.close();
    });

    test('pays, then waits for the webhook to give the place', () async {
      final queue = _Queue()
        ..reads = [_queue(), _queue(), _queue(mine: _entry())]
        ..joinResult = Success(
          QueueJoin(
            entry: _entry(status: QueueEntryStatus.pendingPayment),
            clientSecret: 'pi_secret',
            holdExpiresAt: DateTime.utc(2026, 11, 3, 9, 22),
            feeCents: 149,
            estimate: const WaitRange(fromMin: 40, toMin: 50),
          ),
        );
      final cubit = flow(queue);
      await cubit.start();
      cubit.review();

      await cubit.payAndJoin();

      expect(cubit.state.step, QueueStep.inLine);
      expect(cubit.state.entry?.status, QueueEntryStatus.waiting);
      expect(queue.calls.where((c) => c == 'join'), hasLength(1));
      await cubit.close();
    });

    test('a full queue sends the customer back to the line', () async {
      final queue = _Queue()
        ..reads = [_queue(), _queue(closed: QueueClosedReason.full)]
        ..joinResult = const Failure(
          Conflict(ApiErrorCode.queueNotAccepting, 'full'),
        );
      final cubit = flow(queue);
      await cubit.start();
      cubit.review();

      await cubit.payAndJoin();

      expect(cubit.state.step, QueueStep.overview);
      expect(cubit.state.queue?.closedReason, QueueClosedReason.full);
      await cubit.close();
    });

    test('a closed sheet keeps the pending place for another try', () async {
      final queue = _Queue()
        ..joinResult = Success(
          QueueJoin(
            entry: _entry(status: QueueEntryStatus.pendingPayment),
            clientSecret: 'pi_secret',
            holdExpiresAt: DateTime.utc(2026, 11, 3, 9, 22),
            feeCents: 149,
            estimate: const WaitRange(fromMin: 40, toMin: 50),
          ),
        );
      final cubit = flow(queue, pay: PaymentOutcome.cancelled);
      await cubit.start();
      cubit.review();

      await cubit.payAndJoin();
      await cubit.payAndJoin();

      expect(cubit.state.step, QueueStep.confirm);
      // The second try reuses the same payment rather than asking for a
      // second place, which the server would refuse.
      expect(queue.calls.where((c) => c == 'join'), hasLength(1));
      await cubit.close();
    });

    test("leaving reports the server's refund verdict", () async {
      final queue = _Queue()
        ..reads = [_queue(mine: _entry())]
        ..leaveResult = Success(
          _entry(status: QueueEntryStatus.left, refunded: true),
        );
      final cubit = flow(queue);
      await cubit.start();

      await cubit.leave();

      expect(cubit.state.step, QueueStep.ended);
      expect(cubit.state.leftRefunded, isTrue);
      await cubit.close();
    });
  });

  group('owner', () {
    test('loads the line and the services for walk-ins', () async {
      final cubit = OwnerQueueCubit(_Queue(), _OwnerShop());
      await cubit.load();

      expect(cubit.state.queue, _ownerQueue);
      expect(cubit.state.services, [_cut]);
      await cubit.close();
    });

    test('a refused button reads the line again', () async {
      final queue = _Queue()
        ..ownerResult = const Failure(
          Conflict(ApiErrorCode.queueEmpty, 'nobody'),
        );
      final cubit = OwnerQueueCubit(queue, _OwnerShop());
      await cubit.load();
      queue.calls.clear();

      await cubit.callNext();

      expect(queue.calls, ['callNext', 'ownerQueue']);
      expect(cubit.state.failure?.code, ApiErrorCode.queueEmpty);
      expect(cubit.state.busy, isFalse);
      await cubit.close();
    });
  });
}

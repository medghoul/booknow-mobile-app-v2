import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reading the queue routes (docs/queue/queue.md §13) the way the API
/// answers them, and staying safe when it answers less.
void main() {
  final entryJson = <String, dynamic>{
    'entryId': 'e-4',
    'shopId': 'shop-1',
    'shopName': 'Barbieri Navona',
    'localDate': '2026-11-03',
    'status': 'waiting',
    'serviceId': 'cut',
    'serviceName': 'Taglio uomo',
    'durationMin': 30,
    'priceCents': 1800,
    'feeAmountCents': 149,
    'position': 4,
    'aheadCount': 3,
    'estimate': {'fromMin': 40, 'toMin': 50},
    'refundIfLeaving': true,
    'holdExpiresAt': null,
    'joinedAt': '2026-11-03T09:12:00.000Z',
    'calledAt': null,
    'noShowFrom': null,
    'refunded': false,
  };

  group('the customer side', () {
    test('reads a place in line', () {
      final entry = QueueEntryDto.fromJson(entryJson).toDomain()!;

      expect(entry.status, QueueEntryStatus.waiting);
      expect(entry.position, 4);
      expect(entry.aheadCount, 3);
      expect(entry.estimate, const WaitRange(fromMin: 40, toMin: 50));
      expect(entry.refundIfLeaving, isTrue);
      expect(entry.feeCents, 149);
    });

    test('never promises a refund the server did not state', () {
      final json = Map<String, dynamic>.from(entryJson)
        ..remove('refundIfLeaving');
      expect(QueueEntryDto.fromJson(json).toDomain()!.refundIfLeaving, isFalse);
    });

    test('drops an entry with no id', () {
      final json = Map<String, dynamic>.from(entryJson)..remove('entryId');
      expect(QueueEntryDto.fromJson(json).toDomain(), isNull);
    });

    test('reads the shop queue, closed reason included', () {
      final queue = ShopQueueDto.fromJson({
        'shopId': 'shop-1',
        'state': 'open',
        'accepting': false,
        'notAccepting': 'full',
        'waitingCount': 3,
        'inChair': true,
        'estimate': {'fromMin': 95, 'toMin': 120},
        'feeAmountCents': 149,
        'myEntry': entryJson,
      }).toDomain();

      expect(queue.isAccepting, isFalse);
      expect(queue.closedReason, QueueClosedReason.full);
      expect(queue.estimate.toMin, 120);
      expect(queue.myEntry?.id, 'e-4');
    });

    test('needs a client secret to make a join usable', () {
      final body = {
        'entry': {...entryJson, 'status': 'pending_payment'},
        'clientSecret': 'pi_secret',
        'holdExpiresAt': '2026-11-03T09:22:00.000Z',
        'feeAmountCents': 149,
        'estimate': {'fromMin': 40, 'toMin': 50},
      };

      expect(QueueJoinDto.fromJson(body).toDomain()?.clientSecret, 'pi_secret');
      expect(
        QueueJoinDto.fromJson({...body, 'clientSecret': null}).toDomain(),
        isNull,
      );
    });
  });

  group('the owner side', () {
    test('splits the line into chair, called and waiting', () {
      final queue = OwnerQueueDto.fromJson({
        'localDate': '2026-11-03',
        'state': 'paused',
        'waitingCount': 2,
        'emptiesAt': '2026-11-03T10:40:00.000Z',
        'entries': [
          {
            'entryId': 'a',
            'status': 'serving',
            'kind': 'app',
            'customerName': 'Luca R.',
          },
          {
            'entryId': 'b',
            'status': 'called',
            'kind': 'app',
            'customerName': 'Giulia M.',
          },
          {'entryId': 'c', 'status': 'waiting', 'kind': 'walk_in'},
          {'status': 'waiting'},
        ],
      }).toDomain();

      expect(queue.state, QueueState.paused);
      expect(queue.inChair?.customerName, 'Luca R.');
      expect(queue.called?.id, 'b');
      // The row with no id is dropped, not fatal.
      expect(queue.waiting.map((e) => e.id), ['c']);
      expect(queue.waiting.single.kind, QueueEntryKind.walkIn);
    });
  });

  test('reads shops saved before queue mode as taking bookings', () {
    expect(ShopMode.fromWire(null), ShopMode.booking);
    expect(ShopMode.fromWire('queue'), ShopMode.queue);
    expect(ShopMode.fromWire('both'), ShopMode.both);
    expect(
      ShopSummaryDto.fromJson({
        'shopId': 's',
        'mode': 'queue',
      }).toDomain()?.mode,
      ShopMode.queue,
    );
  });
}

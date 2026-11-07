import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/features/home/widgets/home_filters.dart';
import 'package:booknow_mobile/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

ShopSummary _shop(
  String id, {
  String city = 'Milano',
  ShopMode mode = ShopMode.queue,
  String? category,
}) => ShopSummary(
  id: id,
  name: id,
  addressLine: null,
  city: city,
  distanceMeters: null,
  openNow: true,
  closesAt: null,
  opensAt: null,
  activeServices: 1,
  fromPriceCents: null,
  photoUrl: null,
  mode: mode,
  category: category,
);

ShopQueue _queue(String id, int fromMin, {QueueClosedReason? closed}) =>
    ShopQueue(
      shopId: id,
      state: QueueState.open,
      closedReason: closed,
      waitingCount: fromMin,
      inChair: false,
      estimate: WaitRange(fromMin: fromMin, toMin: fromMin + 10),
      feeCents: 149,
      myEntry: null,
    );

FreeSlot _slot(String shopId, int hour) => FreeSlot(
  shopId: shopId,
  shopName: shopId,
  serviceId: 's',
  serviceName: 'Cut',
  durationMinutes: 30,
  priceCents: 1000,
  startUtc: DateTime.utc(2026, 11, 5, hour),
);

void main() {
  group('visibleShops', () {
    test('right now is the lines taking people, shortest wait first', () {
      final result = visibleShops(
        [
          _shop('long'),
          _shop('short'),
          _shop('closed'),
          _shop('book', mode: ShopMode.booking),
        ],
        intent: HomeIntent.now,
        queues: {
          'long': _queue('long', 30),
          'short': _queue('short', 5),
          'closed': _queue('closed', 1, closed: QueueClosedReason.values.first),
        },
      );

      expect(result.map((s) => s.id), ['short', 'long']);
    });

    test('a shop taking both is in the line and in tomorrow', () {
      final both = _shop('both', mode: ShopMode.both);

      expect(visibleShops([both], intent: HomeIntent.now, queues: const {}), [
        both,
      ]);
      expect(
        visibleShops([both], intent: HomeIntent.tomorrow, queues: const {}),
        [both],
      );
    });

    test('a line not read yet stays in, last', () {
      final result = visibleShops(
        [_shop('unread'), _shop('read')],
        intent: HomeIntent.now,
        queues: {'read': _queue('read', 5)},
      );

      expect(result.map((s) => s.id), ['read', 'unread']);
    });

    test('today is soonest time first', () {
      final late = _shop('late', mode: ShopMode.booking);
      final early = _shop('early', mode: ShopMode.booking);

      final result = visibleShops([
        late,
        early,
      ], nextSlots: firstSlots([_slot('late', 17), _slot('early', 9)]));

      expect(result.map((s) => s.id), ['early', 'late']);
    });

    test('tomorrow is only what can be booked: a queue is for today', () {
      final result = visibleShops([
        _shop('line'),
        _shop('book', mode: ShopMode.booking),
      ], intent: HomeIntent.tomorrow);

      expect(result.map((s) => s.id), ['book']);
    });

    test('a city narrows it', () {
      final result = visibleShops([
        _shop('a'),
        _shop('b', city: 'Roma'),
      ], city: 'Roma');

      expect(result.map((s) => s.id), ['b']);
    });

    test('a category narrows it, but a shop with none stays visible', () {
      final result = visibleShops([
        _shop('barber', category: 'barber'),
        _shop('nails', category: 'nails'),
        _shop('unknown'),
      ], category: ShopCategory.barber);

      expect(result.map((s) => s.id), ['barber', 'unknown']);
    });
  });

  test('firstSlots keeps the earliest of each shop', () {
    final first = firstSlots([_slot('a', 17), _slot('a', 9), _slot('b', 12)]);

    expect(first['a']!.startUtc.hour, 9);
    expect(first['b']!.startUtc.hour, 12);
  });

  group('the header', () {
    Widget header({required bool mini}) => SingleChildScrollView(
      child: HomeHeader(
        greeting: 'Ciao Marco.',
        headline: '5 shops can see you now',
        mini: mini,
        category: ShopCategory.barber,
        location: 'Milano',
        onCategory: (_) {},
        onClearCategory: () {},
        onLocation: () {},
        onSearch: () {},
      ),
    );

    testWidgets('open: says what is available and names the categories', (
      tester,
    ) async {
      await pumpThemed(tester, header(mini: false));
      await tester.pumpAndSettle();

      expect(find.textContaining('5 shops can see you now'), findsOneWidget);
      expect(find.text('Nails'), findsOneWidget);
    });

    testWidgets('shrunk: the categories stay, without their labels', (
      tester,
    ) async {
      await pumpThemed(tester, header(mini: true));
      await tester.pumpAndSettle();

      expect(find.textContaining('5 shops can see you now'), findsNothing);
      expect(find.text('Nails'), findsNothing);
      expect(find.byType(CategoryPicture), findsWidgets);
    });
  });

  test('no category shape is a perfect circle', () {
    for (final category in ShopCategory.values) {
      final radius = blobRadius(category, 100, 100);

      expect(radius.topLeft.x, isNot(radius.topRight.x));
    }
  });
}

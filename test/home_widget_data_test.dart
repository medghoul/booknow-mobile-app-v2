import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home_widgets/home_widget_data.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

final DateTime now = DateTime.utc(2026, 11, 6, 12);
final Translations en = AppLocale.en.buildSync();

QueueEntry place({
  QueueEntryStatus status = QueueEntryStatus.waiting,
  DateTime? noShowFrom,
}) => QueueEntry(
  id: 'e',
  shopId: 's',
  shopName: 'Barberia Navigli',
  status: status,
  serviceId: 'cut',
  serviceName: 'Fade',
  durationMinutes: 30,
  priceCents: 1800,
  feeCents: 149,
  position: 3,
  aheadCount: 2,
  estimate: const WaitRange(fromMin: 20, toMin: 30),
  refundIfLeaving: false,
  holdExpiresAt: null,
  calledAt: null,
  noShowFrom: noShowFrom,
  refunded: false,
);

Booking visit({
  String shop = 'Studio Capelli',
  BookingStatus status = BookingStatus.confirmed,
}) {
  final start = now.add(const Duration(days: 1));

  return Booking(
    id: 'b',
    status: status,
    startUtc: start,
    endUtc: start.add(const Duration(minutes: 30)),
    durationMinutes: 30,
    timeZone: 'Europe/Rome',
    shopId: 's',
    shopName: shop,
    shopAddressLine: 'Via Tortona 18',
    shopPhone: null,
    serviceId: 'cut',
    serviceName: 'Cut',
    priceCents: 3800,
    feeCents: 0,
    freeCancellationUntilUtc: start,
    holdExpiresAt: null,
    cardBrand: null,
    cardLast4: null,
    cancelledBy: null,
    refunded: false,
  );
}

WidgetValues customer({
  QueueEntry? entry,
  List<Booking> upcoming = const [],
  List<Booking> past = const [],
}) => customerWidgetValues(
  t: en,
  locale: 'en',
  now: now,
  entry: entry,
  upcoming: upcoming,
  past: past,
);

void main() {
  setUpAll(initializeDateFormatting);

  group('a customer widget', () {
    test('puts a place in line ahead of a booking', () {
      final values = customer(entry: place(), upcoming: [visit()]);

      expect(values['big'], '#3');
      expect(values['title'], 'Barberia Navigli');
      expect(values['foot'], '2 people ahead');
    });

    test('stops vouching for a place in line after half an hour', () {
      final values = customer(entry: place());
      final until = DateTime.fromMillisecondsSinceEpoch(
        int.parse(values['freshUntil']!),
        isUtc: true,
      );

      expect(until, now.add(const Duration(minutes: 30)));
      expect(values['stale'], en.homeWidgets.staleQueue);
    });

    test('turns green at their turn, until the grace runs out', () {
      final graceEnds = now.add(const Duration(minutes: 7));
      final values = customer(
        entry: place(status: QueueEntryStatus.called, noShowFrom: graceEnds),
      );

      expect(values['tone'], 'green');
      expect(values['title'], en.queue.turnTitle);
      expect(values['freshUntil'], '${graceEnds.millisecondsSinceEpoch}');
    });

    test('shows the next confirmed visit, never one still unpaid', () {
      final unpaid = visit(
        shop: 'Unpaid',
        status: BookingStatus.pendingPayment,
      );
      final values = customer(upcoming: [unpaid, visit()]);

      expect(values['overline'], en.homeWidgets.nextVisit);
      expect(values['title'], 'Studio Capelli');
      expect(values['geo'], contains('Via%20Tortona%2018'));
    });

    test('offers each usual shop once when nothing is booked', () {
      final values = customer(
        past: [
          visit(shop: 'A'),
          visit(shop: 'A'),
          visit(shop: 'B'),
        ],
      );

      expect(values['overline'], en.homeWidgets.bookAgain);
      expect(values['title'], 'A');
      expect(values['line'], 'B');
    });

    test('invites a guest to look around', () {
      expect(customer()['title'], en.homeWidgets.findTitle);
    });
  });

  group('an owner widget', () {
    OwnerQueueEntry entry(QueueEntryStatus status, String? name) =>
        OwnerQueueEntry(
          id: name ?? 'walk-in',
          status: status,
          kind: QueueEntryKind.app,
          customerName: name,
          serviceId: 'cut',
          serviceName: 'Fade',
          durationMinutes: 30,
          joinedAt: now,
          calledAt: null,
          startedAt: null,
          noShowFrom: null,
        );

    test('shows the line and who is next, naming a walk-in as one', () {
      final values = ownerQueueWidgetValues(
        t: en,
        now: now,
        shopName: 'Old Town',
        queue: OwnerQueue(
          localDate: '2026-11-06',
          state: QueueState.open,
          waitingCount: 2,
          emptiesAt: null,
          entries: [
            entry(QueueEntryStatus.waiting, null),
            entry(QueueEntryStatus.waiting, 'Anna'),
          ],
        ),
      );

      expect(values['overline'], 'Old Town · Open');
      expect(values['big'], '2');
      expect(values['title'], en.queue.owner.walkInName);
      expect(values['row2Name'], 'Anna');
      expect(values['row3Name'], isNull);
    });

    test('says when nothing is left in the day', () {
      final values = ownerDayWidgetValues(
        t: en,
        locale: 'en',
        now: now,
        shopName: 'Old Town',
        day: AgendaDay(
          date: '2026-11-06',
          timeZone: 'Europe/Rome',
          closed: false,
          closure: false,
          openingHours: const [],
          summary: const AgendaSummary(booked: 0, free: 0, toCollectCents: 0),
          days: const [],
          rows: const [],
        ),
      );

      expect(values['title'], en.homeWidgets.nothingLeft);
      expect(values['big'], '');
    });
  });
}

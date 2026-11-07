import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_view.dart';
import 'package:flutter_test/flutter_test.dart';

AgendaBookingRow _booking(
  String id,
  int startHour, {
  BookingStatus status = BookingStatus.confirmed,
}) {
  final start = DateTime.utc(2026, 11, 6, startHour);
  final end = start.add(const Duration(minutes: 30));

  return AgendaBookingRow(
    id: id,
    startUtc: start,
    endUtc: end,
    occupiedUntilUtc: end,
    durationMinutes: 30,
    status: status,
    serviceName: 'Fade',
    priceCents: 2000,
    feeCents: 149,
    customerName: id,
    customerPhone: null,
  );
}

void main() {
  group('todayFocus', () {
    final morning = _booking('morning', 9);
    final noon = _booking('noon', 12);
    final late = _booking('late', 17);

    test('is the booking happening now', () {
      final now = DateTime.utc(2026, 11, 6, 12, 10);

      expect(todayFocus([morning, noon, late], now), noon);
    });

    test('is the next one when nothing is happening', () {
      final now = DateTime.utc(2026, 11, 6, 13);

      expect(todayFocus([morning, noon, late], now), late);
    });

    test('is nothing once the day is over', () {
      final now = DateTime.utc(2026, 11, 6, 20);

      expect(todayFocus([morning, noon, late], now), isNull);
    });

    test('skips a cancelled booking and a missed one', () {
      final now = DateTime.utc(2026, 11, 6, 8);
      final rows = [
        _booking('gone', 9, status: BookingStatus.cancelled),
        _booking('missed', 10, status: BookingStatus.noShow),
        late,
      ];

      expect(todayFocus(rows, now), late);
    });

    test('keeps a customer who has arrived and is in the chair', () {
      final now = DateTime.utc(2026, 11, 6, 9, 5);
      final arrived = _booking('here', 9, status: BookingStatus.arrived);

      expect(todayFocus([arrived, late], now), arrived);
    });
  });
}

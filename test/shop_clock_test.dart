import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:flutter_test/flutter_test.dart';

/// The shop's clock, which is the only one the agenda may be read on.
///
/// Dart ships no time zone database, so the EU's own rule is written out in
/// [ShopClock] instead — and a rule written out is a rule that needs pinning
/// to the dates it claims. These are the real 2026 change-over Sundays:
/// 29 March and 25 October, both at 01:00 UTC.
void main() {
  const rome = 'Europe/Rome';

  DateTime utc(String iso) => DateTime.parse('${iso}Z').toUtc();

  group('offsetFor', () {
    test('is one hour ahead in winter and two in summer', () {
      expect(offsetHours('2026-01-15T12:00:00'), 1);
      expect(offsetHours('2026-07-15T12:00:00'), 2);
    });

    test('changes at 01:00 UTC on the last Sunday of March', () {
      expect(offsetHours('2026-03-29T00:59:00'), 1);
      expect(offsetHours('2026-03-29T01:00:00'), 2);
    });

    test('changes back at 01:00 UTC on the last Sunday of October', () {
      expect(offsetHours('2026-10-25T00:59:00'), 2);
      expect(offsetHours('2026-10-25T01:00:00'), 1);
    });

    /// 2027 moves both Sundays — 28 March and 31 October — which a tabulated
    /// offset would get wrong and a rule gets right.
    test('follows the rule into another year', () {
      expect(offsetHours('2027-03-28T00:59:00'), 1);
      expect(offsetHours('2027-03-28T01:00:00'), 2);
      expect(offsetHours('2027-10-31T00:59:00'), 2);
      expect(offsetHours('2027-10-31T01:00:00'), 1);
    });

    /// A zone with no rule formats as UTC and says so in the log. Visibly
    /// wrong beats the device's own time, which is right in Italy and wrong
    /// everywhere else — and that is the failure nobody would notice.
    test('falls back to UTC for a zone it has no rule for', () {
      expect(
        ShopClock.offsetFor(utc('2026-07-15T12:00:00'), 'America/New_York'),
        Duration.zero,
      );
    });
  });

  group('wallTime', () {
    test('reads a summer instant on the shop clock', () {
      expect(ShopClock.wallTime(utc('2026-10-03T07:30:00'), rome).hour, 9);
    });

    test('reads a winter instant an hour differently', () {
      expect(ShopClock.wallTime(utc('2026-12-03T08:30:00'), rome).hour, 9);
    });

    /// The reason the day comes from the shop and not the phone: at 23:30 in
    /// Rome it is already the next day, and a booking at that hour belongs in
    /// the column the owner is looking at.
    test('gives the shop its own calendar day', () {
      expect(ShopClock.dateOf(utc('2026-07-03T22:30:00'), rome), '2026-07-04');
      expect(ShopClock.dateOf(utc('2026-07-03T21:30:00'), rome), '2026-07-03');
    });
  });

  group('instantOf', () {
    test('turns a picked wall time back into an instant', () {
      expect(
        ShopClock.instantOf(DateTime.utc(2026, 10, 3), 9, 30, rome),
        utc('2026-10-03T07:30:00'),
      );
    });

    test('round-trips through wallTime', () {
      final instant = utc('2026-02-11T14:05:00');
      final wall = ShopClock.wallTime(instant, rome);

      expect(ShopClock.instantOf(wall, wall.hour, wall.minute, rome), instant);
    });

    test('is right on both sides of the day the clocks go forward', () {
      expect(
        ShopClock.instantOf(DateTime.utc(2026, 3, 29), 9, 0, rome),
        utc('2026-03-29T07:00:00'),
      );
      expect(
        ShopClock.instantOf(DateTime.utc(2026, 10, 25), 9, 0, rome),
        utc('2026-10-25T08:00:00'),
      );
    });

    /// What the second offset pass is for.
    ///
    /// 01:30 on the Sunday the clocks go forward is still winter time, but a
    /// first guess made in UTC lands at 01:30 UTC, which is already past the
    /// change — so the offset read there is the summer one and the answer is
    /// an hour out. Nine in the morning is on the same side of the boundary
    /// either way and never shows it.
    test('is right inside the hour the clocks move', () {
      expect(
        ShopClock.instantOf(DateTime.utc(2026, 3, 29), 1, 30, rome),
        utc('2026-03-29T00:30:00'),
      );
      expect(
        ShopClock.instantOf(DateTime.utc(2026, 10, 25), 1, 30, rome),
        utc('2026-10-24T23:30:00'),
      );
    });

    /// 02:30 does not happen on the Sunday the clocks skip from 02:00 to
    /// 03:00. It resolves forward, to the same instant as 03:30 — which is
    /// what a shop blocking "from half past two" would mean.
    test('resolves a wall time that never happens forward', () {
      final skipped = ShopClock.instantOf(
        DateTime.utc(2026, 3, 29),
        2,
        30,
        rome,
      );

      expect(skipped, utc('2026-03-29T01:30:00'));
      expect(
        skipped,
        ShopClock.instantOf(DateTime.utc(2026, 3, 29), 3, 30, rome),
      );
    });

    /// 01:30 happens twice on the Sunday the clocks go back. The first one is
    /// returned — the earlier instant, which is the one still on summer time.
    test('resolves a wall time that happens twice to the first of them', () {
      expect(
        ShopClock.wallTime(
          ShopClock.instantOf(DateTime.utc(2026, 10, 25), 1, 30, rome),
          rome,
        ).hour,
        1,
      );
    });
  });

  group('calendarDay', () {
    test('reads a date string as that calendar day, in UTC', () {
      final day = ShopClock.calendarDay('2026-10-03');

      expect(day.isUtc, isTrue);
      expect(day.day, 3);
      expect(day.month, 10);
    });

    test('survives a date it cannot read', () {
      expect(ShopClock.calendarDay('not a date').year, 1970);
    });
  });
}

int offsetHours(String iso) =>
    ShopClock.offsetFor(DateTime.parse('${iso}Z'), 'Europe/Rome').inHours;

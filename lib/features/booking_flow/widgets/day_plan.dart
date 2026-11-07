import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/slot_grid.dart';

/// A day of the shop's grid, as the picker draws it.
///
/// The availability endpoint answers with the times that can be *sold*, which
/// is not enough to draw the design: a grid of only free times reads as a shop
/// with four openings, not as a day that is mostly booked. So the marks come
/// from the shop's own opening hours and each is then classified against the
/// list the server sent.
///
/// A mark the server left out is drawn as taken. Most of them are — somebody
/// has the slot — and a few are marks where the service would not fit before
/// closing. Both mean the same thing to the customer: not this one.
class DayPlan {
  const DayPlan({
    required this.morning,
    required this.afternoon,
    required this.breakFrom,
    required this.breakTo,
    required this.closed,
  });

  final List<GridSlot> morning;
  final List<GridSlot> afternoon;

  /// The shop's lunch break, as wall-clock strings, when it has one.
  final String? breakFrom;
  final String? breakTo;

  /// No opening hours at all on this day, or a closure.
  final bool closed;

  bool get isEmpty => morning.isEmpty && afternoon.isEmpty;

  /// The day's times still to come, in order: what has passed is not offered.
  List<GridSlot> get upcoming => [
    ...morning,
    ...afternoon,
  ].where((slot) => slot.state != SlotState.past).toList();

  /// Times before this hour sit under "morning", the rest under "afternoon".
  ///
  /// The split is the clock, not the opening ranges: a shop with one long
  /// range still reads better in two halves, and one with three would have no
  /// obvious second heading.
  static const int _afternoonFromHour = 13;

  /// Candidates are every quarter hour inside the opening ranges (§6.2).
  static const int _stepMinutes = 15;

  static DayPlan from({
    required Shop shop,
    required String date,
    required String timeZone,
    required Availability? availability,
    required DateTime? selected,
    required DateTime now,
  }) {
    final day = ShopClock.calendarDay(date);
    final weekday = Weekday.values[day.weekday - 1];
    final ranges = shop.openingHours
        .rangesOn(weekday)
        .where((range) => range.isValid)
        .toList();

    if (ranges.isEmpty || shop.closures.contains(date)) {
      return const DayPlan(
        morning: [],
        afternoon: [],
        breakFrom: null,
        breakTo: null,
        closed: true,
      );
    }

    final free = availability?.starts.toSet() ?? const <DateTime>{};
    final morning = <GridSlot>[];
    final afternoon = <GridSlot>[];

    for (final range in ranges) {
      for (
        var minutes = _ceilToStep(range.fromMinutes);
        minutes < range.toMinutes;
        minutes += _stepMinutes
      ) {
        final start = ShopClock.instantOf(
          day,
          minutes ~/ 60,
          minutes % 60,
          timeZone,
        );

        final slot = GridSlot(
          startUtc: start,
          state: _stateOf(
            start: start,
            free: free,
            selected: selected,
            now: now,
          ),
        );

        (minutes < _afternoonFromHour * 60 ? morning : afternoon).add(slot);
      }
    }

    return DayPlan(
      morning: morning,
      afternoon: afternoon,
      // Only the first gap: a day with three ranges is not a product v0 sells,
      // and naming one break is better than listing every pause.
      breakFrom: ranges.length > 1 ? ranges.first.to : null,
      breakTo: ranges.length > 1 ? ranges[1].from : null,
      closed: false,
    );
  }

  static SlotState _stateOf({
    required DateTime start,
    required Set<DateTime> free,
    required DateTime? selected,
    required DateTime now,
  }) {
    if (selected != null && start.isAtSameMomentAs(selected)) {
      return SlotState.selected;
    }
    // Past before taken: a time that has already gone is past whatever the
    // server thinks of it, and "occupato" on this morning's nine o'clock would
    // be a lie.
    if (!start.isAfter(now)) return SlotState.past;
    if (free.any(start.isAtSameMomentAs)) return SlotState.free;
    return SlotState.taken;
  }

  static int _ceilToStep(int minutes) =>
      (minutes + _stepMinutes - 1) ~/ _stepMinutes * _stepMinutes;
}

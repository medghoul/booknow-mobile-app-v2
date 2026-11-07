import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours.freezed.dart';

/// A single open range within a day, as `HH:mm` strings.
///
/// Kept as strings rather than `TimeOfDay` because that is what the API
/// stores, and because a shop's hours are wall-clock in the shop's own
/// timezone — converting them through a device-local `DateTime` is how you end
/// up opening an hour early in March.
@freezed
abstract class TimeRange with _$TimeRange {
  const factory TimeRange({required String from, required String to}) =
      _TimeRange;

  const TimeRange._();

  /// Minutes since midnight, for ordering and overlap checks.
  static int _minutes(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return 0;
    return (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
  }

  int get fromMinutes => _minutes(from);

  int get toMinutes => _minutes(to);

  /// A range that ends before it starts is not a valid range. Overnight
  /// opening is out of scope for v0 — no barber in the pilot works past
  /// midnight.
  bool get isValid => toMinutes > fromMinutes;

  bool overlaps(TimeRange other) =>
      fromMinutes < other.toMinutes && other.fromMinutes < toMinutes;

  /// What a day opens with until the owner says otherwise: a morning, a lunch
  /// break, an afternoon. Taken from the design's own Tuesday.
  static const List<TimeRange> defaultDay = [
    TimeRange(from: '09:00', to: '13:00'),
    TimeRange(from: '15:00', to: '19:00'),
  ];
}

/// The weekly opening hours: a list of ranges per day.
///
/// A day with no ranges is closed. A lunch break is simply the gap between two
/// ranges, which is why this is a list rather than a single open/close pair.
@freezed
abstract class OpeningHours with _$OpeningHours {
  const factory OpeningHours([
    @Default(<Weekday, List<TimeRange>>{}) Map<Weekday, List<TimeRange>> byDay,
  ]) = _OpeningHours;

  const OpeningHours._();

  List<TimeRange> rangesOn(Weekday day) => byDay[day] ?? const [];

  bool isOpenOn(Weekday day) => rangesOn(day).isNotEmpty;

  bool get hasAnyOpenDay => byDay.values.any((ranges) => ranges.isNotEmpty);

  Iterable<Weekday> get openDays => Weekday.values.where(isOpenOn);

  /// Every range on every day holds together: valid, and not overlapping
  /// another range on the same day.
  bool get isValid => byDay.values.every((ranges) {
    if (ranges.any((range) => !range.isValid)) return false;
    for (var i = 0; i < ranges.length; i++) {
      for (var j = i + 1; j < ranges.length; j++) {
        if (ranges[i].overlaps(ranges[j])) return false;
      }
    }
    return true;
  });

  OpeningHours setDay(Weekday day, List<TimeRange> ranges) {
    final next = Map<Weekday, List<TimeRange>>.from(byDay);
    if (ranges.isEmpty) {
      next.remove(day);
    } else {
      next[day] = List.unmodifiable(ranges);
    }
    return OpeningHours(next);
  }

  OpeningHours closeDay(Weekday day) => setDay(day, const []);

  /// Takes one day's ranges and applies them to every other day that is
  /// already open, leaving closed days closed. The wizard's shortcut, where
  /// the owner is filling in a week from nothing.
  OpeningHours copyToOpenDays(Weekday source) {
    final ranges = rangesOn(source);
    if (ranges.isEmpty) return this;

    final next = Map<Weekday, List<TimeRange>>.from(byDay);
    for (final day in byDay.keys) {
      if (byDay[day]?.isEmpty ?? true) continue;
      next[day] = List.unmodifiable(ranges);
    }
    return OpeningHours(next);
  }

  /// Writes [source]'s ranges onto the days in [targets] and leaves every
  /// other day alone.
  ///
  /// The edit screen's "Copia su altri giorni", where the owner names the days
  /// rather than taking all of them: a shop with a short Saturday does not
  /// want Tuesday's hours on it. A target that was closed opens — that is what
  /// choosing it means — and a closed [source] copies nothing, since there is
  /// nothing to copy and closing six days is not a thing anyone asks for by
  /// tapping "copy".
  OpeningHours copyDay(Weekday source, Iterable<Weekday> targets) {
    final ranges = rangesOn(source);
    if (ranges.isEmpty) return this;

    final next = Map<Weekday, List<TimeRange>>.from(byDay);
    for (final day in targets) {
      if (day == source) continue;
      next[day] = List.unmodifiable(ranges);
    }
    return OpeningHours(next);
  }
}

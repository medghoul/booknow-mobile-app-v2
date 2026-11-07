import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:intl/intl.dart';

/// The shop's wall clock, read off a UTC instant.
///
/// Every booking, block and opening range arrives as a UTC instant, and the
/// owner has to read them on the clock hanging in the shop — an owner on
/// holiday in London still opens an agenda that says 09:00 for the nine
/// o'clock client. `DateTime.toLocal()` would give them 08:00, so it is never
/// used on anything the server sent.
///
/// Dart ships no time zone database, and `package:timezone` is most of a
/// megabyte of it. v0 is one country, so the one rule that matters is written
/// out instead: the EU moves its clocks together, on the last Sunday of March
/// and of October, at 01:00 UTC in every member state at once. That is a date
/// calculation, not a table, and it does not expire.
///
/// Adding a zone outside the EU means this file grows a real rule for it, and
/// [offsetFor] saying so out loud is what makes that impossible to miss: an
/// unknown zone formats as UTC and logs, rather than quietly showing the
/// device's own time, which is right in Italy and wrong everywhere else.
abstract final class ShopClock {
  /// Standard-time offsets, in hours east of UTC. Summer time is the rule in
  /// [_isSummerTime], not another row here.
  static const Map<String, int> _standardOffsetHours = {'Europe/Rome': 1};

  /// How far [timeZone] is ahead of UTC at [instant].
  static Duration offsetFor(DateTime instant, String timeZone) {
    final standard = _standardOffsetHours[timeZone];
    if (standard == null) {
      AppLogger.warning(
        '[clock] no rule for "$timeZone" — times will be shown in UTC',
      );
      return Duration.zero;
    }

    final utc = instant.toUtc();
    return Duration(hours: standard + (_isSummerTime(utc) ? 1 : 0));
  }

  /// What a clock in [timeZone] reads at [instant].
  ///
  /// The result is flagged UTC and its fields are the shop's wall clock, which
  /// is exactly what `DateFormat` prints. It is a set of digits, not a moment:
  /// never compare it to [DateTime.now], and never send it anywhere.
  static DateTime wallTime(DateTime instant, String timeZone) =>
      instant.toUtc().add(offsetFor(instant, timeZone));

  /// The instant a wall-clock [hour]:[minute] on [date] happens.
  ///
  /// The inverse of [wallTime], and the direction the block sheet needs: the
  /// owner picks 14:30 on the shop's clock and the server wants the instant.
  /// The offset is read at a first guess and then at the corrected instant,
  /// because on the Sunday the clocks move the offset is different on the two
  /// sides of the time being solved for.
  static DateTime instantOf(
    DateTime date,
    int hour,
    int minute,
    String timeZone,
  ) {
    final asIfUtc = DateTime.utc(date.year, date.month, date.day, hour, minute);

    final firstGuess = asIfUtc.subtract(offsetFor(asIfUtc, timeZone));
    return asIfUtc.subtract(offsetFor(firstGuess, timeZone));
  }

  /// `09:30` on the shop's clock.
  static String hm(DateTime instant, String timeZone, String locale) =>
      DateFormat.Hm(locale).format(wallTime(instant, timeZone));

  /// Which day it is in [timeZone] at [instant], as `YYYY-MM-DD`.
  ///
  /// The shop's calendar, which at eleven at night is not the same day as a
  /// phone two zones east of it.
  static String dateOf(DateTime instant, String timeZone) =>
      wallTime(instant, timeZone).toIso8601String().substring(0, 10);

  /// A `YYYY-MM-DD` as a date whose fields are that calendar day.
  ///
  /// Flagged UTC so no zone conversion can move it: a date string carries no
  /// time, and reading it as local midnight is how a day becomes the one
  /// before it for anybody west of Greenwich.
  static DateTime calendarDay(String date) =>
      DateTime.tryParse('${date}T00:00:00Z')?.toUtc() ?? DateTime.utc(1970);

  /// `sabato 3 ottobre`, from a `YYYY-MM-DD`.
  static String dayTitle(String date, String locale) =>
      DateFormat('EEEE d MMMM', locale).format(calendarDay(date));

  /// Whether [utc] falls inside EU summer time.
  ///
  /// The change is at 01:00 UTC, simultaneously across the union, which is why
  /// this can be decided on a UTC instant without knowing the zone.
  static bool _isSummerTime(DateTime utc) {
    final from = _lastSundayAtOneUtc(utc.year, DateTime.march);
    final to = _lastSundayAtOneUtc(utc.year, DateTime.october);
    return !utc.isBefore(from) && utc.isBefore(to);
  }

  static DateTime _lastSundayAtOneUtc(int year, int month) {
    // Day zero of the next month is the last day of this one, which saves
    // knowing how long any month is.
    final lastDay = DateTime.utc(year, month + 1, 0);

    // `weekday` is 1 for Monday and 7 for Sunday, so `% 7` turns Sunday into
    // the zero that leaves the last day alone when it is already a Sunday.
    return DateTime.utc(year, month, lastDay.day - lastDay.weekday % 7, 1);
  }
}

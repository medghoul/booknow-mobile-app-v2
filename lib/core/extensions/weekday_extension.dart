import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/localization/localization.dart';

/// A weekday's name, in the active language.
///
/// A switch rather than a list indexed by [Weekday.index], so a day added to
/// the enum fails to compile instead of rendering a blank cell.
///
/// It takes the translations rather than a `BuildContext` because the callers
/// that fold several days into one string — the profile's "Mar–Sab" — are
/// static and have no context to pass.
extension WeekdayNames on Weekday {
  /// "Mar" — the three-letter form a row or a summary uses.
  String shortName(Translations t) {
    final short = t.weekdays.short;
    return switch (this) {
      Weekday.monday => short.mon,
      Weekday.tuesday => short.tue,
      Weekday.wednesday => short.wed,
      Weekday.thursday => short.thu,
      Weekday.friday => short.fri,
      Weekday.saturday => short.sat,
      Weekday.sunday => short.sun,
    };
  }

  /// "Martedì" — for a heading, where there is room for the whole word.
  String fullName(Translations t) {
    final long = t.weekdays.long;
    return switch (this) {
      Weekday.monday => long.mon,
      Weekday.tuesday => long.tue,
      Weekday.wednesday => long.wed,
      Weekday.thursday => long.thu,
      Weekday.friday => long.fri,
      Weekday.saturday => long.sat,
      Weekday.sunday => long.sun,
    };
  }
}

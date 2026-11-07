import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/opening_hours.dart';

/// The request side: domain going out, rather than JSON coming in.
///
/// Only opening hours need it — everything else the app sends is a scalar the
/// repository passes straight through.
abstract final class ShopRequests {
  /// Every day is written, including the closed ones: an absent key would
  /// read as "leave this day alone", and closing a day has to be sendable.
  static Map<String, dynamic> openingHours(OpeningHours hours) => {
    for (final day in Weekday.values)
      day.wireName: hours
          .rangesOn(day)
          .map((range) => {'from': range.from, 'to': range.to})
          .toList(),
  };
}

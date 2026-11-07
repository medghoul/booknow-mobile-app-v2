import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability.freezed.dart';

/// The start times one shop can sell for one service on one day.
///
/// An empty list is an ordinary answer, not an error: a closed day, a day past
/// the booking horizon and a fully booked day all come back the same way, and
/// the picker says the same thing for each.
@freezed
abstract class Availability with _$Availability {
  const factory Availability({
    required String date,
    required String timeZone,
    required int durationMinutes,
    required List<DateTime> starts,
  }) = _Availability;
}

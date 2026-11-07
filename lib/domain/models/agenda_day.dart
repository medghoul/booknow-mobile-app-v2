import 'package:booknow_mobile/domain/models/agenda_row.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_day.freezed.dart';

/// One day of the owner's agenda, as `GET /shops/me/agenda` answers it.
///
/// The date strip comes down with the day rather than being fetched per
/// column: the server counts every day in the window from one query, and the
/// owner swiping the strip would otherwise fire a request per tap.
@freezed
abstract class AgendaDay with _$AgendaDay {
  const factory AgendaDay({
    /// The day this is, as `YYYY-MM-DD` in the shop's own calendar.
    required String date,

    /// The zone every instant in here is read in — the shop's, never the
    /// device's. Passed to `ShopClock`, not to `toLocal`.
    required String timeZone,

    /// No opening hours at all on this weekday.
    required bool closed,

    /// Closed because the owner closed it, rather than because the weekday is
    /// not a working one. The strip looks the same; the empty day does not.
    required bool closure,

    required List<AgendaOpening> openingHours,
    required AgendaSummary summary,
    required List<AgendaStripDay> days,
    required List<AgendaRow> rows,

    /// Everyone working, by order, plus anyone removed since who still has a
    /// row on this day, so every row can be labelled (providers §5).
    @Default(<AgendaProvider>[]) List<AgendaProvider> providers,
  }) = _AgendaDay;

  const AgendaDay._();

  /// More than one person's time on this day, so rows say whose they are.
  bool get hasTeam => providers.length > 1;

  String? nameOf(String? providerId) {
    for (final provider in providers) {
      if (provider.id == providerId) return provider.name;
    }
    return null;
  }
}

/// Someone whose time is on the agenda.
@freezed
abstract class AgendaProvider with _$AgendaProvider {
  const factory AgendaProvider({
    required String id,

    /// The owner's own provider shows the shop's name until given one.
    String? name,
  }) = _AgendaProvider;
}

/// One opening range, already in instants.
@freezed
abstract class AgendaOpening with _$AgendaOpening {
  const factory AgendaOpening({
    required DateTime fromUtc,
    required DateTime toUtc,
  }) = _AgendaOpening;
}

/// The three pills above the timeline.
@freezed
abstract class AgendaSummary with _$AgendaSummary {
  const factory AgendaSummary({
    required int booked,
    required int free,

    /// Service money still to take in the shop. Never the €1.49 the app
    /// charged — that one is BookNow's, and putting it here would overstate
    /// the barber's day by it.
    required int toCollectCents,
  }) = _AgendaSummary;
}

/// One card in the swipeable date strip.
@freezed
abstract class AgendaStripDay with _$AgendaStripDay {
  const factory AgendaStripDay({
    required String date,
    required int bookings,
    required bool closed,
  }) = _AgendaStripDay;
}

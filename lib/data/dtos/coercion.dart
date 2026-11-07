/// Readers that take whatever the wire actually sent.
///
/// A DTO's job is to get the body in without throwing; these turn the loose
/// types that survive that into the exact ones the domain wants. They are here
/// rather than in each DTO so every `toDomain` coerces the same way.
library;

String asText(Object? value, [String fallback = '']) =>
    value is String ? value : fallback;

String? asTextOrNull(Object? value) =>
    value is String && value.isNotEmpty ? value : null;

/// Accepts a number sent as a number or as a string — both happen, and a
/// price arriving as `"1500"` should not become `0`.
int asInt(Object? value, [int fallback = 0]) => switch (value) {
  final int v => v,
  final num v => v.toInt(),
  final String v => int.tryParse(v) ?? fallback,
  _ => fallback,
};

double? asDoubleOrNull(Object? value) => switch (value) {
  final num v => v.toDouble(),
  final String v => double.tryParse(v),
  _ => null,
};

/// Absent means true: only a soft delete ever sets `active` to false.
bool asBool(Object? value, {required bool fallback}) =>
    value is bool ? value : fallback;

/// A nested object, or an empty one.
///
/// Empty rather than null so a reader can go straight on to the keys inside
/// without a null check at every level — a missing `dailySummary` and a
/// `dailySummary` with nothing in it both mean "no answer here", and the
/// per-field fallbacks already handle that.
///
/// Rebuilt entry by entry rather than cast: `jsonDecode` gives
/// `Map<String, dynamic>`, but a map written in Dart arrives as whatever the
/// literal inferred, and a failed cast would read as an absent object.
Map<String, dynamic> asMap(Object? value) => value is Map
    ? {for (final entry in value.entries) '${entry.key}': entry.value}
    : const {};

/// A UTC instant from an ISO 8601 string, or null when the wire sent anything
/// else.
///
/// Normalised to UTC on the way in so nothing downstream has to wonder which
/// zone a `DateTime` is flagged with: the server sends instants, the app shows
/// them on the shop's clock, and `toLocal` never enters it.
DateTime? asInstantOrNull(Object? value) =>
    value is String ? DateTime.tryParse(value)?.toUtc() : null;

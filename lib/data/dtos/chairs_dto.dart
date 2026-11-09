import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/chairs.dart';

/// Reads `GET /v1/shops/me/chairs`, and the body of a Start or a Done.
///
/// An unreadable visit reads as nobody rather than failing the board: the
/// barber still needs the chairs the app can read.
ChairBoard chairBoardFromJson(Map<String, dynamic> json) => ChairBoard(
  localDate: asText(json['localDate']),
  timeZone: asText(json['timeZone'], 'Europe/Rome'),
  chairs: [
    for (final row
        in (json['chairs'] as List?)?.whereType<Map>() ?? const <Map>[])
      ?_chair(asMap(row)),
  ],
);

Chair? _chair(Map<String, dynamic> json) {
  final providerId = asTextOrNull(json['providerId']);
  if (providerId == null) return null;

  final upNext = asMap(json['upNext']);
  final nextVisit = _visit(upNext['visit']);

  return Chair(
    providerId: providerId,
    name: asTextOrNull(json['name']),
    current: _visit(json['current']),
    called: _visit(json['called']),
    nextVisit: nextVisit,
    nextAction: nextVisit == null
        ? null
        : (asTextOrNull(upNext['action']) == 'call'
              ? ChairNextAction.call
              : ChairNextAction.start),
    nextInQueue: _visit(json['nextInQueue']),
    nextBooking: _visit(json['nextBooking']),
  );
}

ChairVisit? _visit(Object? value) {
  if (value is! Map) return null;
  final json = asMap(value);
  final kind = VisitKind.fromWire(asTextOrNull(json['kind']));
  final id = asTextOrNull(json['visitId']);
  if (kind == null || id == null) return null;

  return ChairVisit(
    kind: kind,
    id: id,
    customerName: asTextOrNull(json['customerName']),
    serviceName: asText(json['serviceName']),
    plannedMinutes: asInt(json['plannedMin'], 30),
    scheduledAt: asInstantOrNull(json['scheduledAt']),
    startedAt: asInstantOrNull(json['startedAt']),
    noShowFrom: asInstantOrNull(json['noShowFrom']),
  );
}

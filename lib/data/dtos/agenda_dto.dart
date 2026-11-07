import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/agenda_day.dart';
import 'package:booknow_mobile/domain/models/agenda_row.dart';
import 'package:booknow_mobile/domain/models/time_block.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_dto.freezed.dart';
part 'agenda_dto.g.dart';

/// `GET /v1/shops/me/agenda?date=`.
///
/// The rows arrive as a heterogeneous list tagged with `kind`, so they are
/// read as raw maps: `json_serializable` would need a discriminator and a
/// class per shape to do the same thing, and would throw on a `kind` this
/// build has never heard of instead of skipping it.
@freezed
abstract class AgendaDayDto with _$AgendaDayDto {
  const factory AgendaDayDto({
    @JsonKey(name: 'date') Object? date,
    @JsonKey(name: 'timeZone') Object? timeZone,
    @JsonKey(name: 'closed') Object? closed,
    @JsonKey(name: 'closure') Object? closure,
    @JsonKey(name: 'openingHours') List<dynamic>? openingHours,
    @JsonKey(name: 'summary') Map<String, dynamic>? summary,
    @JsonKey(name: 'days') List<dynamic>? days,
    @JsonKey(name: 'rows') List<dynamic>? rows,
    @JsonKey(name: 'providers') List<dynamic>? providers,
  }) = _AgendaDayDto;

  factory AgendaDayDto.fromJson(Map<String, dynamic> json) =>
      _$AgendaDayDtoFromJson(json);
}

/// `POST /v1/shops/me/blocks`.
@freezed
abstract class BlockDto with _$BlockDto {
  const factory BlockDto({
    @JsonKey(name: 'blockId') Object? blockId,
    @JsonKey(name: 'id') Object? id,
    @JsonKey(name: 'startUtc') Object? startUtc,
    @JsonKey(name: 'endUtc') Object? endUtc,
    @JsonKey(name: 'note') Object? note,
  }) = _BlockDto;

  factory BlockDto.fromJson(Map<String, dynamic> json) =>
      _$BlockDtoFromJson(json);
}

extension AgendaDayDtoX on AgendaDayDto {
  AgendaDay toDomain() {
    final day = asText(date);

    return AgendaDay(
      date: day,
      // Falls back to the one zone v0 ships in rather than to the device's:
      // an absent field is a server that did not say, not permission to show
      // the owner their phone's idea of the time.
      timeZone: asText(timeZone, 'Europe/Rome'),
      closed: asBool(closed, fallback: false),
      closure: asBool(closure, fallback: false),
      openingHours: _openings(openingHours),
      summary: _summary(summary),
      days: _strip(days),
      rows: _rows(rows),
      providers: [
        for (final entry in providers?.whereType<Map>() ?? const <Map>[])
          if (asTextOrNull(entry['providerId']) case final id?)
            AgendaProvider(id: id, name: asTextOrNull(entry['name'])),
      ],
    );
  }
}

extension BlockDtoX on BlockDto {
  /// Null when the range is unreadable — a block with no start is not a block,
  /// and the repository turns that into a failure the owner can see rather
  /// than into a row at the epoch.
  TimeBlock? toDomain() {
    final from = asInstantOrNull(startUtc);
    final to = asInstantOrNull(endUtc);
    if (from == null || to == null) return null;

    return TimeBlock(
      id: asText(blockId, asText(id)),
      startUtc: from,
      endUtc: to,
      note: asTextOrNull(note),
    );
  }
}

List<AgendaOpening> _openings(List<dynamic>? json) => [
  for (final entry in json?.whereType<Map>() ?? const <Map>[])
    if (asInstantOrNull(entry['fromUtc']) case final from?)
      if (asInstantOrNull(entry['toUtc']) case final to?)
        AgendaOpening(fromUtc: from, toUtc: to),
];

AgendaSummary _summary(Map<String, dynamic>? json) => AgendaSummary(
  booked: asInt(json?['booked']),
  free: asInt(json?['free']),
  toCollectCents: asInt(json?['toCollectCents']),
);

List<AgendaStripDay> _strip(List<dynamic>? json) => [
  for (final entry in json?.whereType<Map>() ?? const <Map>[])
    if (asTextOrNull(entry['date']) case final date?)
      AgendaStripDay(
        date: date,
        bookings: asInt(entry['bookings']),
        closed: asBool(entry['closed'], fallback: false),
      ),
];

/// The rows, in the order the server sorted them.
///
/// A row the app cannot place is dropped rather than failing the day: a kind
/// added by a newer API, or a row whose instants are unreadable, costs the
/// owner one line — failing the parse would cost them the whole agenda.
List<AgendaRow> _rows(List<dynamic>? json) => [
  for (final entry in json?.whereType<Map>() ?? const <Map>[]) ?_row(entry),
];

AgendaRow? _row(Map<dynamic, dynamic> json) {
  final from = asInstantOrNull(json['startUtc']);
  final to = asInstantOrNull(json['endUtc']);
  if (from == null || to == null) return null;

  return switch (asText(json['kind'])) {
    'booking' => AgendaRow.booking(
      id: asText(json['bookingId'], asText(json['id'])),
      startUtc: from,
      endUtc: to,
      // Absent means the slot frees the moment the service ends, which is the
      // safe reading: it can only ever show the owner less time as taken.
      occupiedUntilUtc: asInstantOrNull(json['occupiedUntilUtc']) ?? to,
      // The wire's own duration rather than the difference between the two
      // instants: it is what the service was sold as, and the row's height is
      // meant to track that even if a minute of rounding creeps in.
      durationMinutes: asInt(
        json['durationMin'],
        to.difference(from).inMinutes,
      ),
      status: BookingStatus.fromWire(asText(json['status'])),
      serviceName: asText(json['serviceName']),
      priceCents: asInt(json['priceCents']),
      feeCents: asInt(json['feeAmountCents']),
      customerName: asTextOrNull(json['customerName']),
      customerPhone: asTextOrNull(json['customerPhone']),
      providerId: asTextOrNull(json['providerId']),
    ),
    'block' => AgendaRow.block(
      id: asText(json['blockId'], asText(json['id'])),
      startUtc: from,
      endUtc: to,
      note: asTextOrNull(json['note']),
      providerId: asTextOrNull(json['providerId']),
    ),
    'free' => AgendaRow.free(
      startUtc: from,
      endUtc: to,
      freedBy: asTextOrNull(json['freedBy']),
      providerId: asTextOrNull(json['providerId']),
    ),
    _ => null,
  };
}

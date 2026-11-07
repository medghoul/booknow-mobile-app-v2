// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AgendaDayDto _$AgendaDayDtoFromJson(Map<String, dynamic> json) =>
    _AgendaDayDto(
      date: json['date'],
      timeZone: json['timeZone'],
      closed: json['closed'],
      closure: json['closure'],
      openingHours: json['openingHours'] as List<dynamic>?,
      summary: json['summary'] as Map<String, dynamic>?,
      days: json['days'] as List<dynamic>?,
      rows: json['rows'] as List<dynamic>?,
    );

Map<String, dynamic> _$AgendaDayDtoToJson(_AgendaDayDto instance) =>
    <String, dynamic>{
      'date': ?instance.date,
      'timeZone': ?instance.timeZone,
      'closed': ?instance.closed,
      'closure': ?instance.closure,
      'openingHours': ?instance.openingHours,
      'summary': ?instance.summary,
      'days': ?instance.days,
      'rows': ?instance.rows,
    };

_BlockDto _$BlockDtoFromJson(Map<String, dynamic> json) => _BlockDto(
  blockId: json['blockId'],
  id: json['id'],
  startUtc: json['startUtc'],
  endUtc: json['endUtc'],
  note: json['note'],
);

Map<String, dynamic> _$BlockDtoToJson(_BlockDto instance) => <String, dynamic>{
  'blockId': ?instance.blockId,
  'id': ?instance.id,
  'startUtc': ?instance.startUtc,
  'endUtc': ?instance.endUtc,
  'note': ?instance.note,
};

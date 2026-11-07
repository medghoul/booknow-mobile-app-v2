// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AvailabilityDto _$AvailabilityDtoFromJson(Map<String, dynamic> json) =>
    _AvailabilityDto(
      date: json['date'],
      timeZone: json['timeZone'],
      durationMin: json['durationMin'],
      starts: json['starts'] as List<dynamic>?,
    );

Map<String, dynamic> _$AvailabilityDtoToJson(_AvailabilityDto instance) =>
    <String, dynamic>{
      'date': ?instance.date,
      'timeZone': ?instance.timeZone,
      'durationMin': ?instance.durationMin,
      'starts': ?instance.starts,
    };

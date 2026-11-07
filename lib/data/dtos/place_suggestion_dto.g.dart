// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_suggestion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceSuggestionDto _$PlaceSuggestionDtoFromJson(Map<String, dynamic> json) =>
    _PlaceSuggestionDto(
      placeId: json['placeId'],
      id: json['id'],
      label: json['label'],
      text: json['text'],
      secondaryLabel: json['secondaryLabel'],
    );

Map<String, dynamic> _$PlaceSuggestionDtoToJson(_PlaceSuggestionDto instance) =>
    <String, dynamic>{
      'placeId': ?instance.placeId,
      'id': ?instance.id,
      'label': ?instance.label,
      'text': ?instance.text,
      'secondaryLabel': ?instance.secondaryLabel,
    };

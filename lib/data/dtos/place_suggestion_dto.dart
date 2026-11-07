import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/shop_address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion_dto.freezed.dart';
part 'place_suggestion_dto.g.dart';

/// One entry of `GET /places/autocomplete`.
@freezed
abstract class PlaceSuggestionDto with _$PlaceSuggestionDto {
  const factory PlaceSuggestionDto({
    @JsonKey(name: 'placeId') Object? placeId,
    @JsonKey(name: 'id') Object? id,
    @JsonKey(name: 'label') Object? label,
    @JsonKey(name: 'text') Object? text,
    @JsonKey(name: 'secondaryLabel') Object? secondaryLabel,
  }) = _PlaceSuggestionDto;

  factory PlaceSuggestionDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceSuggestionDtoFromJson(json);
}

extension PlaceSuggestionDtoX on PlaceSuggestionDto {
  PlaceSuggestion toDomain() => PlaceSuggestion(
    placeId: asText(placeId, asText(id)),
    label: asText(label, asText(text)),
    secondaryLabel: asTextOrNull(secondaryLabel),
  );
}

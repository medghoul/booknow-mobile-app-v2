import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/availability.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_dto.freezed.dart';
part 'availability_dto.g.dart';

/// `GET /v1/shops/{shopId}/availability?serviceId=&date=`.
@freezed
abstract class AvailabilityDto with _$AvailabilityDto {
  const factory AvailabilityDto({
    @JsonKey(name: 'date') Object? date,
    @JsonKey(name: 'timeZone') Object? timeZone,
    @JsonKey(name: 'durationMin') Object? durationMin,
    @JsonKey(name: 'starts') List<dynamic>? starts,
  }) = _AvailabilityDto;

  const AvailabilityDto._();

  factory AvailabilityDto.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityDtoFromJson(json);

  Availability toDomain() => Availability(
    date: asText(date),
    timeZone: asText(timeZone, 'Europe/Rome'),
    durationMinutes: asInt(durationMin, 30),
    starts: [
      for (final entry in starts ?? const <dynamic>[]) ?asInstantOrNull(entry),
    ],
  );
}

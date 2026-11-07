// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPreferencesDto _$NotificationPreferencesDtoFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferencesDto(
  newBooking: json['newBooking'],
  cancellation: json['cancellation'],
  dailySummary: json['dailySummary'],
  reminder: json['reminder'],
);

Map<String, dynamic> _$NotificationPreferencesDtoToJson(
  _NotificationPreferencesDto instance,
) => <String, dynamic>{
  'newBooking': ?instance.newBooking,
  'cancellation': ?instance.cancellation,
  'dailySummary': ?instance.dailySummary,
  'reminder': ?instance.reminder,
};

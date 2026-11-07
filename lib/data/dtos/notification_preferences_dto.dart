import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/notification_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_dto.freezed.dart';
part 'notification_preferences_dto.g.dart';

/// `notificationPrefs` on the profile.
///
/// The wire shape is nested — `dailySummary` and `reminder` each carry an
/// `enabled` and a value — while the screen draws one flat list of rows. The
/// flattening happens here, in the layer whose job is the difference between
/// the two.
///
/// The API returns this complete, with its own defaults filled in, so none of
/// the fallbacks below should ever be reached. They are here for the build
/// that meets an older deployment: a missing switch must read as the default
/// rather than as off, because off is a promise the server has not made.
@freezed
abstract class NotificationPreferencesDto with _$NotificationPreferencesDto {
  const factory NotificationPreferencesDto({
    @JsonKey(name: 'newBooking') Object? newBooking,
    @JsonKey(name: 'cancellation') Object? cancellation,
    @JsonKey(name: 'dailySummary') Object? dailySummary,
    @JsonKey(name: 'reminder') Object? reminder,
  }) = _NotificationPreferencesDto;

  factory NotificationPreferencesDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesDtoFromJson(json);
}

extension NotificationPreferencesDtoX on NotificationPreferencesDto {
  NotificationPreferences toDomain() {
    const fallback = NotificationPreferences();

    final summary = asMap(dailySummary);
    final appointment = asMap(reminder);

    return NotificationPreferences(
      appointmentReminder: asBool(
        appointment['enabled'],
        fallback: fallback.appointmentReminder,
      ),
      reminderLead: ReminderLead.fromWire(appointment['offset']),
      newBookings: asBool(newBooking, fallback: fallback.newBookings),
      cancellations: asBool(cancellation, fallback: fallback.cancellations),
      dailySummary: asBool(summary['enabled'], fallback: fallback.dailySummary),
      summaryTime: asTextOrNull(summary['time']) ?? fallback.summaryTime,
    );
  }
}

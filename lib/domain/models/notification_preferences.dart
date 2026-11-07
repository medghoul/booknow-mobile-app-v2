import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';

/// When the owner's daily summary goes out before anyone changes it: before
/// the first customer, in the design's own example, and the API's default for
/// the same field.
///
/// Top level rather than a static on the model: freezed copies a default
/// into generated code, where a static of the class it is generating is not
/// in scope.
const String defaultSummaryTime = '08:00';

/// What the app is allowed to send, and when.
///
/// Part of `GET /me` and written with `PATCH /me/notification-preferences`.
/// The server owns these, not the device: it is what sends the pushes, long
/// after any request of the app's, so a switch kept on the phone would be a
/// preference nothing reads. The defaults below are the API's own, and they
/// are only reached before the first profile arrives.
///
/// One model for both roles rather than two: a user can be an owner today and
/// a customer tomorrow, and splitting the shape would mean deciding which half
/// to throw away at the moment the role changes. One object is also what the
/// server stores — though each field belongs to a role, and
/// `PATCH /me/notification-preferences` refuses the other role's.
///
/// Cancellations and refunds *to the customer* are deliberately not here. They
/// are the receipts for a payment, so they are always sent — the design draws
/// that row as a locked label instead of a switch, and a field nobody can set
/// would only invite one. [cancellations] is the owner's: a slot given back.
///
/// The defaults are the design's own drawn state: the reminders people expect
/// are on.
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    // ─── Customer ───────────────────────────────────────────────────────────
    @Default(true) bool appointmentReminder,
    @Default(ReminderLead.twoHours) ReminderLead reminderLead,

    // ─── Owner ──────────────────────────────────────────────────────────────
    @Default(true) bool newBookings,
    @Default(true) bool cancellations,
    @Default(true) bool dailySummary,

    /// When the daily summary goes out, as `HH:mm` wall-clock in the shop's
    /// timezone — the same convention as [OpeningHours], and for the same
    /// reason: 08:00 means eight in the morning where the shop is, whatever
    /// the device thinks the time is.
    ///
    /// Always on the quarter hour; see [quarterHour].
    @Default(defaultSummaryTime) String summaryTime,
  }) = _NotificationPreferences;

  const NotificationPreferences._();

  /// A picked time as [summaryTime] has to be: `HH:mm` on the nearest quarter
  /// hour.
  ///
  /// The server's own constraint — it schedules the summary rather than
  /// polling for it, and an EventBridge rule per arbitrary minute is 1440 of
  /// them. The platform's time picker offers every minute, so 08:07 has to
  /// become 08:00 here or the request comes back a 400 the user cannot act on.
  ///
  /// Rounds rather than truncates, and rolls the hour: 23:58 is 00:00, not
  /// 24:00.
  static String quarterHour(int hour, int minute) {
    final total =
        ((hour * 60 + minute + 7) ~/ 15 * 15) % Duration.minutesPerDay;

    return '${_two(total ~/ 60)}:${_two(total % 60)}';
  }

  static String _two(int value) => value.toString().padLeft(2, '0');
}

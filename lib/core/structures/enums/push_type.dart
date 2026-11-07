import 'package:booknow_mobile/core/structures/enums/user_role.dart';

/// What a push is about, from the `type` key of its data payload.
///
/// The six the API sends in v0. Each belongs to exactly one [recipient], which
/// is what decides where a tap lands: an owner hears about their agenda, a
/// customer about their appointment and their money.
///
/// A value this build does not know is **not** an error — the server may send
/// a type a newer app understands, and the push still arrives with its own
/// title and body. It simply has nowhere to open.
enum PushType {
  // ─── Owner ──────────────────────────────────────────────────────────────
  bookingConfirmed('BOOKING_CONFIRMED', UserRole.owner),
  bookingCancelledByCustomer('BOOKING_CANCELLED_BY_CUSTOMER', UserRole.owner),
  dailySummary('DAILY_SUMMARY', UserRole.owner),

  // ─── Customer ───────────────────────────────────────────────────────────
  bookingCancelledByShop('BOOKING_CANCELLED_BY_SHOP', UserRole.customer),
  bookingLateRefund('BOOKING_LATE_REFUND', UserRole.customer),
  bookingReminder('BOOKING_REMINDER', UserRole.customer);

  const PushType(this.wireName, this.recipient);

  /// The value in the payload. Upper snake case, and not the enum's own name,
  /// so renaming a case here cannot stop a push from being understood.
  final String wireName;

  /// Who this kind of push is sent to.
  ///
  /// A phone that has been signed in as both roles can hold a push for the
  /// other one; this is what stops a tap on it walking the current user into
  /// the other role's half of the app.
  final UserRole recipient;

  /// The type the payload names, or null when it names none this build knows.
  static PushType? fromWire(Object? value) {
    if (value is! String) return null;
    for (final type in values) {
      if (type.wireName == value) return type;
    }
    return null;
  }
}

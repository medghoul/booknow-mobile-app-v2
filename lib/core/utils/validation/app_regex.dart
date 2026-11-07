/// The patterns the app validates against.
///
/// Kept apart from the validators so a pattern can be unit-tested and reused
/// without dragging in localisation.
abstract final class AppRegex {
  /// Deliberately permissive. Anything stricter starts rejecting addresses
  /// that are perfectly valid — the only real proof an address works is that
  /// mail to it arrives, and for BookNow the address comes from Apple or
  /// Google anyway.
  static final RegExp email = RegExp(
    r'^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  /// E.164: an optional `+`, then 2–15 digits.
  ///
  /// The phone field is optional throughout BookNow and only the barber ever
  /// sees it, so this checks the shape and nothing more. Spaces are stripped
  /// before matching, since the design shows numbers grouped ("347 8821 940").
  static final RegExp phoneE164 = RegExp(r'^\+?[1-9]\d{1,14}$');

  static final RegExp digitsOnly = RegExp(r'^\d+$');

  /// Everything a phone number may carry for readability.
  static final RegExp phoneSeparators = RegExp(r'[\s().-]');
}

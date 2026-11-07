import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';

/// A booking status as the three signals a badge needs.
///
/// The tint is the theme's — `context.status.ofBooking(status)` — and the word
/// and the glyph are here, so the rule that a status is never colour alone has
/// one place to be satisfied from.
///
/// A switch rather than a map, so a status added to the enum fails to compile
/// instead of rendering an unlabelled pill.
extension BookingStatusPresentation on BookingStatus {
  /// The word on the badge, in the active language.
  String label(Translations t) {
    final words = t.bookingStatus;
    return switch (this) {
      BookingStatus.pendingPayment => words.pendingPayment,
      BookingStatus.confirmed => words.confirmed,
      BookingStatus.arrived => words.arrived,
      BookingStatus.noShow => words.noShow,
      BookingStatus.cancelled => words.cancelled,
      BookingStatus.completed => words.completed,
      BookingStatus.expired => words.expired,
    };
  }

  /// The glyph beside it.
  ///
  /// `expired` and `cancelled` share one, as they share a tint: both mean the
  /// booking is not happening, and the owner never sees them side by side.
  IconData get icon => switch (this) {
    BookingStatus.pendingPayment => Icons.schedule_rounded,
    BookingStatus.confirmed => Icons.check_circle_outline_rounded,
    BookingStatus.arrived => Icons.how_to_reg_rounded,
    BookingStatus.noShow => Icons.person_off_outlined,
    BookingStatus.cancelled || BookingStatus.expired => Icons.cancel_outlined,
    BookingStatus.completed => Icons.done_all_rounded,
  };
}

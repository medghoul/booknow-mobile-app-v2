import 'package:flutter/material.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';

/// A tinted background with the foreground colour that reads on it.
@immutable
class StatusTint {
  const StatusTint({required this.background, required this.foreground});

  final Color background;
  final Color foreground;

  static StatusTint lerp(StatusTint a, StatusTint b, double t) => StatusTint(
    background: Color.lerp(a.background, b.background, t)!,
    foreground: Color.lerp(a.foreground, b.foreground, t)!,
  );
}

/// Booking-status tints and the generic feedback colours.
///
/// The design rule is that a status always carries tint **plus** icon **plus**
/// word — colour is never the only signal — so these pairs are only ever half
/// of a status badge. Resolve one with [ofBooking] rather than switching on
/// the status at the call site.
@immutable
class AppStatusColors extends ThemeExtension<AppStatusColors> {
  const AppStatusColors({
    required this.pending,
    required this.confirmed,
    required this.arrived,
    required this.noShow,
    required this.cancelled,
    required this.completed,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final StatusTint pending;
  final StatusTint confirmed;
  final StatusTint arrived;
  final StatusTint noShow;
  final StatusTint cancelled;
  final StatusTint completed;

  /// Generic feedback tints, for banners and snackbars that aren't about a
  /// booking.
  final StatusTint success;
  final StatusTint warning;
  final StatusTint error;
  final StatusTint info;

  /// The tint for a booking in [status].
  ///
  /// `expired` reuses the cancelled tint: to the customer both read as "this
  /// booking is not happening", and the spec never shows them side by side.
  StatusTint ofBooking(BookingStatus status) => switch (status) {
    BookingStatus.pendingPayment => pending,
    BookingStatus.confirmed => confirmed,
    BookingStatus.arrived => arrived,
    BookingStatus.noShow => noShow,
    BookingStatus.cancelled || BookingStatus.expired => cancelled,
    BookingStatus.completed => completed,
  };

  @override
  AppStatusColors copyWith({
    StatusTint? pending,
    StatusTint? confirmed,
    StatusTint? arrived,
    StatusTint? noShow,
    StatusTint? cancelled,
    StatusTint? completed,
    StatusTint? success,
    StatusTint? warning,
    StatusTint? error,
    StatusTint? info,
  }) {
    return AppStatusColors(
      pending: pending ?? this.pending,
      confirmed: confirmed ?? this.confirmed,
      arrived: arrived ?? this.arrived,
      noShow: noShow ?? this.noShow,
      cancelled: cancelled ?? this.cancelled,
      completed: completed ?? this.completed,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  AppStatusColors lerp(ThemeExtension<AppStatusColors>? other, double t) {
    if (other is! AppStatusColors) return this;
    return AppStatusColors(
      pending: StatusTint.lerp(pending, other.pending, t),
      confirmed: StatusTint.lerp(confirmed, other.confirmed, t),
      arrived: StatusTint.lerp(arrived, other.arrived, t),
      noShow: StatusTint.lerp(noShow, other.noShow, t),
      cancelled: StatusTint.lerp(cancelled, other.cancelled, t),
      completed: StatusTint.lerp(completed, other.completed, t),
      success: StatusTint.lerp(success, other.success, t),
      warning: StatusTint.lerp(warning, other.warning, t),
      error: StatusTint.lerp(error, other.error, t),
      info: StatusTint.lerp(info, other.info, t),
    );
  }

  static const AppStatusColors light = AppStatusColors(
    pending: StatusTint(
      background: AppColors.lightStatusPendingBg,
      foreground: AppColors.lightStatusPendingFg,
    ),
    confirmed: StatusTint(
      background: AppColors.lightStatusConfirmedBg,
      foreground: AppColors.lightStatusConfirmedFg,
    ),
    arrived: StatusTint(
      background: AppColors.lightStatusArrivedBg,
      foreground: AppColors.lightStatusArrivedFg,
    ),
    noShow: StatusTint(
      background: AppColors.lightStatusNoShowBg,
      foreground: AppColors.lightStatusNoShowFg,
    ),
    cancelled: StatusTint(
      background: AppColors.lightStatusCancelledBg,
      foreground: AppColors.lightStatusCancelledFg,
    ),
    completed: StatusTint(
      background: AppColors.lightStatusCompletedBg,
      foreground: AppColors.lightStatusCompletedFg,
    ),
    success: StatusTint(
      background: AppColors.lightStatusArrivedBg,
      foreground: AppColors.lightStatusArrivedFg,
    ),
    warning: StatusTint(
      background: AppColors.lightStatusPendingBg,
      foreground: AppColors.lightStatusPendingFg,
    ),
    error: StatusTint(
      background: AppColors.lightDangerBg,
      foreground: AppColors.lightDangerFg,
    ),
    info: StatusTint(
      background: AppColors.lightStatusCompletedBg,
      foreground: AppColors.lightStatusCompletedFg,
    ),
  );

  static const AppStatusColors dark = AppStatusColors(
    pending: StatusTint(
      background: AppColors.darkStatusPendingBg,
      foreground: AppColors.darkStatusPendingFg,
    ),
    confirmed: StatusTint(
      background: AppColors.darkStatusConfirmedBg,
      foreground: AppColors.darkStatusConfirmedFg,
    ),
    arrived: StatusTint(
      background: AppColors.darkStatusArrivedBg,
      foreground: AppColors.darkStatusArrivedFg,
    ),
    noShow: StatusTint(
      background: AppColors.darkStatusNoShowBg,
      foreground: AppColors.darkStatusNoShowFg,
    ),
    cancelled: StatusTint(
      background: AppColors.darkStatusCancelledBg,
      foreground: AppColors.darkStatusCancelledFg,
    ),
    completed: StatusTint(
      background: AppColors.darkStatusCompletedBg,
      foreground: AppColors.darkStatusCompletedFg,
    ),
    success: StatusTint(
      background: AppColors.darkStatusArrivedBg,
      foreground: AppColors.darkStatusArrivedFg,
    ),
    warning: StatusTint(
      background: AppColors.darkStatusPendingBg,
      foreground: AppColors.darkStatusPendingFg,
    ),
    error: StatusTint(
      background: AppColors.darkDangerBg,
      foreground: AppColors.darkDangerFg,
    ),
    info: StatusTint(
      background: AppColors.darkStatusCompletedBg,
      foreground: AppColors.darkStatusCompletedFg,
    ),
  );
}

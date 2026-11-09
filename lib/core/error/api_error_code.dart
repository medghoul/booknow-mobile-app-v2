/// The `code` values the API returns in `{ "code": …, "message": … }`.
///
/// The app switches on these rather than on HTTP status or on the message
/// text, which is server-localised and may change.
enum ApiErrorCode {
  /// Someone else took the slot between rendering the list and confirming.
  slotTaken('SLOT_TAKEN'),

  /// The payment hold expired before the Payment Sheet was completed.
  holdExpired('HOLD_EXPIRED'),

  /// The slot starts sooner than the shop's minimum lead time allows.
  leadTimeTooShort('LEAD_TIME_TOO_SHORT'),

  /// The slot is past the shop's booking horizon.
  outsideBookingHorizon('OUTSIDE_BOOKING_HORIZON'),

  /// The shop is closed on that date.
  shopClosed('SHOP_CLOSED'),

  /// Cancelling inside the cancellation window, so the fee is not refunded.
  cancellationWindowPassed('CANCELLATION_WINDOW_PASSED'),

  /// The start is on the grid but nothing can be sold there — outside the
  /// opening hours, or the service would not fit before closing.
  slotNotBookable('SLOT_NOT_BOOKABLE'),

  /// The service was deleted or deactivated while the picker was open.
  serviceNotAvailable('SERVICE_NOT_AVAILABLE'),

  /// The owner asked to block a range the rules do not allow — backwards,
  /// over eight hours, across two days, or already in the past.
  invalidBlock('INVALID_BLOCK'),

  /// The caller is not the owner of this shop or booking.
  forbidden('FORBIDDEN'),

  /// The role has already been chosen and cannot be changed.
  roleAlreadySet('ROLE_ALREADY_SET'),

  /// An owner tried to delete their account with future bookings open.
  ownerHasFutureBookings('OWNER_HAS_FUTURE_BOOKINGS'),

  // ─── Queue mode (queue spec §13.4) ──────────────────────────────────────────

  /// A queue route on a shop that takes bookings.
  shopNotInQueueMode('SHOP_NOT_IN_QUEUE_MODE'),

  /// A booking route on a shop that runs a queue.
  shopNotInBookingMode('SHOP_NOT_IN_BOOKING_MODE'),

  /// Paused, closed, outside opening hours or full; the error carries which.
  queueNotAccepting('QUEUE_NOT_ACCEPTING'),

  /// One queue at a time, across every shop.
  alreadyInQueue('ALREADY_IN_QUEUE'),

  /// The place has already moved on: in the chair, served or gone.
  entryNotLeavable('ENTRY_NOT_LEAVABLE'),

  /// "Chiama il prossimo" with nobody waiting.
  queueEmpty('QUEUE_EMPTY'),

  /// The owner tried to switch mode with bookings ahead or people in line.
  modeChangeBlocked('MODE_CHANGE_BLOCKED'),

  /// A no-show marked before its time — bookings and queue alike.
  noShowTooEarly('NO_SHOW_TOO_EARLY'),

  // ─── Providers (providers spec) ─────────────────────────────────────────────

  /// Ten people working is the most a shop can have.
  providerLimitReached('PROVIDER_LIMIT_REACHED'),

  /// Customers are still booked with them, or waiting for them.
  providerInUse('PROVIDER_IN_USE'),

  /// The owner's own place in the shop, which cannot be removed.
  defaultProvider('DEFAULT_PROVIDER'),

  /// The person chosen is not working, or does not do this service.
  providerNotAvailable('PROVIDER_NOT_AVAILABLE'),

  /// A Start or a Done on a visit that has already moved on.
  visitMoved('VISIT_MOVED'),

  /// Anything the app does not recognise.
  shopIncomplete('SHOP_INCOMPLETE'),
  shopAlreadyExists('SHOP_ALREADY_EXISTS'),
  unknown('UNKNOWN');

  const ApiErrorCode(this.wireName);

  final String wireName;

  static ApiErrorCode fromWire(String? value) => ApiErrorCode.values.firstWhere(
    (code) => code.wireName == value,
    orElse: () => ApiErrorCode.unknown,
  );
}

/// The six states a booking moves through.
///
/// Mirrors the API's `status` field and the lifecycle in the v0 spec:
/// `pendingPayment → confirmed → arrived | noShow | completed`, with
/// `expired` and `cancelled` as terminal states.
enum BookingStatus {
  /// Slot held while the customer pays. Occupies the slot until the hold
  /// expires.
  pendingPayment('pending_payment'),

  /// Payment was not completed in time; the slot was released.
  expired('expired'),

  /// Paid and scheduled.
  confirmed('confirmed'),

  /// The barber checked the customer in.
  arrived('arrived'),

  /// The customer did not show up.
  noShow('no_show'),

  /// Cancelled by the customer or the barber.
  cancelled('cancelled'),

  /// A past appointment, closed by the end-of-day job.
  completed('completed');

  const BookingStatus(this.wireName);

  /// The value the API sends and expects.
  final String wireName;

  static BookingStatus fromWire(String value) =>
      BookingStatus.values.firstWhere(
        (status) => status.wireName == value,
        orElse: () => BookingStatus.pendingPayment,
      );
}

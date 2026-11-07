/// How customers come in to a shop (queue spec §3).
enum ShopMode {
  /// They pick a day and a time.
  booking('booking'),

  /// They join a live line and wait their turn.
  queue('queue'),

  /// They choose: a time, or the line.
  both('both');

  const ShopMode(this.wireName);

  final String wireName;

  bool get takesBookings => this != queue;

  bool get runsQueue => this != booking;

  /// Absent or unknown reads as [booking]: every shop saved before queue mode
  /// existed takes bookings, and a newer value must never hide a time picker
  /// the shop still needs.
  static ShopMode fromWire(String? value) => ShopMode.values.firstWhere(
    (mode) => mode.wireName == value,
    orElse: () => ShopMode.booking,
  );
}

/// Whether the queue is taking people today (queue spec §5.2).
enum QueueState {
  open('open'),
  paused('paused'),
  closed('closed');

  const QueueState(this.wireName);

  final String wireName;

  static QueueState fromWire(String? value) => QueueState.values.firstWhere(
    (state) => state.wireName == value,
    orElse: () => QueueState.open,
  );
}

/// Why nobody can join right now, from `notAccepting`.
enum QueueClosedReason {
  paused('paused'),
  closed('closed'),
  outsideHours('outside_hours'),

  /// A newcomer would finish after closing time.
  full('full');

  const QueueClosedReason(this.wireName);

  final String wireName;

  static QueueClosedReason? fromWire(String? value) {
    for (final reason in QueueClosedReason.values) {
      if (reason.wireName == value) return reason;
    }
    return null;
  }
}

/// Where one place in line stands (queue spec §7).
enum QueueEntryStatus {
  /// Paying; not in line yet.
  pendingPayment('pending_payment'),

  /// The payment never came.
  expired('expired'),
  waiting('waiting'),

  /// The owner called them; they have ten minutes to arrive.
  called('called'),

  /// In the chair.
  serving('serving'),
  served('served'),

  /// The customer left.
  left('left'),

  /// The owner removed them; the fee is refunded.
  removed('removed'),

  /// Still waiting when the day ended; the fee is refunded.
  unserved('unserved'),
  noShow('no_show');

  const QueueEntryStatus(this.wireName);

  final String wireName;

  /// Physically in line.
  bool get isInLine => this == waiting || this == called || this == serving;

  static QueueEntryStatus fromWire(String? value) =>
      QueueEntryStatus.values.firstWhere(
        (status) => status.wireName == value,
        orElse: () => QueueEntryStatus.expired,
      );
}

/// Whether a place was taken through the app or added by the owner.
enum QueueEntryKind {
  app('app'),
  walkIn('walk_in');

  const QueueEntryKind(this.wireName);

  final String wireName;

  static QueueEntryKind fromWire(String? value) =>
      value == walkIn.wireName ? walkIn : app;
}

/// Every path the app calls, relative to the `/v1` base URL in [AppConfig].
///
/// Kept in one place so a route rename is a single edit, and so the set of
/// endpoints the app actually uses is readable at a glance against the spec.
abstract final class ApiEndpoints {
  // ─── Users ──────────────────────────────────────────────────────────────────
  static const String me = '/me';
  static const String myRole = '/me/role';
  static const String myDevices = '/me/devices';
  static const String myBookings = '/me/bookings';
  static const String myNotificationPreferences =
      '/me/notification-preferences';

  static String myDevice(String token) => '/me/devices/$token';

  /// The owner's own shop, and everything hanging off it. `me` rather than an
  /// id: the server resolves the shop from the token, so an owner can never
  /// address somebody else's.
  static const String myShop = '/me/shop';
  static const String myShopDetails = '/shops/me';
  static const String myShopServices = '/shops/me/services';
  static const String myShopPhoto = '/shops/me/photo';
  static const String myShopPublish = '/shops/me/publish';
  static const String placesAutocomplete = '/places/autocomplete';

  /// One day of the owner's timeline, with the date strip that goes above it.
  /// `?date=YYYY-MM-DD`, defaulting to today **in the shop's** timezone.
  static const String myShopAgenda = '/shops/me/agenda';

  /// Time the owner takes off the grid. The delete needs the day as well as
  /// the id — a block lives in its day's partition and nothing indexes blocks
  /// by id alone.
  static const String myShopBlocks = '/shops/me/blocks';

  static String myShopService(String serviceId) =>
      '/shops/me/services/$serviceId';

  /// Who works in the shop (providers §9). `DELETE` on one removes them.
  static const String myShopProviders = '/shops/me/providers';

  static String myShopProvider(String providerId) =>
      '/shops/me/providers/$providerId';

  static String myShopBlock(String blockId) => '/shops/me/blocks/$blockId';

  /// Everything the customer's home draws, in one call (§7.3).
  static const String home = '/home';

  // ─── Shops ──────────────────────────────────────────────────────────────────
  /// `POST` creates the owner's shop; `GET` is the customer's directory.
  static const String shops = '/shops';

  static String shop(String shopId) => '/shops/$shopId';

  static String shopAvailability(String shopId) =>
      '/shops/$shopId/availability';

  static String shopHours(String shopId) => '/shops/$shopId/hours';

  static String shopBookings(String shopId) => '/shops/$shopId/bookings';

  static String shopClosure(String shopId, String date) =>
      '/shops/$shopId/closures/$date';

  // ─── Bookings ───────────────────────────────────────────────────────────────
  static const String bookings = '/bookings';

  static String booking(String bookingId) => '/bookings/$bookingId';

  static String cancelBooking(String bookingId) =>
      '/bookings/$bookingId/cancel';

  static String bookingArrived(String bookingId) =>
      '/bookings/$bookingId/arrived';

  static String bookingNoShow(String bookingId) =>
      '/bookings/$bookingId/no-show';

  // ─── Queue (queue spec §13) ─────────────────────────────────────────────────
  /// `GET` the live line, `POST` to join it.
  static String shopQueue(String shopId) => '/shops/$shopId/queue';

  /// The customer's active place, at any shop.
  static const String myQueue = '/me/queue';

  static String leaveQueue(String entryId) => '/queue/$entryId/leave';

  /// The owner's line, and the buttons on it.
  static const String myShopQueue = '/shops/me/queue';
  static const String myShopQueueWalkIns = '/shops/me/queue/walk-ins';
  static const String myShopQueueCallNext = '/shops/me/queue/call-next';
  static const String myShopQueuePause = '/shops/me/queue/pause';
  static const String myShopQueueResume = '/shops/me/queue/resume';
  static const String myShopQueueClose = '/shops/me/queue/close';
  static const String myShopQueueTurnedAway = '/shops/me/queue/turned-away';
  static const String myShopChairs = '/shops/me/chairs';
  static const String myShopStatistics = '/shops/me/statistics';

  /// `start` or `done` on one chair.
  static String chairAction(String providerId, String action) =>
      '/shops/me/chairs/$providerId/$action';

  /// `start`, `done`, `no-show` or `remove` on one place in line.
  static String queueEntryAction(String entryId, String action) =>
      '/queue/$entryId/$action';
}

import '../../core/error/api_result.dart';
import '../../core/structures/enums/queue_enums.dart';
import '../models/queue.dart';
import '../models/shop.dart';

/// Queue mode, for both sides of the counter (queue spec §13).
///
/// Like booking, joining is two steps because it is two steps on the server:
/// [join] opens the payment, Stripe's webhook gives the place, and [mine] is
/// how the app finds out — it never puts itself in line.
abstract interface class QueueRepository {
  // ─── Customer ───────────────────────────────────────────────────────────────

  /// `GET /v1/shops/{shopId}/queue` — the live line on the shop page.
  Future<ApiResult<ShopQueue>> shopQueue(String shopId);

  /// `POST /v1/shops/{shopId}/queue` — a pending place and its payment.
  ///
  /// `409 QUEUE_NOT_ACCEPTING` is an ordinary answer: the queue can fill up
  /// or pause while the customer reads the summary.
  ///
  /// With [providerId] the customer waits for that person; without, whoever
  /// is free first calls them.
  Future<ApiResult<QueueJoin>> join({
    required String shopId,
    required String serviceId,
    String? providerId,
  });

  /// `GET /v1/me/queue` — the customer's active entry, or null.
  Future<ApiResult<QueueEntry?>> mine();

  /// `POST /v1/queue/{entryId}/leave` — the returned entry says whether the
  /// fee came back.
  Future<ApiResult<QueueEntry>> leave(String entryId);

  // ─── Owner ──────────────────────────────────────────────────────────────────

  /// `GET /v1/shops/me/queue`.
  Future<ApiResult<OwnerQueue>> ownerQueue();

  /// `POST /v1/shops/me/queue/walk-ins` — [serviceId] defaults to the shop's
  /// main service.
  Future<ApiResult<OwnerQueue>> addWalkIn({String? serviceId, String? name});

  /// `POST /v1/shops/me/queue/call-next`.
  ///
  /// [providerId] is who is calling. The server needs it once more than one
  /// person works, and picks the first in line who asked for them or for
  /// anyone (providers §7.3).
  Future<ApiResult<OwnerQueue>> callNext({String? providerId});

  /// Pause, resume or close for today.
  Future<ApiResult<OwnerQueue>> setState(QueueState state);

  Future<ApiResult<OwnerQueue>> start(String entryId);

  Future<ApiResult<OwnerQueue>> done(String entryId);

  /// `409 NO_SHOW_TOO_EARLY` within ten minutes of the call.
  Future<ApiResult<OwnerQueue>> noShow(String entryId);

  /// The fee is always refunded.
  Future<ApiResult<OwnerQueue>> remove(String entryId);

  /// `PATCH /v1/shops/me` with `mode`. `409 MODE_CHANGE_BLOCKED` while it
  /// would strand customers (queue spec §3).
  Future<ApiResult<Shop>> setMode(ShopMode mode);
}

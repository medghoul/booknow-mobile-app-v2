import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue.freezed.dart';

/// The estimated wait as the server rounds it: "circa 35–45 min".
///
/// A range and never one number (queue spec §6.2): a single time would be
/// wrong most days, and the app never computes its own.
@freezed
abstract class WaitRange with _$WaitRange {
  const factory WaitRange({required int fromMin, required int toMin}) =
      _WaitRange;
}

/// The customer's own place in a shop's queue.
@freezed
abstract class QueueEntry with _$QueueEntry {
  const factory QueueEntry({
    required String id,
    required String shopId,
    required String? shopName,
    required QueueEntryStatus status,
    required String serviceId,
    required String serviceName,
    required int durationMinutes,

    /// Paid in the shop.
    required int priceCents,

    /// The BookNow fee paid to join.
    required int? feeCents,

    /// 1 is next. Set only while waiting; the person in the chair is not
    /// counted.
    required int? position,
    required int? aheadCount,
    required WaitRange? estimate,

    /// Whether leaving now gives the fee back — the server's verdict, shown
    /// before the customer taps rather than after (queue spec §8).
    required bool refundIfLeaving,
    required DateTime? holdExpiresAt,
    required DateTime? calledAt,

    /// When the owner may mark a no-show: ten minutes after the call.
    required DateTime? noShowFrom,
    required bool refunded,
  }) = _QueueEntry;
}

/// A shop's live queue, as the shop page shows it (queue spec §4.1).
@freezed
abstract class ShopQueue with _$ShopQueue {
  const factory ShopQueue({
    required String shopId,
    required QueueState state,

    /// Null while the queue is taking people.
    required QueueClosedReason? closedReason,

    /// People waiting, not counting the one in the chair.
    required int waitingCount,
    required bool inChair,

    /// For someone joining now.
    required WaitRange estimate,
    required int feeCents,

    /// The caller's own place, when they are already in this queue.
    required QueueEntry? myEntry,
  }) = _ShopQueue;

  const ShopQueue._();

  bool get isAccepting => closedReason == null;
}

/// `POST /v1/shops/{shopId}/queue`: a pending place and its payment.
///
/// The customer is not in line yet. Stripe's webhook gives the place once the
/// payment lands, and the app finds out by reading [QueueEntry] again.
@freezed
abstract class QueueJoin with _$QueueJoin {
  const factory QueueJoin({
    required QueueEntry entry,
    required String clientSecret,
    required DateTime holdExpiresAt,
    required int feeCents,
    required WaitRange estimate,
  }) = _QueueJoin;
}

/// One person in the owner's line.
@freezed
abstract class OwnerQueueEntry with _$OwnerQueueEntry {
  const factory OwnerQueueEntry({
    required String id,
    required QueueEntryStatus status,
    required QueueEntryKind kind,

    /// Null for a walk-in who gave no name: the screen says "Walk-in".
    required String? customerName,
    required String serviceId,
    required String serviceName,
    required int durationMinutes,
    required DateTime? joinedAt,
    required DateTime? calledAt,
    required DateTime? startedAt,
    required DateTime? noShowFrom,

    /// Who they asked for; null is whoever is free first (providers §7.4).
    String? requestedProviderId,

    /// Who serves them: set at join when asked for, otherwise when called.
    String? providerId,
    String? providerName,
  }) = _OwnerQueueEntry;
}

/// One person working the line, and where they are with it (providers §7.4).
@freezed
abstract class OwnerQueueProvider with _$OwnerQueueProvider {
  const factory OwnerQueueProvider({
    required String id,

    /// The owner's own provider shows the shop's name until given one.
    String? name,
    String? servingEntryId,
    String? calledEntryId,

    /// Who "call next" would call for them.
    String? nextEntryId,
  }) = _OwnerQueueProvider;
}

/// Today's queue as the owner runs it (queue spec §5).
@freezed
abstract class OwnerQueue with _$OwnerQueue {
  const factory OwnerQueue({
    /// `yyyy-MM-dd` in the shop's own calendar.
    required String localDate,
    required QueueState state,
    required int waitingCount,

    /// When the line is estimated to be empty; null when it already is.
    required DateTime? emptiesAt,

    /// In serving order: in the chair, called, then waiting.
    required List<OwnerQueueEntry> entries,

    /// Everyone working today, by order. Empty from an API older than
    /// providers.
    @Default(<OwnerQueueProvider>[]) List<OwnerQueueProvider> providers,
  }) = _OwnerQueue;

  const OwnerQueue._();

  /// More than one chair to run. Below that the screen is the one-chair
  /// screen it always was, and "call next" names nobody (providers §0).
  bool get hasTeam => providers.length > 1;

  OwnerQueueEntry? entry(String? entryId) => entryId == null
      ? null
      : entries.where((e) => e.id == entryId).firstOrNull;

  OwnerQueueEntry? get inChair =>
      entries.where((e) => e.status == QueueEntryStatus.serving).firstOrNull;

  OwnerQueueEntry? get called =>
      entries.where((e) => e.status == QueueEntryStatus.called).firstOrNull;

  List<OwnerQueueEntry> get waiting =>
      entries.where((e) => e.status == QueueEntryStatus.waiting).toList();
}

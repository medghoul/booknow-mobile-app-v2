import 'package:booknow_mobile/core/structures/enums/push_type.dart';
import 'package:flutter/foundation.dart';

/// The `data` part of a push: what it is about, and which booking.
///
/// Read the way a DTO is read — tolerantly. The payload crosses FCM as a flat
/// map of strings written by a Lambda, so a missing key, an unknown type or a
/// value of the wrong shape must produce no payload rather than an exception:
/// the notification itself has already been delivered and shown by the
/// operating system, and the only thing left to get wrong is where a tap goes.
@immutable
class PushPayload {
  const PushPayload({required this.type, this.bookingId});

  final PushType type;

  /// The booking the push is about, when it is about one — every type except
  /// the owner's daily summary.
  ///
  /// Carried but not yet used: the booking detail screens the design sends
  /// these taps to are not built, so a tap lands on the role's own list for
  /// now. It is parsed here so that becomes one line rather than a payload
  /// change.
  final String? bookingId;

  /// The payload of a message, or null when there is nothing to act on.
  static PushPayload? from(Map<String, dynamic>? data) {
    final type = PushType.fromWire(data?['type']);
    if (type == null) return null;

    final bookingId = data?['bookingId'];
    return PushPayload(
      type: type,
      bookingId: bookingId is String && bookingId.isNotEmpty ? bookingId : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is PushPayload &&
      other.type == type &&
      other.bookingId == bookingId;

  @override
  int get hashCode => Object.hash(type, bookingId);

  @override
  String toString() => 'PushPayload(${type.wireName}, booking: $bookingId)';
}

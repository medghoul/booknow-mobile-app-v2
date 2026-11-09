import 'package:freezed_annotation/freezed_annotation.dart';

part 'chairs.freezed.dart';

/// Where a visit came from: a booking or a place in line.
enum VisitKind {
  booking,
  queue;

  static VisitKind? fromWire(String? value) => switch (value) {
    'booking' => VisitKind.booking,
    'queue' => VisitKind.queue,
    _ => null,
  };
}

/// Somebody on a chair, or on their way to one.
@freezed
abstract class ChairVisit with _$ChairVisit {
  const factory ChairVisit({
    required VisitKind kind,
    required String id,

    /// Null for a walk-in who gave no name.
    required String? customerName,
    required String serviceName,
    required int plannedMinutes,

    /// A booking's time; null for someone from the line.
    required DateTime? scheduledAt,
    required DateTime? startedAt,

    /// When someone called may be marked a no-show.
    required DateTime? noShowFrom,
  }) = _ChairVisit;

  const ChairVisit._();

  /// When the plan says this finishes; null until it has started.
  DateTime? get plannedEnd => startedAt?.add(Duration(minutes: plannedMinutes));
}

/// What the big button on a chair does.
enum ChairNextAction { start, call }

/// One person working today (`GET /v1/shops/me/chairs`).
@freezed
abstract class Chair with _$Chair {
  const factory Chair({
    required String providerId,

    /// The owner's own chair shows the shop's name until given one.
    required String? name,
    required ChairVisit? current,
    required ChairVisit? called,
    required ChairNextAction? nextAction,
    required ChairVisit? nextVisit,
    required ChairVisit? nextInQueue,
    required ChairVisit? nextBooking,
  }) = _Chair;
}

/// Today as the owner works it, one card per chair.
@freezed
abstract class ChairBoard with _$ChairBoard {
  const factory ChairBoard({
    required String localDate,

    /// The shop's zone, which every time on the board is shown in.
    required String timeZone,
    required List<Chair> chairs,
  }) = _ChairBoard;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_block.freezed.dart';

/// What is wrong with a block the owner is drafting (§9).
///
/// Only the two the owner can see and fix from the sheet. The rest of §9 — a
/// range already over, one beyond the thirty-day horizon, one crossing
/// midnight — is the server's to refuse, and its code comes back as copy; a
/// second copy of those rules here would be a second place for them to drift.
enum BlockProblem { backwards, tooLong }

/// Time the owner has taken off the grid: a break, a walk-in, an errand.
///
/// Not a booking. It holds its cells for exactly its own range — a booking
/// also holds the buffer after it — and it has no customer, no price and no
/// status to move through.
@freezed
abstract class TimeBlock with _$TimeBlock {
  const factory TimeBlock({
    required String id,
    required DateTime startUtc,
    required DateTime endUtc,
    required String? note,
  }) = _TimeBlock;

  /// The longest range the server will take. Eight hours is 96 five-minute
  /// cells, and with the block itself that is 97 of DynamoDB's 100 writes per
  /// transaction — the next step up would not be writable at all.
  static const int maxMinutes = 8 * 60;

  /// The grid every start and end has to land on.
  static const int cellMinutes = 5;

  /// What the server truncates a note to, so the field says so first.
  static const int noteMaxLength = 60;

  /// [minutes] floored onto the five-minute grid.
  ///
  /// Floored rather than rounded, and done as the owner picks rather than
  /// refused afterwards: the picker offers every minute, and somebody asking
  /// to block from 11:02 means the block that is running at 11:02.
  static int onGrid(int minutes) => minutes ~/ cellMinutes * cellMinutes;

  /// What is wrong with a range of wall-clock minutes, or null when nothing
  /// is. Both are reachable from the two pickers alone, which is why the
  /// sheet names the problem instead of only greying out its button.
  static BlockProblem? problemFor(int fromMinutes, int toMinutes) {
    if (toMinutes <= fromMinutes) return BlockProblem.backwards;
    if (toMinutes - fromMinutes > maxMinutes) return BlockProblem.tooLong;
    return null;
  }
}

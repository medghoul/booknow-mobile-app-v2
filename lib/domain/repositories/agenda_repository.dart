import '../../core/error/api_result.dart';
import '../models/agenda_day.dart';
import '../models/time_block.dart';

/// The owner's day, and the time blocks on it.
///
/// Reads, blocks, and what the owner does to a booking on the day.
abstract class AgendaRepository {
  /// One day of the timeline. A null [date] asks for today **in the shop's**
  /// timezone, which the server knows and the device does not.
  Future<ApiResult<AgendaDay>> day({String? date});

  Future<ApiResult<TimeBlock>> block({
    required DateTime startUtc,
    required DateTime endUtc,
    String? note,
  });

  /// [date] is the block's own day, in the shop's calendar: blocks are stored
  /// by day and nothing indexes them by id alone.
  Future<ApiResult<void>> unblock({
    required String blockId,
    required String date,
  });

  /// `POST /v1/bookings/{id}/arrived`.
  Future<ApiResult<void>> markArrived(String bookingId);

  /// `POST /v1/bookings/{id}/no-show`. Refused until the grace has passed.
  Future<ApiResult<void>> markNoShow(String bookingId);

  /// `POST /v1/bookings/{id}/cancel`, as the owner.
  Future<ApiResult<void>> cancelBooking(String bookingId);
}

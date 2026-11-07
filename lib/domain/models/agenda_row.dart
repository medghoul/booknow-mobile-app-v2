import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_row.freezed.dart';

/// One row of the owner's day.
///
/// The three kinds are drawn differently and tap differently — a booking opens
/// its sheet, a free run offers to block itself, a block offers to give itself
/// back — so they are a union rather than one row with three nullable halves.
/// The timeline then switches on the variant and the compiler says when a
/// fourth kind arrives.
@freezed
sealed class AgendaRow with _$AgendaRow {
  /// A live booking: everything a barber needs without opening the sheet.
  const factory AgendaRow.booking({
    required String id,
    required DateTime startUtc,
    required DateTime endUtc,

    /// When the slot is free again — the service plus its buffer. Longer than
    /// [endUtc], and never shown: the customer's appointment ends at [endUtc].
    required DateTime occupiedUntilUtc,

    required int durationMinutes,
    required BookingStatus status,
    required String serviceName,

    /// The service, paid in the shop.
    required int priceCents,

    /// The hold already charged in the app. Kept apart from [priceCents]
    /// rather than added to it: the sheet shows what the barber collects over
    /// what the customer has already paid, which is how the two settle.
    required int feeCents,

    required String? customerName,
    required String? customerPhone,

    /// Whose time it is (providers §5). Null from an API older than providers.
    String? providerId,
  }) = AgendaBookingRow;

  /// Time the owner took off the grid themselves.
  const factory AgendaRow.block({
    required String id,
    required DateTime startUtc,
    required DateTime endUtc,
    required String? note,
    String? providerId,
  }) = AgendaBlockRow;

  /// A run of bookable time, long enough for the shop's shortest service.
  const factory AgendaRow.free({
    required DateTime startUtc,
    required DateTime endUtc,

    /// The customer whose cancellation opened this, when one did. A quiet
    /// morning and a client who dropped out read differently — the second is
    /// someone the owner may want to call.
    required String? freedBy,

    /// Whose free time: blocking it takes theirs and nobody else's.
    String? providerId,
  }) = AgendaFreeRow;

  const AgendaRow._();

  /// How long the row is, in the minutes its height is drawn from.
  ///
  /// `startUtc` and `endUtc` need no declaration here: every variant has
  /// both, so freezed lifts them onto this class and the timeline can sort
  /// and measure a row without knowing which kind it is.
  int get durationMinutes => switch (this) {
    AgendaBookingRow(:final durationMinutes) => durationMinutes,
    // A block and a free run have no service behind them, so their length is
    // the only duration they have.
    _ => endUtc.difference(startUtc).inMinutes,
  };
}

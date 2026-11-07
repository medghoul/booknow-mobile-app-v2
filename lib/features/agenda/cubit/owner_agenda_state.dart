import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_agenda_state.freezed.dart';

@freezed
abstract class OwnerAgendaState with _$OwnerAgendaState {
  const factory OwnerAgendaState({
    /// The day being shown, as `YYYY-MM-DD`. Null until the first load
    /// answers: which day "today" is, is the shop's question, not the phone's.
    String? date,

    AgendaDay? day,

    /// Whose day is shown; null is everyone's.
    String? providerId,

    /// The first load, and every date change. A swipe of the strip replaces
    /// the whole timeline, so it is a load rather than a refresh.
    @Default(true) bool isLoading,

    /// A block is being written or removed. Blocks the sheet's own action, not
    /// the day behind it.
    @Default(false) bool isSaving,

    /// Re-read every minute so the current row keeps up with the clock
    /// without the owner pulling to refresh. It is the device's clock — the
    /// one instant in the screen that legitimately is — and it is compared
    /// against instants, never against a wall time.
    required DateTime now,

    NetworkException? failure,
  }) = _OwnerAgendaState;

  const OwnerAgendaState._();

  /// The zone every instant on this screen is read in.
  ///
  /// Falls back to the one zone v0 ships in rather than to the device's: a
  /// screen with no day loaded yet has nothing to show anyway, and the
  /// fallback is never the reason a time is wrong.
  String get timeZone => day?.timeZone ?? 'Europe/Rome';
}

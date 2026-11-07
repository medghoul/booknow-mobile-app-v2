import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The owner's day: which one is shown, what is on it, and the clock.
class OwnerAgendaCubit extends Cubit<OwnerAgendaState> {
  OwnerAgendaCubit(this._repository)
    : super(OwnerAgendaState(now: DateTime.now())) {
    // The current row is outlined and past rows are faded, so the screen is
    // wrong a minute after it is drawn unless something moves. A minute is
    // the finest granularity anything here shows, and the tick is unaligned —
    // a row can flip up to a minute late, which costs nothing and saves
    // scheduling against the wall clock.
    _ticker = Timer.periodic(
      const Duration(minutes: 1),
      (_) => emit(state.copyWith(now: DateTime.now())),
    );
  }

  final AgendaRepository _repository;
  late final Timer _ticker;

  /// Loads a day.
  ///
  /// A null [date] asks the server for today in the shop's own calendar,
  /// which is the only way to open on the right day for an owner whose phone
  /// is in another zone. With [refresh] the current day stays on screen while
  /// the call runs, and a failed refresh leaves it there rather than replacing
  /// a readable agenda with an error page.
  Future<void> load({String? date, bool refresh = false}) async {
    final wanted = date ?? state.date;

    emit(
      refresh
          ? state.copyWith(failure: null)
          : state.copyWith(date: wanted, isLoading: true, failure: null),
    );

    final result = await _repository.day(date: wanted);
    if (isClosed) return;

    switch (result) {
      case Success<AgendaDay>(:final data):
        emit(
          state.copyWith(
            // The server's answer, not the request: it is what resolved the
            // null date, and the strip highlights whichever day it names.
            date: data.date,
            day: data,
            isLoading: false,
            now: DateTime.now(),
          ),
        );
      case Failure<AgendaDay>(:final error):
        if (refresh && state.day != null) return;
        emit(state.copyWith(isLoading: false, failure: error));
    }
  }

  /// Takes a range off the grid. True once the server has it.
  Future<bool> blockTime({
    required DateTime startUtc,
    required DateTime endUtc,
    String? note,
  }) async {
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _repository.block(
      startUtc: startUtc,
      endUtc: endUtc,
      note: note,
    );
    if (isClosed) return false;

    switch (result) {
      case Success<TimeBlock>():
        emit(state.copyWith(isSaving: false));
        // Re-read rather than inserting the block: blocking splits whatever
        // free run it landed in, and the server is the only thing that knows
        // what the two halves are.
        await load(refresh: true);
        return true;
      case Failure<TimeBlock>(:final error):
        emit(state.copyWith(isSaving: false, failure: error));
        return false;
    }
  }

  /// Gives a blocked range back. True once the server has.
  Future<bool> unblockTime(String blockId) async {
    final date = state.date;
    if (date == null) return false;

    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _repository.unblock(blockId: blockId, date: date);
    if (isClosed) return false;

    switch (result) {
      case Success<void>():
        emit(state.copyWith(isSaving: false));
        await load(refresh: true);
        return true;
      case Failure<void>(:final error):
        emit(state.copyWith(isSaving: false, failure: error));
        return false;
    }
  }

  Future<bool> markArrived(String bookingId) =>
      _bookingAction(() => _repository.markArrived(bookingId));

  Future<bool> markNoShow(String bookingId) =>
      _bookingAction(() => _repository.markNoShow(bookingId));

  Future<bool> cancelBooking(String bookingId) =>
      _bookingAction(() => _repository.cancelBooking(bookingId));

  /// Does it, then reads the day again: the row's status and the summary above
  /// it are both the server's to say.
  Future<bool> _bookingAction(Future<ApiResult<void>> Function() action) async {
    if (state.isSaving) return false;
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await action();
    if (isClosed) return false;

    switch (result) {
      case Success<void>():
        emit(state.copyWith(isSaving: false));
        await load(refresh: true);
        return true;
      case Failure<void>(:final error):
        emit(state.copyWith(isSaving: false, failure: error));
        return false;
    }
  }

  @override
  Future<void> close() {
    _ticker.cancel();
    return super.close();
  }
}

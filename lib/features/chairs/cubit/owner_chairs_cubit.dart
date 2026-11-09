import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/chairs.dart';
import 'package:booknow_mobile/domain/repositories/chairs_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What the chairs board is showing.
class OwnerChairsState {
  const OwnerChairsState({
    required this.now,
    this.board,
    this.isLoading = true,
    this.busy = false,
    this.revision = 0,
    this.failure,
  });

  final ChairBoard? board;
  final bool isLoading;

  /// A button is waiting on the server; the others wait with it.
  final bool busy;

  /// Drives "6 min over plan" and the no-show countdown.
  final DateTime now;

  /// Goes up when a button changed something, so the lists under the board
  /// know to read again.
  final int revision;
  final NetworkException? failure;

  OwnerChairsState copyWith({
    ChairBoard? board,
    bool? isLoading,
    bool? busy,
    DateTime? now,
    int? revision,
    NetworkException? failure,
    bool clearFailure = false,
  }) => OwnerChairsState(
    board: board ?? this.board,
    isLoading: isLoading ?? this.isLoading,
    busy: busy ?? this.busy,
    now: now ?? this.now,
    revision: revision ?? this.revision,
    failure: clearFailure ? null : (failure ?? this.failure),
  );
}

/// Runs the chairs from the owner's side (statistics §3).
class OwnerChairsCubit extends Cubit<OwnerChairsState> {
  OwnerChairsCubit(this._chairs, this._queue)
    : super(OwnerChairsState(now: DateTime.now().toUtc())) {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  final ChairsRepository _chairs;
  final QueueRepository _queue;
  late final Timer _ticker;
  int _seconds = 0;

  /// Customers join and leave from their own phones (queue spec §14).
  static const int _refreshEverySeconds = 20;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearFailure: true));

    final result = await _chairs.board();
    if (isClosed) return;

    switch (result) {
      case Success<ChairBoard>(:final data):
        emit(state.copyWith(board: data, isLoading: false));
      case Failure<ChairBoard>(:final error):
        emit(state.copyWith(isLoading: false, failure: error));
    }
  }

  Future<void> refresh() async {
    final result = await _chairs.board();
    if (isClosed) return;
    if (result case Success<ChairBoard>(:final data)) {
      emit(state.copyWith(board: data));
    }
  }

  Future<void> start(Chair chair, ChairVisit visit) =>
      _act(() => _chairs.start(chair.providerId, visit));

  Future<void> done(Chair chair, ChairVisit visit) =>
      _act(() => _chairs.done(chair.providerId, visit));

  /// Tells someone who joined in the app that it is their turn.
  Future<void> call(Chair chair) =>
      _changeLine(() => _queue.callNext(providerId: chair.providerId));

  Future<void> noShow(ChairVisit visit) =>
      _changeLine(() => _queue.noShow(visit.id));

  /// True once it is recorded.
  Future<bool> turnedAway() async {
    if (state.busy) return false;
    emit(state.copyWith(busy: true, clearFailure: true));

    final result = await _chairs.turnedAway();
    if (isClosed) return false;

    switch (result) {
      case Success<void>():
        emit(state.copyWith(busy: false));
        return true;
      case Failure<void>(:final error):
        emit(state.copyWith(busy: false, failure: error));
        return false;
    }
  }

  Future<void> _act(Future<ApiResult<ChairBoard>> Function() action) async {
    if (state.busy) return;
    emit(state.copyWith(busy: true, clearFailure: true));

    final result = await action();
    if (isClosed) return;

    switch (result) {
      case Success<ChairBoard>(:final data):
        emit(
          state.copyWith(
            board: data,
            busy: false,
            revision: state.revision + 1,
          ),
        );
      case Failure<ChairBoard>(:final error):
        emit(state.copyWith(busy: false, failure: error));
        // The visit moved under the owner. Reading again shows where it went.
        await refresh();
    }
  }

  /// A button that answers with the line, not the board.
  Future<void> _changeLine(Future<ApiResult<Object?>> Function() action) async {
    if (state.busy) return;
    emit(state.copyWith(busy: true, clearFailure: true));

    final result = await action();
    if (isClosed) return;

    if (result case Failure<Object?>(:final error)) {
      emit(state.copyWith(busy: false, failure: error));
    } else {
      emit(state.copyWith(busy: false, revision: state.revision + 1));
    }
    await refresh();
  }

  void _tick() {
    _seconds += 1;
    emit(state.copyWith(now: DateTime.now().toUtc()));
    if (!state.busy && _seconds % _refreshEverySeconds == 0) {
      unawaited(refresh());
    }
  }

  @override
  Future<void> close() {
    _ticker.cancel();
    return super.close();
  }
}

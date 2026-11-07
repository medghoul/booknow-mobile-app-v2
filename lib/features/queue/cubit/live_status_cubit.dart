import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/queue.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The customer's live place in a queue, for the bar that follows them across
/// the tabs. Null when they are not in one.
///
/// Reads while something is watching; a failed read keeps what is on screen
/// rather than making a place in line blink out.
class LiveStatusCubit extends Cubit<QueueEntry?> {
  LiveStatusCubit(this._queue) : super(null);

  final QueueRepository _queue;
  Timer? _timer;

  /// The same pace as the queue screen.
  static const Duration _every = Duration(seconds: 20);

  void watch() {
    _timer ??= Timer.periodic(_every, (_) => refresh());
    refresh();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    if (!isClosed) emit(null);
  }

  Future<void> refresh() async {
    final result = await _queue.mine();
    if (isClosed) return;

    if (result case Success<QueueEntry?>(:final data)) {
      emit(data != null && isLive(data.status) ? data : null);
    }
  }

  /// Leaves the line. The returned entry says whether the fee came back; null
  /// means the leave failed and the place still stands.
  Future<QueueEntry?> leave(String entryId) async {
    final result = await _queue.leave(entryId);
    if (isClosed) return null;

    if (result case Success<QueueEntry>(:final data)) {
      emit(null);
      return data;
    }
    unawaited(refresh());
    return null;
  }

  /// A place worth showing. `pendingPayment` is not in line yet.
  static bool isLive(QueueEntryStatus status) =>
      status == QueueEntryStatus.waiting ||
      status == QueueEntryStatus.called ||
      status == QueueEntryStatus.serving;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

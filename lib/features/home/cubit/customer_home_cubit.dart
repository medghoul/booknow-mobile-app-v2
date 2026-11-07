import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/customer_home.dart';
import 'package:booknow_mobile/domain/models/queue.dart';
import 'package:booknow_mobile/domain/repositories/customer_home_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What the customer's home is showing.
sealed class CustomerHomeState {
  const CustomerHomeState();
}

final class CustomerHomeLoading extends CustomerHomeState {
  const CustomerHomeLoading();
}

final class CustomerHomeLoaded extends CustomerHomeState {
  const CustomerHomeLoaded(
    this.data, {
    this.queueEntry,
    this.queues = const {},
  });

  final CustomerHome data;

  /// The customer's place in a shop's queue, shown above everything else.
  final QueueEntry? queueEntry;

  /// The live line of each queue shop on screen, by shop id. Absent for a shop
  /// whose read failed: its card just goes without the pill.
  final Map<String, ShopQueue> queues;
}

final class CustomerHomeFailure extends CustomerHomeState {
  const CustomerHomeFailure(this.error);

  final NetworkException error;
}

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  CustomerHomeCubit(
    this._repository, {
    QueueRepository? queue,
    bool Function()? isSignedIn,
  }) : _queue = queue,
       _isSignedIn = isSignedIn ?? _always,
       super(const CustomerHomeLoading());

  final CustomerHomeRepository _repository;
  final QueueRepository? _queue;
  final bool Function() _isSignedIn;

  static bool _always() => true;

  /// The home endpoint has no queue numbers, so each queue shop is one more
  /// call. The cap keeps a long list from becoming a burst of requests.
  static const int _maxLiveQueues = 10;

  ({double lat, double lng})? _origin;

  /// Whether the shops are ordered by distance from the customer.
  bool get isNearby => _origin != null;

  /// Orders the shops by distance from here, or by name again with null.
  Future<void> useOrigin(({double lat, double lng})? origin) {
    _origin = origin;
    return load();
  }

  /// Loads the home. With [refresh] — a pull-to-refresh — the current content
  /// stays on screen while the call runs, and a failed refresh leaves it
  /// there rather than replacing good data with an error page.
  ///
  /// Coordinates go only once the customer asked for the nearest shops. Without
  /// them the server orders by name and every card comes back with no distance.
  Future<void> load({bool refresh = false}) async {
    if (!refresh) emit(const CustomerHomeLoading());

    final (result, queueEntry) = await (
      _repository.load(lat: _origin?.lat, lng: _origin?.lng),
      _activeQueueEntry(),
    ).wait;
    if (isClosed) return;

    switch (result) {
      case Success<CustomerHome>(:final data):
        // Draw now, with whatever lines are already known, then fill them in.
        final previous = state;
        emit(
          CustomerHomeLoaded(
            data,
            queueEntry: queueEntry,
            queues: previous is CustomerHomeLoaded ? previous.queues : const {},
          ),
        );

        final queues = await _liveQueues(data);
        if (isClosed || queues.isEmpty) return;
        emit(CustomerHomeLoaded(data, queueEntry: queueEntry, queues: queues));
      case Failure<CustomerHome>(:final error):
        if (refresh && state is CustomerHomeLoaded) return;
        emit(CustomerHomeFailure(error));
    }
  }

  Future<Map<String, ShopQueue>> _liveQueues(CustomerHome data) async {
    final queue = _queue;
    if (queue == null) return const {};

    final shopIds = data.shops
        .where((shop) => shop.mode.runsQueue)
        .take(_maxLiveQueues)
        .map((shop) => shop.id);
    final results = await Future.wait(shopIds.map(queue.shopQueue));

    return {
      for (final result in results)
        if (result case Success<ShopQueue>(:final data)) data.shopId: data,
    };
  }

  /// The active queue place, or null. A failed read never costs the home:
  /// the card is extra, the rest of the screen is not.
  Future<QueueEntry?> _activeQueueEntry() async {
    final queue = _queue;
    if (queue == null || !_isSignedIn()) return null;
    final result = await queue.mine();
    return result is Success<QueueEntry?> ? result.data : null;
  }
}

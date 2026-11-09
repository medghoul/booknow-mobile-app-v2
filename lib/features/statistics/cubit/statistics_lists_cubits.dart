import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What a screen reading one thing from the server is showing.
class StatisticsLoadState<T> {
  const StatisticsLoadState({
    this.data,
    this.isLoading = true,
    this.busy = false,
    this.failure,
  });

  final T? data;
  final bool isLoading;

  /// A button is waiting on the server; the others wait with it.
  final bool busy;
  final NetworkException? failure;
}

/// One person against the shop, over the overview's date range.
class StaffStatisticsCubit extends Cubit<StatisticsLoadState<StaffStatistics>> {
  StaffStatisticsCubit(
    this._repository, {
    required this.providerId,
    this.days,
    this.from,
    this.to,
  }) : super(const StatisticsLoadState());

  final StatisticsRepository _repository;
  final String providerId;
  final int? days;
  final String? from;
  final String? to;

  Future<void> load() async {
    emit(StatisticsLoadState(data: state.data));

    final result = await _repository.staff(
      providerId,
      days: days,
      from: from,
      to: to,
    );
    if (isClosed) return;

    switch (result) {
      case Success<StaffStatistics>(:final data):
        emit(StatisticsLoadState(data: data, isLoading: false));
      case Failure<StaffStatistics>(:final error):
        emit(
          StatisticsLoadState(
            data: state.data,
            isLoading: false,
            failure: error,
          ),
        );
    }
  }
}

/// The menu times the real times disagree with.
///
/// Accepting is the only thing in the app that changes the menu from here, and
/// it always asks the server, which works the number out again.
class SuggestionsCubit
    extends Cubit<StatisticsLoadState<List<DurationSuggestion>>> {
  SuggestionsCubit(this._repository) : super(const StatisticsLoadState());

  final StatisticsRepository _repository;

  Future<void> load() => _run(_repository.suggestions, keepLoading: true);

  /// True once the menu has changed.
  Future<bool> accept(DurationSuggestion item) =>
      _run(() => _repository.acceptSuggestion(item.serviceId));

  Future<bool> dismiss(DurationSuggestion item) =>
      _run(() => _repository.dismissSuggestion(item.serviceId));

  Future<bool> _run(
    Future<ApiResult<List<DurationSuggestion>>> Function() action, {
    bool keepLoading = false,
  }) async {
    if (state.busy) return false;
    emit(
      StatisticsLoadState(
        data: state.data,
        isLoading: keepLoading,
        busy: !keepLoading,
      ),
    );

    final result = await action();
    if (isClosed) return false;

    switch (result) {
      case Success<List<DurationSuggestion>>(:final data):
        emit(StatisticsLoadState(data: data, isLoading: false));
        return true;
      case Failure<List<DurationSuggestion>>(:final error):
        emit(
          StatisticsLoadState(
            data: state.data,
            isLoading: false,
            failure: error,
          ),
        );
        return false;
    }
  }
}

/// The visits whose times the owner should look at.
class NeedsReviewCubit extends Cubit<StatisticsLoadState<ReviewList>> {
  NeedsReviewCubit(this._repository) : super(const StatisticsLoadState());

  final StatisticsRepository _repository;

  Future<void> load() async {
    emit(StatisticsLoadState(data: state.data));

    final result = await _repository.reviewItems();
    if (isClosed) return;

    switch (result) {
      case Success<ReviewList>(:final data):
        emit(StatisticsLoadState(data: data, isLoading: false));
      case Failure<ReviewList>(:final error):
        emit(
          StatisticsLoadState(
            data: state.data,
            isLoading: false,
            failure: error,
          ),
        );
    }
  }

  /// True once saved.
  Future<bool> correct(
    ReviewItem item, {
    DateTime? startedAt,
    DateTime? finishedAt,
  }) => _settle(
    item,
    () => _repository.correctVisit(
      item,
      startedAt: startedAt,
      finishedAt: finishedAt,
    ),
  );

  /// True once it is off the list.
  Future<bool> leave(ReviewItem item) =>
      _settle(item, () => _repository.dismissVisit(item));

  Future<bool> _settle(
    ReviewItem item,
    Future<ApiResult<void>> Function() action,
  ) async {
    final list = state.data;
    if (state.busy || list == null) return false;
    emit(StatisticsLoadState(data: list, isLoading: false, busy: true));

    final result = await action();
    if (isClosed) return false;

    switch (result) {
      case Success<void>():
        emit(
          StatisticsLoadState(
            data: list.copyWith(
              items: list.items
                  .where((other) => other.visitId != item.visitId)
                  .toList(),
            ),
            isLoading: false,
          ),
        );
        return true;
      case Failure<void>(:final error):
        emit(StatisticsLoadState(data: list, isLoading: false, failure: error));
        return false;
    }
  }
}

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum StatisticsPreset {
  today(1),
  week(7),
  month(30),
  custom(null);

  const StatisticsPreset(this.days);

  final int? days;
}

/// What the statistics screens are showing, and what they are filtered by.
class OwnerStatisticsState {
  const OwnerStatisticsState({
    this.preset = StatisticsPreset.week,
    this.customFrom,
    this.customTo,
    this.providerId,
    this.serviceId,
    this.data,
    this.isLoading = true,
    this.failure,
  });

  final StatisticsPreset preset;
  final String? customFrom;
  final String? customTo;
  final String? providerId;
  final String? serviceId;
  final ShopStatistics? data;
  final bool isLoading;
  final NetworkException? failure;
}

/// Runs the date range and filters over `GET /v1/shops/me/statistics`.
///
/// Shared by the overview and its detail pages, so a page opened from a card
/// shows exactly the range and filters the card was showing.
class OwnerStatisticsCubit extends Cubit<OwnerStatisticsState> {
  OwnerStatisticsCubit(this._repository) : super(const OwnerStatisticsState());

  final StatisticsRepository _repository;

  /// A slow answer for the range before must not replace the one asked for now.
  int _request = 0;

  Future<void> load() async {
    final wanted = state;
    final request = _request += 1;

    emit(_with(isLoading: true));

    final result = await _repository.statistics(
      days: wanted.preset.days,
      from: wanted.preset == StatisticsPreset.custom ? wanted.customFrom : null,
      to: wanted.preset == StatisticsPreset.custom ? wanted.customTo : null,
      providerId: wanted.providerId,
      serviceId: wanted.serviceId,
    );
    if (isClosed || request != _request) return;

    switch (result) {
      case Success<ShopStatistics>(:final data):
        emit(_with(data: data, isLoading: false));
      case Failure<ShopStatistics>(:final error):
        emit(_with(isLoading: false, failure: error));
    }
  }

  Future<void> choosePreset(StatisticsPreset preset) {
    emit(_copy(preset: preset));
    return load();
  }

  /// [from] and [to] are `yyyy-MM-dd`.
  Future<void> chooseCustom(String from, String to) {
    emit(
      _copy(preset: StatisticsPreset.custom, customFrom: from, customTo: to),
    );
    return load();
  }

  /// Null is everyone.
  Future<void> filterProvider(String? providerId) {
    emit(_copy(providerId: () => providerId));
    return load();
  }

  /// Null is every service.
  Future<void> filterService(String? serviceId) {
    emit(_copy(serviceId: () => serviceId));
    return load();
  }

  OwnerStatisticsState _with({
    ShopStatistics? data,
    required bool isLoading,
    NetworkException? failure,
  }) => OwnerStatisticsState(
    preset: state.preset,
    customFrom: state.customFrom,
    customTo: state.customTo,
    providerId: state.providerId,
    serviceId: state.serviceId,
    data: data ?? state.data,
    isLoading: isLoading,
    failure: failure,
  );

  OwnerStatisticsState _copy({
    StatisticsPreset? preset,
    String? customFrom,
    String? customTo,
    String? Function()? providerId,
    String? Function()? serviceId,
  }) => OwnerStatisticsState(
    preset: preset ?? state.preset,
    customFrom: customFrom ?? state.customFrom,
    customTo: customTo ?? state.customTo,
    providerId: providerId == null ? state.providerId : providerId(),
    serviceId: serviceId == null ? state.serviceId : serviceId(),
    data: state.data,
    isLoading: state.isLoading,
    failure: state.failure,
  );
}

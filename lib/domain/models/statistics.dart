import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics.freezed.dart';

/// The shop's figures for one date range and filter.
///
/// A null is "nothing to work this out from", which is a different thing to
/// say from zero.
@freezed
abstract class StatisticsSummary with _$StatisticsSummary {
  const factory StatisticsSummary({
    required int completed,
    required int reliable,
    required int revenueCents,
    required int flagged,
    required int? medianMin,
    required double? avgPlannedMin,
    required double? avgActualMin,
    required int overruns,
    required double? overrunPct,
    required int waitCount,
    required double? waitAvgMin,
    required int? waitP90Min,
    required int joined,
    required int walkAways,
    required int unserved,
    required int turnedAway,
    required int lostWalkAwayCents,
    required int lostUnservedCents,
    required int lostTurnedAwayCents,
    required int lostCents,
    required int booked,
    required int cancelled,
    required int noShows,
    required double? noShowPct,
    required int bookingsStarted,
    required double? onTimePct,
    required double? avgDelayMin,
    required double? utilizationPct,
    required int busyMin,
    required int availableMin,
    required int afterCloseMin,
    required int estimates,
    required double? estimateWithinPct,
    required double? estimateAvgErrorMin,
    required double? estimateAvgAbsErrorMin,
  }) = _StatisticsSummary;
}

/// Real against planned time for one person doing one service.
@freezed
abstract class ServicePersonStatistics with _$ServicePersonStatistics {
  const factory ServicePersonStatistics({
    required String providerId,
    required String? name,
    required int completed,
    required int? medianMin,
    required double? avgPlannedMin,
    required double? overrunPct,
  }) = _ServicePersonStatistics;
}

/// Real against planned time for one service.
@freezed
abstract class ServiceStatistics with _$ServiceStatistics {
  const factory ServiceStatistics({
    required String serviceId,

    /// Null once the service has been deleted: it is still history.
    required String? name,
    required int? menuMin,
    required int revenueCents,
    required int completed,
    required int? medianMin,
    required double? avgPlannedMin,
    required double? overrunPct,
    required List<ServicePersonStatistics> byProvider,
  }) = _ServiceStatistics;
}

/// Services started in one hour of one weekday, Monday being 0.
@freezed
abstract class HeatmapCell with _$HeatmapCell {
  const factory HeatmapCell({
    required int weekday,
    required int hour,
    required int count,
  }) = _HeatmapCell;
}

/// Something the statistics can be filtered by.
@freezed
abstract class StatisticsFilterOption with _$StatisticsFilterOption {
  const factory StatisticsFilterOption({
    required String id,
    required String name,
  }) = _StatisticsFilterOption;
}

/// `GET /v1/shops/me/statistics`.
@freezed
abstract class ShopStatistics with _$ShopStatistics {
  const factory ShopStatistics({
    required String from,
    required String to,
    required String timeZone,
    required bool hasData,

    /// Off means nothing here can be told apart by employee.
    required bool personStatsEnabled,
    required List<StatisticsFilterOption> providers,
    required List<StatisticsFilterOption> services,
    required StatisticsSummary summary,
    required List<ServiceStatistics> perService,
    required List<HeatmapCell> heatmap,
  }) = _ShopStatistics;
}

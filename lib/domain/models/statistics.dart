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

    /// Menu times the real times disagree with.
    required int suggestionCount,

    /// Visits whose times the owner should look at.
    required int reviewCount,
    required List<StatisticsFilterOption> providers,
    required List<StatisticsFilterOption> services,
    required StatisticsSummary summary,
    required List<ServiceStatistics> perService,
    required List<HeatmapCell> heatmap,
  }) = _ShopStatistics;
}

/// One service, this person against the shop.
@freezed
abstract class StaffServiceStatistics with _$StaffServiceStatistics {
  const factory StaffServiceStatistics({
    required String serviceId,
    required String? name,
    required int? menuMin,
    required int completed,
    required int? medianMin,
    required double? overrunPct,
    required int? shopMedianMin,
    required double? shopOverrunPct,
  }) = _StaffServiceStatistics;
}

/// One person against the shop (`GET /v1/shops/me/statistics/staff/{id}`).
@freezed
abstract class StaffStatistics with _$StaffStatistics {
  const factory StaffStatistics({
    required String from,
    required String to,
    required String? name,
    required bool hasData,
    required StatisticsSummary summary,
    required StatisticsSummary shop,
    required List<StaffServiceStatistics> perService,
  }) = _StaffStatistics;
}

/// "Fade takes 36 minutes, your menu says 30."
@freezed
abstract class DurationSuggestion with _$DurationSuggestion {
  const factory DurationSuggestion({
    required String serviceId,
    required String name,
    required int menuMin,
    required int realMin,

    /// [realMin] on the booking grid: what the menu would become.
    required int suggestedMin,
    required int samples,
  }) = _DurationSuggestion;
}

/// Why a visit's times cannot be believed.
enum ReviewFlag { forgottenDone, tooShort, neverStarted }

/// A visit for the owner to fix. Names no customer.
@freezed
abstract class ReviewItem with _$ReviewItem {
  const factory ReviewItem({
    required String visitId,
    required String localDate,
    required ReviewFlag flag,
    required int? plannedMin,
    required DateTime? startedAt,
    required DateTime? finishedAt,
    required String? providerName,
    required String? serviceName,
  }) = _ReviewItem;
}

/// `GET /v1/shops/me/statistics/review`.
@freezed
abstract class ReviewList with _$ReviewList {
  const factory ReviewList({
    required String timeZone,
    required List<ReviewItem> items,
  }) = _ReviewList;
}

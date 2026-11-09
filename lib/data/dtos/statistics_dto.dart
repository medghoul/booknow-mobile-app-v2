import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';

int? _intOrNull(Object? value) => value is num ? value.round() : null;

Iterable<Map<String, dynamic>> _rows(Object? value) =>
    (value is List ? value.whereType<Map>() : const <Map>[]).map(asMap);

/// Reads `GET /v1/shops/me/statistics`.
ShopStatistics shopStatisticsFromJson(Map<String, dynamic> json) =>
    ShopStatistics(
      from: asText(json['from']),
      to: asText(json['to']),
      timeZone: asText(json['timeZone'], 'Europe/Rome'),
      hasData: asBool(json['hasData'], fallback: false),
      personStatsEnabled: asBool(json['personStatsEnabled'], fallback: false),
      suggestionCount: asInt(json['suggestionCount']),
      reviewCount: asInt(json['reviewCount']),
      providers: [
        for (final row in _rows(json['providers']))
          if (asTextOrNull(row['providerId']) case final id?)
            StatisticsFilterOption(id: id, name: asText(row['name'], id)),
      ],
      services: [
        for (final row in _rows(json['services']))
          if (asTextOrNull(row['serviceId']) case final id?)
            StatisticsFilterOption(id: id, name: asText(row['name'], id)),
      ],
      summary: _summary(asMap(json['summary'])),
      perService: [
        for (final row in _rows(json['perService']))
          if (asTextOrNull(row['serviceId']) case final id?) _service(id, row),
      ],
      heatmap: [
        for (final row in _rows(json['heatmap']))
          HeatmapCell(
            weekday: asInt(row['weekday']),
            hour: asInt(row['hour']),
            count: asInt(row['count']),
          ),
      ],
    );

StatisticsSummary _summary(Map<String, dynamic> json) => StatisticsSummary(
  completed: asInt(json['completed']),
  reliable: asInt(json['reliable']),
  revenueCents: asInt(json['revenueCents']),
  flagged: asInt(json['flagged']),
  medianMin: _intOrNull(json['medianMin']),
  avgPlannedMin: asDoubleOrNull(json['avgPlannedMin']),
  avgActualMin: asDoubleOrNull(json['avgActualMin']),
  overruns: asInt(json['overruns']),
  overrunPct: asDoubleOrNull(json['overrunPct']),
  waitCount: asInt(json['waitCount']),
  waitAvgMin: asDoubleOrNull(json['waitAvgMin']),
  waitP90Min: _intOrNull(json['waitP90Min']),
  joined: asInt(json['joined']),
  walkAways: asInt(json['walkAways']),
  unserved: asInt(json['unserved']),
  turnedAway: asInt(json['turnedAway']),
  lostWalkAwayCents: asInt(json['lostWalkAwayCents']),
  lostUnservedCents: asInt(json['lostUnservedCents']),
  lostTurnedAwayCents: asInt(json['lostTurnedAwayCents']),
  lostCents: asInt(json['lostCents']),
  booked: asInt(json['booked']),
  cancelled: asInt(json['cancelled']),
  noShows: asInt(json['noShows']),
  noShowPct: asDoubleOrNull(json['noShowPct']),
  bookingsStarted: asInt(json['bookingsStarted']),
  onTimePct: asDoubleOrNull(json['onTimePct']),
  avgDelayMin: asDoubleOrNull(json['avgDelayMin']),
  utilizationPct: asDoubleOrNull(json['utilizationPct']),
  busyMin: asInt(json['busyMin']),
  availableMin: asInt(json['availableMin']),
  afterCloseMin: asInt(json['afterCloseMin']),
  estimates: asInt(json['estimates']),
  estimateWithinPct: asDoubleOrNull(json['estimateWithinPct']),
  estimateAvgErrorMin: asDoubleOrNull(json['estimateAvgErrorMin']),
  estimateAvgAbsErrorMin: asDoubleOrNull(json['estimateAvgAbsErrorMin']),
);

ServiceStatistics _service(String id, Map<String, dynamic> json) =>
    ServiceStatistics(
      serviceId: id,
      name: asTextOrNull(json['name']),
      menuMin: _intOrNull(json['menuMin']),
      revenueCents: asInt(json['revenueCents']),
      completed: asInt(json['completed']),
      medianMin: _intOrNull(json['medianMin']),
      avgPlannedMin: asDoubleOrNull(json['avgPlannedMin']),
      overrunPct: asDoubleOrNull(json['overrunPct']),
      byProvider: [
        for (final row in _rows(json['byProvider']))
          if (asTextOrNull(row['providerId']) case final providerId?)
            ServicePersonStatistics(
              providerId: providerId,
              name: asTextOrNull(row['name']),
              completed: asInt(row['completed']),
              medianMin: _intOrNull(row['medianMin']),
              avgPlannedMin: asDoubleOrNull(row['avgPlannedMin']),
              overrunPct: asDoubleOrNull(row['overrunPct']),
            ),
      ],
    );

/// Reads `GET /v1/shops/me/statistics/staff/{providerId}`.
StaffStatistics staffStatisticsFromJson(Map<String, dynamic> json) =>
    StaffStatistics(
      from: asText(json['from']),
      to: asText(json['to']),
      name: asTextOrNull(json['name']),
      hasData: asBool(json['hasData'], fallback: false),
      summary: _summary(asMap(json['summary'])),
      shop: _summary(asMap(json['shop'])),
      perService: [
        for (final row in _rows(json['perService']))
          if (asTextOrNull(row['serviceId']) case final id?)
            StaffServiceStatistics(
              serviceId: id,
              name: asTextOrNull(row['name']),
              menuMin: _intOrNull(row['menuMin']),
              completed: asInt(row['completed']),
              medianMin: _intOrNull(row['medianMin']),
              overrunPct: asDoubleOrNull(row['overrunPct']),
              shopMedianMin: _intOrNull(row['shopMedianMin']),
              shopOverrunPct: asDoubleOrNull(row['shopOverrunPct']),
            ),
      ],
    );

/// Reads the `suggestions` of the suggestion routes.
List<DurationSuggestion> suggestionsFromJson(Map<String, dynamic> json) => [
  for (final row in _rows(json['suggestions']))
    if (asTextOrNull(row['serviceId']) case final id?)
      DurationSuggestion(
        serviceId: id,
        name: asText(row['name']),
        menuMin: asInt(row['menuMin']),
        realMin: asInt(row['realMin']),
        suggestedMin: asInt(row['suggestedMin']),
        samples: asInt(row['samples']),
      ),
];

ReviewFlag? _flag(String? value) => switch (value) {
  'forgotten_done' => ReviewFlag.forgottenDone,
  'too_short' => ReviewFlag.tooShort,
  'never_started' => ReviewFlag.neverStarted,
  _ => null,
};

/// Reads `GET /v1/shops/me/statistics/review`.
ReviewList reviewListFromJson(Map<String, dynamic> json) => ReviewList(
  timeZone: asText(json['timeZone'], 'Europe/Rome'),
  items: [
    for (final row in _rows(json['items']))
      if ((asTextOrNull(row['visitId']), _flag(asTextOrNull(row['flag'])))
          case (final id?, final flag?))
        ReviewItem(
          visitId: id,
          localDate: asText(row['localDate']),
          flag: flag,
          plannedMin: _intOrNull(row['plannedMin']),
          startedAt: asInstantOrNull(row['startedAt']),
          finishedAt: asInstantOrNull(row['finishedAt']),
          providerName: asTextOrNull(row['providerName']),
          serviceName: asTextOrNull(row['serviceName']),
        ),
  ],
);

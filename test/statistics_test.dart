import 'dart:async';

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/data/dtos/statistics_dto.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_heatmap.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_overview.dart';
import 'package:booknow_mobile/features/statistics/widgets/statistics_sections.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

Map<String, dynamic> _json({
  bool hasData = true,
  bool personStats = true,
  Map<String, dynamic> summary = const {},
}) => {
  'from': '2026-10-01',
  'to': '2026-10-31',
  'timeZone': 'Europe/Rome',
  'hasData': hasData,
  'personStatsEnabled': personStats,
  'providers': personStats
      ? [
          {'providerId': 'luca', 'name': 'Luca'},
        ]
      : [],
  'services': [
    {'serviceId': 'cut', 'name': 'Haircut'},
  ],
  'summary': {
    'completed': 636,
    'reliable': 618,
    'revenueCents': 1598900,
    'flagged': 18,
    'medianMin': 34,
    'avgPlannedMin': 36.1,
    'avgActualMin': 39.9,
    'overruns': 90,
    'overrunPct': 14.6,
    'waitCount': 356,
    'waitAvgMin': 15.6,
    'waitP90Min': 48,
    'joined': 400,
    'walkAways': 25,
    'unserved': 0,
    'turnedAway': 121,
    'lostWalkAwayCents': 57400,
    'lostUnservedCents': 0,
    'lostTurnedAwayCents': 329300,
    'lostCents': 386700,
    'booked': 300,
    'cancelled': 20,
    'noShows': 26,
    'noShowPct': 9.5,
    'bookingsStarted': 250,
    'onTimePct': 68.6,
    'avgDelayMin': 11.4,
    'utilizationPct': 52.1,
    'busyMin': 25000,
    'availableMin': 48600,
    'afterCloseMin': 271,
    'estimates': 356,
    'estimateWithinPct': 92.7,
    'estimateAvgErrorMin': -1.5,
    'estimateAvgAbsErrorMin': 2.5,
    ...summary,
  },
  'perService': [
    {
      'serviceId': 'cut',
      'name': 'Haircut',
      'menuMin': 30,
      'revenueCents': 400000,
      'completed': 200,
      'medianMin': 36,
      'avgPlannedMin': 30,
      'overrunPct': 20,
      'byProvider': [
        {
          'providerId': 'luca',
          'name': 'Luca',
          'completed': 80,
          'medianMin': 38,
          'avgPlannedMin': 30,
          'overrunPct': 25,
        },
      ],
    },
    {
      'serviceId': 'gone',
      'name': null,
      'revenueCents': 100,
      'completed': 1,
      'byProvider': [],
    },
  ],
  'heatmap': [
    {'weekday': 0, 'hour': 9, 'count': 3},
    {'weekday': 5, 'hour': 18, 'count': 20},
  ],
};

class _Repository implements StatisticsRepository {
  _Repository(this.answer);

  ApiResult<ShopStatistics> answer;
  final List<Map<String, Object?>> asked = [];

  @override
  Future<ApiResult<ShopStatistics>> statistics({
    int? days,
    String? from,
    String? to,
    String? providerId,
    String? serviceId,
  }) async {
    asked.add({
      'days': days,
      'from': from,
      'to': to,
      'providerId': providerId,
      'serviceId': serviceId,
    });
    return answer;
  }
}

ApiResult<ShopStatistics> _ok([Map<String, dynamic>? json]) =>
    ApiResult.success(shopStatisticsFromJson(json ?? _json()));

void main() {
  final t = AppLocale.en.buildSync().statistics;

  group('reading the response', () {
    test('reads the figures and keeps a missing one null', () {
      final data = shopStatisticsFromJson(
        _json(summary: {'onTimePct': null, 'waitP90Min': null}),
      );

      expect(data.summary.completed, 636);
      expect(data.summary.utilizationPct, 52.1);
      expect(data.summary.onTimePct, isNull);
      expect(data.summary.waitP90Min, isNull);
    });

    test('keeps a deleted service as history', () {
      final data = shopStatisticsFromJson(_json());

      expect(data.perService[1].name, isNull);
      expect(data.perService[0].byProvider.single.name, 'Luca');
    });
  });

  group('the cubit', () {
    test('opens on the last seven days', () async {
      final repository = _Repository(_ok());
      final cubit = OwnerStatisticsCubit(repository);

      await cubit.load();

      expect(repository.asked.single['days'], 7);
      expect(cubit.state.data, isNotNull);
      await cubit.close();
    });

    test('asks for each preset', () async {
      final repository = _Repository(_ok());
      final cubit = OwnerStatisticsCubit(repository);

      await cubit.choosePreset(StatisticsPreset.today);
      await cubit.choosePreset(StatisticsPreset.month);

      expect(repository.asked.map((item) => item['days']), [1, 30]);
      await cubit.close();
    });

    test('a custom range sends dates and no days', () async {
      final repository = _Repository(_ok());
      final cubit = OwnerStatisticsCubit(repository);

      await cubit.chooseCustom('2026-10-01', '2026-10-15');

      expect(repository.asked.single, {
        'days': null,
        'from': '2026-10-01',
        'to': '2026-10-15',
        'providerId': null,
        'serviceId': null,
      });
      await cubit.close();
    });

    test('filters stack, and can be cleared', () async {
      final repository = _Repository(_ok());
      final cubit = OwnerStatisticsCubit(repository);

      await cubit.filterProvider('luca');
      await cubit.filterService('cut');
      await cubit.filterProvider(null);

      expect(repository.asked.last, containsPair('providerId', null));
      expect(repository.asked.last, containsPair('serviceId', 'cut'));
      await cubit.close();
    });

    test('keeps showing the figures when a refresh fails', () async {
      final repository = _Repository(_ok());
      final cubit = OwnerStatisticsCubit(repository);
      await cubit.load();

      repository.answer = ApiResult.failure(const UnexpectedError('down'));
      await cubit.load();

      expect(cubit.state.data, isNotNull);
      expect(cubit.state.failure, isNotNull);
      await cubit.close();
    });

    test('ignores a slow answer for a range no longer asked for', () async {
      final slow = Completer<ApiResult<ShopStatistics>>();
      final repository = _Sequenced([
        slow.future,
        Future.value(_ok(_json(summary: {'completed': 2}))),
      ]);
      final cubit = OwnerStatisticsCubit(repository);

      final first = cubit.choosePreset(StatisticsPreset.today);
      await cubit.choosePreset(StatisticsPreset.month);
      slow.complete(_ok(_json(summary: {'completed': 1})));
      await first;

      expect(cubit.state.data?.summary.completed, 2);
      await cubit.close();
    });
  });

  group('the overview', () {
    Future<OwnerStatisticsCubit> pump(
      WidgetTester tester,
      ApiResult<ShopStatistics> answer, {
      ValueChanged<StatisticsSection>? onOpen,
    }) async {
      tester.view.physicalSize = const Size(1170, 3000);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final cubit = OwnerStatisticsCubit(_Repository(answer));
      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: StatisticsOverview(onOpen: onOpen ?? (_) {}),
        ),
      );
      await cubit.load();
      await tester.pumpAndSettle();
      return cubit;
    }

    testWidgets('shows a card for each figure', (tester) async {
      await pump(tester, _ok());

      for (final label in [
        t.kpi.wait,
        t.kpi.lost,
        t.kpi.onTime,
        t.kpi.utilization,
        t.kpi.overruns,
        t.kpi.revenue,
        t.kpi.estimates,
      ]) {
        expect(find.text(label), findsOneWidget);
      }
      expect(find.text('68.6%'), findsOneWidget);
      expect(find.text('€15,989'), findsOneWidget);
    });

    testWidgets('opens the page for each figure', (tester) async {
      final opened = <StatisticsSection>[];
      await pump(tester, _ok(), onOpen: opened.add);

      for (final label in [
        t.kpi.wait,
        t.kpi.lost,
        t.kpi.onTime,
        t.kpi.utilization,
        t.kpi.overruns,
        t.kpi.revenue,
        t.kpi.estimates,
      ]) {
        await tester.tap(find.text(label));
      }

      expect(opened, [
        StatisticsSection.waits,
        StatisticsSection.waits,
        StatisticsSection.bookings,
        StatisticsSection.busyHours,
        StatisticsSection.services,
        StatisticsSection.services,
        StatisticsSection.estimates,
      ]);
    });

    testWidgets('compares average with average across services', (
      tester,
    ) async {
      await pump(tester, _ok());

      expect(
        find.text(t.kpi.overrunsDetail(real: '39.9 min', plan: '36.1 min')),
        findsOneWidget,
      );
    });

    testWidgets('says a figure it cannot work out is unknown', (tester) async {
      await pump(tester, _ok(_json(summary: {'onTimePct': null})));

      expect(find.text('–'), findsOneWidget);
    });

    testWidgets('offers the staff filter when the shop chose it', (
      tester,
    ) async {
      await pump(tester, _ok());

      expect(find.text(t.everyone), findsOneWidget);
    });

    testWidgets('hides the staff filter otherwise', (tester) async {
      await pump(tester, _ok(_json(personStats: false)));

      expect(find.text(t.everyone), findsNothing);
      expect(find.text(t.allServices), findsOneWidget);
    });

    testWidgets('filters by a person from the sheet', (tester) async {
      final cubit = await pump(tester, _ok());

      await tester.tap(find.text(t.everyone));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Luca'));
      await tester.pumpAndSettle();

      expect(cubit.state.providerId, 'luca');
    });

    testWidgets('has an empty state', (tester) async {
      await pump(tester, _ok(_json(hasData: false)));

      expect(find.text(t.emptyTitle), findsOneWidget);
      expect(find.text(t.kpi.wait), findsNothing);
    });

    testWidgets('has an error state with a retry', (tester) async {
      await pump(tester, ApiResult.failure(const UnexpectedError('down')));

      expect(find.text(AppLocale.en.buildSync().common.retry), findsOneWidget);
    });

    testWidgets('has a loading state', (tester) async {
      final cubit = OwnerStatisticsCubit(
        _Sequenced([Completer<ApiResult<ShopStatistics>>().future]),
      );
      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: StatisticsOverview(onOpen: (_) {}),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsWidgets);
      expect(find.text(t.kpi.wait), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  });

  group('the detail pages', () {
    final data = shopStatisticsFromJson(_json());
    final detail = t.detail;

    Future<void> pump(WidgetTester tester, StatisticsSection section) async {
      tester.view.physicalSize = const Size(1170, 3000);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await pumpThemed(
        tester,
        StatisticsSectionView(section: section, data: data),
      );
      await tester.pump();
    }

    testWidgets('services compare real and planned, by person too', (
      tester,
    ) async {
      await pump(tester, StatisticsSection.services);

      expect(find.text('Haircut'), findsOneWidget);
      expect(find.text('Luca'), findsOneWidget);
      expect(find.text(detail.deletedService), findsOneWidget);
    });

    testWidgets('waits show the average, the 90th percentile and the loss', (
      tester,
    ) async {
      await pump(tester, StatisticsSection.waits);

      expect(find.text(detail.p90), findsOneWidget);
      expect(find.text('€3,867'), findsOneWidget);
    });

    testWidgets('bookings show punctuality and no-shows', (tester) async {
      await pump(tester, StatisticsSection.bookings);

      expect(find.text('68.6%'), findsOneWidget);
      expect(find.text('9.5%'), findsOneWidget);
    });

    testWidgets('busy hours draw the heatmap', (tester) async {
      await pump(tester, StatisticsSection.busyHours);

      expect(find.byType(StatisticsHeatmap), findsOneWidget);
    });

    testWidgets('estimates say which way they miss', (tester) async {
      await pump(tester, StatisticsSection.estimates);

      expect(find.text(detail.shorterThanShown), findsOneWidget);
      expect(find.text(detail.longerThanShown), findsNothing);
    });

    for (final section in StatisticsSection.values) {
      testWidgets('$section fits a small phone', (tester) async {
        tester.view.physicalSize = const Size(960, 1600);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);

        await pumpThemed(
          tester,
          StatisticsSectionView(section: section, data: data),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);
      });
    }
  });
}

class _Sequenced implements StatisticsRepository {
  _Sequenced(this.answers);

  final List<Future<ApiResult<ShopStatistics>>> answers;
  int _next = 0;

  @override
  Future<ApiResult<ShopStatistics>> statistics({
    int? days,
    String? from,
    String? to,
    String? providerId,
    String? serviceId,
  }) => answers[_next++];
}

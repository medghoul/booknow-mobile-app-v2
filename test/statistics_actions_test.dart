import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/data/dtos/statistics_dto.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/statistics/cubit/statistics_lists_cubits.dart';
import 'package:booknow_mobile/features/statistics/views/needs_review_page.dart';
import 'package:booknow_mobile/features/statistics/views/staff_statistics_page.dart';
import 'package:booknow_mobile/features/statistics/views/suggestions_page.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

const _fade = DurationSuggestion(
  serviceId: 'cut',
  name: 'Fade',
  menuMin: 30,
  realMin: 36,
  suggestedMin: 35,
  samples: 42,
);

final _forgotten = ReviewItem(
  visitId: 'v-1',
  localDate: '2026-11-05',
  flag: ReviewFlag.forgottenDone,
  plannedMin: 30,
  startedAt: DateTime.utc(2026, 11, 5, 9),
  finishedAt: DateTime.utc(2026, 11, 5, 12),
  providerName: 'Luca',
  serviceName: 'Fade',
);

final _reviewList = ReviewList(timeZone: 'UTC', items: [_forgotten]);

Map<String, dynamic> _staffJson({bool hasData = true}) => {
  'from': '2026-10-01',
  'to': '2026-10-31',
  'name': 'Luca',
  'hasData': hasData,
  'summary': {
    'completed': 200,
    'avgActualMin': 41.2,
    'overrunPct': 18.5,
    'utilizationPct': 61,
  },
  'shop': {
    'completed': 636,
    'avgActualMin': 39.9,
    'overrunPct': 14.6,
    'utilizationPct': 52.1,
  },
  'perService': [
    {
      'serviceId': 'cut',
      'name': 'Fade',
      'menuMin': 30,
      'completed': 80,
      'medianMin': 34,
      'overrunPct': 12,
      'shopMedianMin': 32,
      'shopOverrunPct': 9.9,
    },
  ],
};

class _Repository implements StatisticsRepository {
  ApiResult<List<DurationSuggestion>> suggestionsAnswer = const Success([
    _fade,
  ]);
  ApiResult<List<DurationSuggestion>>? decideAnswer;
  ApiResult<StaffStatistics>? staffAnswer;
  ApiResult<void> settleAnswer = const Success(null);
  final List<String> calls = [];
  Map<String, Object?>? askedStaff;
  DateTime? correctedStart;
  DateTime? correctedFinish;

  @override
  Future<ApiResult<List<DurationSuggestion>>> suggestions() async =>
      suggestionsAnswer;

  @override
  Future<ApiResult<List<DurationSuggestion>>> acceptSuggestion(
    String serviceId,
  ) async {
    calls.add('accept $serviceId');
    return decideAnswer ?? const Success([]);
  }

  @override
  Future<ApiResult<List<DurationSuggestion>>> dismissSuggestion(
    String serviceId,
  ) async {
    calls.add('dismiss $serviceId');
    return decideAnswer ?? const Success([]);
  }

  @override
  Future<ApiResult<StaffStatistics>> staff(
    String providerId, {
    int? days,
    String? from,
    String? to,
  }) async {
    askedStaff = {'id': providerId, 'days': days, 'from': from, 'to': to};
    return staffAnswer ?? Success(staffStatisticsFromJson(_staffJson()));
  }

  @override
  Future<ApiResult<ReviewList>> reviewItems() async => Success(_reviewList);

  @override
  Future<ApiResult<void>> correctVisit(
    ReviewItem item, {
    DateTime? startedAt,
    DateTime? finishedAt,
  }) async {
    calls.add('correct ${item.visitId}');
    correctedStart = startedAt;
    correctedFinish = finishedAt;
    return settleAnswer;
  }

  @override
  Future<ApiResult<void>> dismissVisit(ReviewItem item) async {
    calls.add('leave ${item.visitId}');
    return settleAnswer;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final all = AppLocale.en.buildSync();
  final t = all.statistics;

  late _Repository repository;

  setUp(() => repository = _Repository());

  group('reading', () {
    test('reads the staff figures against the shop', () {
      final data = staffStatisticsFromJson(_staffJson());

      expect(data.summary.overrunPct, 18.5);
      expect(data.shop.overrunPct, 14.6);
      expect(data.perService.single.shopMedianMin, 32);
    });

    test('reads suggestions', () {
      expect(
        suggestionsFromJson({
          'suggestions': [
            {
              'serviceId': 'cut',
              'name': 'Fade',
              'menuMin': 30,
              'realMin': 36,
              'suggestedMin': 35,
              'samples': 42,
            },
          ],
        }),
        [_fade],
      );
    });

    test('reads each reason, and drops one it does not know', () {
      final list = reviewListFromJson({
        'timeZone': 'Europe/Rome',
        'items': [
          {'visitId': 'a', 'flag': 'forgotten_done'},
          {'visitId': 'b', 'flag': 'too_short'},
          {'visitId': 'c', 'flag': 'never_started'},
          {'visitId': 'd', 'flag': 'mystery'},
        ],
      });

      expect(list.items.map((item) => item.flag), [
        ReviewFlag.forgottenDone,
        ReviewFlag.tooShort,
        ReviewFlag.neverStarted,
      ]);
    });
  });

  group('suggestions', () {
    Future<SuggestionsCubit> pump(WidgetTester tester) async {
      final cubit = SuggestionsCubit(repository);
      await pumpThemed(
        tester,
        BlocProvider.value(value: cubit, child: const SuggestionsView()),
      );
      await cubit.load();
      await tester.pump();
      return cubit;
    }

    testWidgets('states the real time and the menu', (tester) async {
      await pump(tester);

      expect(find.text(t.suggestions.takes(name: 'Fade', real: 36)), findsOne);
      expect(
        find.text(t.suggestions.menuSays(menu: 30, samples: 42)),
        findsOne,
      );
    });

    testWidgets('reading changes nothing', (tester) async {
      await pump(tester);

      expect(repository.calls, isEmpty);
    });

    testWidgets('Accept changes the menu', (tester) async {
      await pump(tester);

      await tester.tap(find.text(t.suggestions.accept(minutes: 35)));
      await tester.pump();
      await tester.pump();

      expect(repository.calls, ['accept cut']);
      expect(find.text(t.suggestions.emptyTitle), findsOne);
    });

    testWidgets('Keep leaves the menu', (tester) async {
      await pump(tester);

      await tester.tap(find.text(t.suggestions.keep(minutes: 30)));
      await tester.pump();

      expect(repository.calls, ['dismiss cut']);
    });

    testWidgets('keeps the card when the numbers have moved', (tester) async {
      final cubit = await pump(tester);
      repository.decideAnswer = const Failure(
        Conflict(ApiErrorCode.suggestionGone, 'gone'),
      );

      await tester.tap(find.text(t.suggestions.accept(minutes: 35)));
      await tester.pump();

      expect(cubit.state.failure?.code, ApiErrorCode.suggestionGone);
      expect(cubit.state.data, [_fade]);
    });

    testWidgets('has an empty state', (tester) async {
      repository.suggestionsAnswer = const Success([]);
      await pump(tester);

      expect(find.text(t.suggestions.emptyTitle), findsOne);
    });

    testWidgets('has an error state', (tester) async {
      repository.suggestionsAnswer = const Failure(UnexpectedError('down'));
      await pump(tester);

      expect(find.text(all.common.retry), findsOne);
    });
  });

  group('needs review', () {
    Future<NeedsReviewCubit> pump(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final cubit = NeedsReviewCubit(repository);
      await pumpThemed(
        tester,
        BlocProvider.value(value: cubit, child: const NeedsReviewView()),
      );
      await cubit.load();
      await tester.pumpAndSettle();
      return cubit;
    }

    testWidgets('says what is wrong and names no customer', (tester) async {
      await pump(tester);

      expect(find.text('Fade · Luca'), findsOne);
      expect(find.text(t.review.forgottenDone), findsOne);
    });

    testWidgets('a forgotten Done cannot be saved until a finish is chosen', (
      tester,
    ) async {
      await pump(tester);

      await tester.tap(find.text(t.review.fix));
      await tester.pumpAndSettle();

      expect(find.text(t.review.notSet), findsOne);
      final save = tester.widget<FilledButton>(find.byType(FilledButton).last);
      expect(save.onPressed, isNull);
    });

    testWidgets('can be left as it is', (tester) async {
      final cubit = await pump(tester);

      await tester.tap(find.text(t.review.fix));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.review.leave));
      await tester.pumpAndSettle();

      expect(repository.calls, ['leave v-1']);
      expect(cubit.state.data?.items, isEmpty);
      expect(find.text(t.review.emptyTitle), findsOne);
    });

    test('a correction takes the visit off the list', () async {
      final cubit = NeedsReviewCubit(repository);
      await cubit.load();

      final saved = await cubit.correct(
        _forgotten,
        finishedAt: DateTime.utc(2026, 11, 5, 9, 40),
      );

      expect(saved, isTrue);
      expect(repository.correctedFinish, DateTime.utc(2026, 11, 5, 9, 40));
      expect(repository.correctedStart, isNull);
      expect(cubit.state.data?.items, isEmpty);
      await cubit.close();
    });

    test('a refused correction keeps the visit on the list', () async {
      repository.settleAnswer = const Failure(UnexpectedError('no'));
      final cubit = NeedsReviewCubit(repository);
      await cubit.load();

      final saved = await cubit.correct(
        _forgotten,
        finishedAt: DateTime.utc(2026, 11, 5, 9, 40),
      );

      expect(saved, isFalse);
      expect(cubit.state.data?.items, hasLength(1));
      expect(cubit.state.failure, isNotNull);
      await cubit.close();
    });
  });

  group('staff member', () {
    Future<void> pump(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final cubit = StaffStatisticsCubit(
        repository,
        providerId: 'luca',
        days: 30,
      );
      await pumpThemed(
        tester,
        BlocProvider.value(value: cubit, child: const StaffStatisticsView()),
      );
      await cubit.load();
      await tester.pump();
    }

    testWidgets('compares the person with the shop', (tester) async {
      await pump(tester);

      expect(find.text('18.5%'), findsOne);
      expect(find.text('14.6%'), findsOne);
      expect(find.text('Fade'), findsOne);
    });

    testWidgets('reads the range the overview is on', (tester) async {
      await pump(tester);

      expect(repository.askedStaff, {
        'id': 'luca',
        'days': 30,
        'from': null,
        'to': null,
      });
    });

    testWidgets('has an empty state', (tester) async {
      repository.staffAnswer = Success(
        staffStatisticsFromJson(_staffJson(hasData: false)),
      );
      await pump(tester);

      expect(find.text(t.staff.emptyTitle), findsOne);
    });

    testWidgets('has an error state', (tester) async {
      repository.staffAnswer = const Failure(UnexpectedError('down'));
      await pump(tester);

      expect(find.text(all.common.retry), findsOne);
    });
  });
}

import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/data/dtos/statistics_dto.dart';
import 'package:booknow_mobile/domain/models/statistics.dart';
import 'package:booknow_mobile/domain/repositories/statistics_repository.dart';
import 'package:booknow_mobile/features/statistics/cubit/statistics_lists_cubits.dart';
import 'package:booknow_mobile/features/statistics/views/data_settings_page.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

const _defaults = StatisticsSettings(
  retentionMonths: 24,
  retentionChoices: [6, 12, 24, 36],
  staffStatistics: false,
);

class _Repository implements StatisticsRepository {
  ApiResult<StatisticsSettings> readAnswer = const Success(_defaults);
  ApiResult<StatisticsSettings>? saveAnswer;
  final List<Map<String, Object?>> saved = [];

  @override
  Future<ApiResult<StatisticsSettings>> settings() async => readAnswer;

  @override
  Future<ApiResult<StatisticsSettings>> updateSettings({
    int? retentionMonths,
    bool? staffStatistics,
  }) async {
    saved.add({'months': retentionMonths, 'staff': staffStatistics});
    return saveAnswer ??
        Success(
          _defaults.copyWith(
            retentionMonths: retentionMonths ?? _defaults.retentionMonths,
            staffStatistics: staffStatistics ?? _defaults.staffStatistics,
          ),
        );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final all = AppLocale.en.buildSync();
  final t = all.statistics.data;

  late _Repository repository;

  Future<DataSettingsCubit> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final cubit = DataSettingsCubit(repository);
    await pumpThemed(
      tester,
      BlocProvider.value(value: cubit, child: const DataSettingsView()),
    );
    await cubit.load();
    await tester.pumpAndSettle();
    return cubit;
  }

  setUp(() => repository = _Repository());

  test('reads the settings', () {
    expect(
      statisticsSettingsFromJson({
        'retentionMonths': 12,
        'retentionChoices': [6, 12],
        'staffStatistics': true,
      }),
      const StatisticsSettings(
        retentionMonths: 12,
        retentionChoices: [6, 12],
        staffStatistics: true,
      ),
    );
  });

  testWidgets('says what is stored and what is not', (tester) async {
    await pump(tester);

    expect(find.text(t.storedBody), findsOne);
    expect(find.text(t.notStored), findsOne);
  });

  testWidgets('offers each period and marks the current one', (tester) async {
    await pump(tester);

    for (final months in [6, 12, 24, 36]) {
      expect(find.text(t.months(n: months)), findsOne);
    }
    expect(find.byType(AppLineIcon), findsOne);
  });

  testWidgets('a longer period needs no confirmation', (tester) async {
    await pump(tester);

    await tester.tap(find.text(t.months(n: 36)));
    await tester.pumpAndSettle();

    expect(repository.saved, [
      {'months': 36, 'staff': null},
    ]);
  });

  testWidgets('a shorter period warns first', (tester) async {
    await pump(tester);

    await tester.tap(find.text(t.months(n: 6)));
    await tester.pumpAndSettle();

    expect(find.text(t.shortenTitle(months: 6)), findsOne);
    expect(repository.saved, isEmpty);

    await tester.tap(find.text(t.shortenConfirm));
    await tester.pumpAndSettle();

    expect(repository.saved.single['months'], 6);
  });

  testWidgets('declining the warning changes nothing', (tester) async {
    await pump(tester);

    await tester.tap(find.text(t.months(n: 6)));
    await tester.pumpAndSettle();
    await tester.tap(find.text(all.common.cancel));
    await tester.pumpAndSettle();

    expect(repository.saved, isEmpty);
  });

  testWidgets('statistics per person are off, and ask before turning on', (
    tester,
  ) async {
    await pump(tester);

    expect(tester.widget<AppSwitch>(find.byType(AppSwitch)).value, isFalse);

    await tester.tap(find.byType(AppSwitch));
    await tester.pumpAndSettle();

    expect(find.text(t.staffConfirmTitle), findsOne);
    expect(repository.saved, isEmpty);

    await tester.tap(find.text(t.staffConfirm));
    await tester.pumpAndSettle();

    expect(repository.saved.single['staff'], true);
    expect(tester.widget<AppSwitch>(find.byType(AppSwitch)).value, isTrue);
  });

  testWidgets('turning them off asks nothing', (tester) async {
    repository.readAnswer = Success(_defaults.copyWith(staffStatistics: true));
    await pump(tester);

    await tester.tap(find.byType(AppSwitch));
    await tester.pumpAndSettle();

    expect(repository.saved.single['staff'], false);
  });

  testWidgets('keeps the choice shown when saving fails', (tester) async {
    final cubit = await pump(tester);
    repository.saveAnswer = const Failure(UnexpectedError('down'));

    await tester.tap(find.text(t.months(n: 36)));
    await tester.pumpAndSettle();

    expect(cubit.state.data?.retentionMonths, 24);
    expect(cubit.state.failure, isNotNull);
  });

  testWidgets('has an error state', (tester) async {
    repository.readAnswer = const Failure(UnexpectedError('down'));
    await pump(tester);

    expect(find.text(all.common.retry), findsOne);
  });

  testWidgets('fits a small phone', (tester) async {
    tester.view.physicalSize = const Size(960, 1600);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final cubit = DataSettingsCubit(repository);

    await pumpThemed(
      tester,
      BlocProvider.value(value: cubit, child: const DataSettingsView()),
    );
    await cubit.load();
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

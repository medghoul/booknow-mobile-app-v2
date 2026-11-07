import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/agenda_repository.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/features/agenda/widgets/agenda_row_actions.dart';
import 'package:booknow_mobile/features/agenda/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// The agenda and blocks per person (providers §5).

/// 09:00 in Rome on the fixture Saturday, on summer time.
DateTime _at(String hhmm) => DateTime.parse(
  '2026-10-03T$hhmm:00.000Z',
).subtract(const Duration(hours: 2));

AgendaFreeRow _free(String providerId) => AgendaFreeRow(
  startUtc: _at('10:00'),
  endUtc: _at('11:00'),
  freedBy: null,
  providerId: providerId,
);

AgendaDay _day({
  List<AgendaProvider> providers = const [
    AgendaProvider(id: 'shop-1', name: 'Barbieri Navona'),
    AgendaProvider(id: 'marco', name: 'Marco'),
  ],
  List<AgendaRow>? rows,
}) => AgendaDay(
  date: '2026-10-03',
  timeZone: 'Europe/Rome',
  closed: false,
  closure: false,
  openingHours: const [],
  summary: const AgendaSummary(booked: 0, free: 1, toCollectCents: 0),
  days: const [],
  rows: rows ?? [_free('marco')],
  providers: providers,
);

class _Agenda implements AgendaRepository {
  _Agenda(this.answer);

  final AgendaDay answer;
  final List<String?> asked = [];
  String? blockedFor = 'none';

  @override
  Future<ApiResult<AgendaDay>> day({String? date, String? providerId}) async {
    asked.add(providerId);
    return Success(answer);
  }

  @override
  Future<ApiResult<TimeBlock>> block({
    required DateTime startUtc,
    required DateTime endUtc,
    String? note,
    String? providerId,
  }) async {
    blockedFor = providerId;
    return Success(
      TimeBlock(id: 'b', startUtc: startUtc, endUtc: endUtc, note: note),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();

  group('reading the day', () {
    test('says whose each row is, and who works that day', () {
      final day = AgendaDayDto.fromJson({
        'date': '2026-10-03',
        'timeZone': 'Europe/Rome',
        'providers': [
          {'providerId': 'shop-1', 'name': 'Barbieri Navona', 'order': 0},
          {'providerId': 'marco', 'name': 'Marco', 'order': 1},
        ],
        'rows': [
          {
            'kind': 'free',
            'providerId': 'marco',
            'startUtc': '2026-10-03T08:00:00.000Z',
            'endUtc': '2026-10-03T09:00:00.000Z',
          },
          {
            'kind': 'block',
            'blockId': 'b1',
            'providerId': 'shop-1',
            'startUtc': '2026-10-03T08:00:00.000Z',
            'endUtc': '2026-10-03T09:00:00.000Z',
          },
        ],
      }).toDomain();

      expect(day.hasTeam, isTrue);
      expect(day.rows.map((row) => row.providerId), ['marco', 'shop-1']);
      expect(day.nameOf('marco'), 'Marco');
    });

    test('an API from before providers reads as one person', () {
      final day = AgendaDayDto.fromJson({
        'date': '2026-10-03',
        'rows': [
          {
            'kind': 'free',
            'startUtc': '2026-10-03T08:00:00.000Z',
            'endUtc': '2026-10-03T09:00:00.000Z',
          },
        ],
      }).toDomain();

      expect(day.hasTeam, isFalse);
      expect(day.rows.single.providerId, isNull);
    });
  });

  group('the cubit', () {
    test("asks for one person's day, and everyone's again", () async {
      final agenda = _Agenda(_day());
      final cubit = OwnerAgendaCubit(agenda);
      addTearDown(cubit.close);

      await cubit.load();
      await cubit.showProvider('marco');
      await cubit.showProvider(null);

      expect(agenda.asked, [null, 'marco', null]);
    });

    test('keeps the person when the day changes', () async {
      final agenda = _Agenda(_day());
      final cubit = OwnerAgendaCubit(agenda);
      addTearDown(cubit.close);

      await cubit.showProvider('marco');
      await cubit.load(date: '2026-10-04');

      expect(agenda.asked.last, 'marco');
    });

    test('blocks the time of the person it is given', () async {
      final agenda = _Agenda(_day());
      final cubit = OwnerAgendaCubit(agenda);
      addTearDown(cubit.close);

      await cubit.blockTime(
        startUtc: _at('10:00'),
        endUtc: _at('11:00'),
        providerId: 'marco',
      );

      expect(agenda.blockedFor, 'marco');
    });
  });

  group('on screen', () {
    late _Agenda agenda;
    late OwnerAgendaCubit cubit;

    // Created by the provider, which closes it with the tree: the cubit's
    // minute ticker must not outlive the test.
    Future<void> pump(WidgetTester tester, AgendaDay day, Widget child) async {
      agenda = _Agenda(day);
      await pumpThemed(
        tester,
        BlocProvider(
          create: (_) => cubit = OwnerAgendaCubit(agenda)..load(),
          child: child,
        ),
      );
      await tester.pump();
    }

    testWidgets('the filter offers everyone, then each person', (tester) async {
      await pump(tester, _day(), const AgendaProviderFilter());

      expect(find.text(t.agenda.everyone), findsOneWidget);
      expect(find.text('Barbieri Navona'), findsOneWidget);

      await tester.tap(find.text('Marco'));
      await tester.pumpAndSettle();

      expect(agenda.asked.last, 'marco');
      expect(cubit.state.providerId, 'marco');
    });

    test('a shop of one has no filter and no names on rows', () {
      final state = OwnerAgendaState(now: _at('09:00')).copyWith(
        day: _day(
          providers: const [AgendaProvider(id: 'shop-1', name: 'Barbieri')],
        ),
      );

      expect(AgendaProviderFilter.showsFor(state), isFalse);
      expect(AgendaProviderFilter.labelFor(state, _free('shop-1')), isNull);
    });

    test("rows are named only on everyone's day", () {
      final base = OwnerAgendaState(now: _at('09:00'));
      final everyone = base.copyWith(day: _day());
      final marcos = everyone.copyWith(providerId: 'marco');

      expect(AgendaProviderFilter.labelFor(everyone, _free('marco')), 'Marco');
      expect(AgendaProviderFilter.labelFor(marcos, _free('marco')), isNull);
      // Picking someone keeps the filter up, so there is a way back.
      expect(AgendaProviderFilter.showsFor(marcos), isTrue);
    });

    testWidgets('a row says whose it is', (tester) async {
      await pumpThemed(
        tester,
        AgendaRowTile(
          row: _free('marco'),
          timeZone: 'Europe/Rome',
          now: _at('09:00'),
          onTap: null,
          providerName: 'Marco',
        ),
      );

      expect(find.textContaining('Marco · '), findsOneWidget);
    });

    testWidgets("blocking a free row takes that person's time", (tester) async {
      await pump(
        tester,
        _day(),
        Builder(
          builder: (context) => TextButton(
            onPressed: agendaRowTap(
              context,
              row: _free('marco'),
              timeZone: 'Europe/Rome',
              now: _at('09:00'),
              providerName: 'Marco',
            ),
            child: const Text('open'),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.textContaining('· Marco'), findsOneWidget);

      await tester.tap(find.text(t.agenda.block.save));
      await tester.pumpAndSettle();

      expect(agenda.blockedFor, 'marco');
      await cubit.close();
    });
  });
}

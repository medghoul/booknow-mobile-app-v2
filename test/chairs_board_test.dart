import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/data/dtos/chairs_dto.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/chairs_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/features/chairs/cubit/owner_chairs_cubit.dart';
import 'package:booknow_mobile/features/chairs/widgets/chairs_board.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

ChairVisit _visit(
  String id, {
  VisitKind kind = VisitKind.queue,
  String? name = 'Anna',
  String service = 'Taglio',
  int planned = 30,
  DateTime? startedAt,
  DateTime? scheduledAt,
  DateTime? noShowFrom,
}) => ChairVisit(
  kind: kind,
  id: id,
  customerName: name,
  serviceName: service,
  plannedMinutes: planned,
  scheduledAt: scheduledAt,
  startedAt: startedAt,
  noShowFrom: noShowFrom,
);

Chair _chair({
  String id = 'luca',
  String? name = 'Luca',
  ChairVisit? current,
  ChairVisit? called,
  ChairNextAction? action,
  ChairVisit? next,
  ChairVisit? inQueue,
  ChairVisit? booking,
}) => Chair(
  providerId: id,
  name: name,
  current: current,
  called: called,
  nextAction: action,
  nextVisit: next,
  nextInQueue: inQueue,
  nextBooking: booking,
);

ChairBoard _board(List<Chair> chairs) =>
    ChairBoard(localDate: '2026-11-09', timeZone: 'UTC', chairs: chairs);

class _Chairs implements ChairsRepository {
  _Chairs(this.answer);

  ChairBoard answer;
  ApiResult<ChairBoard>? moveResult;
  final List<String> moves = [];
  int turned = 0;

  @override
  Future<ApiResult<ChairBoard>> board() async => ApiResult.success(answer);

  @override
  Future<ApiResult<ChairBoard>> start(
    String providerId,
    ChairVisit visit,
  ) async {
    moves.add('start $providerId ${visit.id}');
    return moveResult ?? ApiResult.success(answer);
  }

  @override
  Future<ApiResult<ChairBoard>> done(
    String providerId,
    ChairVisit visit,
  ) async {
    moves.add('done $providerId ${visit.id}');
    return moveResult ?? ApiResult.success(answer);
  }

  @override
  Future<ApiResult<void>> turnedAway() async {
    turned += 1;
    return ApiResult.success(null);
  }
}

class _Queue implements QueueRepository {
  final List<String> moves = [];

  @override
  Future<ApiResult<OwnerQueue>> callNext({String? providerId}) async {
    moves.add('call $providerId');
    return ApiResult.success(_line);
  }

  @override
  Future<ApiResult<OwnerQueue>> noShow(String entryId) async {
    moves.add('no-show $entryId');
    return ApiResult.success(_line);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  static const _line = OwnerQueue(
    localDate: '2026-11-09',
    state: QueueState.open,
    waitingCount: 0,
    emptiesAt: null,
    entries: [],
  );
}

void main() {
  final t = AppLocale.en.buildSync();
  final now = DateTime.now().toUtc();
  DateTime ago(int minutes) => now.subtract(Duration(minutes: minutes));

  late _Chairs chairs;
  late _Queue queue;

  Future<OwnerChairsCubit> pump(
    WidgetTester tester,
    List<Chair> cards, {
    bool showTurnedAway = false,
  }) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    chairs = _Chairs(_board(cards));
    queue = _Queue();
    final cubit = OwnerChairsCubit(chairs, queue);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: cubit,
        child: ChairsBoard(showTurnedAway: showTurnedAway),
      ),
    );
    await cubit.load();
    await tester.pump();
    return cubit;
  }

  // The cubit ticks every second; closing it stops the timer.
  Future<void> leave(WidgetTester tester, OwnerChairsCubit cubit) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await cubit.close();
  }

  testWidgets('shows a card for each chair', (tester) async {
    final cubit = await pump(tester, [
      _chair(),
      _chair(id: 'sara', name: 'Sara'),
    ]);

    expect(find.text('Luca'), findsOneWidget);
    expect(find.text('Sara'), findsOneWidget);
    expect(find.text(t.chairs.free), findsNWidgets(2));
    await leave(tester, cubit);
  });

  testWidgets('shows who is in the chair and when the plan ends', (
    tester,
  ) async {
    final cubit = await pump(tester, [
      _chair(current: _visit('e1', startedAt: ago(10))),
    ]);

    expect(find.text('Anna · Taglio'), findsOneWidget);
    expect(find.textContaining('until'), findsOneWidget);
    expect(find.textContaining('over plan'), findsNothing);
    await leave(tester, cubit);
  });

  testWidgets('says in red how far over the plan it has run', (tester) async {
    final cubit = await pump(tester, [
      _chair(current: _visit('e1', startedAt: ago(36))),
    ]);

    final over = tester.widget<Text>(find.text(t.chairs.overPlan(minutes: 6)));
    final context = tester.element(find.text(t.chairs.overPlan(minutes: 6)));
    expect(over.style?.color, context.status.error.foreground);
    await leave(tester, cubit);
  });

  testWidgets('Done finishes the visit on that chair', (tester) async {
    final cubit = await pump(tester, [
      _chair(current: _visit('e1', startedAt: ago(10))),
    ]);

    await tester.tap(find.text(t.chairs.done));
    await tester.pump();

    expect(chairs.moves, ['done luca e1']);
    expect(cubit.state.revision, 1);
    await leave(tester, cubit);
  });

  testWidgets('offers Done and Start next side by side', (tester) async {
    final cubit = await pump(tester, [
      _chair(
        current: _visit('e1', startedAt: ago(10)),
        action: ChairNextAction.start,
        next: _visit('b1', kind: VisitKind.booking, name: 'Marco Rossi'),
      ),
    ]);

    expect(find.text(t.chairs.done), findsOneWidget);
    await tester.tap(find.text(t.chairs.startName(name: 'Marco')));
    await tester.pump();

    expect(chairs.moves, ['start luca b1']);
    await leave(tester, cubit);
  });

  testWidgets('calls someone who joined in the app', (tester) async {
    final cubit = await pump(tester, [
      _chair(
        action: ChairNextAction.call,
        next: _visit('e2', name: 'Paolo'),
      ),
    ]);

    await tester.tap(find.text(t.today.callName(name: 'Paolo')));
    await tester.pump();

    expect(queue.moves, ['call luca']);
    expect(chairs.moves, isEmpty);
    await leave(tester, cubit);
  });

  testWidgets('holds the no-show button until the grace is over', (
    tester,
  ) async {
    final called = _visit(
      'e3',
      noShowFrom: now.add(const Duration(minutes: 5)),
    );
    final cubit = await pump(tester, [_chair(called: called)]);

    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(button.onPressed, isNull);
    await leave(tester, cubit);
  });

  testWidgets('allows a no-show once the grace is over', (tester) async {
    final cubit = await pump(tester, [
      _chair(called: _visit('e3', noShowFrom: ago(1))),
    ]);

    await tester.tap(find.text(t.queue.owner.noShow));
    await tester.pump();

    expect(queue.moves, ['no-show e3']);
    await leave(tester, cubit);
  });

  testWidgets('shows what is next from the line and the bookings', (
    tester,
  ) async {
    final cubit = await pump(tester, [
      _chair(
        inQueue: _visit('e4', name: null, service: 'Barba'),
        booking: _visit(
          'b2',
          kind: VisitKind.booking,
          name: 'Marco',
          scheduledAt: DateTime.utc(2026, 11, 9, 15, 30),
        ),
      ),
    ]);

    expect(find.text('${t.queue.owner.walkInName} · Barba'), findsOneWidget);
    expect(find.text('15:30 · Marco · Taglio'), findsOneWidget);
    await leave(tester, cubit);
  });

  testWidgets('has no big button on a chair with nothing to do', (
    tester,
  ) async {
    final cubit = await pump(tester, [_chair()]);

    expect(find.byType(FilledButton), findsNothing);
    await leave(tester, cubit);
  });

  testWidgets('records someone turned away in one tap', (tester) async {
    final cubit = await pump(tester, [_chair()], showTurnedAway: true);

    await tester.tap(find.text(t.chairs.turnedAway));
    await tester.pump();

    expect(chairs.turned, 1);
    await leave(tester, cubit);
  });

  testWidgets('offers no turned-away button without a line', (tester) async {
    final cubit = await pump(tester, [_chair()]);

    expect(find.text(t.chairs.turnedAway), findsNothing);
    await leave(tester, cubit);
  });

  testWidgets('reads the board again when a visit has moved on', (
    tester,
  ) async {
    final cubit = await pump(tester, [
      _chair(current: _visit('e1', startedAt: ago(10))),
    ]);
    chairs.moveResult = ApiResult.failure(
      const Conflict(ApiErrorCode.visitMoved, 'moved'),
    );
    chairs.answer = _board([_chair()]);

    await tester.tap(find.text(t.chairs.done));
    await tester.pump();
    await tester.pump();

    expect(cubit.state.failure?.code, ApiErrorCode.visitMoved);
    expect(find.text(t.chairs.free), findsOneWidget);
    expect(cubit.state.revision, 0);
    await leave(tester, cubit);
  });

  group('states', () {
    testWidgets('shows an error with a retry when the board fails', (
      tester,
    ) async {
      final failing = _FailingChairs();
      final cubit = OwnerChairsCubit(failing, _Queue());
      await pumpThemed(
        tester,
        BlocProvider.value(
          value: cubit,
          child: const ChairsBoard(showTurnedAway: false),
        ),
      );
      await cubit.load();
      await tester.pump();

      expect(find.text(t.common.retry), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await cubit.close();
    });
  });

  group('reading the board', () {
    test('reads a chair, its visits and what comes next', () {
      final board = chairBoardFromJson({
        'localDate': '2026-11-09',
        'timeZone': 'Europe/Rome',
        'chairs': [
          {
            'providerId': 'luca',
            'name': 'Luca',
            'current': {
              'kind': 'booking',
              'visitId': 'b1',
              'customerName': 'Marco',
              'serviceName': 'Taglio',
              'plannedMin': 30,
              'scheduledAt': '2026-11-09T09:00:00.000Z',
              'startedAt': '2026-11-09T09:02:00.000Z',
            },
            'called': null,
            'upNext': {
              'action': 'call',
              'visit': {
                'kind': 'queue',
                'visitId': 'e1',
                'serviceName': 'Barba',
              },
            },
            'nextInQueue': null,
            'nextBooking': null,
          },
        ],
      });

      final chair = board.chairs.single;
      expect(board.timeZone, 'Europe/Rome');
      expect(chair.current?.kind, VisitKind.booking);
      expect(chair.current?.plannedEnd, DateTime.utc(2026, 11, 9, 9, 32));
      expect(chair.nextAction, ChairNextAction.call);
      expect(chair.nextVisit?.id, 'e1');
    });

    test('an unreadable visit reads as nobody', () {
      final board = chairBoardFromJson({
        'chairs': [
          {
            'providerId': 'luca',
            'current': {'kind': 'mystery', 'visitId': 'x'},
            'upNext': null,
          },
          {'name': 'no id'},
        ],
      });

      expect(board.chairs.single.current, isNull);
      expect(board.chairs.single.nextAction, isNull);
    });
  });
}

class _FailingChairs implements ChairsRepository {
  @override
  Future<ApiResult<ChairBoard>> board() async =>
      ApiResult.failure(const UnexpectedError('down'));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

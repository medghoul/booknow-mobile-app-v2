import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/data/dtos/index.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/queue/cubit/owner_queue_cubit.dart';
import 'package:booknow_mobile/features/queue/widgets/owner_queue_view.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'theme_test.dart' show pumpThemed;

/// Running the line with a team: a chair per person, each with its own
/// "call next" (providers §7.3, §7.4).

OwnerQueueEntry _entry(
  String id,
  String name,
  QueueEntryStatus status, {
  String? requested,
  String? providerId,
  String? providerName,
}) => OwnerQueueEntry(
  id: id,
  status: status,
  kind: QueueEntryKind.app,
  customerName: name,
  serviceId: 'cut',
  serviceName: 'Taglio',
  durationMinutes: 30,
  joinedAt: null,
  calledAt: null,
  startedAt: null,
  noShowFrom: null,
  requestedProviderId: requested,
  providerId: providerId,
  providerName: providerName,
);

final _paolo = _entry(
  'paolo',
  'Paolo',
  QueueEntryStatus.called,
  requested: 'marco',
  providerId: 'marco',
  providerName: 'Marco',
);
final _anna = _entry('anna', 'Anna', QueueEntryStatus.waiting);
final _luigi = _entry(
  'luigi',
  'Luigi',
  QueueEntryStatus.waiting,
  requested: 'marco',
  providerId: 'marco',
  providerName: 'Marco',
);

OwnerQueue _teamLine() => OwnerQueue(
  localDate: '2026-11-07',
  state: QueueState.open,
  waitingCount: 2,
  emptiesAt: null,
  entries: [_paolo, _anna, _luigi],
  providers: const [
    OwnerQueueProvider(
      id: 'shop-1',
      name: 'Barbieri Navona',
      nextEntryId: 'anna',
    ),
    OwnerQueueProvider(
      id: 'marco',
      name: 'Marco',
      calledEntryId: 'paolo',
      nextEntryId: 'anna',
    ),
  ],
);

OwnerQueue _oneChairLine() => OwnerQueue(
  localDate: '2026-11-07',
  state: QueueState.open,
  waitingCount: 1,
  emptiesAt: null,
  entries: [_anna],
  providers: const [OwnerQueueProvider(id: 'shop-1', name: 'Barbieri Navona')],
);

class _Queue implements QueueRepository {
  _Queue(this.line);

  final OwnerQueue line;
  final calls = <String?>[];

  @override
  Future<ApiResult<OwnerQueue>> ownerQueue() async => Success(line);

  @override
  Future<ApiResult<OwnerQueue>> callNext({String? providerId}) async {
    calls.add(providerId);
    return Success(line);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _OwnerShop implements ShopRepository {
  @override
  Future<ApiResult<Shop?>> getMyShop() async => const Success(
    Shop(id: 'shop-1', status: ShopStatus.active, name: 'Barbieri Navona'),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _StubAuthCubit extends Cubit<AuthState> implements AuthCubit {
  _StubAuthCubit() : super(const AuthState());

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final t = AppLocale.en.buildSync();
  final owner = t.queue.owner;

  setUp(() => di.registerSingleton<AuthCubit>(_StubAuthCubit()));
  tearDown(() async => di.reset());

  Future<_Queue> pump(WidgetTester tester, OwnerQueue line) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final queue = _Queue(line);
    await pumpThemed(
      tester,
      BlocProvider(
        create: (_) => OwnerQueueCubit(queue, _OwnerShop())..load(),
        child: const OwnerQueueView(),
      ),
    );
    await tester.pumpAndSettle();
    return queue;
  }

  // The cubit ticks every second; taking the screen down closes it.
  Future<void> leave(WidgetTester tester) =>
      tester.pumpWidget(const SizedBox.shrink());

  group('with a team', () {
    testWidgets('shows a chair for each person', (tester) async {
      await pump(tester, _teamLine());

      expect(find.text('${owner.called} · Marco'), findsOneWidget);
      expect(find.text(owner.calledName(name: 'Paolo')), findsOneWidget);
      // The owner's chair is free, and offers who it would call.
      expect(find.text('Barbieri Navona'), findsOneWidget);
      expect(find.text(t.today.callName(name: 'Anna')), findsOneWidget);
      await leave(tester);
    });

    testWidgets("calls next for that person's chair", (tester) async {
      final queue = await pump(tester, _teamLine());

      await tester.tap(find.text(t.today.callName(name: 'Anna')));
      await tester.pumpAndSettle();

      expect(queue.calls, ['shop-1']);
      await leave(tester);
    });

    testWidgets('says who a customer asked for', (tester) async {
      await pump(tester, _teamLine());

      expect(find.text('Taglio · Marco'), findsOneWidget);
      // Anna takes whoever is free first, so her row names nobody.
      expect(find.text('Taglio'), findsOneWidget);
      await leave(tester);
    });
  });

  group('with one chair', () {
    testWidgets('calls without naming anyone, as before', (tester) async {
      final queue = await pump(tester, _oneChairLine());

      await tester.tap(find.text(t.today.callName(name: 'Anna')));
      await tester.pumpAndSettle();

      expect(queue.calls, [null]);
      expect(find.textContaining('Marco'), findsNothing);
      await leave(tester);
    });
  });

  test('reads the chairs and whose each entry is', () {
    final line = OwnerQueueDto.fromJson({
      'localDate': '2026-11-07',
      'state': 'open',
      'waitingCount': 1,
      'providers': [
        {'providerId': 'shop-1', 'name': 'Barbieri Navona', 'order': 0},
        {
          'providerId': 'marco',
          'name': 'Marco',
          'order': 1,
          'servingEntryId': 'e1',
          'calledEntryId': null,
          'nextEntryId': 'e2',
        },
      ],
      'entries': [
        {
          'entryId': 'e1',
          'status': 'serving',
          'serviceName': 'Taglio',
          'requestedProviderId': null,
          'providerId': 'marco',
          'providerName': 'Marco',
        },
      ],
    }).toDomain();

    expect(line.hasTeam, isTrue);
    expect(line.providers[1].servingEntryId, 'e1');
    expect(line.providers[1].nextEntryId, 'e2');
    expect(line.entry('e1')?.providerName, 'Marco');
    expect(line.entry('e1')?.requestedProviderId, isNull);
  });

  test('an API from before providers is one chair', () {
    final line = OwnerQueueDto.fromJson({
      'localDate': '2026-11-07',
      'state': 'open',
      'entries': const [],
    }).toDomain();

    expect(line.hasTeam, isFalse);
  });
}

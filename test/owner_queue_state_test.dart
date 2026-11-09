import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
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

/// Closing the queue is for the rest of the day, not for good: the owner can
/// open it again (docs/queue/queue.md §5.2).

OwnerQueue _line(QueueState state) => OwnerQueue(
  localDate: '2026-11-07',
  state: state,
  waitingCount: 2,
  emptiesAt: null,
  entries: const [],
);

class _Queue implements QueueRepository {
  _Queue(this.state);

  QueueState state;
  final sent = <QueueState>[];

  @override
  Future<ApiResult<OwnerQueue>> ownerQueue() async => Success(_line(state));

  @override
  Future<ApiResult<OwnerQueue>> setState(QueueState next) async {
    sent.add(next);
    state = next;
    return Success(_line(next));
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

  setUp(() => di.registerSingleton<AuthCubit>(_StubAuthCubit()));
  tearDown(() async => di.reset());

  Future<_Queue> pumpClosed(WidgetTester tester) async {
    final queue = _Queue(QueueState.closed);
    await pumpThemed(
      tester,
      BlocProvider(
        create: (_) => OwnerQueueCubit(queue, _OwnerShop())..load(),
        child: const OwnerQueueView(board: SizedBox.shrink()),
      ),
    );
    await tester.pumpAndSettle();
    return queue;
  }

  // The cubit ticks every second; taking the screen down closes it.
  Future<void> leave(WidgetTester tester) =>
      tester.pumpWidget(const SizedBox.shrink());

  testWidgets('the closed banner reopens the queue', (tester) async {
    final queue = await pumpClosed(tester);

    expect(find.text(t.today.closedBanner), findsOneWidget);
    await tester.tap(find.text(t.queue.owner.reopen));
    await tester.pumpAndSettle();

    expect(queue.sent, [QueueState.open]);
    expect(find.text(t.today.closedBanner), findsNothing);
    await leave(tester);
  });

  testWidgets('a closed queue can be opened from the state sheet', (
    tester,
  ) async {
    final queue = await pumpClosed(tester);

    await tester.tap(find.text(t.queue.stateClosed));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.today.stateOpenTitle));
    await tester.pumpAndSettle();

    expect(queue.sent, [QueueState.open]);
    await leave(tester);
  });
}

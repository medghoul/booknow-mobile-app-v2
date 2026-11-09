import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_state.dart';
import 'package:booknow_mobile/features/chairs/cubit/owner_chairs_cubit.dart';
import 'package:booknow_mobile/features/chairs/widgets/chairs_board.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_view.dart';
import 'package:booknow_mobile/features/queue/cubit/owner_queue_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/shop_mode_notifier.dart';
import 'package:booknow_mobile/features/queue/widgets/owner_queue_view.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The owner's first tab, and where they land once the shop is published: the
/// day as it is happening, one card per chair and then who is still to come.
///
/// A shop in queue mode runs its day as a line, one taking bookings as a list
/// of times, and one taking both switches between the two. The mode is read once and then followed through
/// [ShopModeNotifier], so a switch made on the Shop tab shows here at once.
@RoutePage()
class OwnerTodayPage extends StatefulWidget {
  const OwnerTodayPage({super.key});

  @override
  State<OwnerTodayPage> createState() => _OwnerTodayPageState();
}

class _OwnerTodayPageState extends State<OwnerTodayPage> {
  final _mode = di<ShopModeNotifier>();

  @override
  void initState() {
    super.initState();
    if (_mode.value == null) _readMode();
  }

  Future<void> _readMode() async {
    final result = await di<ShopRepository>().getMyShop();
    if (!mounted) return;
    // A failed read falls back to bookings, which reports its own errors.
    _mode.value = switch (result) {
      Success<Shop?>(:final data) => data?.mode ?? ShopMode.booking,
      Failure<Shop?>() => ShopMode.booking,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Above the modes, so the chairs survive a switch between line and bookings.
    return BlocProvider(
      create: (_) => di<OwnerChairsCubit>()..load(),
      child: Builder(
        builder: (context) => RefreshWhenShown(
          routeName: OwnerTodayRoute.name,
          onShown: context.read<OwnerChairsCubit>().refresh,
          child: BlocListener<OwnerChairsCubit, OwnerChairsState>(
            listenWhen: (before, after) =>
                before.failure != after.failure && after.board != null,
            listener: (context, state) {
              if (state.failure case final failure?) {
                AppSnackBar.error(context, failure.localized(context));
              }
            },
            child: ValueListenableBuilder<ShopMode?>(
              valueListenable: _mode,
              builder: (context, mode, _) => switch (mode) {
                null => const AppScaffold(body: AppLoader.centered()),
                ShopMode.queue => const _Line(key: ValueKey(ShopMode.queue)),
                ShopMode.booking => const _Bookings(
                  key: ValueKey(ShopMode.booking),
                  runsLine: false,
                ),
                ShopMode.both => const _Both(key: ValueKey(ShopMode.both)),
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerQueueCubit>()..load(),
      child: MultiBlocListener(
        listeners: [
          _whenChairsChange(
            (context) => context.read<OwnerQueueCubit>().refresh(),
          ),
          // Someone joined, left or was added: the chairs show who is next.
          BlocListener<OwnerQueueCubit, OwnerQueueState>(
            listenWhen: (before, after) =>
                before.queue != null && before.queue != after.queue,
            listener: (context, _) =>
                context.read<OwnerChairsCubit>().refresh(),
          ),
        ],
        child: const OwnerQueueView(board: ChairsBoard(showTurnedAway: true)),
      ),
    );
  }
}

/// Reads the list under the board again after a button on the board.
BlocListener<OwnerChairsCubit, OwnerChairsState> _whenChairsChange(
  void Function(BuildContext context) read,
) => BlocListener<OwnerChairsCubit, OwnerChairsState>(
  listenWhen: (before, after) => before.revision != after.revision,
  listener: (context, _) => read(context),
);

class _Bookings extends StatelessWidget {
  const _Bookings({super.key, this.runsLine = true});

  final bool runsLine;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // No date: the server answers with today in the shop's own calendar.
      create: (_) => di<OwnerAgendaCubit>()..load(),
      child: Builder(
        builder: (context) => RefreshWhenShown(
          routeName: OwnerTodayRoute.name,
          onShown: () => context.read<OwnerAgendaCubit>().load(refresh: true),
          child: MultiBlocListener(
            listeners: [
              _whenChairsChange(
                (context) =>
                    context.read<OwnerAgendaCubit>().load(refresh: true),
              ),
              // Marked arrived or cancelled from the booking sheet.
              BlocListener<OwnerAgendaCubit, OwnerAgendaState>(
                listenWhen: (before, after) =>
                    before.day != null && before.day != after.day,
                listener: (context, _) =>
                    context.read<OwnerChairsCubit>().refresh(),
              ),
            ],
            child: OwnerTodayView(board: ChairsBoard(showTurnedAway: runsLine)),
          ),
        ),
      ),
    );
  }
}

/// Today in a shop taking both: the line and the bookings, one at a time.
class _Both extends StatefulWidget {
  const _Both({super.key});

  @override
  State<_Both> createState() => _BothState();
}

class _BothState extends State<_Both> {
  bool _line = true;

  @override
  Widget build(BuildContext context) {
    final t = context.t.today;

    return OwnerHeaderExtra(
      extra: AppSegmentedControl<bool>(
        segments: [
          AppSegment(value: true, label: t.wayLine),
          AppSegment(value: false, label: t.wayBookings),
        ],
        value: _line,
        onChanged: (value) => setState(() => _line = value),
      ),
      child: IndexedStack(
        index: _line ? 0 : 1,
        sizing: StackFit.expand,
        children: const [_Line(), _Bookings()],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
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
/// day as it is happening.
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
    return ValueListenableBuilder<ShopMode?>(
      valueListenable: _mode,
      builder: (context, mode, _) => switch (mode) {
        null => const AppScaffold(body: AppLoader.centered()),
        ShopMode.queue => const _Line(key: ValueKey(ShopMode.queue)),
        ShopMode.booking => const _Bookings(key: ValueKey(ShopMode.booking)),
        ShopMode.both => const _Both(key: ValueKey(ShopMode.both)),
      },
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerQueueCubit>()..load(),
      child: const OwnerQueueView(),
    );
  }
}

class _Bookings extends StatelessWidget {
  const _Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // No date: the server answers with today in the shop's own calendar.
      create: (_) => di<OwnerAgendaCubit>()..load(),
      child: Builder(
        builder: (context) => RefreshWhenShown(
          routeName: OwnerTodayRoute.name,
          onShown: () => context.read<OwnerAgendaCubit>().load(refresh: true),
          child: const OwnerTodayView(),
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

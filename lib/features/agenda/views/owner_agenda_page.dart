import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/features/agenda/cubit/owner_agenda_cubit.dart';
import 'package:booknow_mobile/features/agenda/widgets/index.dart';
import 'package:booknow_mobile/features/agenda/widgets/owner_today_parts.dart';
import 'package:booknow_mobile/features/queue/cubit/shop_mode_notifier.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The owner's Calendar tab: any day, for planning.
///
/// A shop in queue mode has no times to plan, so it says that rather than
/// showing an empty month. Today is where its line is run.
@RoutePage()
class OwnerAgendaPage extends StatelessWidget {
  const OwnerAgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ShopMode?>(
      valueListenable: di<ShopModeNotifier>(),
      builder: (context, mode, _) {
        if (mode == ShopMode.queue) {
          final t = context.t.today;

          return AppScaffold(
            appBar: AppAppBar(title: t.calendarTitle, showBack: false),
            body: AppEmptyState(
              icon: Icons.groups_outlined,
              title: t.calendarQueueTitle,
              message: t.calendarQueueBody,
              action: AppOutlinedButton(
                label: t.calendarQueueCta,
                onPressed: () =>
                    context.router.push(ShopModeRoute(current: ShopMode.queue)),
              ),
            ),
          );
        }

        return BlocProvider(
          // No date: the server answers with today in the shop's own calendar.
          create: (_) => di<OwnerAgendaCubit>()..load(),
          child: Builder(
            builder: (context) => RefreshWhenShown(
              routeName: OwnerAgendaRoute.name,
              onShown: () =>
                  context.read<OwnerAgendaCubit>().load(refresh: true),
              child: const OwnerAgendaView(),
            ),
          ),
        );
      },
    );
  }
}

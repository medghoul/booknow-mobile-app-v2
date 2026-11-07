import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/features/splash/cubit/splash_cubit.dart';
import 'package:booknow_mobile/features/splash/widgets/splash_view.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The first screen. Holds the brand while the session is restored, contracts
/// into the header, then replaces itself so it never sits in the back stack.
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SplashCubit(auth: di<AuthCubit>(), live: di<LiveStatusCubit>())
            ..resolve(),
      child: BlocBuilder<SplashCubit, SplashDestination?>(
        builder: (context, destination) =>
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: BlocBuilder<LiveStatusCubit, QueueEntry?>(
                bloc: di<LiveStatusCubit>(),
                builder: (context, entry) => SplashView(
                  leaving: destination != null,
                  queueLine: _lineFor(context, entry),
                  onFinished: () => _leave(context),
                ),
              ),
            ),
      ),
    );
  }

  String? _lineFor(BuildContext context, QueueEntry? entry) {
    final t = context.t.queue;
    final shop = entry?.shopName;
    if (entry == null || shop == null) return null;
    if (entry.status == QueueEntryStatus.called) {
      return t.splashTurn(shop: shop);
    }

    final position = entry.position;
    return position == null ? null : t.splashPlace(n: position, shop: shop);
  }

  void _leave(BuildContext context) {
    final route = AuthStepListener.routeFor(
      di<AuthCubit>().state.destination ?? const SignInDestination(),
    );
    if (route != null) context.router.replaceAll([route]);
  }
}

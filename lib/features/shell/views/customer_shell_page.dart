import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/features/queue/cubit/live_status_cubit.dart';
import 'package:booknow_mobile/features/queue/cubit/next_booking_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booknow_mobile/features/shell/widgets/app_tabs_shell.dart';
import 'package:flutter/material.dart';

/// A customer's half of the signed-in app.
///
/// See [OwnerShellPage] for why the shell, rather than the bar, is what
/// decides which pages a role gets.
@RoutePage()
class CustomerShellPage extends StatelessWidget {
  const CustomerShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStepListener(
      child: BlocListener<AuthCubit, AuthState>(
        bloc: di<AuthCubit>(),
        listenWhen: (before, after) =>
            (before.session == null) != (after.session == null),
        listener: (_, auth) => _follow(auth),
        child: const _WatchOnOpen(child: AppTabsShell(role: UserRole.customer)),
      ),
    );
  }
}

void _follow(AuthState auth) {
  if (auth.session == null) {
    di<LiveStatusCubit>().stop();
    di<NextBookingCubit>().stop();
  } else {
    di<LiveStatusCubit>().watch();
    di<NextBookingCubit>().watch();
  }
}

/// Starts the live bar when the shell opens on a restored session, which no
/// session change will announce.
class _WatchOnOpen extends StatefulWidget {
  const _WatchOnOpen({required this.child});

  final Widget child;

  @override
  State<_WatchOnOpen> createState() => _WatchOnOpenState();
}

class _WatchOnOpenState extends State<_WatchOnOpen> {
  @override
  void initState() {
    super.initState();
    final auth = di<AuthCubit>().state;
    if (auth.session != null) _follow(auth);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Moves the user as the destination changes.
///
/// Navigation lives here rather than in each screen's button handler, so the
/// journey has one description: §5 of the auth-flow document decides where to
/// go, and this only carries it out.
///
/// Every hop replaces the stack. There is no back out of the role screen or
/// the wizard — the user is already signed in, and the steps behind them are
/// done.
class AuthStepListener extends StatelessWidget {
  const AuthStepListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      // Resolved from the container rather than looked up through the tree.
      // `AuthCubit` is a singleton that outlives every route, so requiring a
      // `BlocProvider` above each listener only adds a way to forget one.
      bloc: di<AuthCubit>(),
      listenWhen: (previous, current) =>
          shouldNavigate(previous.destination, current.destination),
      listener: (context, state) {
        final route = routeFor(state.destination!);
        if (route != null) context.router.replaceAll([route]);
      },
      child: child,
    );
  }

  /// Whether moving from [from] to [to] means changing screen.
  ///
  /// Not simply `from != to`: the wizard is one route whose step is state, so
  /// `shopSetup(shop)` -> `shopSetup(hours)` is a different value but the same
  /// screen, and re-navigating would rebuild the cubit and throw away a
  /// half-filled form. Comparing the route each destination resolves to says
  /// that directly, rather than leaving it implied by a type check.
  static bool shouldNavigate(AuthDestination? from, AuthDestination? to) {
    if (to == null) return false;
    if (from == null) return true;
    return routeFor(from)?.routeName != routeFor(to)?.routeName;
  }

  /// The one place a destination becomes a route.
  static PageRouteInfo<dynamic>? routeFor(AuthDestination destination) =>
      switch (destination) {
        // Signed out is not a wall: guests browse the customer's tabs, and
        // Profile is where signing in lives.
        SignInDestination() => const CustomerShellRoute(),
        RoleChoiceDestination() => const RoleRoute(),
        ShopSetupDestination(:final step) => ShopSetupRoute(initialStep: step),
        ProfileSetupDestination() => const ProfileSetupRoute(),
        NotificationPermissionDestination() =>
          const NotificationPermissionRoute(),
        OwnerAgendaDestination() => const OwnerShellRoute(),
        CustomerHomeDestination() => const CustomerShellRoute(),
      };
}

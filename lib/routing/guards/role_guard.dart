import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';

/// Keeps a user inside the half of the app they belong to.
///
/// The route tree already confines navigation from inside the app: an owner's
/// shell holds no customer routes, so there is nothing to push. This is for
/// the paths that do not come from a widget — a push notification's payload, a
/// universal link, a restored URL — which name a route directly and would
/// otherwise open whatever they asked for.
///
/// The decision is not a table of its own. It resolves through
/// [AuthRouter.destinationFor], the same rule the splash and every auth screen
/// use, so there is one description of where a user belongs; a second copy
/// here is the one that would go stale.
class RoleGuard extends AutoRouteGuard {
  const RoleGuard(this.allowed);

  /// The role this branch of the route tree belongs to. It is what makes the
  /// intent readable where the shell is declared.
  final UserRole allowed;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Resolved from the container, not from a context — a guard has none.
    // `AuthCubit` is a singleton that outlives every route.
    final elsewhere = redirectFor(allowed, di<AuthCubit>().state);

    if (elsewhere == null) return resolver.next();

    // `redirectUntil` rather than `redirect`: it re-runs the guards on what it
    // lands on, and nothing it can land on is guarded, so this settles in one
    // hop instead of looping.
    resolver.redirectUntil(elsewhere);
  }

  /// Where this user should go instead, or null when this branch is right.
  ///
  /// Stricter than comparing roles, and deliberately so. A deep link skips
  /// every screen between sign-in and itself, so an owner whose shop is still
  /// a draft would land on an agenda with no shop behind it. Asking
  /// [AuthRouter] where they belong covers both: the wrong role, and the right
  /// role with the journey unfinished.
  ///
  /// `notificationsPrompted` is left at its default — the flag is device-local
  /// and not in [AuthState] — so a deep link is never redirected to the
  /// permission explainer. The right failure: the explainer is a nicety, and
  /// bouncing someone to it instead of the screen they tapped is worse than
  /// showing it late.
  static PageRouteInfo<dynamic>? redirectFor(
    UserRole allowed,
    AuthState state,
  ) {
    final belongs = AuthStepListener.routeFor(
      AuthRouter.destinationFor(profile: state.profile, shop: state.shop),
    );

    return belongs?.routeName == shellNameFor(allowed) ? null : belongs;
  }

  /// The shell that is a [role]'s home.
  ///
  /// A `switch` over the enum rather than a map, so adding a third role is a
  /// compile error here rather than a guard that silently redirects them out
  /// of their own app.
  static String shellNameFor(UserRole role) => switch (role) {
    UserRole.owner => OwnerShellRoute.name,
    UserRole.customer => CustomerShellRoute.name,
  };
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/routing/app_page_transitions.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/routing/guards/role_guard.dart';

/// Every route in the app.
///
/// The onboarding and auth screens replace the stack rather than stacking on
/// it — once a step is done there is nothing useful to go back to, and a back
/// gesture into a finished sign-in would be a dead end.
///
/// Every route is a [CustomRoute] so navigation uses the app's own fade rather
/// than the platform default, which differs between iOS and Android and
/// matches neither the entrance the screens already have. The exception is a
/// tab, whose fade comes from the shell's `AutoTabsRouter` instead.
///
/// ## Which pages a role gets
///
/// The signed-in app is two regions, one per [UserRole], and this table is
/// where that is written down. An owner's shell holds the agenda and the
/// profile; a customer's holds Discover, Activity and the profile. A role has no
/// way to navigate to the other's pages because they are not in its tree —
/// the enforcement is structural, not an `if` inside a screen.
///
/// [RoleGuard] covers what the tree cannot: a path that arrives from outside
/// the app — a push notification's payload, a universal link — names a route
/// directly and would otherwise open whatever it asked for.
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Full screen, no bar: the journey to being signed in, and the tasks that
    // take over the screen once you are.
    _route(SplashRoute.page, '/', initial: true),
    _route(OnboardingRoute.page, '/onboarding'),
    _route(SignInRoute.page, '/sign-in'),
    _route(SignUpRoute.page, '/sign-up'),
    _route(RoleRoute.page, '/role'),
    _route(ProfileSetupRoute.page, '/profile-setup'),
    _route(ShopSetupRoute.page, '/shop-setup'),
    _route(ShopDetailsRoute.page, '/shop-details'),
    _route(ServicesRoute.page, '/services'),
    _route(HoursRoute.page, '/hours'),
    _route(NotificationPermissionRoute.page, '/notifications'),
    _route(HelpRoute.page, '/help'),
    _route(NotificationSettingsRoute.page, '/notification-settings'),
    _route(PersonalDataRoute.page, '/personal-data'),

    // Booking is a task that takes over the screen, not a tab: it holds a slot
    // for ten minutes, and a customer who wandered back to a tab mid-payment
    // would leave that hold behind them.
    _route(
      BookingFlowRoute.page,
      '/book/:shopId',
      transition: AppPageTransitions.grow,
    ),
    _route(
      QueueFlowRoute.page,
      '/queue/:shopId',
      transition: AppPageTransitions.grow,
    ),
    _route(ShopModeRoute.page, '/shop-mode'),
    _route(BookingDetailRoute.page, '/bookings/:bookingId'),

    _route(
      OwnerShellRoute.page,
      '/owner',
      guards: [const RoleGuard(UserRole.owner)],
      children: [
        _tab(OwnerTodayRoute.page, 'today', initial: true),
        _tab(OwnerAgendaRoute.page, 'agenda'),
        _tab(ProfileRoute.page, 'profile'),
      ],
    ),
    _route(
      CustomerShellRoute.page,
      '/customer',
      guards: [const RoleGuard(UserRole.customer)],
      children: [
        _tab(HomeRoute.page, 'home', initial: true),
        _tab(BookingsRoute.page, 'bookings'),
        _tab(ProfileRoute.page, 'profile'),
      ],
    ),
  ];

  /// One shape for every route: the app's fade, at the app's duration.
  static CustomRoute<dynamic> _route(
    PageInfo page,
    String path, {
    bool initial = false,
    List<AutoRouteGuard> guards = const [],
    List<AutoRoute>? children,
    RouteTransitionsBuilder transition = AppPageTransitions.fade,
  }) {
    return CustomRoute(
      page: page,
      path: path,
      initial: initial,
      guards: guards,
      children: children,
      transitionsBuilder: transition,
      duration: AppPageTransitions.duration,
      reverseDuration: AppPageTransitions.duration,
    );
  }

  /// A tab inside a shell.
  ///
  /// A plain [AutoRoute] rather than the fade above: a tab is the root of its
  /// own nested stack and is never pushed, so its page transition would never
  /// run. The shell's `transitionBuilder` is what cross-fades a tab swap.
  static AutoRoute _tab(PageInfo page, String path, {bool initial = false}) =>
      AutoRoute(page: page, path: path, initial: initial);
}

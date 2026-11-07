import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';

/// One tab: what it looks like and where it goes.
///
/// The two were separate — [AppNavTab] in the widget library, the route in the
/// shell — and both lists were per-role and positional, which is a desync
/// waiting to happen: an owner's bar showing "Profilo" over the agenda's
/// route. Paired here so they cannot disagree.
@immutable
class AppNavDestination {
  const AppNavDestination({required this.tab, required this.route});

  final AppNavTab tab;
  final PageRouteInfo<dynamic> route;
}

/// The destinations a [role] is allowed, in tab order.
///
/// This is the app's answer to "which pages does this user get". The shells in
/// `AppRouter` declare the same sets as their children, so a role cannot
/// navigate outside them, and `RoleGuard` stops a deep link from trying.
///
/// Two different bars, not one with a hidden tab: a customer books and reads
/// their own bookings, an owner runs an agenda. Taken from the design, where
/// the customer and the owner have three destinations each.
///
/// Profile is last for both, and shared: one screen, because the header, the
/// appearance controls and the account rows are identical and only the shop
/// section is an owner's.
List<AppNavDestination> navDestinationsFor(
  BuildContext context,
  UserRole role,
) {
  final t = context.t.nav;

  final profile = AppNavDestination(
    tab: AppNavTab(icon: AppLineIcons.person, label: t.profile),
    route: const ProfileRoute(),
  );

  return switch (role) {
    UserRole.customer => [
      AppNavDestination(
        tab: AppNavTab(icon: AppLineIcons.search, label: t.discover),
        route: const HomeRoute(),
      ),
      AppNavDestination(
        tab: AppNavTab(icon: AppLineIcons.activity, label: t.activity),
        route: const BookingsRoute(),
      ),
      profile,
    ],
    UserRole.owner => [
      AppNavDestination(
        tab: AppNavTab(icon: AppLineIcons.today, label: t.today),
        route: const OwnerTodayRoute(),
      ),
      AppNavDestination(
        tab: AppNavTab(icon: AppLineIcons.calendar, label: t.calendar),
        route: const OwnerAgendaRoute(),
      ),
      // The same route as a customer's profile: for an owner it leads with the
      // shop, and that is what the tab is for.
      AppNavDestination(
        tab: AppNavTab(icon: AppLineIcons.shop, label: t.shop),
        route: const ProfileRoute(),
      ),
    ],
  };
}

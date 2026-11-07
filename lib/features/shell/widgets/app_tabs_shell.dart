import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/queue/widgets/live_bar.dart';
import 'package:booknow_mobile/routing/app_page_transitions.dart';
import 'package:booknow_mobile/routing/nav_destinations.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';

/// The signed-in app: a role's tabs, with the bar over them.
///
/// One widget for both roles, driven by [role] — the two shells differ only in
/// which destinations they hold, and that answer already lives in
/// `navDestinationsFor`. The tab list and the route list are read from the
/// same pairs, so the bar cannot end up labelling the wrong screen.
class AppTabsShell extends StatelessWidget {
  const AppTabsShell({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final destinations = navDestinationsFor(context, role);

    return AutoTabsRouter(
      routes: [for (final destination in destinations) destination.route],
      // Back lands on the first tab before it leaves the app, and only once
      // the active tab's own stack is empty — `TabsRouter.maybePop` does both
      // itself given a home index, which is why there is no `PopScope` here.
      // Without it, back from the third tab exits the app, which reads as a
      // crash.
      homeIndex: 0,
      transitionBuilder: AppPageTransitions.tabFade,
      builder: (context, child) {
        final tabs = AutoTabsRouter.of(context);

        return AppScaffold(
          // Every tab is its own `AppScaffold` with its own app bar, so this
          // one contributes nothing but the bar: no gutter and no top inset,
          // or both stack with the tab's.
          padding: EdgeInsets.zero,
          useSafeArea: false,
          // The bar belongs behind the keyboard. Resizing would lift it to sit
          // on top of one, where it covers the field the user is typing in.
          resizeToAvoidBottomInset: false,
          body: child,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (role == UserRole.customer) const LiveBar(),
              AppBottomNavBar(
                tabs: [for (final destination in destinations) destination.tab],
                currentIndex: tabs.activeIndex,
                onTap: tabs.setActiveIndex,
              ),
            ],
          ),
        );
      },
    );
  }
}

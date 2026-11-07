import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/features/shell/widgets/app_tabs_shell.dart';
import 'package:flutter/material.dart';

/// An owner's half of the signed-in app.
///
/// The route rather than the bar is what makes a role's pages its own: this
/// shell's children in `AppRouter` are the only screens reachable from here,
/// and `RoleGuard` turns away a deep link that names someone else's.
///
/// [AuthStepListener] sits here rather than on each tab. A shell is one route
/// for the whole signed-in session, so one listener covers every tab — and
/// signing out from the profile tab actually leaves, which it did not when the
/// agenda carried no listener.
@RoutePage()
class OwnerShellPage extends StatelessWidget {
  const OwnerShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthStepListener(child: AppTabsShell(role: UserRole.owner));
  }
}

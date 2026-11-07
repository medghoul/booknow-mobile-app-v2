import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/support/widgets/help_contacts_list.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Help and contacts, reached from either role's profile.
///
/// No cubit: the questions are copy, and the two contacts are handed to the
/// phone rather than to the server. The only state is which answer is open,
/// and it belongs to the list.
///
/// [AuthCubit] comes from the container rather than the tree for the reason
/// `ProfilePage` gives — it is a singleton that outlives every route, and this
/// screen is pushed from a tab with no provider above it.
@RoutePage()
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = di<AuthCubit>().state.profile;

    return AppScaffold(
      appBar: AppAppBar(title: context.t.help.screenTitle),
      body: Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: HelpContactsList(
          appVersion: di<PackageInfo>().version,
          replyTo: user?.email,
          role: user?.role,
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/domain/repositories/user_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/notifications/cubit/notification_settings_cubit.dart';
import 'package:booknow_mobile/features/notifications/widgets/notification_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screens G and H: what the app may send, reached from either profile.
///
/// The role decides which list is shown, and it is read from [AuthCubit] in
/// the container rather than from the tree, for the reason `ProfilePage`
/// documents — this screen is pushed from a tab, with no provider above it.
/// The switches come from the same profile, and go back to it.
@RoutePage()
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationSettingsCubit(
        auth: di<AuthCubit>(),
        users: di<UserRepository>(),
        push: di<PushService>(),
        settings: di(),
      ),
      child: NotificationSettingsView(
        role: di<AuthCubit>().state.profile?.role,
      ),
    );
  }
}

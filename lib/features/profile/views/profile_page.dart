import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/features/auth/widgets/guest_views.dart';
import 'package:booknow_mobile/features/profile/cubit/profile_cubit.dart';
import 'package:booknow_mobile/features/profile/cubit/profile_state.dart';
import 'package:booknow_mobile/features/profile/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The profile tab.
@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStepListener(
      child: BlocProvider(
        create: (_) => ProfileCubit(di<ShopRepository>(), di<PushService>())
          ..load()
          ..refreshNotifications(),
        // `AuthCubit` comes from the container, not from the tree, for the
        // reason `AuthStepListener` gives: it is a singleton that outlives
        // every route, and this screen is reached from the tab bar rather
        // than from the auth journey, so there is no `BlocProvider` above it
        // to find. Reading it through the tree here threw
        // `ProviderNotFoundException` the first time the tab was opened.
        child: BlocBuilder<AuthCubit, AuthState>(
          bloc: di<AuthCubit>(),
          buildWhen: (previous, current) =>
              previous.profile != current.profile ||
              previous.session != current.session,
          builder: (context, auth) {
            final user = auth.profile;

            // No signed-in user means the session went away under the screen;
            // the listener above is already routing out of here, so this is
            // one frame.
            if (user == null) {
              return auth.session == null
                  ? const GuestProfileView()
                  : const AppScaffold(body: Center(child: AppLoader()));
            }
            return _scaffold(context, user, auth.session?.provider);
          },
        ),
      ),
    );
  }

  Widget _scaffold(
    BuildContext context,
    UserProfile user,
    AuthProviderKind? provider,
  ) {
    final theme = di<ThemeService>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => ListenableBuilder(
        listenable: theme,
        builder: (context, _) => AppScaffold(
          body: ProfileView(
            user: user,
            provider: provider,
            shop: state.shop,
            isLoadingShop: state.isLoading,
            notificationsEnabled: state.notificationsEnabled,
            themeMode: theme.themeMode,
            onThemeModeChanged: theme.setThemeMode,
            onSignOut: () {
              AppSnackBar.success(context, context.t.profile.signedOut);
              di<AuthCubit>().signOut();
            },
            onOpenPersonalData: () => context.router.push(
              PersonalDataRoute(shopName: state.shop?.name),
            ),
            onOpenShop: () => _openAndReload(context, const ShopDetailsRoute()),
            onOpenServices: () =>
                _openAndReload(context, const ServicesRoute()),
            onOpenHours: () => _openAndReload(context, const HoursRoute()),
            onOpenTeam: () => _openAndReload(context, const TeamRoute()),
            onOpenMode: state.shop == null
                ? null
                : () => _openAndReload(
                    context,
                    ShopModeRoute(current: state.shop!.mode),
                  ),
            onPreviewShop: state.shop == null
                ? null
                : () => context.router.push(
                    state.shop!.mode == ShopMode.queue
                        ? QueueFlowRoute(shopId: state.shop!.id, preview: true)
                        : BookingFlowRoute(
                            shopId: state.shop!.id,
                            preview: true,
                          ),
                  ),
            onOpenNotifications: () => _openNotifications(context),
            onOpenHelp: () => context.router.push(const HelpRoute()),
            onDeleteAccount: () => _deleteAccount(context),
          ),
        ),
      ),
    );
  }

  /// Deletes the account, and says so when it does not work.
  ///
  /// The sheet that spells out what deleting costs has already been shown and
  /// answered — `ProfileView` raises it — so this is the act itself. On
  /// success `AuthStepListener` replaces the stack with the sign-in screen and
  /// there is nobody left to report to; on failure the user is still here,
  /// still signed in, and would otherwise be looking at a row that did
  /// nothing.
  Future<void> _deleteAccount(BuildContext context) async {
    final auth = di<AuthCubit>();
    await auth.deleteAccount();

    final failure = auth.state.failure;
    if (failure == null || !context.mounted) return;

    AppSnackBar.error(context, failure.localized(context));
  }

  /// Opens the notifications screen, then re-reads the phone's permission.
  ///
  /// That screen is the one place the app sends people to the OS settings, so
  /// it is the one they come back from having turned notifications off.
  Future<void> _openNotifications(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();
    await context.router.push(const NotificationSettingsRoute());
    await cubit.refreshNotifications();
  }

  /// Opens a screen that can change the shop, then re-reads it.
  ///
  /// This tab's route — and the [ProfileCubit] created with it — stays alive
  /// under whatever is pushed on top, so nothing rebuilds on the way back.
  /// Without the reload, adding a service would leave the row still counting
  /// the old list.
  Future<void> _openAndReload(
    BuildContext context,
    PageRouteInfo<dynamic> route,
  ) async {
    final cubit = context.read<ProfileCubit>();
    await context.router.push(route);
    await cubit.load();
  }
}

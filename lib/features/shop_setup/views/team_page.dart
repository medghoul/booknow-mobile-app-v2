import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_state.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Who works in the shop, reached from the owner's profile (providers §9).
///
/// On the same cubit as the services and hours screens, for the same reason:
/// each change saves on its own and the shop is read back, so the list is
/// always what the server holds.
@RoutePage()
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShopSetupCubit(di<ShopRepository>())..start(),
      child: const _TeamScreen(),
    );
  }
}

class _TeamScreen extends StatelessWidget {
  const _TeamScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopSetupCubit, ShopSetupState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) =>
          AppSnackBar.error(context, state.failure!.localized(context)),
      child: Builder(
        builder: (context) => AppScaffold(
          appBar: AppAppBar(title: context.t.shopSetup.team.screenTitle),
          body: BlocBuilder<ShopSetupCubit, ShopSetupState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) => state.isLoading
                ? const Center(child: AppLoader())
                : Padding(
                    padding: EdgeInsets.only(top: context.spacing.lg.h),
                    child: const TeamList(),
                  ),
          ),
        ),
      ),
    );
  }
}

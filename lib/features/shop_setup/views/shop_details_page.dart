import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_state.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Editing the shop's own details, reached from the owner's profile.
///
/// Its own route rather than a step of the wizard: the owner arrived here to
/// change one thing, and the back gesture has to return them to the profile
/// rather than walk them through setup.
@RoutePage()
class ShopDetailsPage extends StatelessWidget {
  const ShopDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ShopSetupCubit(di<ShopRepository>(), startAt: ShopSetupStep.shop)
            ..start(),
      child: const _ShopDetailsScreen(),
    );
  }
}

class _ShopDetailsScreen extends StatelessWidget {
  const _ShopDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopSetupCubit, ShopSetupState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) =>
          AppSnackBar.error(context, state.failure!.localized(context)),
      child: Builder(
        builder: (context) => AppScaffold(
          appBar: AppAppBar(title: context.t.shopSetup.details.title),
          body: BlocBuilder<ShopSetupCubit, ShopSetupState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) => state.isLoading
                ? const Center(child: AppLoader())
                : Padding(
                    padding: EdgeInsets.only(top: context.spacing.lg.h),
                    child: ShopDetailsView(onSaved: () => _pop(context)),
                  ),
          ),
        ),
      ),
    );
  }

  /// Back to the profile, with the confirmation the design asks for. The
  /// message goes up with the pop rather than being shown here, so it lands
  /// on the screen that was asking about the shop.
  void _pop(BuildContext context) {
    final message = context.t.shopSetup.details.saved;
    context.router.maybePop();
    AppSnackBar.success(context, message);
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_step_listener.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_state.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/index.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// First setup: a checklist, with each step opening over it.
///
/// One route: the step is state, not a navigation entry. Every step saves as it
/// finishes, so coming back later resumes on the same checklist.
@RoutePage()
class ShopSetupPage extends StatelessWidget {
  const ShopSetupPage({super.key, this.initialStep});

  /// The shop's first gap, from `AuthRouter`. The checklist shows it, so setup
  /// always opens there rather than inside a step.
  final ShopSetupStep? initialStep;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShopSetupCubit(
        di<ShopRepository>(),
        startAt: ShopSetupStep.review,
        returnToChecklist: true,
      )..start(),
      child: const AuthStepListener(child: _ShopSetupView()),
    );
  }
}

class _ShopSetupView extends StatelessWidget {
  const _ShopSetupView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopSetupCubit, ShopSetupState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) =>
          AppSnackBar.error(context, state.failure!.localized(context)),
      builder: (context, state) {
        final cubit = context.read<ShopSetupCubit>();

        final inStep = state.step != ShopSetupStep.review;
        void toChecklist() => cubit.goTo(ShopSetupStep.review);

        return AppScaffold(
          appBar: inStep && !state.isPublished
              ? AppAppBar(
                  title: _titleOf(context, state.step),
                  onBack: toChecklist,
                )
              : null,
          canPop: false,
          // Back from a step is back to the checklist.
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && inStep && !state.isSaving) toChecklist();
          },
          body: state.isLoading
              ? const Center(child: AppLoader())
              : AnimatedSwitcher(
                  duration: context.motion.normal,
                  child: state.isPublished
                      ? const ShopLiveView()
                      : inStep
                      ? Padding(
                          key: ValueKey(state.step),
                          padding: EdgeInsets.only(top: context.spacing.lg.h),
                          child: _stepBody(state, toChecklist),
                        )
                      : ShopSetupChecklist(
                          key: const ValueKey('checklist'),
                          shop: state.shop,
                        ),
                ),
        );
      },
    );
  }

  // Services and hours are the very screens the Shop tab opens later: what the
  // owner learns here is what they will find there.
  Widget _stepBody(ShopSetupState state, VoidCallback onDone) =>
      switch (state.step) {
        ShopSetupStep.shop => ShopDetailsStep(shop: state.shop),
        ShopSetupStep.address => ShopAddressStep(shop: state.shop),
        ShopSetupStep.services => ShopServicesList(onDone: onDone),
        ShopSetupStep.hours => ShopHoursList(onDone: onDone),
        ShopSetupStep.review => const SizedBox.shrink(),
      };

  String _titleOf(BuildContext context, ShopSetupStep step) {
    final t = context.t.shopSetup.checklist;
    return switch (step) {
      ShopSetupStep.shop => t.shop,
      ShopSetupStep.address => t.address,
      ShopSetupStep.services => t.services,
      ShopSetupStep.hours => t.hours,
      ShopSetupStep.review => t.title,
    };
  }
}

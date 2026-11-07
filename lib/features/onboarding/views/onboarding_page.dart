import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/storage/prefs_service.dart';
import 'package:booknow_mobile/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:booknow_mobile/features/onboarding/widgets/onboarding_view.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(di<PrefsService>()),
      child: AppScaffold(
        body: OnboardingView(
          // Browsing needs no account, and Profile is where signing in lives.
          onFinished: () =>
              context.router.replaceAll([const CustomerShellRoute()]),
          onSignInInstead: () => context.router.replaceAll([
            const CustomerShellRoute(children: [ProfileRoute()]),
          ]),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/widgets/index.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di<AuthCubit>(),
      child: AuthStepListener(
        child: AuthFailureListener(
          child: AppScaffold(
            appBar: const AppAppBar(),
            body: SignUpView(
              onSignInInstead: () =>
                  context.router.replaceAll([const SignInRoute()]),
            ),
          ),
        ),
      ),
    );
  }
}

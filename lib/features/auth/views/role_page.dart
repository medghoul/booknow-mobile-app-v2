import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/widgets/index.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di<AuthCubit>(),
      child: const AuthStepListener(
        child: AuthFailureListener(
          // There is no way back: the user is signed in, and the role has to
          // be chosen before anything else in the app works.
          child: AppScaffold(canPop: false, body: RoleView()),
        ),
      ),
    );
  }
}

import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Surfaces an auth failure as a snackbar.
///
/// A failed sign-in doesn't change what the user can do next — the buttons are
/// still there to try again — so transient feedback is the right weight here.
class AuthFailureListener extends StatelessWidget {
  const AuthFailureListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) =>
          AppSnackBar.error(context, state.failure!.localized(context)),
      child: child,
    );
  }
}

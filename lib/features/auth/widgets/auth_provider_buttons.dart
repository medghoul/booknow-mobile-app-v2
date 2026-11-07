import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:flutter/foundation.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The Apple and Google buttons, the platform's own one first.
///
/// Only the tapped button spins; the other is disabled meanwhile, so two
/// hosted flows can't be opened at once.
class AuthProviderButtons extends StatelessWidget {
  const AuthProviderButtons({
    super.key,
    required this.appleLabel,
    required this.googleLabel,
    this.role = UserRole.customer,
  });

  final String appleLabel;
  final String googleLabel;

  /// What a first sign-in from here makes the account.
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        void signIn(AuthProviderKind provider) =>
            context.read<AuthCubit>().signInWith(provider, role: role);

        Widget button(AuthProviderKind provider, String label) =>
            AppProviderButton(
              provider: provider,
              label: label,
              isLoading: state.pendingProvider == provider,
              onPressed: state.isBusy ? null : () => signIn(provider),
            );

        final apple = button(AuthProviderKind.apple, appleLabel);
        final google = button(AuthProviderKind.google, googleLabel);
        // Each platform's own account first.
        final isAndroid = defaultTargetPlatform == TargetPlatform.android;

        return Column(
          children: [
            isAndroid ? google : apple,
            SizedBox(height: context.spacing.sm.h),
            isAndroid ? apple : google,
          ],
        );
      },
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_divider.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_provider_buttons.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_legal_note.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key, required this.onCreateAccount});

  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth;

    return AppDockedColumn(
      docked: const AuthLegalNote(),
      children: [
        SizedBox(height: context.spacing.xs.h),
        Text(t.signIn.title, style: context.textTheme.displayLarge),
        SizedBox(height: context.spacing.sm.h),
        Text(
          t.signIn.body,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.xl.h),
        AuthProviderButtons(
          appleLabel: t.continueWithApple,
          googleLabel: t.continueWithGoogle,
        ),
        SizedBox(height: context.spacing.xl.h),
        AuthDivider(label: t.signIn.firstTime),
        SizedBox(height: context.spacing.md.h),
        AppOutlinedButton(
          label: t.signIn.createAccount,
          expand: true,
          onPressed: onCreateAccount,
        ),
        SizedBox(height: context.spacing.xl.h),
      ],
    );
  }
}

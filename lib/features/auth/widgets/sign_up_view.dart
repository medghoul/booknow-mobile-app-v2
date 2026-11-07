import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_provider_buttons.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key, required this.onSignInInstead});

  final VoidCallback onSignInInstead;

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth;

    return AppDockedColumn(
      docked: Column(
        children: [
          AuthProviderButtons(
            appleLabel: t.signUpWithApple,
            googleLabel: t.signUpWithGoogle,
          ),
          SizedBox(height: context.spacing.lg.h),
          _SignInPrompt(onTap: onSignInInstead),
          SizedBox(height: context.spacing.lg.h),
        ],
      ),
      children: [
        Text(t.signUp.title, style: context.textTheme.displayLarge),
        SizedBox(height: context.spacing.sm.h),
        Text(
          t.signUp.body,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.xl.h),
        _Benefit(
          icon: Icons.credit_card_off_outlined,
          title: t.signUp.noCardTitle,
          body: t.signUp.noCardBody,
        ),
        _Benefit(
          icon: Icons.lock_outline,
          title: t.signUp.dataTitle,
          body: t.signUp.dataBody,
        ),
        _Benefit(
          icon: Icons.storefront_outlined,
          title: t.signUp.roleTitle,
          body: t.signUp.roleBody,
        ),
      ],
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  static const double _iconContainerSize = 38.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.lg.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _iconContainerSize.w,
            height: _iconContainerSize.w,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: context.icons.s.w,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: context.spacing.sm.w + 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.labelLarge),
                Text(
                  body,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth.signUp;

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '${t.alreadyHaveAccount} ',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              t.signInLink,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_failure_listener.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_legal_note.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_provider_buttons.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Signs the customer in at the moment it matters, without leaving the screen.
///
/// Resolves to true once a customer is signed in and still on this screen, so
/// the caller can carry on with what they were doing. Anyone already signed in
/// passes straight through, so a screen can call this before any protected
/// action rather than checking first. The first sign-in also asks for a name.
///
/// False for anyone else: an owner who signs in here is on their way to their
/// own app, and [AuthStepListener] is what takes them there.
Future<bool> ensureSignedIn(
  BuildContext context, {
  required String title,
  required String body,
}) async {
  final auth = di<AuthCubit>();

  if (auth.state.session == null) {
    final done = await AppBottomSheet.show<bool>(
      context,
      builder: (_) => _SignInSheet(title: title, body: body),
    );
    if (done != true || !context.mounted) return false;
  }

  if (auth.state.profile?.role != UserRole.customer) return false;

  await askNameIfNeeded(context);
  return context.mounted && auth.state.session != null;
}

/// The one question a first sign-in asks, and only of a customer.
Future<void> askNameIfNeeded(BuildContext context) async {
  final profile = di<AuthCubit>().state.profile;
  if (profile == null ||
      profile.role != UserRole.customer ||
      profile.profileSetupSeen) {
    return;
  }

  await AppBottomSheet.show<void>(
    context,
    isDismissible: false,
    builder: (_) => _NameSheet(initial: profile.name),
  );
}

class _SignInSheet extends StatelessWidget {
  const _SignInSheet({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth;

    return BlocProvider.value(
      value: di<AuthCubit>(),
      child: AuthFailureListener(
        child: BlocListener<AuthCubit, AuthState>(
          // The profile, not the session: the sheet closes only once the
          // journey has resolved, so what follows can rely on the role.
          listenWhen: (before, after) =>
              before.profile == null && after.profile != null,
          listener: (context, _) => Navigator.of(context).pop(true),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: context.spacing.xs.h),
              Text(
                body,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.spacing.lg.h),
              AuthProviderButtons(
                appleLabel: t.continueWithApple,
                googleLabel: t.continueWithGoogle,
              ),
              SizedBox(height: context.spacing.md.h),
              const AuthLegalNote(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameSheet extends StatefulWidget {
  const _NameSheet({required this.initial});

  final String initial;

  @override
  State<_NameSheet> createState() => _NameSheetState();
}

class _NameSheetState extends State<_NameSheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final auth = di<AuthCubit>();
    final name = _name.text.trim();
    unawaited(name.isEmpty ? auth.skipProfile() : auth.saveProfile(name: name));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.welcome;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.title,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        AppTextField(controller: _name, label: t.nameLabel),
        SizedBox(height: context.spacing.sm.h),
        Text(
          t.body,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        AppElevatedButton(label: t.cta, expand: true, onPressed: _submit),
      ],
    );
  }
}

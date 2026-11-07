import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/identity_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The last step: confirm the name the provider sent, optionally add a phone.
///
/// Every field here is pre-filled or optional, which is why the screen can be
/// skipped outright — nothing on it blocks booking.
class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<AuthCubit>().state.session?.profile;
    _nameController = TextEditingController(text: profile?.name ?? '');
    _phoneController = TextEditingController(text: profile?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AuthCubit>().saveProfile(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth.profile;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final session = state.session;
        final providerLabel = switch (session?.provider) {
          AuthProviderKind.apple => 'Apple',
          AuthProviderKind.google => 'Google',
          null => '',
        };

        return Form(
          key: _formKey,
          child: AppDockedColumn(
            docked: AppElevatedButton(
              label: t.save,
              expand: true,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: AppTextButton(
                  label: context.t.common.skip,
                  foregroundColor: context.colorScheme.onSurfaceVariant,
                  onPressed: state.isBusy
                      ? null
                      : context.read<AuthCubit>().skipProfile,
                ),
              ),
              Text(t.title, style: context.textTheme.displayLarge),
              SizedBox(height: context.spacing.sm.h),
              Text(
                t.body(provider: providerLabel),
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.spacing.xl.h),
              if (session != null)
                IdentityCard(
                  name: session.profile.name,
                  email: session.profile.email,
                  providerLabel: providerLabel,
                ),
              SizedBox(height: context.spacing.xl.h),
              AppTextField(
                controller: _nameController,
                label: t.nameLabel,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                validator: (value) => FormValidators.required(value) == null
                    ? null
                    : t.nameRequired,
              ),
              SizedBox(height: context.spacing.lg.h),
              AppPhoneField(
                controller: _phoneController,
                label: '${t.phoneLabel} · ${t.phoneOptional}',
                helper: t.phoneHelper,
                textInputAction: TextInputAction.done,
                validator: FormValidators.phone,
              ),
              SizedBox(height: context.spacing.xl.h),
            ],
          ),
        );
      },
    );
  }
}

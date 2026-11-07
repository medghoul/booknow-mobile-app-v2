import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/utils/validation/form_validators.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_avatar.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_header.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The dial code the fields are written against. Italy only, like the rest of
/// v0 — the shop's timezone and the money are both `it` too.
const String _dialCode = '+39';

/// Name, phone and the address the account is signed in with.
///
/// One screen for both roles, the way [ProfileView] is: the fields are the
/// same three and the save is the same request, so splitting it would
/// duplicate a form to change four strings. What a role changes is only what
/// the screen says — an owner's phone is "personale", and has to be told
/// apart from the shop's number, which is edited somewhere else entirely.
///
/// The email is shown and locked. It is the provider's, it is what the
/// account is keyed on, and there is no endpoint that would change it — so it
/// is on the screen to be read, with the padlock saying why it cannot be
/// touched rather than leaving a field that silently refuses.
class PersonalDataView extends StatefulWidget {
  const PersonalDataView({
    super.key,
    required this.user,
    required this.onSaved,
    required this.onCancel,
    this.provider,
    this.shopName,
    this.isSaving = false,
  });

  final UserProfile user;

  /// Which account the session was opened with, named under the email.
  final AuthProviderKind? provider;

  /// The owner's shop, named under the avatar. Null for a customer, and null
  /// for an owner who has not finished the wizard — they are a titolare of
  /// nothing yet, so the line falls back to the customer's.
  final String? shopName;

  final bool isSaving;

  /// Called with what to save. The screen does not pop itself — the page it
  /// sits on owns the route and the confirmation.
  final void Function({required String name, required String phone}) onSaved;

  final VoidCallback onCancel;

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.user.name);
    _phone = TextEditingController(text: widget.user.phone ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    widget.onSaved(name: _name.text.trim(), phone: _phone.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile.personal;
    final isOwner = widget.user.role == UserRole.owner;
    final shopName = widget.shopName?.trim();

    return Form(
      key: _formKey,
      child: AppDockedColumn(
        // Pushed from a row the user tapped, so the fields are already where
        // they expect them. The push is the arrival; staggering them in would
        // be a second one on top of it.
        animate: false,
        docked: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppElevatedButton(
              label: context.t.common.save,
              expand: true,
              isLoading: widget.isSaving,
              onPressed: _submit,
            ),
            SizedBox(height: context.spacing.sm.h),
            AppOutlinedButton(
              label: context.t.common.cancel,
              expand: true,
              onPressed: widget.isSaving ? null : widget.onCancel,
            ),
          ],
        ),
        children: [
          SizedBox(height: 16.h),
          Center(
            child: ProfileAvatar(
              initials: ProfileHeader.initialsOf(widget.user.name),
              label: widget.user.name,
              size: 88,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            // What the disc is, in the owner's case by naming the shop: the
            // initials are the only picture the app has, and an owner reads
            // this screen as the one behind their own name on it.
            isOwner && shopName != null && shopName.isNotEmpty
                ? t.ownerOf(shop: shopName)
                : t.initialsNote,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _name,
            label: t.nameLabel,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            validator: (value) =>
                FormValidators.required(value) == null ? null : t.nameRequired,
          ),
          const SizedBox(height: 14),
          AppFieldLabel(
            label: isOwner ? t.phoneLabelOwner : t.phoneLabelCustomer,
          ),
          AppPhoneField(
            controller: _phone,
            dialCode: _dialCode,
            textInputAction: TextInputAction.done,
            validator: FormValidators.phone,
          ),
          AppFieldHelper(isOwner ? t.phoneHelperOwner : t.phoneHelperCustomer),
          const SizedBox(height: 14),
          AppTextField(
            label: t.emailLabel,
            initialValue: widget.user.email,
            enabled: false,
          ),
          AppFieldHelper(switch (widget.provider) {
            AuthProviderKind.apple => t.emailApple,
            AuthProviderKind.google => t.emailGoogle,
            null => t.emailProvider,
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

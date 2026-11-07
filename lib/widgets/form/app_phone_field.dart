import 'package:booknow_mobile/widgets/form/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Phone number entry.
///
/// The number is optional throughout the product — the spec keeps it that way
/// for data minimisation — so this field never marks itself required; the
/// screen decides.
class AppPhoneField extends StatelessWidget {
  const AppPhoneField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.dialCode,
  });

  final TextEditingController? controller;

  /// Optional: the shop wizard puts its labels above the field rather than
  /// floating inside it, so there is nothing to show here.
  final String? label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;

  /// Drawn in front of the number — "+39" on the profile forms, where the
  /// design shows the country rather than a handset.
  ///
  /// Only ever shown. The app stores whatever the user typed, so a number
  /// saved before this existed still reads back unchanged, and one typed with
  /// its own prefix is not quietly given a second.
  final String? dialCode;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      helper: helper,
      errorText: errorText,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      textInputAction: textInputAction,
      keyboardType: TextInputType.phone,
      prefixIcon: null,
      prefixText: dialCode,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputFormatters: [
        // Digits plus the characters a written number can carry.
        FilteringTextInputFormatter.allow(RegExp(r'[\d\s+\-()]')),
        LengthLimitingTextInputFormatter(20),
      ],
    );
  }
}

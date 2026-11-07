import 'package:booknow_mobile/core/utils/validation/app_regex.dart';
import 'package:booknow_mobile/localization/localization.dart';

/// Validators for `TextFormField`, returning localised copy.
///
/// They read the global `t` rather than taking a `BuildContext`, so a
/// validator can be passed as a bare function reference and stays testable
/// without pumping a widget.
///
/// Every validator treats null and empty the same way, and an optional field
/// returns null for both — an empty optional field is valid, which is the
/// case the phone field depends on.
abstract final class FormValidators {
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName == null
          ? t.validation.required
          : t.validation.requiredNamed(field: fieldName);
    }
    return null;
  }

  static String? email(String? value, {bool isRequired = true}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return isRequired ? required(value) : null;
    return AppRegex.email.hasMatch(text) ? null : t.validation.email;
  }

  /// [isRequired] is false by default: BookNow's phone field is optional
  /// everywhere it appears.
  static String? phone(String? value, {bool isRequired = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return isRequired ? required(value) : null;

    final digits = text.replaceAll(AppRegex.phoneSeparators, '');
    return AppRegex.phoneE164.hasMatch(digits) ? null : t.validation.phone;
  }

  static String? length(
    String? value, {
    int? min,
    int? max,
    bool isRequired = true,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return isRequired ? required(value) : null;

    if (min != null && text.length < min) {
      return t.validation.tooShort(min: min.toString());
    }
    if (max != null && text.length > max) {
      return t.validation.tooLong(max: max.toString());
    }
    return null;
  }

  /// Runs validators in order and reports the first complaint, so a field can
  /// carry several rules without nesting them at the call site.
  static String? Function(String?) all(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validate in validators) {
        final error = validate(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The base text field. Every other field in this folder wraps it.
///
/// The label sits above the field rather than floating inside it: the design's
/// forms are short and left-aligned, and a static label stays readable while
/// the field holds text.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixText,
    this.suffix,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.autofillHints,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;

  /// Guidance shown under the field while it is valid.
  final String? helper;

  /// Replaces [helper] when set. Pass the localised message, not a code.
  final String? errorText;

  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;

  /// A fixed string in front of what is typed — the dial code on a phone
  /// field. It is not part of the value: it is drawn, never edited, and never
  /// comes back out of the controller.
  final String? prefixText;

  final Widget? suffix;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;

  /// A field that holds more than one line is drawn as a rounded box, not a
  /// pill.
  ///
  /// The pill is the system's shape for controls, and the theme gives every
  /// field one. At four lines tall that shape stops reading as a field: the
  /// curve carves a crescent out of the first and last line, and the text has
  /// to start a long way in to clear it. The design draws the message box as
  /// a 26-radius rectangle for exactly that reason.
  bool get _isBox => maxLines > 1 && !obscureText;

  /// The themed border with the box radius, or null to keep the theme's — so
  /// a single-line field is untouched by any of this.
  InputBorder? _boxed(InputBorder? border, BorderRadius radius) {
    if (!_isBox || border is! OutlineInputBorder) return null;
    return border.copyWith(borderRadius: radius);
  }

  @override
  Widget build(BuildContext context) {
    final fields = context.theme.inputDecorationTheme;
    final boxRadius = context.radii.xlR;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          autofillHints: autofillHints,
          focusNode: focusNode,
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: context.fonts.s.sp,
            fontWeight: FontWeight.w600,
            color: enabled ? null : context.colorScheme.onSurfaceVariant,
          ),
          decoration: InputDecoration(
            hintText: hint,
            helperText: helper,
            errorText: errorText,
            counterText: '',
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, size: context.icons.m.w),
            prefix: prefixText == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(right: context.spacing.sm.w),
                    child: Text(
                      prefixText!,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            suffixIcon: suffix,
            // The pill's padding buys room for its own curve; a box needs
            // none of it, and the text would otherwise sit oddly far in.
            contentPadding: _isBox
                ? EdgeInsets.symmetric(
                    horizontal: context.spacing.lg.w,
                    vertical: context.spacing.lg.h,
                  )
                : null,
            border: _boxed(fields.border, boxRadius),
            enabledBorder: _boxed(fields.enabledBorder, boxRadius),
            focusedBorder: _boxed(fields.focusedBorder, boxRadius),
            errorBorder: _boxed(fields.errorBorder, boxRadius),
            focusedErrorBorder: _boxed(fields.focusedErrorBorder, boxRadius),
            disabledBorder: _boxed(fields.disabledBorder, boxRadius),
          ),
        ),
      ],
    );
  }
}

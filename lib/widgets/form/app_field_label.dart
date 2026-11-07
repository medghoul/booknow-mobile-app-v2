import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// A label above a field, with an optional right-hand note ("facoltativo").
///
/// [AppTextField] can draw its own label, and that is the one to use where a
/// field stands alone. This is for a form that also needs the note on the
/// right — the design hangs "facoltativo" and "personale" off the label's own
/// line, which a single string cannot say.
class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel({super.key, required this.label, this.trailing});

  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

/// The helper line under a field.
class AppFieldHelper extends StatelessWidget {
  const AppFieldHelper(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

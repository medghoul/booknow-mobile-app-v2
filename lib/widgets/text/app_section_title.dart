import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The uppercase micro-label that opens a section.
///
/// Weight and tracking come from `labelSmall`, so call sites never restate
/// them and every section header on every screen matches.
class AppSectionTitle extends StatelessWidget {
  const AppSectionTitle(this.title, {super.key, this.trailing});

  final String title;

  /// An action aligned to the end of the row — "See all", "Edit".
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      title.toUpperCase(),
      style: context.textTheme.labelSmall?.copyWith(
        color: context.colorScheme.onSurfaceVariant,
      ),
    );

    if (trailing == null) return label;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [label, trailing!],
    );
  }
}

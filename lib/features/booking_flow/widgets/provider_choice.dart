import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "With whom": anyone free, or one person by name (providers §4, §7.1).
///
/// Shared by booking a time and joining the line. Shown only when more than
/// one person does the chosen service: with one, there is nobody to choose
/// and the screen stays as it was.
class ProviderChoice extends StatelessWidget {
  const ProviderChoice({
    super.key,
    required this.providers,
    required this.selected,
    required this.onSelected,
  });

  /// Who does the chosen service, by display order.
  final List<ShopProvider> providers;

  /// The person chosen; null is anyone.
  final String? selected;

  final ValueChanged<String?> onSelected;

  /// Whether [shop] has a choice to offer for [service].
  static bool offers(Shop? shop, ShopService? service) =>
      shop != null &&
      service != null &&
      shop.providersFor(service.id).length > 1;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.whoLike, style: context.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: context.spacing.sm.w,
          runSpacing: context.spacing.sm.h,
          children: [
            ChoiceChip(
              label: Text(t.anyone),
              selected: selected == null,
              showCheckmark: false,
              onSelected: (_) => onSelected(null),
            ),
            for (final provider in providers)
              ChoiceChip(
                label: Text(provider.name ?? ''),
                selected: selected == provider.id,
                showCheckmark: false,
                onSelected: (_) => onSelected(provider.id),
              ),
          ],
        ),
      ],
    );
  }
}

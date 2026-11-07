import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// What the owner chose in the walk-in sheet.
typedef WalkInChoice = ({String? serviceId, String? name});

/// "Aggiungere un walk-in?" (queue spec §5.1): a service and an optional name
/// for someone who came in without the app, so the wait stays right.
class WalkInSheet extends StatefulWidget {
  const WalkInSheet._({required this.services});

  final List<ShopService> services;

  /// Null when the owner backed out.
  static Future<WalkInChoice?> ask(
    BuildContext context, {
    required List<ShopService> services,
  }) => AppBottomSheet.show<WalkInChoice>(
    context,
    builder: (_) => WalkInSheet._(services: services),
  );

  @override
  State<WalkInSheet> createState() => _WalkInSheetState();
}

class _WalkInSheetState extends State<WalkInSheet> {
  final _name = TextEditingController();
  late String? _serviceId = widget.services.firstOrNull?.id;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue.owner.walkInSheet;

    final scheme = context.colorScheme;

    // Scrolls once the keyboard is up: the sheet is lifted above it and
    // left with about half the screen, less than the whole form needs.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(t.title, style: context.textTheme.titleMedium),
          if (widget.services.length > 1) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final service in widget.services)
                  _ServiceChip(
                    label: service.name,
                    selected: service.id == _serviceId,
                    onTap: () => setState(() => _serviceId = service.id),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          AppFieldLabel(label: t.name),
          TextField(
            controller: _name,
            textInputAction: TextInputAction.done,
            style: context.textTheme.bodyMedium,
            decoration: InputDecoration(
              filled: true,
              fillColor: scheme.surface,
              enabledBorder: OutlineInputBorder(
                borderRadius: context.radii.mdR,
                borderSide: BorderSide(color: scheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: context.radii.mdR,
                borderSide: BorderSide(color: scheme.secondary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: () {
              final name = _name.text.trim();
              Navigator.of(context).pop<WalkInChoice>((
                serviceId: _serviceId,
                name: name.isEmpty ? null : name,
              ));
            },
            style: FilledButton.styleFrom(
              minimumSize: Size.fromHeight(52.h),
              backgroundColor: scheme.secondary,
              foregroundColor: scheme.onSecondary,
              textStyle: context.textTheme.labelLarge,
              shape: RoundedRectangleBorder(borderRadius: context.radii.mdR),
            ),
            child: Text(t.add),
          ),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  const _ServiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surface,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? scheme.secondary : scheme.outline,
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Center(
              widthFactor: 1,
              child: Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  color: selected
                      ? scheme.onSecondaryContainer
                      : scheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

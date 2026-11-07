import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// What the three-dot menu on a service row offers.
enum ServiceAction { edit, delete }

/// The actions behind a service row's three dots.
///
/// A sheet rather than a popup menu: the design reserves sheets for "continue
/// a task", and both of these are a next step on the service the owner just
/// pointed at.
///
/// It repeats the service it acts on — name, duration, price — because by the
/// time the sheet is open the row that was tapped is behind a scrim, and
/// deleting the wrong service is not something the owner can undo.
///
/// The design lists three actions: Modifica, Nascondi ai clienti, Elimina.
/// Hiding is not offered here because the API has no such flag — `active` is
/// its soft-delete marker and an inactive service is filtered out of the shop
/// entirely, so a "hidden" service would vanish from this list rather than
/// sit in it dimmed. The row belongs here the day the endpoint grows one.
///
/// Annulla is a separate button rather than a third row: dismissing is not an
/// action on the service, and keeping it apart means the rows that *are* read
/// as a pair.
class ServiceActionsSheet extends StatelessWidget {
  const ServiceActionsSheet({super.key, required this.service});

  final ShopService service;

  /// Opens the sheet and resolves to the action the owner chose, or null if
  /// they dismissed it.
  static Future<ServiceAction?> open(
    BuildContext context,
    ShopService service,
  ) => AppBottomSheet.show<ServiceAction>(
    context,
    builder: (_) => ServiceActionsSheet(service: service),
  );

  /// Asks before deleting, and resolves to true when the owner said yes.
  ///
  /// The design deletes straight from the sheet and offers an undo in the
  /// toast that follows. There is no undo to offer: `DELETE` is the only call
  /// there is and nothing re-activates a service, so the question has to come
  /// before the delete rather than after it. Both delete paths — this screen
  /// and the wizard's step — go through here so neither is one tap from gone.
  static Future<bool> confirmDelete(BuildContext context, ShopService service) {
    final t = context.t.shopSetup.services;

    return AppDialog.show(
      context,
      icon: Icons.delete_outline_rounded,
      title: t.deleteTitle(name: service.name),
      message: t.deleteBody,
      confirmLabel: t.delete,
      cancelLabel: context.t.common.cancel,
      isDestructive: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.services;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: context.textTheme.titleMedium),
                  Text(
                    t.minutes(count: service.durationMinutes.toString()),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            Text(
              Money.formatCents(service.priceCents),
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: context.spacing.lg.h),

        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.radii.xl.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _ActionRow(
                icon: Icons.edit_outlined,
                label: t.edit,
                onTap: () => Navigator.of(context).pop(ServiceAction.edit),
              ),
              const AppDivider.inset(),
              _ActionRow(
                icon: Icons.delete_outline,
                label: t.delete,
                // The destructive one carries the error colour, so it is never
                // the option taken without meaning to.
                color: context.colorScheme.error,
                onTap: () => Navigator.of(context).pop(ServiceAction.delete),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacing.md.h),

        AppOutlinedButton(
          label: context.t.common.cancel,
          expand: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? context.colorScheme.onSurface;

    return AppPressScale(
      builder: (context, states) => InkWell(
        onTap: onTap,
        statesController: states,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.lg.w,
            vertical: context.spacing.lg.h,
          ),
          child: Row(
            children: [
              Icon(icon, size: context.icons.s.w, color: foreground),
              SizedBox(width: context.spacing.md.w),
              Text(
                label,
                style: context.textTheme.titleSmall?.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

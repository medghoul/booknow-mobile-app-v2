import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/service_actions_sheet.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/service_editor_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Every service the shop offers, as the owner's own list.
///
/// Not a wizard step: there is nothing to continue to, so the docked action
/// adds a service rather than advancing. Tapping a row opens the editor,
/// which is the design's reading of the list — the three dots are for the
/// things an owner does rarely, and editing is the thing they do often.
class ShopServicesList extends StatelessWidget {
  const ShopServicesList({super.key, this.onDone});

  /// During first setup: finishes the step. Adding a service then moves out of
  /// the main button's way, because finishing is what comes next.
  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.services;
    final state = context.watch<ShopSetupCubit>().state;
    final services = state.shop?.activeServices ?? const <ShopService>[];

    if (services.isEmpty) {
      return AppEmptyState(
        icon: Icons.content_cut_rounded,
        title: t.emptyTitle,
        message: t.emptyBody,
        // The one action there is, so it goes in the empty state rather than
        // docked under it: nothing else on the screen competes with it.
        action: AppElevatedButton(
          label: t.add,
          icon: Icons.add_rounded,
          onPressed: () => _add(context),
        ),
      );
    }

    return AppDockedColumn(
      // The list changes under a standing layout — a service is added, a
      // price edited — and re-running the entrance on that reads as a
      // flicker rather than as an arrival.
      animate: false,
      docked: onDone == null
          ? AppElevatedButton(
              label: t.add,
              icon: Icons.add_rounded,
              expand: true,
              isDisabled: state.isSaving,
              onPressed: () => _add(context),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppOutlinedButton(
                  label: t.add,
                  icon: Icons.add_rounded,
                  expand: true,
                  onPressed: state.isSaving ? null : () => _add(context),
                ),
                SizedBox(height: context.spacing.sm.h),
                AppElevatedButton(
                  label: context.t.shopSetup.checklist.done,
                  expand: true,
                  onPressed: onDone,
                ),
              ],
            ),
      children: [
        Text(
          t.manageSubtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        for (final service in services) ...[
          _ServiceRow(
            service: service,
            onTap: state.isSaving ? null : () => _edit(context, service),
            onMenu: state.isSaving ? null : () => _actions(context, service),
          ),
          SizedBox(height: context.spacing.sm.h),
        ],
        SizedBox(height: context.spacing.lg.h),
      ],
    );
  }

  Future<void> _add(BuildContext context) async {
    final added = await ServiceEditorSheet.open(context);
    if (!(added ?? false) || !context.mounted) return;

    AppSnackBar.success(context, context.t.shopSetup.services.added);
  }

  Future<void> _edit(BuildContext context, ShopService service) async {
    final saved = await ServiceEditorSheet.open(context, service: service);
    if (!(saved ?? false) || !context.mounted) return;

    AppSnackBar.success(context, context.t.shopSetup.services.saved);
  }

  Future<void> _actions(BuildContext context, ShopService service) async {
    final action = await ServiceActionsSheet.open(context, service);
    if (!context.mounted) return;

    switch (action) {
      case ServiceAction.edit:
        await _edit(context, service);
      case ServiceAction.delete:
        await _delete(context, service);
      case null:
        break;
    }
  }

  Future<void> _delete(BuildContext context, ShopService service) async {
    final cubit = context.read<ShopSetupCubit>();

    final confirmed = await ServiceActionsSheet.confirmDelete(context, service);
    if (!confirmed) return;

    final removed = await cubit.removeService(service.id);
    if (!removed || !context.mounted) return;

    AppSnackBar.success(context, context.t.shopSetup.services.deleted);
  }
}

/// One service: what it is called, how long it takes, what it costs.
///
/// The whole row opens the editor and only the three dots stop it, so the
/// common edit is the easy one and the rare actions are still a tap away.
class _ServiceRow extends StatelessWidget {
  const _ServiceRow({
    required this.service,
    required this.onTap,
    required this.onMenu,
  });

  final ShopService service;
  final VoidCallback? onTap;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.services;

    return Material(
      color: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            left: context.spacing.lg.w,
            right: context.spacing.sm.w,
            top: context.spacing.md.h,
            bottom: context.spacing.md.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.name, style: context.textTheme.titleSmall),
                    Text(
                      t.minutes(count: service.durationMinutes.toString()),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              Text(
                Money.formatCents(service.priceCents),
                style: context.textTheme.titleSmall,
              ),
              SizedBox(width: context.spacing.xs.w),
              AppIconButton(
                icon: Icons.more_vert,
                tooltip: t.actionsFor(name: service.name),
                size: context.icons.s.w,
                onPressed: onMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

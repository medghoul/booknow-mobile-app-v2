import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/provider_editor_sheet.dart';
import 'package:booknow_mobile/features/shop_setup/widgets/service_actions_sheet.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/avatar/app_avatar.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Everyone who takes customers in the shop, and the people taken off it.
///
/// Never empty: the owner is always on it, as the provider whose id is the
/// shop's. They are listed first and marked as the owner, and their menu has
/// no way to remove them because the server would refuse it.
class TeamList extends StatelessWidget {
  const TeamList({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.team;
    final state = context.watch<ShopSetupCubit>().state;
    final shop = state.shop;
    if (shop == null) return const SizedBox.shrink();

    final active = shop.activeProviders;
    final removed = shop.providers.where((p) => !p.isActive).toList();

    return AppDockedColumn(
      animate: false,
      docked: AppElevatedButton(
        label: t.add,
        icon: Icons.add_rounded,
        expand: true,
        isDisabled: state.isSaving,
        onPressed: () => _add(context),
      ),
      children: [
        Text(
          t.subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        for (final provider in active) ...[
          _ProviderRow(
            provider: provider,
            shop: shop,
            onTap: state.isSaving ? null : () => _edit(context, provider),
            onMenu: state.isSaving || provider.isDefaultOf(shop.id)
                ? null
                : () => _actions(context, provider),
          ),
          SizedBox(height: context.spacing.sm.h),
        ],
        if (removed.isNotEmpty) ...[
          SizedBox(height: context.spacing.lg.h),
          AppSectionTitle(t.removedSection),
          SizedBox(height: context.spacing.sm.h),
          for (final provider in removed) ...[
            _RemovedRow(
              name: provider.name ?? '',
              onRestore: state.isSaving
                  ? null
                  : () => _restore(context, provider),
            ),
            SizedBox(height: context.spacing.sm.h),
          ],
        ],
        SizedBox(height: context.spacing.lg.h),
      ],
    );
  }

  Future<void> _add(BuildContext context) async {
    final added = await ProviderEditorSheet.open(context);
    if (!(added ?? false) || !context.mounted) return;

    AppSnackBar.success(context, context.t.shopSetup.team.added);
  }

  Future<void> _edit(BuildContext context, ShopProvider provider) async {
    final saved = await ProviderEditorSheet.open(context, provider: provider);
    if (!(saved ?? false) || !context.mounted) return;

    AppSnackBar.success(context, context.t.shopSetup.team.saved);
  }

  Future<void> _actions(BuildContext context, ShopProvider provider) async {
    final t = context.t.shopSetup.team;
    final name = provider.name ?? '';

    final action = await AppBottomSheet.show<ServiceAction>(
      context,
      title: name,
      builder: (sheet) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSettingsCard(
            children: [
              AppSettingsRow.action(
                icon: AppLineIcons.person,
                label: t.edit,
                onTap: () => Navigator.of(sheet).pop(ServiceAction.edit),
              ),
              AppSettingsRow.action(
                icon: AppLineIcons.close,
                label: t.remove,
                isDanger: true,
                onTap: () => Navigator.of(sheet).pop(ServiceAction.delete),
              ),
            ],
          ),
          SizedBox(height: context.spacing.md.h),
          AppOutlinedButton(
            label: context.t.common.cancel,
            expand: true,
            onPressed: () => Navigator.of(sheet).pop(),
          ),
        ],
      ),
    );
    if (!context.mounted) return;

    switch (action) {
      case ServiceAction.edit:
        await _edit(context, provider);
      case ServiceAction.delete:
        await _remove(context, provider);
      case null:
        break;
    }
  }

  /// Asks first: the server keeps their bookings' history, but from now on
  /// nobody can book them, and that is what the owner is agreeing to.
  Future<void> _remove(BuildContext context, ShopProvider provider) async {
    final t = context.t.shopSetup.team;
    final cubit = context.read<ShopSetupCubit>();
    final name = provider.name ?? '';

    final confirmed = await AppDialog.show(
      context,
      icon: Icons.person_remove_outlined,
      title: t.removeTitle(name: name),
      message: t.removeBody,
      confirmLabel: t.remove,
      cancelLabel: context.t.common.cancel,
      isDestructive: true,
    );
    if (!confirmed) return;

    final removed = await cubit.removeProvider(provider.id);
    if (!removed || !context.mounted) return;

    AppSnackBar.success(context, t.removed(name: name));
  }

  Future<void> _restore(BuildContext context, ShopProvider provider) async {
    final cubit = context.read<ShopSetupCubit>();

    final restored = await cubit.restoreProvider(provider.id);
    if (!restored || !context.mounted) return;

    AppSnackBar.success(
      context,
      context.t.shopSetup.team.restored(name: provider.name ?? ''),
    );
  }
}

/// One person: their name, and what sets them apart from the shop.
class _ProviderRow extends StatelessWidget {
  const _ProviderRow({
    required this.provider,
    required this.shop,
    required this.onTap,
    required this.onMenu,
  });

  final ShopProvider provider;
  final Shop shop;
  final VoidCallback? onTap;

  /// Null on the owner's own row, which has nothing behind the three dots.
  final VoidCallback? onMenu;

  /// "Every service · Shop's hours · 2 days off".
  static String summaryOf(ShopProvider provider, Translations t) {
    final team = t.shopSetup.team;
    final services = provider.serviceIds;

    return [
      services == null
          ? team.everyService
          : team.servicesCount(n: services.length),
      provider.hasOwnHours ? team.ownHours : team.shopHours,
      if (provider.timeOff.isNotEmpty) team.daysOff(n: provider.timeOff.length),
    ].join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.team;
    final name = provider.name ?? shop.name ?? '';
    final isOwner = provider.isDefaultOf(shop.id);

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
              AppAvatar(name: name, size: 40),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: context.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isOwner) ...[
                          SizedBox(width: context.spacing.xs.w),
                          _OwnerTag(label: t.you),
                        ],
                      ],
                    ),
                    Text(
                      summaryOf(provider, context.t),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (onMenu != null)
                AppIconButton(
                  icon: Icons.more_vert,
                  tooltip: t.actionsFor(name: name),
                  size: context.icons.s.w,
                  onPressed: onMenu,
                )
              else
                SizedBox(width: context.spacing.lg.w),
            ],
          ),
        ),
      ),
    );
  }
}

/// "You", beside the owner's own name.
class _OwnerTag extends StatelessWidget {
  const _OwnerTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final tint = context.status.confirmed;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.sm.w),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.smR,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(color: tint.foreground),
      ),
    );
  }
}

/// Someone taken off the team, with the way back.
class _RemovedRow extends StatelessWidget {
  const _RemovedRow({required this.name, required this.onRestore});

  final String name;
  final VoidCallback? onRestore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: context.spacing.lg.w,
        right: context.spacing.xs.w,
        top: context.spacing.xs.h,
        bottom: context.spacing.xs.h,
      ),
      decoration: context.decorations.cardFlat,
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          AppTextButton(
            label: context.t.shopSetup.team.restore,
            onPressed: onRestore,
          ),
        ],
      ),
    );
  }
}

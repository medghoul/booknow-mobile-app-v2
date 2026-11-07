import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_shop_section.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:booknow_mobile/features/queue/views/shop_mode_page.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';
import 'package:booknow_mobile/widgets/feedback/app_tick.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// First setup as a checklist: what is left is always visible, any step can be
/// done in any order, and leaving never loses anything because each one saves.
///
/// The main button always does the useful thing: it opens the first step still
/// missing, and once none is, it publishes.
class ShopSetupChecklist extends StatelessWidget {
  const ShopSetupChecklist({super.key, required this.shop});

  final Shop? shop;

  Future<void> _chooseMode(BuildContext context, Shop shop) async {
    final cubit = context.read<ShopSetupCubit>();
    await context.router.push(ShopModeRoute(current: shop.mode));
    await cubit.reload();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.checklist;
    final cubit = context.read<ShopSetupCubit>();
    final isSaving = context.select<ShopSetupCubit, bool>(
      (cubit) => cubit.state.isSaving,
    );
    final current = shop ?? const Shop(id: '', status: ShopStatus.draft);
    final steps = ShopSetupStep.counted;
    final done = steps.where(current.isComplete).length;
    final missing = current.missingForPublish.firstOrNull;
    final progress = done / steps.length;

    return ListView(
      padding: EdgeInsets.only(top: 22.h, bottom: 24.h),
      children: [
        Text(t.title, style: context.textTheme.displayMedium),
        const SizedBox(height: 6),
        Text(
          missing == null ? t.allDone : t.left(n: steps.length - done),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: progress),
            duration: context.motion.normal,
            curve: context.motion.curveEmphasized,
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              minHeight: 8,
              color: context.colorScheme.secondary,
              backgroundColor: context.colorScheme.surfaceContainer,
            ),
          ),
        ),
        SizedBox(height: 18.h),
        for (final step in steps) ...[
          _StepRow(
            title: _title(context, step),
            line: _line(context, step, current),
            done: current.isComplete(step),
            onTap: () => cubit.goTo(step),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(height: 10.h),
        AppSectionTitle(t.optional),
        SizedBox(height: 18.h),
        _StepRow(
          title: context.t.queue.mode.row,
          line: shopModeName(context, current.mode),
          onTap: shop == null ? null : () => _chooseMode(context, shop!),
        ),
        SizedBox(height: 18.h),
        Center(
          child: SizedBox(
            height: 44,
            child: TextButton(
              onPressed: isSaving ? null : di<AuthCubit>().signOut,
              style: TextButton.styleFrom(
                textStyle: context.textTheme.labelLarge?.copyWith(
                  fontSize: context.fonts.s.sp,
                ),
              ),
              child: Text(context.t.profile.signOut),
            ),
          ),
        ),
        SizedBox(height: 18.h),
        AppElevatedButton(
          label: missing == null
              ? context.t.shopSetup.review.publish
              : t.continueWith(step: _title(context, missing)),
          expand: true,
          isLoading: isSaving,
          onPressed: missing == null
              ? cubit.publish
              : () => cubit.goTo(missing),
        ),
      ],
    );
  }

  String _title(BuildContext context, ShopSetupStep step) {
    final t = context.t.shopSetup.checklist;
    return switch (step) {
      ShopSetupStep.shop => t.shop,
      ShopSetupStep.address => t.address,
      ShopSetupStep.services => t.services,
      ShopSetupStep.hours => t.hours,
      ShopSetupStep.review => t.title,
    };
  }

  /// What was saved once a step is done, and what it asks for until then.
  String _line(BuildContext context, ShopSetupStep step, Shop shop) {
    final t = context.t.shopSetup.checklist;
    final done = shop.isComplete(step);

    return switch (step) {
      ShopSetupStep.shop => done ? shop.name ?? '' : t.shopHint,
      ShopSetupStep.address => done ? shop.address?.line ?? '' : t.addressHint,
      ShopSetupStep.services =>
        done
            ? context.t.profile.servicesCount(n: shop.activeServices.length)
            : t.servicesHint,
      ShopSetupStep.hours =>
        done
            ? ProfileShopSection.openDaysLabel(shop.openingHours, context.t) ??
                  ''
            : t.hoursHint,
      ShopSetupStep.review => '',
    };
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.title,
    required this.line,
    required this.onTap,
    this.done,
  });

  final String title;
  final String line;
  final VoidCallback? onTap;

  /// Null for an optional row, which has nothing to tick.
  final bool? done;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final done = this.done;

    return Semantics(
      button: true,
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.mdR,
          side: BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: BoxConstraints(minHeight: 64.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                if (done != null) ...[
                  AnimatedContainer(
                    duration: context.motion.normal,
                    curve: context.motion.curveEmphasized,
                    width: 26.w,
                    height: 26.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? scheme.secondary : scheme.surface,
                      border: done
                          ? null
                          : Border.all(color: scheme.outline, width: 2),
                    ),
                    child: done
                        ? Center(
                            child: AppLineIcon(
                              AppLineIcons.check,
                              size: 15,
                              color: scheme.onSecondary,
                              strokeWidth: 3,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: context.spacing.md.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: context.fonts.s.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        line,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                AppLineIcon(
                  AppLineIcons.chevronRight,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Published: the moment the shop goes live, before the owner's tabs take over.
class ShopLiveView extends StatefulWidget {
  const ShopLiveView({super.key});

  @override
  State<ShopLiveView> createState() => _ShopLiveViewState();
}

class _ShopLiveViewState extends State<ShopLiveView> {
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    HapticFeedback.mediumImpact();
  }

  Future<void> _open() async {
    setState(() => _leaving = true);
    // The shop is active now, so the router sends the owner on to their tabs,
    // or to the notification step if that is still pending.
    await di<AuthCubit>().refreshShop();
    if (mounted) setState(() => _leaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.shopSetup.checklist;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppTick(),
          const SizedBox(height: 12),
          Text(t.liveTitle, style: context.textTheme.displayMedium),
          const SizedBox(height: 12),
          Text(
            t.liveBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: _leaving ? null : _open,
              child: Text(t.liveCta),
            ),
          ),
        ],
      ),
    );
  }
}

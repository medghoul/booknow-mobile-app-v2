import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/role_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// "How do you use BookNow?" — asked once, on first sign-in.
class RoleView extends StatelessWidget {
  const RoleView({super.key});

  /// The v0 pilot. Hard-coded here rather than fetched: it is copy on a
  /// first-run screen, and `GET /shops` isn't reachable until the role is set.
  static const String _pilotShopName = 'Barbieri Navona';
  static const String _pilotShopAddress = 'Via dei Coronari 18, Roma';

  @override
  Widget build(BuildContext context) {
    final t = context.t.auth.role;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final firstName = state.session?.profile.name.split(' ').first;

        return AppDockedColumn(
          docked: AppElevatedButton(
            label: context.t.common.continue_,
            expand: true,
            isLoading: state.isSubmitting,
            // Nothing is chosen on a fresh arrival, and the design leaves
            // both cards unticked — so the action stays disabled until the
            // user has actually decided.
            isDisabled: state.selectedRole == null,
            onPressed: cubit.confirmRole,
          ),
          children: [
            SizedBox(height: context.spacing.lg.h),
            if (firstName != null)
              Text(
                t.greeting(name: firstName).toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            SizedBox(height: context.spacing.sm.h),
            Text(t.title, style: context.textTheme.displayLarge),
            SizedBox(height: context.spacing.sm.h),
            Text(
              t.body,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.spacing.xl.h),
            RoleCard(
              icon: Icons.event_available_outlined,
              title: t.customerTitle,
              body: t.customerBody,
              selectedLabel: t.selected,
              isSelected: state.selectedRole == UserRole.customer,
              onSelected: () => cubit.selectRole(UserRole.customer),
            ),
            SizedBox(height: context.spacing.sm.h + 5),
            RoleCard(
              icon: Icons.storefront_outlined,
              title: t.ownerTitle,
              body: t.ownerBody,
              selectedLabel: t.selected,
              isSelected: state.selectedRole == UserRole.owner,
              onSelected: () => cubit.selectRole(UserRole.owner),
            ),
            SizedBox(height: context.spacing.lg.h),
            _PilotNote(
              text: t.pilotNote(
                shop: _pilotShopName,
                address: _pilotShopAddress,
              ),
            ),
            SizedBox(height: context.spacing.xl.h),
          ],
        );
      },
    );
  }
}

class _PilotNote extends StatelessWidget {
  const _PilotNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.lg.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: context.radii.xlR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: context.icons.s.w,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: context.spacing.sm.w),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

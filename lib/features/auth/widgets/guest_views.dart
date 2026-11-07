import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/theme/theme_service.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_failure_listener.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_legal_note.dart';
import 'package:booknow_mobile/features/auth/widgets/auth_provider_buttons.dart';
import 'package:booknow_mobile/features/auth/widgets/sign_in_sheet.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_appearance_section.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The Profile tab for someone who has not signed in.
///
/// New or returning is the same two buttons: the first sign-in is what creates
/// the account, so there is no separate sign-up to choose.
class GuestProfileView extends StatelessWidget {
  const GuestProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.guest;
    final auth = context.t.auth;
    final scheme = context.colorScheme;

    return BlocProvider.value(
      value: di<AuthCubit>(),
      child: AuthFailureListener(
        child: AppScaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            children: [
              const _HeroPictures(),
              SizedBox(height: 16.h),
              Text(
                t.title,
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 6),
              Text(
                t.body,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              AuthProviderButtons(
                appleLabel: auth.continueWithApple,
                googleLabel: auth.continueWithGoogle,
              ),
              SizedBox(height: 16.h),
              const AuthLegalNote(),
              SizedBox(height: 24.h),
              const _AppearanceRow(),
              SizedBox(height: 24.h),
              const _RunAShopCard(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Activity tab for someone who has not signed in.
class GuestActivityView extends StatelessWidget {
  const GuestActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.guest;

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryPicture(category: ShopCategory.barber, size: 96.w),
            SizedBox(height: context.spacing.md.h),
            Text(
              t.activityTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.displaySmall,
            ),
            SizedBox(height: context.spacing.sm.h),
            Text(
              t.activityBody,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.spacing.lg.h),
            AppElevatedButton(
              label: t.signIn,
              onPressed: () =>
                  ensureSignedIn(context, title: t.signInTitle, body: t.body),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroPictures extends StatelessWidget {
  const _HeroPictures();

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CategoryBlob(
            category: ShopCategory.salon,
            width: 84.w,
            height: 80.w,
            pictureSize: 60.w,
            color: scheme.primaryContainer,
          ),
          SizedBox(width: context.spacing.xs.w),
          Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: CategoryBlob(
              category: ShopCategory.barber,
              width: 100.w,
              height: 96.w,
              pictureSize: 72.w,
              color: scheme.secondaryContainer,
            ),
          ),
          SizedBox(width: context.spacing.xs.w),
          CategoryBlob(
            category: ShopCategory.nails,
            width: 84.w,
            height: 80.w,
            pictureSize: 60.w,
            color: scheme.primaryContainer,
          ),
        ],
      ),
    );
  }
}

class _AppearanceRow extends StatelessWidget {
  const _AppearanceRow();

  @override
  Widget build(BuildContext context) {
    final theme = di<ThemeService>();

    return ListenableBuilder(
      listenable: theme,
      builder: (context, _) => ProfileAppearanceSection(
        themeMode: theme.themeMode,
        onThemeModeChanged: theme.setThemeMode,
      ),
    );
  }
}

/// The way in for a shop owner: the same sign-in, but the account starts as an
/// owner and goes on to set the shop up.
class _RunAShopCard extends StatelessWidget {
  const _RunAShopCard();

  @override
  Widget build(BuildContext context) {
    final t = context.t.guest;
    final auth = context.t.auth;

    return Material(
      color: context.headerColor,
      borderRadius: context.radii.lgR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => AppBottomSheet.show<void>(
          context,
          title: t.ownerSheetTitle,
          builder: (sheet) => BlocProvider.value(
            value: di<AuthCubit>(),
            child: AuthFailureListener(
              // An owner is taken to their shop by the journey. An account
              // that is already a customer stays one, so the sheet closes and
              // says why, rather than sitting there signed in.
              child: BlocListener<AuthCubit, AuthState>(
                listenWhen: (before, after) =>
                    before.profile == null && after.profile != null,
                listener: (_, auth) {
                  if (auth.profile?.role != UserRole.customer) return;
                  Navigator.of(sheet).pop();
                  if (context.mounted) {
                    AppSnackBar.info(context, t.ownerCustomerAccount);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t.ownerBody,
                      style: sheet.textTheme.bodyMedium?.copyWith(
                        color: sheet.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: sheet.spacing.lg.h),
                    AuthProviderButtons(
                      appleLabel: auth.continueWithApple,
                      googleLabel: auth.continueWithGoogle,
                      role: UserRole.owner,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.ownerTitle,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: context.fonts.s.sp,
                        color: context.onHeaderColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.ownerBody,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.onHeaderColor.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              AppLineIcon(
                AppLineIcons.chevronRight,
                size: 18,
                color: context.onHeaderColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

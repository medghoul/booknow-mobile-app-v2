import 'package:booknow_mobile/core/constants/app_icons.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/avatar/app_avatar.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The top card of the profile: initials avatar, name, email, which provider
/// the account came from, and the edit action.
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.provider,
    this.onEdit,
  });

  final String name;
  final String email;

  /// Null when the session is not in memory (a restored session); the badge
  /// is then left out rather than guessed.
  final AuthProviderKind? provider;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return DecoratedBox(
      decoration: context.decorations.card,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg.w),
        child: Row(
          children: [
            AppAvatar(name: name, size: 56),
            SizedBox(width: context.spacing.lg.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: context.spacing.xxs.h),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  if (provider != null) ...[
                    SizedBox(height: context.spacing.xs.h),
                    _ProviderBadge(provider: provider!),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.spacing.sm.w),
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scheme.outline),
              ),
              child: AppIconButton(
                icon: Icons.edit_outlined,
                size: context.icons.s.w + 2,
                tooltip: context.t.account.editProfile,
                onPressed: onEdit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Accesso con Apple" / "Accesso con Google", with the provider's own mark.
///
/// Same rule as the sign-in buttons: Google's G stays in its own colours,
/// Apple's silhouette takes the text colour so it reads on both themes.
class _ProviderBadge extends StatelessWidget {
  const _ProviderBadge({required this.provider});

  final AuthProviderKind provider;

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.onSurfaceVariant;
    final size = context.icons.xs.w;

    final (glyph, name) = switch (provider) {
      AuthProviderKind.apple => (
        SvgPicture.asset(
          AppIcons.appleLogo,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        'Apple',
      ),
      AuthProviderKind.google => (
        SvgPicture.asset(AppIcons.googleLogo, width: size, height: size),
        'Google',
      ),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        glyph,
        SizedBox(width: context.spacing.xs.w),
        Text(
          context.t.account.signedInWith(provider: name),
          style: context.textTheme.labelSmall?.copyWith(
            color: color,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

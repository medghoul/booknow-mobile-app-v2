import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_avatar.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_header.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The customer's account, on the card the design leads their profile with.
///
/// It names the provider as well as the address because with Apple's private
/// relay the email alone does not say which account this is — "Accesso con
/// Apple" over a `@privaterelay.appleid.com` address is the only thing that
/// makes the two agree.
///
/// An owner gets [ProfileHeader] instead, which says the same in one line to
/// leave the top of the screen for the shop card.
class ProfileIdentityCard extends StatelessWidget {
  const ProfileIdentityCard({
    super.key,
    required this.name,
    required this.email,
    this.provider,
    this.onEdit,
  });

  final String name;
  final String email;

  /// Absent when the session was restored from a token that names no provider
  /// the app knows. The line is then left out rather than guessed at.
  final AuthProviderKind? provider;

  /// Null leaves the card without its edit button, for the same reason a
  /// settings row without a destination has no chevron.
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    final quiet = context.colorScheme.onSurfaceVariant;

    return Material(
      color: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              ProfileAvatar(
                initials: ProfileHeader.initialsOf(name),
                label: name,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 17.sp,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: quiet,
                      ),
                    ),
                    if (provider != null) ...[
                      const SizedBox(height: 1),
                      _ProviderLine(provider: provider!, color: quiet),
                    ],
                  ],
                ),
              ),
              if (onEdit != null) ...[
                SizedBox(width: context.spacing.md.w),
                Semantics(
                  label: t.editProfile,
                  child: AppLineIcon(
                    AppLineIcons.chevronRight,
                    size: 18,
                    color: quiet,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// "Signed in with Apple".
class _ProviderLine extends StatelessWidget {
  const _ProviderLine({required this.provider, required this.color});

  final AuthProviderKind provider;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final name = switch (provider) {
      AuthProviderKind.apple => 'Apple',
      AuthProviderKind.google => 'Google',
    };

    return Text(
      context.t.profile.signedInWith(provider: name),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.bodySmall?.copyWith(color: color),
    );
  }
}

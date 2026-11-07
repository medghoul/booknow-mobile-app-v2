import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_avatar.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Who is signed in, and the way into their personal details.
///
/// The owner's header. The avatar is the control, not decoration — the design
/// gives this header no other affordance, so the initials have to be tappable
/// and labelled.
///
/// A customer gets [ProfileIdentityCard] instead: with no shop card to lead
/// with, the design has room to name the account they are signed in with.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    this.onOpenPersonalData,
  });

  final String name;
  final UserRole? role;
  final VoidCallback? onOpenPersonalData;

  /// First letters of the first two words. A one-word name gives one letter
  /// rather than two of the same, and a blank name gives nothing instead of
  /// an index error.
  static String initialsOf(String name) => name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part.characters.first.toUpperCase())
      .join();

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    final roleLabel = switch (role) {
      UserRole.owner => t.roleOwner,
      UserRole.customer => t.roleCustomer,
      null => null,
    };

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(t.title, style: context.textTheme.displayMedium),
              if (roleLabel != null)
                Text(
                  // "Marco Rinaldi · titolare" — one line, because the name
                  // and what they are here to do are one fact.
                  '$name · $roleLabel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: context.spacing.md.w),
        ProfileAvatar(
          initials: initialsOf(name),
          label: t.personalData,
          onTap: onOpenPersonalData,
          showEditBadge: onOpenPersonalData != null,
        ),
      ],
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The account the details came from: initials, name, email, provider chip.
///
/// Shown so the user can see *which* account they just used — with two
/// providers and Apple's private relay addresses, that isn't always obvious.
class IdentityCard extends StatelessWidget {
  const IdentityCard({
    super.key,
    required this.name,
    required this.email,
    required this.providerLabel,
  });

  final String name;
  final String email;
  final String providerLabel;

  static const double _avatarSize = 56.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: context.decorations.card,
      child: Row(
        children: [
          Container(
            width: _avatarSize.w,
            height: _avatarSize.w,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              name.toInitials(),
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: context.spacing.lg.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.spacing.sm.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.sm.w,
              vertical: context.spacing.xs.h,
            ),
            decoration: context.decorations.chip,
            child: Text(
              providerLabel,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A rounded surface that groups related rows, separated by hairlines.
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: context.decorations.card,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.lg.w,
          vertical: context.spacing.xs.h,
        ),
        child: Column(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: context.colorScheme.outlineVariant,
                ),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

/// One row inside a [ProfileCard]: icon, title, optional subtitle and a
/// trailing widget (a chevron, a switch, nothing).
///
/// [destructive] draws the row in the danger colour — sign-out and account
/// deletion are the only users.
class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool destructive;

  /// The standard "goes somewhere" chevron.
  static Widget chevron(BuildContext context) => Icon(
    Icons.chevron_right_rounded,
    size: context.icons.m.w,
    color: context.colorScheme.onSurface,
  );

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final titleColor = destructive ? scheme.error : scheme.onSurface;
    final iconColor = destructive ? scheme.error : scheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: context.radii.mdR,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 52.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.spacing.sm.h),
          child: Row(
            children: [
              Icon(icon, size: context.icons.m.w, color: iconColor),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: titleColor,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: context.spacing.sm.w),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

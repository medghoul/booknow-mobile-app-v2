import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The user's initials on a terracotta disc.
///
/// Initials rather than a photograph because the app never asks for one, and
/// a provider's picture is not ours to show.
///
/// Whether it is a control is [onTap]'s to decide. On the owner's header it is
/// the only way into personal data, so it is tappable and labelled; on the
/// customer's identity card the edit button beside it carries that, and the
/// disc is just a picture.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.initials,
    required this.label,
    this.onTap,
    this.size = AppComponentSizes.profileAvatarSize,
    this.showEditBadge = false,
  });

  final String initials;

  /// What a screen reader announces, with or without [onTap].
  final String label;

  final VoidCallback? onTap;

  /// The disc's diameter, before scaling.
  final double size;

  /// Draws the pencil badge on the lower corner.
  ///
  /// The owner's header gives the disc no label and no chevron, so without it
  /// the one way into personal data is a circle of initials that happens to
  /// be tappable. The badge is decoration for a screen reader — [label]
  /// already says where the button goes.
  final bool showEditBadge;

  @override
  Widget build(BuildContext context) {
    final diameter = size.w;

    final circle = Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style:
            (size > AppComponentSizes.profileAvatarSize
                    ? context.textTheme.headlineSmall
                    : context.textTheme.titleSmall)
                ?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
      ),
    );

    final disc = showEditBadge
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              circle,
              _EditBadge(diameter: diameter),
            ],
          )
        : circle;

    if (onTap == null) {
      return Semantics(label: label, image: true, child: disc);
    }

    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: AppPressScale.tap(onTap: onTap, child: disc),
      ),
    );
  }
}

/// The pencil on the avatar's lower corner, ringed in the page's own
/// background so it reads as sitting on top of the disc rather than cut out
/// of it.
class _EditBadge extends StatelessWidget {
  const _EditBadge({required this.diameter});

  final double diameter;

  @override
  Widget build(BuildContext context) {
    final size = AppComponentSizes.profileAvatarBadgeSize.w;

    return PositionedDirectional(
      end: -size / 4,
      bottom: -size / 4,
      child: ExcludeSemantics(
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Icon(
            Icons.edit_outlined,
            size: size / 2,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

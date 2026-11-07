import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:booknow_mobile/widgets/icons/app_line_icon.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One line in an [AppSettingsCard]: icon, label, what it is set to, chevron.
///
/// The chevron is never asked for separately. It is a promise about where the
/// tap goes — *this opens a screen* — so it follows from which constructor
/// was used and whether there is an [onTap] at all, and cannot be got wrong.
///
/// A row with no [onTap] is inert and draws none: an arrow leading nowhere is
/// a promise the screen does not keep. [AppSettingsRow.action] is tappable
/// and draws none either, because it has not gone anywhere.
class AppSettingsRow extends StatelessWidget {
  const AppSettingsRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
    this.isDanger = false,
    this.leading,
  }) : _opensScreen = true;

  const AppSettingsRow.action({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.isDanger = false,
  }) : leading = null,
       _opensScreen = false;

  /// Path data, from [AppLineIcons].
  final String icon;
  final String label;

  /// What this setting currently reads as — "4 servizi", "Attive". Absent
  /// where the row is a door rather than a value.
  final String? value;

  /// Null leaves the row inert and drops the chevron.
  final VoidCallback? onTap;

  /// Deleting an account is not the same kind of act as opening a screen, so
  /// it does not look the same. Colour is not the only signal — the row also
  /// sits last, alone, under a separator.
  final bool isDanger;

  /// Whether the tap leads to a screen. Only a row that does draws a
  /// chevron.
  final bool _opensScreen;

  /// Replaces the icon entirely, for the shop row's photo thumbnail.
  ///
  /// A row with a thumbnail is the one a card leads with, so its label is heavier.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final color = isDanger
        ? context.colorScheme.error
        : context.colorScheme.onSurface;
    final scheme = context.colorScheme;
    final tile = isDanger
        ? context.status.error.background
        : scheme.primaryContainer;
    final iconColor = isDanger ? scheme.error : scheme.primary;

    final row = Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          leading ??
              Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tile,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: AppLineIcon(icon, color: iconColor),
              ),
          SizedBox(width: context.spacing.md.w),
          Expanded(child: _label(context, color)),
          if (onTap != null && _opensScreen) ...[
            SizedBox(width: context.spacing.md.w),
            AppLineIcon(
              AppLineIcons.chevronRight,
              size: 18,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ],
      ),
    );

    final sized = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 62.h),
      child: row,
    );

    if (onTap == null) {
      // No recogniser at all rather than a disabled one, so a drag that starts
      // here still scrolls the page it sits on.
      return Semantics(container: true, child: sized);
    }

    return Semantics(
      button: true,
      container: true,
      child: AppPressScale.tap(onTap: onTap, child: sized),
    );
  }

  /// The label, with [value] under it, so neither ever squeezes the other.
  Widget _label(BuildContext context, Color color) {
    final isHeader = leading != null;

    final text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.titleSmall?.copyWith(
        fontSize: context.fonts.s.sp,
        color: color,
        fontWeight: isHeader ? FontWeight.w800 : FontWeight.w600,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        text,
        AnimatedSize(
          duration: context.motion.fast,
          curve: context.motion.curve,
          alignment: AlignmentDirectional.topStart,
          child: AnimatedSwitcher(
            duration: context.motion.fast,
            layoutBuilder: (current, previous) => Stack(
              alignment: AlignmentDirectional.topStart,
              children: [...previous, ?current],
            ),
            child: value == null
                ? const SizedBox.shrink(key: ValueKey('none'))
                : Padding(
                    key: ValueKey(value),
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      value!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

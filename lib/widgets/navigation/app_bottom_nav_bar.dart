import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/animations/index.dart';
import 'package:booknow_mobile/widgets/icons/app_line_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// One destination in [AppBottomNavBar].
///
/// Carries its own label rather than an index into a translation table, so a
/// tab cannot be added without saying what it is called.
@immutable
class AppNavTab {
  const AppNavTab({required this.icon, required this.label});

  /// Path data, from [AppLineIcons]. The mint pill behind it, the darker colour
  /// and the heavier label carry the state.
  final String icon;

  /// Already localised. The bar never reaches for translations itself.
  final String label;
}

/// The app's primary navigation, docked at the bottom of a tab shell.
///
/// Flat and attached rather than the floating blurred pill the sibling app
/// uses: this one carries labels, and a label needs a solid surface behind it
/// to stay legible over whatever content scrolls underneath. The hairline
/// above it is what keeps it from reading as part of the page.
///
/// Presentational on purpose — it takes an index and reports taps, and knows
/// nothing about routes. The shell that owns the tab stack decides what a tap
/// means, which is what lets the same bar sit over a customer's three
/// destinations and an owner's two.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppNavTab> tabs;

  /// Which tab is selected. Out-of-range selects nothing rather than throwing:
  /// a bar that crashes the app over a stale index is the worse failure.
  final int currentIndex;

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: AppComponentSizes.hairline,
          ),
        ),
      ),
      // Only the bottom inset. The bar is already against the screen edge, so
      // the side insets belong to the content, and `SafeArea` is what lifts
      // the labels clear of the home indicator.
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              for (final (index, tab) in tabs.indexed)
                Expanded(
                  child: _NavItem(
                    tab: tab,
                    isSelected: index == currentIndex,
                    onTap: () => onTap(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final color = isSelected ? scheme.onSurface : scheme.onSurfaceVariant;

    return Semantics(
      // `selected` is what a screen reader announces as "selected" — the
      // colour and the filled icon say it to everyone else.
      selected: isSelected,
      button: true,
      container: true,
      child: AppPressScale.tap(
        onTap: () {
          // The same click the OS uses for a segmented control. Navigation is
          // a selection, not a confirmation, so it is the light one.
          HapticFeedback.selectionClick();
          onTap();
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 71.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // The mint pill behind the active icon.
              AnimatedContainer(
                duration: context.motion.fast,
                width: 60.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? scheme.secondaryContainer
                      : scheme.secondaryContainer.withValues(alpha: 0),
                  borderRadius: context.radii.lgR,
                ),
                alignment: Alignment.center,
                child: AppLineIcon(tab.icon, size: 22, color: color),
              ),
              SizedBox(height: context.spacing.xs.h),
              AnimatedDefaultTextStyle(
                duration: context.motion.fast,
                style:
                    context.textTheme.labelMedium?.copyWith(
                      fontSize: context.fonts.xxs.sp,
                      color: color,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ) ??
                    const TextStyle(),
                child: Text(
                  tab.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

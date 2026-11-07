import 'package:booknow_mobile/widgets/buttons/app_back_button.dart';
import 'package:flutter/material.dart';

/// The standard app bar: a title, an optional back button, optional actions.
///
/// [onBack] is taken rather than assumed so a screen can intercept the gesture
/// — confirming before abandoning a booking mid-payment, for example.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBack = true,
    this.onBack,
    this.backTooltip,
    this.backgroundColor,
    this.bottom,
  });

  final String? title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;

  /// Accessible name for the back control. Required by the design's
  /// accessibility rules whenever [showBack] is true and a screen reader would
  /// otherwise announce an unlabelled button.
  final String? backTooltip;

  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(60 + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      title: title == null ? null : Text(title!),
      toolbarHeight: 60,
      leadingWidth: 68,
      titleSpacing: showBack && (canPop || onBack != null) ? 0 : 16,
      backgroundColor: backgroundColor,
      actions: actions,
      bottom: bottom,
      automaticallyImplyLeading: false,
      leading: showBack && (canPop || onBack != null)
          ? Center(
              child: AppBackButton(tooltip: backTooltip, onPressed: onBack),
            )
          : null,
    );
  }
}

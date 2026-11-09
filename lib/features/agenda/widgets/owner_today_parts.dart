import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The navy bar an owner's tab opens with. It paints behind the status bar, so
/// the screen holding it turns the scaffold's safe area off.
class OwnerHeader extends StatelessWidget {
  const OwnerHeader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.headerColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          context.mediaQuery.padding.top + 12.h,
          16.w,
          12.h,
        ),
        child: switch (OwnerHeaderExtra._of(context)) {
          null => child,
          final extra => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              child,
              SizedBox(height: 12.h),
              extra,
            ],
          ),
        },
      ),
    );
  }
}

/// Something every [OwnerHeader] under it shows below its own content.
class OwnerHeaderExtra extends InheritedWidget {
  const OwnerHeaderExtra({
    super.key,
    required this.extra,
    required super.child,
  });

  final Widget extra;

  static Widget? _of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OwnerHeaderExtra>()?.extra;

  @override
  bool updateShouldNotify(OwnerHeaderExtra old) => old.extra != extra;
}

/// A title and a line of facts, for the top of [OwnerHeader].
class OwnerHeaderTitle extends StatelessWidget {
  const OwnerHeaderTitle({
    super.key,
    required this.title,
    required this.line,
    this.trailing,
  });

  final String title;
  final String line;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.19,
                  color: context.onHeaderColor,
                ),
              ),
              Text(
                line,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.headerSoftColor,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: context.spacing.md.w),
          trailing!,
        ],
      ],
    );
  }
}

/// One chair: who is in it, how it is going, and the one thing to do next.
class TodayChairCard extends StatelessWidget {
  const TodayChairCard({
    super.key,
    required this.initial,
    required this.overline,
    required this.title,
    this.meta,
    this.metaColor,
    this.progress,
    this.progressColor,
    this.actions,
    this.footer,
  });

  final String initial;
  final String overline;
  final String title;

  /// "until 15:30", "6 min over plan".
  final String? meta;
  final Color? metaColor;

  /// How far through the service, zero to one.
  final double? progress;
  final Color? progressColor;
  final Widget? actions;

  /// What is next for this chair, under the buttons.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: context.decorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  initial,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.primary,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overline,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: context.fonts.xxs.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              if (meta case final meta?) ...[
                SizedBox(width: 10.w),
                Text(
                  meta,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: metaColor ?? scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
          if (progress case final progress?) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: scheme.surfaceContainerHighest,
                color: progressColor ?? scheme.secondary,
              ),
            ),
          ],
          if (actions case final actions?) ...[
            const SizedBox(height: 12),
            actions,
          ],
          ?footer,
        ],
      ),
    );
  }
}

/// The button on a chair card: navy to finish, teal to start something.
class TodayActionButton extends StatelessWidget {
  const TodayActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.navy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool navy;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final background = navy ? scheme.primary : scheme.secondary;
    final foreground = navy ? scheme.onPrimary : scheme.onSecondary;

    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(50.h),
        backgroundColor: background,
        foregroundColor: foreground,
        disabledBackgroundColor: scheme.surfaceContainerHighest,
        disabledForegroundColor: scheme.onSurfaceVariant,
        textStyle: context.textTheme.labelLarge,
        shape: RoundedRectangleBorder(borderRadius: context.radii.mdR),
      ),
      child: isLoading
          ? SizedBox.square(
              dimension: 22.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: background,
              ),
            )
          : Text(label),
    );
  }
}

/// One person still to come: a place or a time, a name, and what they are.
class TodayRow extends StatelessWidget {
  const TodayRow({
    super.key,
    required this.lead,
    required this.leadAmber,
    required this.name,
    required this.line,
    required this.tag,
    required this.tagTint,
    required this.onTap,
  });

  final String lead;
  final bool leadAmber;
  final String name;
  final String line;
  final String tag;
  final StatusTint tagTint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.mdR,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minHeight: 60.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              SizedBox(
                width: 52.w,
                child: Text(
                  lead,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: context.fonts.s.sp,
                    fontWeight: FontWeight.w800,
                    color: leadAmber
                        ? context.status.pending.foreground
                        : scheme.primary,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: context.fonts.s.sp,
                      ),
                    ),
                    Text(
                      line,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagTint.background,
                  borderRadius: context.radii.smR,
                ),
                child: Text(
                  tag,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: context.fonts.xxs.sp,
                    fontWeight: FontWeight.w700,
                    color: tagTint.foreground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Runs [onShown] whenever the owner comes back to this tab.
///
/// Tabs stay alive while hidden, so what the owner did on one would otherwise
/// not show on another until the next launch.
class RefreshWhenShown extends StatefulWidget {
  const RefreshWhenShown({
    super.key,
    required this.routeName,
    required this.onShown,
    required this.child,
  });

  final String routeName;
  final VoidCallback onShown;
  final Widget child;

  @override
  State<RefreshWhenShown> createState() => _RefreshWhenShownState();
}

class _RefreshWhenShownState extends State<RefreshWhenShown> {
  TabsRouter? _tabs;
  bool _wasShown = true;

  bool get _isShown => _tabs?.current.name == widget.routeName;

  void _onTabChange() {
    final shown = _isShown;
    if (shown && !_wasShown) widget.onShown();
    _wasShown = shown;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tabs = AutoTabsRouter.of(context);
    if (identical(tabs, _tabs)) return;

    _tabs?.removeListener(_onTabChange);
    _tabs = tabs..addListener(_onTabChange);
    _wasShown = _isShown;
  }

  @override
  void dispose() {
    _tabs?.removeListener(_onTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

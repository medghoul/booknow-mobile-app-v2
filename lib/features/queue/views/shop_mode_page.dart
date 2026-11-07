import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/features/queue/cubit/shop_mode_notifier.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// What a mode is called.
String shopModeName(BuildContext context, ShopMode mode) {
  final t = context.t.queue.mode;
  return switch (mode) {
    ShopMode.booking => t.booking,
    ShopMode.queue => t.queue,
    ShopMode.both => t.both,
  };
}

/// "Come lavori": bookings, a live queue, or both (queue spec §3).
///
/// The server decides whether a switch is allowed — it is refused while it
/// would strand paying customers — so the page only shows the choice and says
/// plainly when the answer is "not yet".
@RoutePage()
class ShopModePage extends StatefulWidget {
  const ShopModePage({super.key, required this.current});

  /// The mode the shop is in now, from the profile that opened this page.
  final ShopMode current;

  @override
  State<ShopModePage> createState() => _ShopModePageState();
}

class _ShopModePageState extends State<ShopModePage> {
  late ShopMode _selected = widget.current;
  bool _saving = false;
  bool _blocked = false;

  Future<void> _save() async {
    if (_selected == widget.current) {
      await context.router.maybePop(false);
      return;
    }

    setState(() {
      _saving = true;
      _blocked = false;
    });

    final result = await di<QueueRepository>().setMode(_selected);
    if (!mounted) return;

    switch (result) {
      case Success<Shop>(:final data):
        di<ShopModeNotifier>().value = data.mode;
        AppSnackBar.success(context, context.t.queue.mode.saved);
        await context.router.maybePop(true);
      case Failure<Shop>(:final error):
        setState(() {
          _saving = false;
          _blocked = error.code == ApiErrorCode.modeChangeBlocked;
        });
        if (!_blocked) AppSnackBar.error(context, error.localized(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.queue.mode;

    return AppScaffold(
      appBar: AppAppBar(title: t.row),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: context.spacing.lg.h),
                Text(
                  t.lead,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.spacing.lg.h),
                for (final (mode, icon, title, body) in [
                  (
                    ShopMode.booking,
                    Icons.calendar_month_outlined,
                    t.booking,
                    t.bookingBody,
                  ),
                  (ShopMode.queue, Icons.groups_outlined, t.queue, t.queueBody),
                  (ShopMode.both, Icons.call_split_rounded, t.both, t.bothBody),
                ]) ...[
                  _ModeOption(
                    icon: icon,
                    title: title,
                    body: body,
                    selected: _selected == mode,
                    onTap: () => setState(() {
                      _selected = mode;
                      _blocked = false;
                    }),
                  ),
                  SizedBox(height: context.spacing.md.h),
                ],
                if (_blocked) ...[
                  Container(
                    padding: EdgeInsets.all(context.spacing.lg.w),
                    decoration: BoxDecoration(
                      color: context.status.warning.background,
                      borderRadius: context.radii.lgR,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: context.status.warning.foreground,
                        ),
                        SizedBox(width: context.spacing.md.w),
                        Expanded(
                          child: Text(
                            t.blocked,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.status.warning.foreground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          AppElevatedButton(
            label: t.save,
            expand: true,
            isLoading: _saving,
            isDisabled: _blocked,
            onPressed: _save,
          ),
          SizedBox(height: context.spacing.lg.h),
        ],
      ),
    );
  }
}

/// One way of working: an icon, what it means, and whether it is chosen.
class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.icon,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.lgR,
          side: BorderSide(
            color: selected ? scheme.secondary : scheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(context.spacing.lg.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? scheme.surface : scheme.primaryContainer,
                    borderRadius: context.radii.mdR,
                  ),
                  child: Icon(icon, size: 24.w, color: scheme.primary),
                ),
                SizedBox(width: context.spacing.md.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.textTheme.titleSmall),
                      SizedBox(height: context.spacing.xxs.h),
                      Text(
                        body,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.spacing.sm.w),
                AnimatedContainer(
                  duration: context.motion.fast,
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? scheme.secondary : scheme.outline,
                      width: selected ? 7 : 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

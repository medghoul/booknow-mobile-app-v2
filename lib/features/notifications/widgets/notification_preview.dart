import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A mock push notification, shown as an example of what the app would send.
///
/// Concrete examples rather than a promise: "ogni nuova prenotazione" is a
/// claim, whereas a card reading "Marco R. · Taglio uomo · sab 3 ott" is the
/// thing itself, and it is what makes the permission worth granting.
class NotificationPreview extends StatelessWidget {
  const NotificationPreview({
    super.key,
    required this.title,
    required this.body,
    required this.when,
    this.isMuted = false,
  });

  final String title;
  final String body;

  /// "ora", "8 min fa" — relative, because a fixed clock time in a mock reads
  /// as stale the moment you look at it twice.
  final String when;

  /// The second card sits behind the first and is dimmed, so the pair reads as
  /// a stack of arriving notifications rather than two equal items.
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final foreground = isMuted
        ? context.colorScheme.onSurfaceVariant
        : context.colorScheme.onSurface;

    return Container(
      padding: EdgeInsets.all(context.spacing.md.w),
      decoration: BoxDecoration(
        color: isMuted
            ? context.colorScheme.surface
            : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.radii.xl.r),
        boxShadow: isMuted ? null : context.shadows.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBrandMark(size: context.icons.l.w),
          SizedBox(width: context.spacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: foreground,
                        ),
                      ),
                    ),
                    SizedBox(width: context.spacing.sm.w),
                    Text(
                      when,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spacing.xxs.h),
                Text(
                  body,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: isMuted
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One line of "what you'll be told", with a tick.
class NotificationPoint extends StatelessWidget {
  const NotificationPoint(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.md.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            size: context.icons.s.w,
            color: context.colorScheme.onSurface,
          ),
          SizedBox(width: context.spacing.md.w),
          Expanded(child: Text(text, style: context.textTheme.labelLarge)),
        ],
      ),
    );
  }
}

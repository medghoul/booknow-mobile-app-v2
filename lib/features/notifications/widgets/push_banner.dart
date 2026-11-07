import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A push that arrived while the app was open and in front.
///
/// The operating system shows nothing in that case, so this is the whole
/// notification: the mark, the title and one line of body. It reads as the
/// same object the lock screen would have shown — the design draws the two
/// the same way, which is why this and [NotificationPreview] share a shape.
///
/// One line, not two: the body is a summary ("Marco · Taglio uomo · sab 3
/// ott, 10:30") and the screen underneath is what the user was doing. A
/// banner that grows to three lines over the top of it is an interruption
/// rather than a notice.
class PushBanner extends StatelessWidget {
  const PushBanner({
    super.key,
    required this.title,
    this.body,
    this.onTap,
    this.onDismissed,
  });

  final String title;
  final String? body;

  /// Opens what the push is about. Null for a push this build has no screen
  /// for — an unknown type still shows, it just does not lead anywhere.
  final VoidCallback? onTap;

  /// Swiped away. Up, the direction it came from, which is how both platforms
  /// dismiss their own banners.
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    final banner = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.radii.xl.r),
        child: Container(
          padding: EdgeInsets.all(context.spacing.md.w),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(context.radii.xl.r),
            boxShadow: context.shadows.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBrandMark(size: context.icons.l.w),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelLarge,
                    ),
                    if (body != null && body!.isNotEmpty) ...[
                      SizedBox(height: context.spacing.xxs.h),
                      Text(
                        body!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg.w),
        child: Dismissible(
          // Keyed by the copy rather than by a counter: two identical pushes
          // in a row are the same notice, and a key that changes under a
          // `Dismissible` mid-drag loses the gesture.
          key: ValueKey('push-banner-$title-$body'),
          direction: DismissDirection.up,
          onDismissed: (_) => onDismissed?.call(),
          child: banner,
        ),
      ),
    );
  }
}

import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The active queue card at the top of the home: the shop, the wait and the
/// place in line, one tap from the line itself.
class QueueHomeCard extends StatelessWidget {
  const QueueHomeCard({super.key, required this.entry, required this.onOpen});

  final QueueEntry entry;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = context.colorScheme;
    final called = entry.status == QueueEntryStatus.called;
    final color = called
        ? context.queueColors.yourTurn
        : context.queueColors.waiting;
    final inkColor = called
        ? context.status.arrived.foreground
        : context.status.pending.foreground;
    final estimate = entry.estimate;
    final position = entry.position;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.lgR,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.lg.w,
            vertical: 14.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: context.spacing.sm.w),
                  Expanded(
                    child: Text(
                      (called ? t.queue.turnTitle : t.home.inQueue)
                          .toUpperCase(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: inkColor,
                      ),
                    ),
                  ),
                  Text(
                    t.home.view,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 14.sp,
                      color: scheme.secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.spacing.md.h),
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: context.radii.mdR,
                    ),
                    child: CategoryPicture(
                      category: ShopCategory.barber,
                      size: 36.w,
                    ),
                  ),
                  SizedBox(width: context.spacing.md.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.shopName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleSmall,
                        ),
                        Text(
                          [
                            entry.serviceName,
                            if (estimate != null && !called)
                              t.queue.range(
                                from: estimate.fromMin,
                                to: estimate.toMin,
                              ),
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (position != null) ...[
                    SizedBox(width: context.spacing.md.w),
                    Column(
                      children: [
                        Text(
                          t.queue.position(n: position),
                          style: context.textTheme.displayMedium?.copyWith(
                            fontSize: 28.sp,
                            height: 1,
                            color: scheme.primary,
                          ),
                        ),
                        Text(
                          t.home.inLine,
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: context.fonts.xxs.sp,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              SizedBox(height: context.spacing.md.h),
              ClipRRect(
                borderRadius: context.radii.xsR,
                child: LinearProgressIndicator(
                  // The API gives a place, not where the customer started from,
                  // so the bar fills as the place nears the front.
                  value: called || position == null ? 1 : 1 / position,
                  minHeight: 8.h,
                  color: color,
                  backgroundColor: scheme.surfaceContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

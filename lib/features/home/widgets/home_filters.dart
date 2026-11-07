import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// When the customer wants to be seen. Decides what the feed shows and how it
/// is ranked, so it reorganises the list rather than merely filtering it.
enum HomeIntent { now, today, tomorrow }

/// The shops for a [city], a [category] and an [intent], in order.
///
/// A shop with no category yet stays in every category's list: the API does
/// not send one today, and hiding every shop would be worse than showing them
/// with the notice the feed puts above them.
List<ShopSummary> visibleShops(
  List<ShopSummary> shops, {
  String? city,
  ShopCategory? category,
  HomeIntent intent = HomeIntent.today,
  Map<String, ShopQueue> queues = const {},
  Map<String, FreeSlot> nextSlots = const {},
}) {
  bool matches(ShopSummary shop) =>
      (city == null || shop.city == city) &&
      (category == null ||
          shop.category == null ||
          shop.category == category.asset);

  final list = shops.where(matches).toList();

  switch (intent) {
    case HomeIntent.now:
      // Who can see you now: the lines taking people, shortest wait first. A
      // line not read yet stays in, last, until its numbers arrive.
      int wait(ShopSummary shop) =>
          queues[shop.id]?.estimate.fromMin ?? 1 << 30;
      return list
          .where(
            (shop) =>
                shop.mode.runsQueue && (queues[shop.id]?.isAccepting ?? true),
          )
          .toList()
        ..sort((a, b) => wait(a).compareTo(wait(b)));
    case HomeIntent.today:
      // Soonest time first; a shop with no known time keeps its place after.
      int next(ShopSummary shop) =>
          nextSlots[shop.id]?.startUtc.millisecondsSinceEpoch ?? 1 << 62;
      return list..sort((a, b) => next(a).compareTo(next(b)));
    case HomeIntent.tomorrow:
      // A queue exists only today, so tomorrow is the shops you can book.
      return list.where((shop) => shop.mode.takesBookings).toList();
  }
}

/// The earliest free time of each shop, from the home's slots.
Map<String, FreeSlot> firstSlots(List<FreeSlot> slots) {
  final first = <String, FreeSlot>{};
  for (final slot in slots) {
    final known = first[slot.shopId];
    if (known == null || slot.startUtc.isBefore(known.startUtc)) {
      first[slot.shopId] = slot;
    }
  }
  return first;
}

/// The three-way switch, with a thumb that slides between its options.
class IntentSwitch extends StatelessWidget {
  const IntentSwitch({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final HomeIntent selected;
  final ValueChanged<HomeIntent> onSelected;

  @override
  Widget build(BuildContext context) {
    final t = context.t.home;
    final scheme = context.colorScheme;
    final labels = {
      HomeIntent.now: t.intentNow,
      HomeIntent.today: t.today,
      HomeIntent.tomorrow: t.intentTomorrow,
    };

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: context.radii.mdR,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth / HomeIntent.values.length;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: context.motion.normal,
                curve: context.motion.curveEmphasized,
                left: width * selected.index,
                top: 0,
                bottom: 0,
                width: width,
                child: Container(
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(9.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F2A4A).withValues(alpha: 0.14),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  for (final intent in HomeIntent.values)
                    Expanded(
                      child: Semantics(
                        button: true,
                        selected: intent == selected,
                        child: InkWell(
                          onTap: () => onSelected(intent),
                          borderRadius: BorderRadius.circular(9.r),
                          child: SizedBox(
                            height: 44,
                            child: Center(
                              child: Text(
                                labels[intent]!,
                                style: context.textTheme.labelMedium?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: intent == selected
                                      ? scheme.onSurface
                                      : scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

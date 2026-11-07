import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The navy Discover header: a live headline, the search bar and the categories.
///
/// Scrolling shrinks it instead of hiding it: the headline goes, the bar gets
/// shorter and the categories drop their labels, so switching category stays
/// one tap from anywhere in the list. It paints behind the status bar itself.
class HomeHeader extends StatelessWidget {
  /// All first, then each category. Null is All.
  static final List<ShopCategory?> _items = [
    null,
    ...ShopCategory.values.where((item) => item != ShopCategory.more),
  ];

  const HomeHeader({
    super.key,
    required this.greeting,
    required this.headline,
    required this.mini,
    required this.category,
    required this.location,
    required this.onCategory,
    required this.onClearCategory,
    required this.onLocation,
    required this.onSearch,
    this.counts,
  });

  final String greeting;

  /// The live sentence: "5 shops can see you now".
  final String headline;
  final bool mini;

  /// Null means every category.
  final ShopCategory? category;
  final String location;
  final ValueChanged<ShopCategory> onCategory;
  final VoidCallback onClearCategory;
  final VoidCallback onLocation;
  final VoidCallback onSearch;

  /// How many shops each category would show. Null while shops carry no
  /// category, when a number would say nothing.
  final Map<ShopCategory, int>? counts;

  @override
  Widget build(BuildContext context) {
    final duration = context.motion.normal;
    final curve = context.motion.curveEmphasized;

    return Material(
      color: context.headerColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.mediaQuery.padding.top + 12.h,
          bottom: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedSize(
              duration: duration,
              curve: curve,
              child: mini
                  ? const SizedBox(width: double.infinity)
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                        context.spacing.lg.w,
                        0,
                        context.spacing.lg.w,
                        10.h,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: '$greeting. ',
                          children: [
                            TextSpan(
                              text: headline,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.onHeaderColor,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.headerSoftColor,
                          height: 1.2,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
              child: _SearchBar(
                height: mini ? 44.h : 50.h,
                category: category,
                location: location,
                onSearch: onSearch,
                onClearCategory: onClearCategory,
                onLocation: onLocation,
              ),
            ),
            SizedBox(height: 12.h),
            ShaderMask(
              // The row runs off the screen, so it fades rather than cuts.
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.black, Colors.black, Colors.transparent],
                stops: [0, 0.88, 1],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: EdgeInsets.symmetric(horizontal: context.spacing.md.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (index, item) in _items.indexed)
                      _CategoryItem(
                        category: item,
                        place: index,
                        selected: item == category,
                        mini: mini,
                        count: item == null ? null : counts?[item],
                        onTap: (itemContext) {
                          HapticFeedback.selectionClick();
                          Scrollable.ensureVisible(
                            itemContext,
                            alignment: 0.5,
                            duration: duration,
                            curve: curve,
                          );
                          item == null ? onClearCategory() : onCategory(item);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.height,
    required this.category,
    required this.location,
    required this.onSearch,
    required this.onClearCategory,
    required this.onLocation,
  });

  final double height;
  final ShopCategory? category;
  final String location;
  final VoidCallback onSearch;
  final VoidCallback onClearCategory;
  final VoidCallback onLocation;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final picked = category;

    return AnimatedContainer(
      duration: context.motion.normal,
      curve: context.motion.curveEmphasized,
      height: height,
      child: Material(
        color: context.colorScheme.surface,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(
              child: Semantics(
                button: true,
                label: t.home.searchHint,
                excludeSemantics: true,
                child: InkWell(
                  onTap: onSearch,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.spacing.lg.w,
                      right: context.spacing.sm.w,
                    ),
                    child: Row(
                      children: [
                        AppLineIcon(
                          AppLineIcons.search,
                          color: context.colorScheme.onSurface,
                          strokeWidth: 2.25,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            picked?.label(t) ?? t.home.searchHint,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyMedium?.copyWith(
                              height: 1.2,
                              fontWeight: picked == null
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: picked == null
                                  ? context.colorScheme.onSurfaceVariant
                                  : context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (picked != null)
              IconButton(
                onPressed: onClearCategory,
                tooltip: t.home.clearCategory,
                icon: AppLineIcon(
                  AppLineIcons.close,
                  size: 14,
                  color: context.colorScheme.onSurfaceVariant,
                  strokeWidth: 2.5,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: context.colorScheme.surfaceContainer,
                  foregroundColor: context.colorScheme.onSurfaceVariant,
                  minimumSize: Size.square(32.w),
                ),
              ),
            Container(
              width: 1,
              height: 24.h,
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              color: context.colorScheme.outline,
            ),
            InkWell(
              onTap: onLocation,
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.spacing.xs.w,
                  right: 14.w,
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppLineIcon(
                        AppLineIcons.pin,
                        size: 16,
                        color: context.colorScheme.onSurface,
                      ),
                      SizedBox(width: context.spacing.xs.w),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 96.w),
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.category,
    required this.place,
    required this.selected,
    required this.mini,
    required this.count,
    required this.onTap,
  });

  /// Null is All.
  final ShopCategory? category;
  final int place;
  final bool selected;
  final bool mini;
  final int? count;
  final ValueChanged<BuildContext> onTap;

  @override
  Widget build(BuildContext context) {
    final duration = context.motion.normal;
    final curve = context.motion.curveEmphasized;
    final blobW = mini ? 44.0.w : 56.0.w;
    final blobH = mini ? 40.0.w : 52.0.w;
    final label = category?.label(context.t) ?? context.t.home.all;
    final count = this.count;
    final none = count == 0 && !selected;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: () => onTap(context),
        borderRadius: context.radii.mdR,
        child: AnimatedOpacity(
          duration: duration,
          opacity: none ? 0.5 : 1,
          child: AnimatedContainer(
            duration: duration,
            curve: curve,
            width: mini ? 54.w : 72.w,
            padding: const EdgeInsets.only(top: 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedContainer(
                      duration: duration,
                      curve: curve,
                      width: blobW,
                      height: blobH,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? context.colorScheme.surface
                            : Colors.white.withValues(alpha: 0.14),
                        borderRadius: blobRadiusAt(place, blobW, blobH),
                        boxShadow: selected
                            ? const [
                                BoxShadow(
                                  color: AppColors.mintRing,
                                  spreadRadius: 3,
                                ),
                              ]
                            : null,
                      ),
                      child: AnimatedScale(
                        // The bounce on selection: a step past full size, then
                        // back.
                        scale: selected ? 1.08 : 1,
                        duration: duration,
                        curve: Curves.elasticOut,
                        child: CategoryPicture(
                          category: category ?? ShopCategory.more,
                          size: mini ? 30.w : 40.w,
                        ),
                      ),
                    ),
                    if (!mini && !selected && count != null && count > 0)
                      Positioned(
                        top: -4,
                        right: -5,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.mintRing,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: context.headerColor,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              color: Color(0xFF042F2E),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                AnimatedSize(
                  duration: duration,
                  curve: curve,
                  child: mini
                      ? const SizedBox(width: double.infinity)
                      : Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium?.copyWith(
                              fontSize: context.fonts.xxs.sp,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: selected
                                  ? context.onHeaderColor
                                  : context.headerSoftColor,
                            ),
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

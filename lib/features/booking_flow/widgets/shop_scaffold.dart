import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/features/home/widgets/shop_summary_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/feedback/app_tick.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Marks everything under it as an owner previewing their own shop: the screen
/// is the customer's, but nothing on it can be booked or paid for.
class ShopPreview extends InheritedWidget {
  const ShopPreview({
    super.key,
    required this.enabled,
    this.category,
    this.distanceMeters,
    required super.child,
  });

  final bool enabled;

  /// What the card that opened the shop already knew.
  final ShopCategory? category;
  final int? distanceMeters;

  static ShopPreview? _find(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ShopPreview>();

  static bool of(BuildContext context) => _find(context)?.enabled ?? false;

  @override
  bool updateShouldNotify(ShopPreview old) =>
      old.enabled != enabled ||
      old.category != category ||
      old.distanceMeters != distanceMeters;
}

/// Lets a shop taking both switch between its times and its line.
class ShopWayScope extends InheritedWidget {
  const ShopWayScope({
    super.key,
    required this.showing,
    required this.onChanged,
    required super.child,
  });

  final ShopMode showing;
  final ValueChanged<ShopMode> onChanged;

  @override
  bool updateShouldNotify(ShopWayScope old) =>
      old.showing != showing || old.onChanged != onChanged;
}

/// The one shop screen, whether it takes bookings or runs a queue.
///
/// A picture that drifts and shrinks as you scroll, the shop's facts, the
/// choices as [slivers], and a bar that always says what you have chosen and
/// what it costs. Past the picture a plain bar with the name fades in. Payment
/// rises over it as [overlay], so choosing and paying stay one screen.
class ShopScaffold extends StatefulWidget {
  const ShopScaffold({
    super.key,
    required this.shopId,
    required this.shop,
    required this.slivers,
    required this.bottomBar,
    this.overlay,
  });

  final String shopId;
  final Shop? shop;
  final List<Widget> slivers;
  final Widget bottomBar;
  final Widget? overlay;

  @override
  State<ShopScaffold> createState() => _ShopScaffoldState();
}

class _ShopScaffoldState extends State<ShopScaffold> {
  static const double _pictureHeight = 196;

  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  double get _offset => _scroll.hasClients ? _scroll.offset.clamp(0, 2000) : 0;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final shop = widget.shop;
    final hints = ShopPreview._find(context);
    final where = [
      ?shop?.address?.line,
      ?shopDistance(context, hints?.distanceMeters),
    ].join(' · ');
    final open = shop == null ? null : _openLine(context, shop);
    final top = context.mediaQuery.padding.top;
    final way = context.dependOnInheritedWidgetOfExactType<ShopWayScope>();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CustomScrollView(
                      controller: _scroll,
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: _pictureHeight + top,
                            child: Hero(
                              tag: shopPhotoTag(widget.shopId),
                              child: _Picture(
                                scroll: _scroll,
                                height: _pictureHeight,
                                url: shop?.photoUrl,
                                category: hints?.category,
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(16.w),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shop?.name ?? '',
                                  style: context.textTheme.displayMedium,
                                ),
                                if (where.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    where,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                                if (open != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    open.$1,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: open.$2
                                              ? context
                                                    .status
                                                    .arrived
                                                    .foreground
                                              : scheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        if (way != null && shop?.mode == ShopMode.both)
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                            sliver: SliverToBoxAdapter(
                              child: AppSegmentedControl<ShopMode>(
                                segments: [
                                  AppSegment(
                                    value: ShopMode.booking,
                                    label: context.t.home.bookTime,
                                  ),
                                  AppSegment(
                                    value: ShopMode.queue,
                                    label: context.t.home.joinLine,
                                  ),
                                ],
                                value: way.showing,
                                onChanged: way.onChanged,
                              ),
                            ),
                          ),
                        ...widget.slivers,
                        const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      ],
                    ),
                    Positioned(
                      top: top + 12,
                      left: 12,
                      child: AppBackButton(
                        tooltip: context.t.common.back,
                        raised: true,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _scroll,
                      builder: (context, _) {
                        final shown = _offset > 150;

                        return Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: IgnorePointer(
                            ignoring: !shown,
                            child: AnimatedOpacity(
                              opacity: shown ? 1 : 0,
                              duration: context.motion.fast,
                              child: Container(
                                height: 68 + top,
                                padding: EdgeInsets.only(
                                  top: top,
                                  left: 12,
                                  right: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: scheme.surface,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: scheme.outlineVariant,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    AppBackButton(
                                      tooltip: context.t.common.back,
                                      color: scheme.surfaceContainerHighest,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        shop?.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.textTheme.titleSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              widget.bottomBar,
            ],
          ),
          ?widget.overlay,
        ],
      ),
    );
  }

  /// "Open until 19:30", from the shop's hours in its own timezone, and whether
  /// that is good news.
  (String, bool)? _openLine(BuildContext context, Shop shop) {
    final t = context.t.home;
    final wall = ShopClock.wallTime(DateTime.now().toUtc(), 'Europe/Rome');
    final ranges = shop.openingHours
        .rangesOn(Weekday.values[wall.weekday - 1])
        .where((range) => range.isValid)
        .toList();
    if (ranges.isEmpty) return (t.closedNow, false);

    String two(int n) => n.toString().padLeft(2, '0');
    final now = '${two(wall.hour)}:${two(wall.minute)}';

    for (final range in ranges) {
      if (now.compareTo(range.from) < 0) {
        return (t.closedUntil(time: range.from), false);
      }
      if (now.compareTo(range.to) < 0) {
        return (t.openUntil(time: range.to), true);
      }
    }
    return (t.closedNow, false);
  }
}

/// The photo, or a picture on a soft tint that drifts down and shrinks a little
/// as the screen scrolls over it.
class _Picture extends StatelessWidget {
  const _Picture({
    required this.scroll,
    required this.height,
    required this.url,
    required this.category,
  });

  final ScrollController scroll;
  final double height;
  final String? url;
  final ShopCategory? category;

  @override
  Widget build(BuildContext context) {
    final url = this.url;

    if (url != null) return ShopPhoto(url: url, category: category);

    return ColoredBox(
      color: context.colorScheme.primaryContainer,
      child: AnimatedBuilder(
        animation: scroll,
        builder: (context, child) {
          final y = (scroll.hasClients ? scroll.offset : 0.0).clamp(
            0.0,
            height,
          );

          return Transform.translate(
            offset: Offset(0, y * 0.35),
            child: Transform.scale(scale: 1 - y / height * 0.25, child: child),
          );
        },
        child: Center(
          child: CategoryPicture(
            category: category ?? ShopCategory.more,
            size: 128.w,
          ),
        ),
      ),
    );
  }
}

/// The bar under the choices: what you picked, what it costs, and the next step.
class ShopBottomBar extends StatelessWidget {
  const ShopBottomBar({
    super.key,
    required this.title,
    required this.line,
    required this.cta,
    required this.onPressed,
  });

  final String title;
  final String line;
  final String cta;

  /// Null while there is nothing to continue with.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final preview = ShopPreview.of(context);
    final title = preview ? context.t.shopScreen.previewTitle : this.title;
    final line = preview ? context.t.shopScreen.previewBody : this.line;
    final onPressed = preview ? null : this.onPressed;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.spacing.lg.w,
            10.h,
            context.spacing.lg.w,
            14.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: context.motion.fast,
                  layoutBuilder: (current, previous) => Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [...previous, ?current],
                  ),
                  child: Column(
                    key: ValueKey('$title$line'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        line,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: context.fonts.xxs.sp,
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              FilledButton(
                onPressed: onPressed,
                style: FilledButton.styleFrom(
                  minimumSize: Size(0, 50.h),
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  backgroundColor: scheme.secondary,
                  foregroundColor: scheme.onSecondary,
                  disabledBackgroundColor: scheme.surfaceContainerHighest,
                  disabledForegroundColor: scheme.onSurfaceVariant,
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: context.radii.mdR,
                  ),
                ),
                child: Text(cta),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A service to choose: a radio, its name and length, and its price.
class ServiceOption extends StatelessWidget {
  const ServiceOption({
    super.key,
    required this.service,
    required this.selected,
    required this.onTap,
  });

  final ShopService service;
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
          borderRadius: context.radii.mdR,
          side: BorderSide(
            color: selected ? scheme.secondary : scheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: BoxConstraints(minHeight: 60.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: context.motion.fast,
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? scheme.secondary : scheme.outline,
                      width: selected ? 6 : 2,
                    ),
                  ),
                ),
                SizedBox(width: context.spacing.md.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: context.fonts.s.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        context.t.queue.minutes(
                          minutes: service.durationMinutes,
                        ),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  Money.shortCents(service.priceCents),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: context.fonts.s.sp,
                    fontWeight: FontWeight.w800,
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

/// Payment rising over the shop screen: a scrim you can tap away and a sheet
/// that slides up from under the bar.
class PayPanel extends StatelessWidget {
  const PayPanel({super.key, required this.onDismiss, required this.children});

  /// Null while a payment is running: nothing may be closed under it.
  final VoidCallback? onDismiss;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: context.motion.normal,
      curve: context.motion.curveEmphasized,
      builder: (context, value, child) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: onDismiss,
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.45 * value),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionalTranslation(
              translation: Offset(0, 1 - value),
              child: child,
            ),
          ),
        ],
      ),
      child: Material(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10, 16.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.outline,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The two lines of money, in one outlined box: what is paid now and what is
/// paid at the shop are different things, and the box is where that is read.
class PayRows extends StatelessWidget {
  const PayRows({super.key, required this.rows});

  final List<PayRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: context.radii.lgR,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          for (final (index, row) in rows.indexed) ...[
            if (index > 0) const AppDivider(),
            row,
          ],
        ],
      ),
    );
  }
}

/// One line of money: what it is, when it is paid, how much.
class PayRow extends StatelessWidget {
  const PayRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.strong = false,
  });

  final String title;
  final String subtitle;
  final String amount;

  /// The money moving now.
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 52.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: context.fonts.xxs.sp,
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: strong
                ? context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  )
                : context.textTheme.labelMedium?.copyWith(
                    fontSize: context.fonts.s.sp,
                    fontWeight: FontWeight.w700,
                  ),
          ),
        ],
      ),
    );
  }
}

/// The amber "Held for you for 9:12".
class HoldPill extends StatelessWidget {
  const HoldPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final tint = context.status.pending;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: tint.background,
          borderRadius: context.radii.smR,
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            fontSize: context.fonts.xxs.sp,
            fontWeight: FontWeight.w700,
            color: tint.foreground,
          ),
        ),
      ),
    );
  }
}

/// The red line under a card that did not go through.
class PayDeclined extends StatelessWidget {
  const PayDeclined({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final tint = context.status.error;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.mdR,
      ),
      child: Text(
        message,
        style: context.textTheme.labelMedium?.copyWith(
          fontSize: 14.sp,
          color: tint.foreground,
        ),
      ),
    );
  }
}

/// The teal button that spends the money, with the spinner while it runs.
class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.label,
    required this.busyLabel,
    required this.busy,
    required this.onPressed,
  });

  final String label;
  final String busyLabel;
  final bool busy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return FilledButton(
      onPressed: busy ? () {} : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(52.h),
        backgroundColor: scheme.secondary,
        foregroundColor: scheme.onSecondary,
        textStyle: context.textTheme.labelLarge,
        shape: RoundedRectangleBorder(borderRadius: context.radii.mdR),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (busy) ...[
            SizedBox.square(
              dimension: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: scheme.onSecondary,
              ),
            ),
            SizedBox(width: 10.w),
          ],
          Text(busy ? busyLabel : label),
        ],
      ),
    );
  }
}

/// The moment it is done, in the sheet: the tick, then the screen gives way.
class PayDone extends StatelessWidget {
  const PayDone({super.key, required this.title, required this.line});

  final String title;
  final String line;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 260.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppTick(),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          Text(
            line,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

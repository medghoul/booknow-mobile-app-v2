import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/services/clock/shop_clock.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The swipeable three weeks, with each day's booking count under its number.
///
/// Edge to edge, so the strip runs off both sides of the screen the way a
/// scrollable thing should. The count is why the whole window comes down with
/// the day: the owner reading "Tuesday, 3" decides where to look next without
/// a request per card.
class AgendaDateStrip extends StatefulWidget {
  const AgendaDateStrip({
    super.key,
    required this.days,
    required this.selected,
    required this.onSelected,
    this.today,
  });

  /// The date that is labelled Today.
  final String? today;

  final List<AgendaStripDay> days;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<AgendaDateStrip> createState() => _AgendaDateStripState();
}

class _AgendaDateStripState extends State<AgendaDateStrip> {
  final ScrollController _controller = ScrollController();

  /// Frames left to wait for the strip to be measured before giving up on
  /// scrolling it; a strip that stays hidden simply opens at the start.
  int _waitFrames = 10;

  @override
  void initState() {
    super.initState();
    // The window reaches a week back, so the chosen day starts off screen.
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelected());
  }

  @override
  void didUpdateWidget(AgendaDateStrip old) {
    super.didUpdateWidget(old);
    if (old.selected != widget.selected) _revealSelected();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Scrolls the chosen day into view, a card and a half from the left edge so
  /// the days before it stay visibly there to swipe back to.
  void _revealSelected() {
    if (!mounted || !_controller.hasClients) return;

    // Attached is not laid out: a strip built inside a tab that is not on
    // screen yet has a position but no extent, and reading
    // `maxScrollExtent` then throws. Try again once it has been measured.
    if (!_controller.position.hasContentDimensions) {
      if (_waitFrames-- > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelected());
      }
      return;
    }
    _waitFrames = 10;

    final index = widget.days.indexWhere((day) => day.date == widget.selected);
    if (index < 0) return;

    final card = 56.w + context.spacing.sm.w;
    final target = (index * card - card * 1.5).clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );

    _controller.animateTo(
      target,
      duration: context.motion.normal,
      curve: context.motion.curveEmphasized,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
      child: Row(
        children: [
          for (final day in widget.days) ...[
            _StripCard(
              day: day,
              isSelected: day.date == widget.selected,
              isToday: day.date == widget.today,
              onTap: () => widget.onSelected(day.date),
            ),
            if (day != widget.days.last) SizedBox(width: context.spacing.sm.w),
          ],
        ],
      ),
    );
  }
}

class _StripCard extends StatelessWidget {
  const _StripCard({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  final AgendaStripDay day;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final date = ShopClock.calendarDay(day.date);
    final scheme = context.colorScheme;
    final color = isSelected ? scheme.onSecondary : scheme.onSurface;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: isSelected ? scheme.secondary : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.mdR,
          side: isSelected
              ? BorderSide.none
              : BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 56.w,
            height: 66.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isToday
                      ? context.t.home.today
                      : DateFormat.E(locale).format(date),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: context.fonts.xxs.sp,
                    color: color,
                  ),
                ),
                Text(
                  '${date.day}',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    letterSpacing: 0,
                    height: 1.2,
                    color: color,
                  ),
                ),
                Text(
                  day.closed ? context.t.agenda.closedShort : '${day.bookings}',
                  maxLines: 1,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: context.fonts.xxs.sp,
                    color: color.withValues(alpha: 0.85),
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

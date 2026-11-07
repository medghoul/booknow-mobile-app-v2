import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/dividers/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Slide one: a tinted disc with a slot chip floating over it.
///
/// The design has a washed photograph of a barber's chair here. Photography
/// isn't in the repo yet, so the disc stands in — and because it is content
/// inside a slide rather than a brand asset, a trade photograph is allowed to
/// replace it later.
class BookingArtwork extends StatelessWidget {
  const BookingArtwork({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      height: 290.w,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.decorations.blobWarm,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.xl.w),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.event_available_outlined,
                    size: context.icons.xxl.w,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: context.spacing.xxs.w,
            bottom: context.spacing.lg.h,
            child: _FloatingChip(label: 'sab · 10:30'),
          ),
        ],
      ),
    );
  }
}

/// Slide two: the two prices, the paid-in-shop one and the fee.
class PriceArtwork extends StatelessWidget {
  const PriceArtwork({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.onboarding.slideTwo;

    return SizedBox(
      width: 300.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PriceRow(
            title: t.serviceLabel,
            note: t.serviceNote,
            amount: t.serviceAmount,
          ),
          SizedBox(height: context.spacing.sm.h),
          _PlusDivider(label: t.plus),
          SizedBox(height: context.spacing.sm.h),
          _PriceRow(
            title: t.feeLabel,
            note: t.feeNote,
            amount: t.feeAmount,
            emphasised: true,
          ),
        ],
      ),
    );
  }
}

/// Slide three: the owner's agenda with a push notification over it.
class AgendaArtwork extends StatelessWidget {
  const AgendaArtwork({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.onboarding.slideThree;

    return SizedBox(
      width: 300.w,
      height: 250.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 14.h,
            child: Container(
              width: 214.w,
              height: 214.w,
              decoration: BoxDecoration(
                color: context.decorations.blobSage,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: context.spacing.xl.w,
            top: 0,
            child: _AgendaCard(
              kicker: t.agendaToday,
              bookedTime: t.agendaBookedTime,
              bookedName: t.agendaBookedName,
              freeTime: t.agendaFreeTime,
              freeLabel: t.agendaFree,
            ),
          ),
          Positioned(
            right: 0,
            bottom: context.spacing.xs.h,
            child: _PushToast(message: t.agendaPush),
          ),
        ],
      ),
    );
  }
}

class _FloatingChip extends StatelessWidget {
  const _FloatingChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.sm.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.radii.pillR,
        boxShadow: context.shadows.md,
      ),
      child: Text(label, style: context.textTheme.labelLarge),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.title,
    required this.note,
    required this.amount,
    this.emphasised = false,
  });

  final String title;
  final String note;
  final String amount;

  /// The fee — the part BookNow actually charges — is filled in the action
  /// colour so the two rows can't be confused.
  final bool emphasised;

  @override
  Widget build(BuildContext context) {
    final foreground = emphasised
        ? context.colorScheme.onPrimary
        : context.colorScheme.onSurface;
    final secondary = emphasised
        ? context.colorScheme.onPrimary.withValues(alpha: 0.82)
        : context.colorScheme.onSurfaceVariant;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.lg.h,
      ),
      decoration: BoxDecoration(
        color: emphasised
            ? context.colorScheme.primary
            : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.radii.xxl.r),
        boxShadow: emphasised ? context.shadows.md : context.shadows.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: foreground,
                  ),
                ),
                Text(
                  note,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.spacing.sm.w),
          Text(
            amount,
            style: context.textTheme.displayMedium?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlusDivider extends StatelessWidget {
  const _PlusDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(child: AppDivider());

    return Row(
      children: [
        line,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.sm.w),
          child: Text(
            label.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        line,
      ],
    );
  }
}

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({
    required this.kicker,
    required this.bookedTime,
    required this.bookedName,
    required this.freeTime,
    required this.freeLabel,
  });

  final String kicker;
  final String bookedTime;
  final String bookedName;
  final String freeTime;
  final String freeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      padding: EdgeInsets.all(context.spacing.lg.w),
      decoration: context.decorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            kicker.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          _AgendaRow(
            time: bookedTime,
            name: bookedName,
            tint: context.status.confirmed.foreground,
          ),
          SizedBox(height: context.spacing.lg.h),
          _AgendaRow(time: freeTime, name: freeLabel, muted: true),
        ],
      ),
    );
  }
}

class _AgendaRow extends StatelessWidget {
  const _AgendaRow({
    required this.time,
    required this.name,
    this.tint,
    this.muted = false,
  });

  final String time;
  final String name;
  final Color? tint;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final color = muted
        ? context.colorScheme.onSurfaceVariant
        : context.colorScheme.onSurface;

    return Row(
      children: [
        SizedBox(
          width: 52.w,
          child: Text(
            time,
            style: context.textTheme.titleSmall?.copyWith(color: color),
          ),
        ),
        SizedBox(width: context.spacing.sm.w),
        Expanded(
          child: Text(
            name,
            style: context.textTheme.labelLarge?.copyWith(color: color),
          ),
        ),
        if (tint != null)
          Container(
            width: context.spacing.sm.w + 3,
            height: context.spacing.sm.w + 3,
            decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          ),
      ],
    );
  }
}

class _PushToast extends StatelessWidget {
  const _PushToast({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    // The toast inverts against the page, the way a system notification does.
    final background = context.colorScheme.onSurface;
    final foreground = context.colorScheme.surface;

    return Container(
      width: 236.w,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.sm.h + 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radii.xlR,
        boxShadow: context.shadows.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_none,
            size: context.icons.s.w,
            color: foreground,
          ),
          SizedBox(width: context.spacing.sm.w),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.labelMedium?.copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}

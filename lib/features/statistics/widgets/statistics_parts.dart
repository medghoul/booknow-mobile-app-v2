import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// How a figure reads. A null is a dash: nothing to work it out from.
class StatFormat {
  StatFormat(BuildContext context)
    : _minutes = context.t.statistics.minutes,
      _number = NumberFormat('#,##0.#', _localeOf(context));

  static String _localeOf(BuildContext context) =>
      Localizations.localeOf(context).toString();

  final String Function({required Object value}) _minutes;
  final NumberFormat _number;

  static const String none = '–';

  String number(num? value) => value == null ? none : _number.format(value);

  String minutes(num? value) =>
      value == null ? none : _minutes(value: _number.format(value));

  String percent(num? value) =>
      value == null ? none : '${_number.format(value)}%';

  /// Whole euros: this is an estimate, so cents would claim too much.
  String money(int cents) => '€${_number.format((cents / 100).round())}';
}

/// One figure, opening the page that explains it.
class StatKpiCard extends StatelessWidget {
  const StatKpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.detail,
    required this.onTap,
  });

  final String label;
  final String value;
  final String detail;
  final VoidCallback onTap;

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
          constraints: BoxConstraints(minHeight: 112.h),
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.displaySmall?.copyWith(
                  color: scheme.onSurface,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                detail,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A card of rows on a detail page.
class StatCard extends StatelessWidget {
  const StatCard({super.key, this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: context.decorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title case final title?) ...[
            Text(title, style: context.textTheme.titleSmall),
            SizedBox(height: 10.h),
          ],
          ...children,
        ],
      ),
    );
  }
}

class StatRow extends StatelessWidget {
  const StatRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: context.fonts.s.sp,
            ),
          ),
        ],
      ),
    );
  }
}

/// Two bars on one scale: what really happened, and what the menu says.
class StatComparisonBars extends StatelessWidget {
  const StatComparisonBars({
    super.key,
    required this.realLabel,
    required this.real,
    required this.plannedLabel,
    required this.planned,
  });

  final String realLabel;
  final num? real;
  final String plannedLabel;
  final num? planned;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final format = StatFormat(context);
    final top = [real ?? 0, planned ?? 0].reduce((a, b) => a > b ? a : b);
    final isOver = real != null && planned != null && real! > planned!;

    Widget bar(String label, num? value, Color color) => Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          SizedBox(
            width: 58.w,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: top == 0 ? 0 : (value ?? 0) / top,
                minHeight: 10,
                backgroundColor: scheme.surfaceContainerHighest,
                color: color,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 58.w,
            child: Text(
              format.minutes(value),
              textAlign: TextAlign.end,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      children: [
        bar(
          realLabel,
          real,
          isOver ? context.status.pending.foreground : scheme.secondary,
        ),
        bar(plannedLabel, planned, scheme.primary),
      ],
    );
  }
}

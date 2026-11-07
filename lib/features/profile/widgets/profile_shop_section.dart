import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/extensions/weekday_extension.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/queue/views/shop_mode_page.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The owner's shop: the shop itself, its services, its hours, its rules.
///
/// Shown only to an owner, and only once they have a shop. A customer has no
/// such thing, and an owner mid-wizard has a draft — which still appears,
/// because this row is how they get back to finishing it.
class ProfileShopSection extends StatelessWidget {
  const ProfileShopSection({
    super.key,
    required this.shop,
    this.onOpenShop,
    this.onOpenServices,
    this.onOpenHours,
    this.onOpenTeam,
    this.onOpenBookingRules,
    this.onOpenMode,
    this.onPreview,
  });

  final Shop shop;
  final VoidCallback? onOpenShop;
  final VoidCallback? onOpenServices;
  final VoidCallback? onOpenHours;

  /// Who works in the shop (providers §9).
  final VoidCallback? onOpenTeam;
  final VoidCallback? onOpenBookingRules;

  /// "Come lavori": bookings or a live queue.
  final VoidCallback? onOpenMode;

  /// "See as customer".
  final VoidCallback? onPreview;

  /// "Via dei Coronari 18 · +39 06 6880 1234", dropping whichever half is
  /// missing rather than leaving a dangling separator.
  static String? detailsOf(Shop shop) {
    final parts = [
      shop.address?.line,
      shop.phone,
    ].where((part) => part != null && part.trim().isNotEmpty).cast<String>();

    return parts.isEmpty ? null : parts.join(' · ');
  }

  /// "Mar–Sab" when the open days run without a gap, otherwise each day named.
  ///
  /// A barber closed on Wednesday is not "Mar–Sab", and compressing it to one
  /// would be a lie about when the shop is open.
  static String? openDaysLabel(OpeningHours hours, Translations t) {
    final open = hours.openDays.toList();
    if (open.isEmpty) return null;

    final isContiguous =
        open.last.index - open.first.index == open.length - 1 &&
        open.length > 1;

    final first = open.first.shortName(t);
    if (isContiguous) return '$first–${open.last.shortName(t)}';

    return open.map((day) => day.shortName(t)).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    final services = shop.activeServices.length;
    final days = openDaysLabel(shop.openingHours, context.t);
    final team = shop.activeProviders.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _LiveCard(shop: shop, onPreview: onPreview),
        SizedBox(height: 18.h),
        AppSectionTitle(t.shopSection),
        SizedBox(height: context.spacing.sm.h),
        AppSettingsCard(
          children: [
            AppSettingsRow(
              icon: AppLineIcons.shop,
              label: shop.name ?? t.shopNameMissing,
              value: detailsOf(shop),
              onTap: onOpenShop,
            ),
            AppSettingsRow(
              icon: AppLineIcons.services,
              label: t.services,
              value: services == 0 ? null : t.servicesCount(n: services),
              onTap: onOpenServices,
            ),
            AppSettingsRow(
              icon: AppLineIcons.hours,
              label: t.hours,
              value: days ?? t.hoursNone,
              onTap: onOpenHours,
            ),
            if (onOpenTeam != null)
              AppSettingsRow(
                icon: AppLineIcons.person,
                label: t.team,
                value: team > 1 ? t.teamCount(n: team) : t.teamJustYou,
                onTap: onOpenTeam,
              ),
          ],
        ),
        SizedBox(height: 18.h),
        AppSectionTitle(t.howYouWork),
        SizedBox(height: context.spacing.sm.h),
        AppSettingsCard(
          children: [
            AppSettingsRow(
              icon: AppLineIcons.customers,
              label: t.modeRow,
              value: shopModeName(context, shop.mode),
              onTap: onOpenMode,
            ),
            // No screen for this yet, so no row that does nothing when tapped.
            if (onOpenBookingRules != null)
              AppSettingsRow(
                icon: AppLineIcons.help,
                label: t.bookingRules,
                onTap: onOpenBookingRules,
              ),
          ],
        ),
      ],
    );
  }
}

/// Whether customers can find the shop, and a way to see it as they do.
class _LiveCard extends StatelessWidget {
  const _LiveCard({required this.shop, this.onPreview});

  final Shop shop;
  final VoidCallback? onPreview;

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    final live = shop.status.isPublished;
    final tint = live ? context.status.arrived : context.status.pending;

    final where = [
      shop.name,
      shop.address?.line,
    ].whereType<String>().join(' · ');

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: tint.background,
        borderRadius: context.radii.lgR,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  live ? t.shopLive : t.shopHidden,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: context.fonts.s.sp,
                    color: tint.foreground,
                  ),
                ),
                if (where.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    where,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: tint.foreground,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onPreview != null) ...[
            SizedBox(width: context.spacing.md.w),
            SizedBox(
              height: 44,
              child: FilledButton(
                onPressed: onPreview,
                style: FilledButton.styleFrom(
                  backgroundColor: tint.foreground,
                  foregroundColor: tint.background,
                  minimumSize: const Size(0, 44),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Text(t.seeAsCustomer),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

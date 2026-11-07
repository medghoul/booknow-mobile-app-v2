import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_card.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The two notification switches: the reminder before a cut, and news from the
/// shop (hours, closures).
///
/// TODO(api): the switches only hold their value while the screen is alive.
/// `UserRepository` has no endpoint for notification preferences yet, so there
/// is nothing to save to. When it exists, take the initial values from the
/// profile and send each change from [_setReminder] / [_setShopNews].
class ProfileNotificationsSection extends StatefulWidget {
  const ProfileNotificationsSection({super.key});

  @override
  State<ProfileNotificationsSection> createState() =>
      _ProfileNotificationsSectionState();
}

class _ProfileNotificationsSectionState
    extends State<ProfileNotificationsSection> {
  bool _reminder = true;
  bool _shopNews = false;

  void _setReminder(bool value) => setState(() => _reminder = value);

  void _setShopNews(bool value) => setState(() => _shopNews = value);

  @override
  Widget build(BuildContext context) {
    final t = context.t.account;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionTitle(t.notificationsTitle),
        SizedBox(height: context.spacing.sm.h),
        ProfileCard(
          children: [
            ProfileRow(
              icon: Icons.notifications_none_rounded,
              title: t.reminderTitle,
              subtitle: t.reminderBody,
              trailing: Switch(value: _reminder, onChanged: _setReminder),
              onTap: () => _setReminder(!_reminder),
            ),
            ProfileRow(
              icon: Icons.mail_outline_rounded,
              title: t.shopNewsTitle,
              subtitle: t.shopNewsBody,
              trailing: Switch(value: _shopNews, onChanged: _setShopNews),
              onTap: () => _setShopNews(!_shopNews),
            ),
          ],
        ),
      ],
    );
  }
}

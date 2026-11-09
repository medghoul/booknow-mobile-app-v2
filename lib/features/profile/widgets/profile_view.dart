import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/reminder_lead.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_account_section.dart';
import 'package:booknow_mobile/features/profile/widgets/delete_account_sheet.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_appearance_section.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_identity_card.dart';
import 'package:booknow_mobile/features/profile/widgets/profile_shop_section.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The profile screen's content.
///
/// One view for both roles rather than two: the appearance controls and the
/// account rows are identical, and only the top of the screen differs.
/// Splitting it would duplicate three quarters of a screen to vary the other
/// quarter.
///
/// What differs is how much room the account has. An owner's screen is led by
/// the shop card, so the design compresses them into one line beside the
/// title; a customer's has nothing above it, so they get the identity card.
class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.user,
    this.provider,
    required this.notificationsEnabled,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.onSignOut,
    this.shop,
    this.isLoadingShop = false,
    this.onOpenPersonalData,
    this.onOpenShop,
    this.onOpenServices,
    this.onOpenHours,
    this.onOpenTeam,
    this.onOpenData,
    this.onOpenBookingRules,
    this.onOpenMode,
    this.onPreviewShop,
    this.onOpenNotifications,
    this.onOpenHelp,
    this.onDeleteAccount,
  });

  final UserProfile user;

  /// Which provider the session was opened with, named on the customer's
  /// identity card. Null when it is not known — see [ProfileIdentityCard].
  final AuthProviderKind? provider;

  /// The owner's shop, once it has loaded. Null for a customer, who never has
  /// one, and null for an owner while [isLoadingShop] is still true.
  final Shop? shop;
  final bool isLoadingShop;

  final bool? notificationsEnabled;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  final VoidCallback? onOpenPersonalData;
  final VoidCallback? onOpenShop;
  final VoidCallback? onOpenServices;
  final VoidCallback? onOpenHours;
  final VoidCallback? onOpenTeam;
  final VoidCallback? onOpenData;
  final VoidCallback? onOpenBookingRules;
  final VoidCallback? onOpenMode;
  final VoidCallback? onPreviewShop;
  final VoidCallback? onOpenNotifications;
  final VoidCallback? onOpenHelp;

  /// Called once the user has confirmed in the dialog, never before — see
  /// [onDeleteAccount] for why both of them are raised from here.
  final VoidCallback onSignOut;

  /// Called once the user has confirmed, never before: the sheet is raised
  /// from here rather than left to the caller, so there is no way to delete
  /// an account without having been told what that costs.
  final VoidCallback? onDeleteAccount;

  /// What this account loses, in the order the design lists them.
  ///
  /// Only an owner has a shop, and only a shop that exists can be lost — an
  /// owner still mid-wizard has a draft, which is still theirs.
  List<DeleteConsequence> deleteConsequences(BuildContext context) {
    final t = context.t.profile.deleteSheet;
    final shop = this.shop;
    final name = shop?.name?.trim();

    return [
      if (user.role == UserRole.owner && shop != null)
        if (name == null || name.isEmpty)
          DeleteConsequence.loss(t.shopLostUnnamed)
        else
          DeleteConsequence.loss(t.shopLost(name: name), emphasis: name),
      DeleteConsequence.loss(t.historyLost),
    ];
  }

  Future<void> _confirmDelete(
    BuildContext context,
    VoidCallback onDelete,
  ) async {
    final confirmed = await DeleteAccountSheet.confirm(
      context,
      consequences: deleteConsequences(context),
    );
    if (confirmed) onDelete();
  }

  Widget _shopSlot(BuildContext context) {
    final shop = this.shop;

    if (shop != null) {
      return ProfileShopSection(
        key: const ValueKey('shop'),
        shop: shop,
        onOpenShop: onOpenShop,
        onOpenServices: onOpenServices,
        onOpenHours: onOpenHours,
        onOpenTeam: onOpenTeam,
        onOpenData: onOpenData,
        onOpenBookingRules: onOpenBookingRules,
        onOpenMode: onOpenMode,
        onPreview: onPreviewShop,
      );
    }

    if (isLoadingShop) {
      return const Center(key: ValueKey('loading'), child: AppLoader());
    }
    return const SizedBox.shrink(key: ValueKey('none'));
  }

  /// "On, 2 hours before", or how it is otherwise set.
  String? _notificationsLine(BuildContext context) {
    final t = context.t.profile;
    return switch (notificationsEnabled) {
      null => null,
      false => t.notificationsOff,
      true when user.role == UserRole.owner => t.notificationsOn,
      true when !user.notificationPrefs.appointmentReminder => t.remindersOff,
      true => t.notificationsOnBefore(
        when: switch (user.notificationPrefs.reminderLead) {
          ReminderLead.oneHour => context.t.notificationSettings.lead.oneHour,
          ReminderLead.twoHours => context.t.notificationSettings.lead.twoHours,
          ReminderLead.oneDay => context.t.notificationSettings.lead.oneDay,
        },
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    final isOwner = user.role == UserRole.owner;
    final notifications = AppSettingsRow(
      icon: AppLineIcons.bell,
      label: t.notifications,
      value: _notificationsLine(context),
      onTap: onOpenNotifications,
    );
    final appearance = ProfileAppearanceSection(
      themeMode: themeMode,
      onThemeModeChanged: onThemeModeChanged,
    );
    final exits = ProfileExitButtons(
      signOutLabel: t.signOut,
      deleteLabel: t.deleteAccount,
      onSignOut: onSignOut,
      onDeleteAccount: switch (onDeleteAccount) {
        null => null,
        final onDelete => () => _confirmDelete(context, onDelete),
      },
    );

    return ListView(
      padding: EdgeInsets.only(top: 18.h, bottom: 24.h),
      children: isOwner
          ? [
              Text(t.shopTitle, style: context.textTheme.displayMedium),
              SizedBox(height: 18.h),
              AnimatedSize(
                duration: context.motion.normal,
                curve: context.motion.curve,
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: context.motion.normal,
                  child: _shopSlot(context),
                ),
              ),
              SizedBox(height: 18.h),
              AppSectionTitle(t.yourAccount),
              SizedBox(height: context.spacing.sm.h),
              AppSettingsCard(
                children: [
                  AppSettingsRow(
                    icon: AppLineIcons.person,
                    label: user.name,
                    value: user.email,
                    onTap: onOpenPersonalData,
                  ),
                  notifications,
                  AppSettingsRow(
                    icon: AppLineIcons.help,
                    label: t.ownerHelp,
                    onTap: onOpenHelp,
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              appearance,
              SizedBox(height: 18.h),
              exits,
            ]
          : [
              Text(t.title, style: context.textTheme.displayMedium),
              SizedBox(height: 20.h),
              ProfileIdentityCard(
                name: user.name,
                email: user.email,
                provider: provider,
                onEdit: onOpenPersonalData,
              ),
              SizedBox(height: 20.h),
              appearance,
              SizedBox(height: 20.h),
              AppSettingsCard(
                children: [
                  notifications,
                  AppSettingsRow(
                    icon: AppLineIcons.help,
                    label: t.help,
                    value: t.helpLine,
                    onTap: onOpenHelp,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              exits,
            ],
    );
  }
}

import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_destination.freezed.dart';

/// Where a signed-in user belongs right now.
///
/// `sealed`, so a new case is a compile error in every switch over it rather
/// than a silent fall-through to a default.
@freezed
sealed class AuthDestination with _$AuthDestination {
  /// No session: browsing as a guest, on the customer's tabs.
  const factory AuthDestination.signIn() = SignInDestination;

  /// Signed in, no role yet. Asked exactly once.
  const factory AuthDestination.roleChoice() = RoleChoiceDestination;

  /// Owner whose shop is still a draft; [ShopSetupDestination.step] is where
  /// to resume.
  const factory AuthDestination.shopSetup(ShopSetupStep step) =
      ShopSetupDestination;

  /// Owner with a published shop.
  const factory AuthDestination.ownerAgenda() = OwnerAgendaDestination;

  /// Customer home.
  const factory AuthDestination.customerHome() = CustomerHomeDestination;

  /// The optional "finish your profile" step, shown once.
  ///
  /// Not in §5's flowchart, which goes straight from the role to home — it
  /// comes from the design board, where it is step 4 and explicitly
  /// skippable. Shown once and never again, which the server records on the
  /// profile: skipping leaves nothing else behind to tell "answered" from
  /// "never asked".
  const factory AuthDestination.profileSetup() = ProfileSetupDestination;

  /// The notification-permission explainer, shown once.
  ///
  /// Asked after the journey is done, never at launch. iOS only ever shows the
  /// system prompt once, so asking at a moment the user understands is the
  /// difference between push working and not.
  ///
  /// The moment is per role — §4.4 of the notifications spec. An owner is
  /// asked at the end of publishing, so this destination is reached from
  /// [AuthRouter.destinationFor]. A customer is asked after their first
  /// confirmed booking, which no resolve can know about, so theirs comes from
  /// [AuthCubit.askForNotifications] instead.
  const factory AuthDestination.notificationPermission() =
      NotificationPermissionDestination;
}

/// Decides the destination from the profile and, for owners, the shop.
///
/// This is §5 of the auth-flow document in one place, so the rule lives
/// somewhere it can be read and tested rather than being spread across the
/// screens that happen to navigate.
///
/// It is deliberately pure: no I/O, no router. Callers fetch `GET /me` and
/// `GET /me/shop` and hand the results in.
abstract final class AuthRouter {
  /// [shop] is null when the owner has no shop yet — `GET /me/shop` answered
  /// 404 — which is a real state, not an error.
  ///
  /// Whether the profile step has been answered comes off the profile itself.
  /// [notificationsPrompted] stays device-local, and correctly so: it tracks
  /// the system permission prompt, which iOS only shows once per install and
  /// a reinstall genuinely does reset.
  static AuthDestination destinationFor({
    required UserProfile? profile,
    Shop? shop,
    bool notificationsPrompted = true,
  }) {
    if (profile == null) return const SignInDestination();
    if (profile.role == null) return const RoleChoiceDestination();

    // Owners finish the shop before anything else is asked of them: a draft
    // shop is the only thing standing between them and a usable app.
    if (profile.role == UserRole.owner) {
      final owner = _ownerDestination(shop);
      if (owner is! OwnerAgendaDestination) return owner;
    }

    // A customer's name is asked in a sheet, at the moment they first act
    // (`askNameIfNeeded`), so signing in never takes them off their screen.
    if (profile.role == UserRole.owner && !profile.profileSetupSeen) {
      return const ProfileSetupDestination();
    }

    // §4.4 of the notifications spec asks each role at the moment the answer
    // means something. For an owner that is here: the shop is published, and
    // the next thing to happen is a booking they would otherwise only find by
    // opening the agenda.
    //
    // A customer is *not* asked here. Nothing has happened to them yet — the
    // explainer promises reminders for an appointment they have not made — so
    // the ask waits for their first confirmed booking, which is a screen's
    // decision rather than this journey's. See `AuthCubit.askForNotifications`.
    if (profile.role == UserRole.owner && !notificationsPrompted) {
      return const NotificationPermissionDestination();
    }

    return profile.role == UserRole.owner
        ? const OwnerAgendaDestination()
        : const CustomerHomeDestination();
  }

  /// An owner with no shop starts the wizard; a draft resumes at its first
  /// incomplete step; an active shop goes to the agenda.
  ///
  /// A `deleted` shop lands on the wizard too — the owner is signed in with no
  /// usable shop, and the wizard is the only way back to one.
  static AuthDestination _ownerDestination(Shop? shop) {
    if (shop == null) return const ShopSetupDestination(ShopSetupStep.shop);
    if (shop.status.isPublished) return const OwnerAgendaDestination();
    return ShopSetupDestination(shop.resumeStep);
  }

  /// Whether reaching this destination needs the shop fetched first.
  ///
  /// Saves a `GET /me/shop` for customers and for users with no role, which is
  /// every first sign-in.
  static bool needsShop(UserProfile? profile) =>
      profile?.role == UserRole.owner;
}

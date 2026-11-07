import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/structures/push_payload.dart';
import 'package:booknow_mobile/routing/app_router.gr.dart';

/// Where a tapped push opens, for the user who is signed in.
///
/// The design sends four of the six types to a booking detail screen, one to
/// the owner's agenda and one to the customer's bookings. The two detail
/// screens do not exist yet, so a booking push lands on the list that holds
/// it: the agenda for an owner, the bookings tab for a customer. Both are the
/// screen the detail would be pushed from, so nothing has to be unlearnt when
/// they arrive — the `bookingId` is already on the payload.
///
/// Null means "do not navigate", and there are two ways to get it:
///
/// - **No role.** The session has not resolved yet, or there is none. Nothing
///   below the shells is reachable, and the splash is already on its way
///   somewhere.
/// - **The other role's push.** A phone can hold a notification for the
///   account that was signed in before this one. `RoleGuard` would turn the
///   navigation away at the door; this turns it away before it is attempted,
///   so the user is not bounced through someone else's half of the app.
PageRouteInfo<dynamic>? pushDestinationFor(
  PushPayload payload,
  UserRole? role,
) {
  if (role == null || payload.type.recipient != role) return null;

  return switch (role) {
    UserRole.owner => const OwnerShellRoute(children: [OwnerAgendaRoute()]),
    UserRole.customer => const CustomerShellRoute(children: [BookingsRoute()]),
  };
}

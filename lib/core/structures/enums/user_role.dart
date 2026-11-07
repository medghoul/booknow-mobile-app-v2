/// Which side of the product a signed-in user is on.
///
/// Chosen once, on first sign-in, and sent to `POST /me/role`. The API rejects
/// a second attempt with `ROLE_ALREADY_SET`, so the app only ever asks when the
/// profile has no role yet.
enum UserRole {
  /// Books slots and pays the service fee.
  customer('customer'),

  /// Runs a shop and manages its agenda. Free.
  owner('owner');

  const UserRole(this.wireName);

  final String wireName;

  static UserRole? fromWire(String? value) {
    if (value == null) return null;
    for (final role in UserRole.values) {
      if (role.wireName == value) return role;
    }
    return null;
  }
}

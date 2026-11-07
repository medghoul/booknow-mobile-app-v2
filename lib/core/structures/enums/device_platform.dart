import 'dart:io' show Platform;

/// Which kind of phone a registered device is.
///
/// Sent with the FCM token to `PUT /me/devices` and stored beside it, so the
/// sender can shape a push per platform — an Android channel, an APNs sound —
/// without asking FCM what each token belongs to.
enum DevicePlatform {
  ios('ios'),
  android('android');

  const DevicePlatform(this.wireName);

  /// What the API expects. Lowercase, and not the enum's own name, so
  /// renaming a case here cannot change what goes over the wire.
  final String wireName;

  /// The platform this build is running on.
  ///
  /// Two cases because the app ships on two platforms. Anything else resolves
  /// to Android rather than being a third case no screen could handle: it is
  /// reachable only from a desktop test run, where no FCM token exists to
  /// register in the first place.
  static DevicePlatform get current =>
      Platform.isIOS ? DevicePlatform.ios : DevicePlatform.android;
}

/// Every key the app persists, in one place.
///
/// Scattering these as private constants inside each storage service made it
/// impossible to see what the app stores without grepping, and nothing stopped
/// the same string being used in both stores. [isSecure] records which of the
/// two a key belongs to, so that can't drift either.
enum PrefsKey {
  // ─── Per-device settings ────────────────────────────────────────────────
  themeMode('theme_mode'),
  locale('locale'),
  onboardingSeen('onboarding_seen'),
  recentShops('recent_shops'),
  notificationsPrompted('notifications_prompted'),

  // ─── Session ────────────────────────────────────────────────────────────
  // Tokens are secrets: they go to the keychain / keystore, never to
  // SharedPreferences, which is plain text on both platforms.
  accessToken('access_token', isSecure: true),
  refreshToken('refresh_token', isSecure: true),
  idToken('id_token', isSecure: true);

  const PrefsKey(this.value, {this.isSecure = false});

  /// The literal string written to storage. Changing one orphans whatever is
  /// already on the device, so treat these as permanent.
  final String value;

  /// True for anything that belongs in `SecureStorageService`.
  final bool isSecure;
}

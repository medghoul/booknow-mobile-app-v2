/// Paths to the icon assets, in one place.
///
/// Declared here rather than inside the widgets that draw them, so a renamed
/// or moved file is a single edit and it is possible to see everything the app
/// ships without grepping the widget tree.
///
/// Runtime assets only. The launcher-icon and splash sources under
/// `assets/icons/app_icon*.png` and `assets/splash/` are inputs to
/// `flutter_launcher_icons` and `flutter_native_splash`; nothing in Dart loads
/// them, so they are not listed.
///
/// Images get the same treatment in an `AppImages` alongside this one. There
/// is nothing in `assets/images/` yet — the shop interior behind the sign-in
/// header and the chair on the first onboarding slide are still to be shot —
/// so that file arrives with the first photograph rather than sitting empty.
abstract final class AppIcons {
  // ─── Auth providers ─────────────────────────────────────────────────────────
  // Each company's own artwork. See `AppProviderButton` for why neither may be
  // swapped for a lookalike from an icon font.
  static const String appleLogo = 'assets/icons/apple_logo.svg';
  static const String googleLogo = 'assets/icons/google_g.svg';
}

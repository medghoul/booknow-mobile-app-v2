/// Typography constants that sit outside the size scale.
///
/// These are statics rather than a `ThemeExtension` because `AppTextTheme`
/// builds the [TextTheme] before any `BuildContext` exists. Sizes live in
/// `AppFontSizes` (`context.fonts`); the family and tracking live here.
abstract final class AppTypography {
  /// Inter is the single typeface. Bundled rather than fetched, so the first
  /// launch needs no network and no request goes to a third party.
  static const String fontFamily = 'Inter';

  /// Uppercase micro-labels — section headers, table captions.
  static const double trackingWide = 0.72;

  /// Uppercase pills, badges and chips, where wide tracking is too airy.
  static const double trackingNormal = 0.5;

  /// Display headings are set tight: at 34px the default tracking opens the
  /// word up and the heading stops reading as one shape.
  static const double trackingDisplay = -0.64;

  /// The same intent one step down, for titles.
  static const double trackingTight = -0.52;

  /// Line heights, as multipliers of the font size. The design sets display at
  /// 1.05 and title at 1.15; body text needs the room that headings don't.
  /// No leading at all — a single glyph centred in its own box, where any
  /// line height shifts it off centre.
  static const double leadingNone = 1.0;

  static const double leadingDisplay = 1.05;
  static const double leadingTitle = 1.15;
  static const double leadingBody = 1.3;
}

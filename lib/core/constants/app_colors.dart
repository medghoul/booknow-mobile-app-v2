import 'dart:ui';

/// The app's colour palette.
///
/// Values come straight from the design system's `--bn-*` tokens
/// (`design/Mobile app design system/BookNow Design System.html`), which
/// defines light and dark as two separate palettes rather than inversions of
/// each other. Anything named `light*` belongs to the light theme, `dark*` to
/// the dark one; the unsuffixed names are theme-agnostic.
///
/// Never read a colour from here inside a widget when the theme already
/// carries it — go through `context.colorScheme`, `context.status` or
/// `context.decorations` so the widget follows the active theme.
abstract final class AppColors {
  // ─── Brand ──────────────────────────────────────────────────────────────────
  /// Deep navy: header background, main buttons, key numbers.
  static const Color primary = Color(0xFF0F2A4A);

  /// The text colour on light surfaces.
  static const Color ink = Color(0xFF0F172A);

  /// Teal: search button, links, selected states. This shade, not `#0D9488`,
  /// because white text on it passes contrast.
  static const Color accent = Color(0xFF0F766E);

  // ─── Light theme ────────────────────────────────────────────────────────────
  static const Color lightBg = Color(0xFFF6F8FB);
  static const Color lightSurface = Color(0xFFF1F5F9);
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightPrimary = Color(0xFF0F2A4A);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF0F2A4A);
  static const Color lightAccent = Color(0xFF0F766E);
  static const Color lightDangerFill = Color(0xFFDC2626);
  static const Color lightOnDanger = Color(0xFFFFFFFF);
  static const Color lightDangerBg = Color(0xFFFEE2E2);
  static const Color lightDangerFg = Color(0xFF991B1B);
  static const Color lightToastBg = Color(0xFF0F2A4A);
  static const Color lightToastFg = Color(0xFFFFFFFF);
  static const Color lightEmptyBlob = Color(0xFFDCE6F5);

  /// The two soft discs behind the splash and the onboarding artwork. Two
  /// distinct tints, not one repeated: the warm one carries the brand, the
  /// sage one the second voice.
  static const Color lightBlobWarm = Color(0xFFDCE6F5);
  static const Color lightBlobSage = Color(0xFFD5F5EB);

  // ─── Brand tints ────────────────────────────────────────────────────────────
  static const Color lightPrimaryContainer = Color(0xFFDCE6F5);
  static const Color darkPrimaryContainer = Color(0xFF1E3A5F);
  static const Color lightSecondaryContainer = Color(0xFFCCFBF1);
  static const Color darkSecondaryContainer = Color(0xFF134E4A);
  static const Color lightOnSecondaryContainer = Color(0xFF134E4A);
  static const Color darkOnSecondaryContainer = Color(0xFFCCFBF1);
  static const Color darkOnAccent = Color(0xFF042F2E);

  /// The "Explore categories" band, and the ring on a selected mini category.
  static const Color mintBand = Color(0xFFD5F5EB);
  static const Color mintRing = Color(0xFF5EEAD4);

  // ─── Borders ────────────────────────────────────────────────────────────────
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderStrong = Color(0xFFCBD5E1);
  static const Color darkBorder = Color(0xFF1A2540);
  static const Color darkBorderStrong = Color(0xFF26324F);

  // ─── Queue states ───────────────────────────────────────────────────────────
  static const Color lightWaiting = Color(0xFFD97706);
  static const Color darkWaiting = Color(0xFFFBBF24);
  static const Color lightYourTurn = Color(0xFF16A34A);
  static const Color darkYourTurn = Color(0xFF4ADE80);
  static const Color lightClosed = Color(0xFFDC2626);
  static const Color darkClosed = Color(0xFFF87171);

  // ─── Dark theme ─────────────────────────────────────────────────────────────
  static const Color darkBg = Color(0xFF0B1220);
  static const Color darkSurface = Color(0xFF1A2540);
  static const Color darkSurfaceElevated = Color(0xFF111A2E);
  static const Color darkText = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFFA3B1C6);
  static const Color darkPrimary = Color(0xFF93B4E6);
  static const Color darkOnPrimary = Color(0xFF0F2A4A);
  static const Color darkPrimaryText = Color(0xFF93B4E6);
  static const Color darkAccent = Color(0xFF2DD4BF);
  static const Color darkDangerFill = Color(0xFFF87171);
  static const Color darkOnDanger = Color(0xFF450A0A);
  static const Color darkDangerBg = Color(0xFF3F1A1A);
  static const Color darkDangerFg = Color(0xFFF87171);
  static const Color darkToastBg = Color(0xFFF1F5F9);
  static const Color darkToastFg = Color(0xFF0B1220);
  static const Color darkEmptyBlob = Color(0xFF1E3A5F);
  static const Color darkBlobWarm = Color(0xFF1E3A5F);
  static const Color darkBlobSage = Color(0xFF134E4A);

  // ─── Booking status tints ───────────────────────────────────────────────────
  // Every status carries tint + icon + word; colour is never the only signal.
  static const Color lightStatusPendingBg = Color(0xFFFEF3C7);
  static const Color lightStatusPendingFg = Color(0xFF92400E);
  static const Color lightStatusConfirmedBg = Color(0xFFCCFBF1);
  static const Color lightStatusConfirmedFg = Color(0xFF134E4A);
  static const Color lightStatusArrivedBg = Color(0xFFDCFCE7);
  static const Color lightStatusArrivedFg = Color(0xFF166534);
  static const Color lightStatusNoShowBg = Color(0xFFFEE2E2);
  static const Color lightStatusNoShowFg = Color(0xFF991B1B);
  static const Color lightStatusCancelledBg = Color(0xFFF1F5F9);
  static const Color lightStatusCancelledFg = Color(0xFF475569);
  static const Color lightStatusCompletedBg = Color(0xFFDCE6F5);
  static const Color lightStatusCompletedFg = Color(0xFF0F2A4A);

  static const Color darkStatusPendingBg = Color(0xFF3B2A0B);
  static const Color darkStatusPendingFg = Color(0xFFFBBF24);
  static const Color darkStatusConfirmedBg = Color(0xFF134E4A);
  static const Color darkStatusConfirmedFg = Color(0xFFCCFBF1);
  static const Color darkStatusArrivedBg = Color(0xFF14321F);
  static const Color darkStatusArrivedFg = Color(0xFF4ADE80);
  static const Color darkStatusNoShowBg = Color(0xFF3F1A1A);
  static const Color darkStatusNoShowFg = Color(0xFFF87171);
  static const Color darkStatusCancelledBg = Color(0xFF1A2540);
  static const Color darkStatusCancelledFg = Color(0xFF94A3B8);
  static const Color darkStatusCompletedBg = Color(0xFF1E3A5F);
  static const Color darkStatusCompletedFg = Color(0xFFDCE6F5);

  // ─── Identity providers ─────────────────────────────────────────────────────
  // Fixed by Apple's and Google's brand guidelines, so they flip with the
  // theme rather than following the palette.
  static const Color lightAppleBg = Color(0xFF000000);
  static const Color lightAppleFg = Color(0xFFFFFFFF);
  static const Color lightAppleBorder = Color(0xFF000000);
  static const Color lightGoogleBg = Color(0xFFFFFFFF);
  static const Color lightGoogleFg = Color(0xFF1F1F1F);
  static const Color lightGoogleBorder = Color(0xFF747775);

  static const Color darkAppleBg = Color(0xFFFFFFFF);
  static const Color darkAppleFg = Color(0xFF000000);
  static const Color darkAppleBorder = Color(0xFFFFFFFF);
  static const Color darkGoogleBg = Color(0xFF131314);
  static const Color darkGoogleFg = Color(0xFFE3E3E3);
  static const Color darkGoogleBorder = Color(0xFF8E918F);

  // ─── Neutrals ───────────────────────────────────────────────────────────────
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
}

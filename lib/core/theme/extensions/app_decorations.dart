import 'package:flutter/material.dart';
import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/theme/extensions/app_radii.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Ready-made surfaces, so a card looks the same wherever it is built.
///
/// Borders over shadows: a card is a 1px outline with no elevation.
@immutable
class AppDecorations extends ThemeExtension<AppDecorations> {
  const AppDecorations({
    required this.card,
    required this.cardFlat,
    required this.cardSelected,
    required this.bottomSheet,
    required this.input,
    required this.chip,
    required this.slot,
    required this.slotSelected,
    required this.slotDisabled,
    required this.blobWarm,
    required this.blobSage,
  });

  /// Elevated content card.
  final BoxDecoration card;

  /// The same surface without elevation.
  final BoxDecoration cardFlat;

  /// Card in its selected/active state.
  final BoxDecoration cardSelected;

  /// Modal bottom sheet container — top-rounded, shadow cast upward.
  final BoxDecoration bottomSheet;

  /// Wrapper for custom fields that don't go through [InputDecoration].
  final BoxDecoration input;

  /// Pill-shaped chip background.
  final BoxDecoration chip;

  /// A bookable time slot.
  final BoxDecoration slot;

  /// The slot the customer has picked.
  final BoxDecoration slotSelected;

  /// A slot that is taken or outside the booking window.
  final BoxDecoration slotDisabled;

  /// The navy-tint shape behind the splash mark and the first onboarding slide.
  final Color blobWarm;

  /// The mint shape, used on the owner slide.
  final Color blobSage;

  @override
  AppDecorations copyWith({
    BoxDecoration? card,
    BoxDecoration? cardFlat,
    BoxDecoration? cardSelected,
    BoxDecoration? bottomSheet,
    BoxDecoration? input,
    BoxDecoration? chip,
    BoxDecoration? slot,
    BoxDecoration? slotSelected,
    BoxDecoration? slotDisabled,
    Color? blobWarm,
    Color? blobSage,
  }) {
    return AppDecorations(
      card: card ?? this.card,
      cardFlat: cardFlat ?? this.cardFlat,
      cardSelected: cardSelected ?? this.cardSelected,
      bottomSheet: bottomSheet ?? this.bottomSheet,
      input: input ?? this.input,
      chip: chip ?? this.chip,
      slot: slot ?? this.slot,
      slotSelected: slotSelected ?? this.slotSelected,
      slotDisabled: slotDisabled ?? this.slotDisabled,
      blobWarm: blobWarm ?? this.blobWarm,
      blobSage: blobSage ?? this.blobSage,
    );
  }

  @override
  AppDecorations lerp(ThemeExtension<AppDecorations>? other, double t) {
    if (other is! AppDecorations) return this;
    return AppDecorations(
      card: BoxDecoration.lerp(card, other.card, t) ?? card,
      cardFlat: BoxDecoration.lerp(cardFlat, other.cardFlat, t) ?? cardFlat,
      cardSelected:
          BoxDecoration.lerp(cardSelected, other.cardSelected, t) ??
          cardSelected,
      bottomSheet:
          BoxDecoration.lerp(bottomSheet, other.bottomSheet, t) ?? bottomSheet,
      input: BoxDecoration.lerp(input, other.input, t) ?? input,
      chip: BoxDecoration.lerp(chip, other.chip, t) ?? chip,
      slot: BoxDecoration.lerp(slot, other.slot, t) ?? slot,
      slotSelected:
          BoxDecoration.lerp(slotSelected, other.slotSelected, t) ??
          slotSelected,
      slotDisabled:
          BoxDecoration.lerp(slotDisabled, other.slotDisabled, t) ??
          slotDisabled,
      blobWarm: Color.lerp(blobWarm, other.blobWarm, t) ?? blobWarm,
      blobSage: Color.lerp(blobSage, other.blobSage, t) ?? blobSage,
    );
  }

  // ─── Presets ────────────────────────────────────────────────────────────────

  static final AppDecorations light = AppDecorations(
    card: BoxDecoration(
      color: AppColors.lightSurfaceElevated,
      borderRadius: AppRadii.standard.xlR,
      border: Border.all(color: AppColors.lightBorder),
    ),
    cardFlat: BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: AppRadii.standard.xlR,
    ),
    cardSelected: BoxDecoration(
      color: AppColors.lightSecondaryContainer,
      borderRadius: AppRadii.standard.xlR,
      border: Border.all(color: AppColors.lightAccent, width: 1.5),
    ),
    bottomSheet: BoxDecoration(
      color: AppColors.lightSurfaceElevated,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadii.standard.xxl.r),
      ),
    ),
    input: BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: AppRadii.standard.mdR,
      border: Border.all(color: AppColors.lightBorder, width: 1),
    ),
    chip: BoxDecoration(
      color: AppColors.lightSurface,
      borderRadius: AppRadii.standard.pillR,
    ),
    slot: BoxDecoration(
      color: AppColors.lightSurfaceElevated,
      borderRadius: AppRadii.standard.mdR,
      border: Border.all(color: AppColors.lightBorder, width: 1.5),
    ),
    slotSelected: BoxDecoration(
      color: AppColors.lightAccent,
      borderRadius: AppRadii.standard.mdR,
    ),
    slotDisabled: BoxDecoration(
      color: AppColors.lightSurface.withOpacityValue(0.6),
      borderRadius: AppRadii.standard.mdR,
    ),
    blobWarm: AppColors.lightBlobWarm,
    blobSage: AppColors.lightBlobSage,
  );

  static final AppDecorations dark = AppDecorations(
    card: BoxDecoration(
      color: AppColors.darkSurfaceElevated,
      borderRadius: AppRadii.standard.xlR,
      border: Border.all(color: AppColors.darkBorder),
    ),
    cardFlat: BoxDecoration(
      color: AppColors.darkSurface,
      borderRadius: AppRadii.standard.xlR,
    ),
    cardSelected: BoxDecoration(
      color: AppColors.darkSecondaryContainer,
      borderRadius: AppRadii.standard.xlR,
      border: Border.all(color: AppColors.darkAccent, width: 1.5),
    ),
    bottomSheet: BoxDecoration(
      color: AppColors.darkSurfaceElevated,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadii.standard.xxl.r),
      ),
    ),
    input: BoxDecoration(
      color: AppColors.darkSurface,
      borderRadius: AppRadii.standard.mdR,
      border: Border.all(color: AppColors.darkBorder, width: 1),
    ),
    chip: BoxDecoration(
      color: AppColors.darkSurface,
      borderRadius: AppRadii.standard.pillR,
    ),
    slot: BoxDecoration(
      color: AppColors.darkSurfaceElevated,
      borderRadius: AppRadii.standard.mdR,
      border: Border.all(color: AppColors.darkBorder, width: 1.5),
    ),
    slotSelected: BoxDecoration(
      color: AppColors.darkAccent,
      borderRadius: AppRadii.standard.mdR,
    ),
    slotDisabled: BoxDecoration(
      color: AppColors.darkSurface.withOpacityValue(0.6),
      borderRadius: AppRadii.standard.mdR,
    ),
    blobWarm: AppColors.darkBlobWarm,
    blobSage: AppColors.darkBlobSage,
  );
}

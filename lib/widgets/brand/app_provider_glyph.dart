import 'package:booknow_mobile/core/constants/app_icons.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The provider mark, from each company's own artwork.
///
/// Google's G keeps its four colours wherever it is drawn — the guidelines
/// never allow it to be recoloured, so it is drawn untinted and [color] does
/// not reach it. Apple's mark is a solid silhouette that takes the colour of
/// whatever it sits on, white on black and black on white.
///
/// Apple's artwork is taller than it is wide (17 × 20), so it is sized by
/// height and lets its width follow; forcing it square would squash it.
///
/// Neither may be redrawn or substituted with a lookalike from an icon font —
/// that is what each company's brand terms require, and `Icons.g_mobiledata`
/// is not Google's logo.
class AppProviderGlyph extends StatelessWidget {
  const AppProviderGlyph({
    super.key,
    required this.provider,
    required this.color,
    this.size,
  });

  final AuthProviderKind provider;

  /// Apple's mark only. Google's keeps its own colours.
  final Color color;

  /// Defaults to the size the provider buttons draw it at.
  final double? size;

  @override
  Widget build(BuildContext context) {
    final height = size ?? context.icons.s.w + context.spacing.xs.w;

    return switch (provider) {
      AuthProviderKind.apple => SvgPicture.asset(
        AppIcons.appleLogo,
        height: height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
      AuthProviderKind.google => SvgPicture.asset(
        AppIcons.googleLogo,
        width: height,
        height: height,
      ),
    };
  }
}

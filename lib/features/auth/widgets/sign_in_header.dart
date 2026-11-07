import 'package:booknow_mobile/core/extensions/color_extension.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The photo band the sign-in screen opens with.
///
/// A returning user is shown the shop, not a form — so the screen leads with a
/// picture of the place they are booking rather than a heading. The photo runs
/// under the status bar and fades into the page colour instead of ending at a
/// card edge, which is what lets the same image work in light and dark without
/// a scrim over it.
///
/// The brand mark sits on the photo at the bottom-left, overlapping the fade.
class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key, this.photo});

  /// The shop interior. Until the pilot shop is photographed there is nothing
  /// to show, so the band falls back to a flat surface tint — the fade and the
  /// mark still read, and dropping an image in later changes nothing else.
  final ImageProvider? photo;

  /// 390 × 352 in the design; the width is the whole screen, so only the
  /// height carries over.
  static const double _bandHeight = 352;

  static const double _markSize = 58;
  static const double _markInset = 26;
  static const double _markBottom = 20;

  /// The fade starts part-way down so the top of the photo stays readable and
  /// only the bottom dissolves into the page.
  static const double _fadeStart = 0.45;

  @override
  Widget build(BuildContext context) {
    final background = context.theme.scaffoldBackgroundColor;

    return SizedBox(
      height: _bandHeight.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              image: photo == null
                  ? null
                  : DecorationImage(image: photo!, fit: BoxFit.cover),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [background.withOpacityValue(0), background],
                stops: const [_fadeStart, 1],
              ),
            ),
          ),
          Positioned(
            left: _markInset.w,
            bottom: _markBottom.h,
            child: const AppBrandMark(size: _markSize),
          ),
        ],
      ),
    );
  }
}

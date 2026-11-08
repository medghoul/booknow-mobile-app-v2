import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// The mark, the name, and three dots forming a little queue, the last one
/// teal: your place.
///
/// The native launch screen is a picture of this, rendered by
/// `tool/render_splash.dart`, so the handoff to Flutter can't show. That is why
/// every size here is a plain logical pixel, never scaled to the screen: the
/// picture is drawn once and can't follow the scaling. Change anything here and
/// run that tool again.
class SplashMark extends StatelessWidget {
  const SplashMark({super.key});

  static const double _gap = 16;
  static const double _dotGap = 8;

  @override
  Widget build(BuildContext context) {
    final on = context.onHeaderColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 84,
          height: 84,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            'B',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 54,
              fontWeight: FontWeight.w800,
              height: 1,
              color: context.headerColor,
            ),
          ),
        ),
        const SizedBox(height: _gap),
        Text(
          'BookNow',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: AppTypography.trackingDisplay,
            height: AppTypography.leadingDisplay,
            color: on,
          ),
        ),
        const SizedBox(height: _gap),
        SizedBox(
          height: 14,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Dot(8, on.withValues(alpha: 0.7)),
              const SizedBox(width: _dotGap),
              _Dot(8, on.withValues(alpha: 0.7)),
              const SizedBox(width: _dotGap),
              const _Dot(12, AppColors.mintRing),
            ],
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.size, this.color);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

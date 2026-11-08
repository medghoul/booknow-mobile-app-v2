import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/theme/app_theme.dart';
import 'package:booknow_mobile/features/splash/widgets/splash_mark.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The splash: [SplashMark] on the navy.
///
/// It is the native launch screen exactly, everything in the same place at the
/// same size and nothing animating in, so opening the app shows no seam.
///
/// It opens in the phone's light or dark, as the launch screen does, whatever
/// theme was chosen in the app. The navy then contracts into the Discover
/// header, turning into that theme's colour on the way, so opening the app reads
/// as one motion. [onFinished] fires when it has, which is when the app may
/// take over from here.
class SplashView extends StatefulWidget {
  const SplashView({
    super.key,
    required this.leaving,
    this.queueLine,
    this.onFinished,
  });

  /// "You're #3 at…", for someone who opens the app while in a line.
  final String? queueLine;

  /// The destination is known: time to contract.
  final bool leaving;
  final VoidCallback? onFinished;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  /// Where the navy lands: the height of the open Discover header.
  static const double _headerHeight = 192;

  @override
  void didUpdateWidget(SplashView old) {
    super.didUpdateWidget(old);
    if (!old.leaving && widget.leaving) {
      final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
      if (reduce) widget.onFinished?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final full = context.mediaQuery.size.height;
    final target = _headerHeight.h + context.mediaQuery.padding.top;
    final queueLine = widget.queueLine;
    final dark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    // The two colours in flutter_native_splash.yaml.
    final launchColor = dark
        ? AppColors.darkSurfaceElevated
        : AppColors.lightPrimary;

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeInOutCubicEmphasized,
          height: widget.leaving ? target : full,
          color: widget.leaving ? context.headerColor : launchColor,
          onEnd: () {
            if (widget.leaving) widget.onFinished?.call();
          },
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.topCenter,
              maxHeight: full,
              child: SizedBox(
                height: full,
                child: AnimatedOpacity(
                  opacity: widget.leaving ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  // Centred on the screen, as the launch screen centres its
                  // picture. The queue line hangs below rather than joining
                  // the column, so it can't nudge the mark when it arrives.
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Theme(
                          data: dark ? AppTheme.dark : AppTheme.light,
                          child: const SplashMark(),
                        ),
                        Positioned(
                          bottom: 0,
                          child: FractionalTranslation(
                            translation: const Offset(0, 1),
                            child: AnimatedSwitcher(
                              duration: context.motion.fast,
                              child: queueLine == null
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      key: ValueKey(queueLine),
                                      padding: EdgeInsets.only(
                                        top: context.spacing.lg,
                                      ),
                                      child: SizedBox(
                                        width:
                                            context.mediaQuery.size.width -
                                            2 * context.spacing.lg,
                                        child: Text(
                                          queueLine,
                                          textAlign: TextAlign.center,
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: context.onHeaderColor
                                                    .withValues(alpha: 0.85),
                                              ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

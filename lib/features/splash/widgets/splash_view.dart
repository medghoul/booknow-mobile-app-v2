import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/features/splash/widgets/splash_mark.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The splash: [SplashMark] on the navy.
///
/// Its first frame is the native launch screen exactly, the mark and the dots
/// in the same place at the same size, so opening the app shows no seam. Only
/// the name, which Android 12+ can't put on the launch screen, fades in.
///
/// The navy then contracts into the Discover header, so opening the app reads
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

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  /// Where the navy lands: the height of the open Discover header.
  static const double _headerHeight = 192;

  late final AnimationController _name = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  )..forward();

  @override
  void didUpdateWidget(SplashView old) {
    super.didUpdateWidget(old);
    if (!old.leaving && widget.leaving) {
      final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
      if (reduce) widget.onFinished?.call();
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final full = context.mediaQuery.size.height;
    final target = _headerHeight.h + context.mediaQuery.padding.top;
    final queueLine = widget.queueLine;

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeInOutCubicEmphasized,
          height: widget.leaving ? target : full,
          color: context.headerColor,
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
                        SplashMark(
                          name: CurvedAnimation(
                            parent: _name,
                            curve: Curves.easeOut,
                          ),
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

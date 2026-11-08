import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The splash: the mark, the name, and three dots forming a little queue, the
/// last one teal: your place.
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

  late final AnimationController _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
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
    _enter.dispose();
    super.dispose();
  }

  Animation<double> _interval(double from, double to, Curve curve) =>
      CurvedAnimation(
        parent: _enter,
        curve: Interval(from, to, curve: curve),
      );

  @override
  Widget build(BuildContext context) {
    final full = context.mediaQuery.size.height;
    final target = _headerHeight.h + context.mediaQuery.padding.top;

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Already in place on the first frame, where the native
                      // launch screen left it, so the handoff doesn't show.
                      Container(
                        width: 84.w,
                        height: 84.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.onHeaderColor,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Text(
                          'B',
                          style: TextStyle(
                            fontFamily:
                                context.textTheme.displayLarge?.fontFamily,
                            fontSize: 54.sp,
                            fontWeight: FontWeight.w800,
                            height: 1,
                            color: context.headerColor,
                          ),
                        ),
                      ),
                      SizedBox(height: context.spacing.lg.h),
                      FadeTransition(
                        opacity: _interval(0.25, 0.7, Curves.easeOut),
                        child: Text(
                          'BookNow',
                          style: context.textTheme.displayLarge?.copyWith(
                            color: context.onHeaderColor,
                          ),
                        ),
                      ),
                      AnimatedSize(
                        duration: context.motion.fast,
                        child: widget.queueLine == null
                            ? const SizedBox(width: double.infinity)
                            : Padding(
                                padding: EdgeInsets.only(
                                  top: context.spacing.sm.h,
                                ),
                                child: Text(
                                  widget.queueLine!,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.onHeaderColor.withValues(
                                      alpha: 0.85,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: context.spacing.lg.h),
                      SizedBox(
                        height: 14.w,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _Dot(
                              _interval(0.4, 0.7, Curves.elasticOut),
                              8,
                              context.onHeaderColor.withValues(alpha: 0.7),
                            ),
                            SizedBox(width: context.spacing.sm.w),
                            _Dot(
                              _interval(0.5, 0.8, Curves.elasticOut),
                              8,
                              context.onHeaderColor.withValues(alpha: 0.7),
                            ),
                            SizedBox(width: context.spacing.sm.w),
                            _Dot(
                              _interval(0.6, 0.95, Curves.elasticOut),
                              12,
                              AppColors.mintRing,
                            ),
                          ],
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
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.scale, this.size, this.color);

  final Animation<double> scale;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

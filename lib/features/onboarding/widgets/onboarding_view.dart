import 'package:booknow_mobile/core/constants/app_component_sizes.dart';
import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/core/structures/enums/ui_enums.dart';
import 'package:booknow_mobile/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:booknow_mobile/features/onboarding/widgets/onboarding_artwork.dart';
import 'package:booknow_mobile/features/onboarding/widgets/onboarding_dots.dart';
import 'package:booknow_mobile/features/onboarding/widgets/onboarding_slide.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The three-slide intro.
///
/// Skip and the last slide both finish onboarding: a user who skips has made a
/// decision, and replaying the deck at them later would ignore it.
class OnboardingView extends StatefulWidget {
  const OnboardingView({
    super.key,
    required this.onFinished,
    required this.onSignInInstead,
  });

  /// Finished the deck, or skipped it — both go to sign-up.
  final VoidCallback onFinished;

  /// "I already have an account", from the last slide.
  final VoidCallback onSignInInstead;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    _controller.nextPage(
      duration: context.motion.normal,
      curve: context.motion.curveEmphasized,
    );
  }

  Future<void> _finish(VoidCallback then) async {
    await context.read<OnboardingCubit>().complete();
    if (mounted) then();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnboardingCubit>();
    final index = cubit.state;
    final t = context.t.onboarding;

    return Column(
      children: [
        // The last slide has no skip: it ends in a decision, and offering a
        // third way out next to "Inizia" and "Ho già un account" would only
        // blur it. The row keeps its height so the deck doesn't jump.
        AppFadeIn.down(
          delay: AppStagger.delayAt(0),
          child: SizedBox(
            height: AppComponentSizes.buttonSmallHeight.h,
            child: cubit.isLastSlide
                ? null
                : Align(
                    alignment: Alignment.centerRight,
                    child: AppTextButton(
                      label: t.skip,
                      foregroundColor: context.colorScheme.onSurfaceVariant,
                      onPressed: () => _finish(widget.onFinished),
                    ),
                  ),
          ),
        ),
        Expanded(
          child: AppFadeIn.up(
            delay: AppStagger.delayAt(1),
            child: PageView(
              controller: _controller,
              onPageChanged: cubit.onPageChanged,
              children: [
                OnboardingSlide(
                  artwork: const BookingArtwork(),
                  title: t.slideOne.title,
                  body: t.slideOne.body,
                ),
                OnboardingSlide(
                  artwork: const PriceArtwork(),
                  title: t.slideTwo.title,
                  body: t.slideTwo.body,
                ),
                OnboardingSlide(
                  artwork: const AgendaArtwork(),
                  title: t.slideThree.title,
                  body: t.slideThree.body,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        AppFadeIn.up(
          delay: AppStagger.delayAt(2),
          child: Align(
            alignment: Alignment.centerLeft,
            child: OnboardingDots(
              count: OnboardingCubit.slideCount,
              activeIndex: index,
            ),
          ),
        ),
        SizedBox(height: context.spacing.xl.h),
        AppFadeIn.up(
          delay: AppStagger.delayAt(3),
          child: _Actions(
            isLastSlide: cubit.isLastSlide,
            onNext: _next,
            onStart: () => _finish(widget.onFinished),
            onSignIn: () => _finish(widget.onSignInInstead),
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
      ],
    );
  }
}

/// The last slide swaps the single "Next" for the two real choices, so the
/// deck ends on a decision instead of another step.
class _Actions extends StatelessWidget {
  const _Actions({
    required this.isLastSlide,
    required this.onNext,
    required this.onStart,
    required this.onSignIn,
  });

  final bool isLastSlide;
  final VoidCallback onNext;
  final VoidCallback onStart;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final t = context.t.onboarding;

    if (!isLastSlide) {
      return AppElevatedButton(
        label: t.next,
        icon: Icons.arrow_forward,
        iconAffinity: ButtonIconAffinity.trailing,
        expand: true,
        onPressed: onNext,
      );
    }

    return Column(
      children: [
        AppElevatedButton(label: t.start, expand: true, onPressed: onStart),
        SizedBox(height: context.spacing.sm.h),
        AppOutlinedButton(
          label: t.haveAccount,
          expand: true,
          onPressed: onSignIn,
        ),
      ],
    );
  }
}

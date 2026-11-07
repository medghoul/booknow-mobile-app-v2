import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_state.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// Step 3b: the card was refused.
///
/// Three questions answered at a glance: what failed, whether any money moved,
/// and how long the slot survives. The slot is still held — that is the whole
/// reason this is a screen and not a dead end.
class PaymentDeclinedView extends StatelessWidget {
  const PaymentDeclinedView({
    super.key,
    required this.state,
    required this.onGiveUp,
  });

  final BookingFlowState state;
  final VoidCallback onGiveUp;

  @override
  Widget build(BuildContext context) {
    final t = context.t.flow;
    final left = state.holdLeft;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
            children: [
              Container(
                padding: EdgeInsets.all(context.spacing.lg.w),
                decoration: BoxDecoration(
                  color: context.status.error.background,
                  borderRadius: context.radii.xlR,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: context.icons.s.w,
                      color: context.status.error.foreground,
                    ),
                    SizedBox(width: context.spacing.md.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.declinedTitle,
                            style: context.textTheme.labelLarge?.copyWith(
                              color: context.status.error.foreground,
                            ),
                          ),
                          SizedBox(height: context.spacing.xxs.h),
                          Text(
                            t.declinedBody,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.status.error.foreground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.spacing.lg.h),
              if (left != null)
                AppStatusBadge(
                  tint: context.status.pending,
                  icon: Icons.timer_outlined,
                  label: left == Duration.zero
                      ? t.holdLapsed
                      : t.holdLeft(n: left.inMinutes + 1),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppElevatedButton(
                label: t.retry,
                expand: true,
                isLoading: state.isBusy,
                // The hold is still live, so this reopens the same payment
                // rather than booking the slot again.
                onPressed: state.holdLapsed
                    ? null
                    : context.read<BookingFlowCubit>().retry,
              ),
              SizedBox(height: context.spacing.sm.h),
              AppOutlinedButton(
                label: t.giveUp,
                expand: true,
                onPressed: onGiveUp,
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
      ],
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/core/structures/enums/booking_status.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_state.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/booking_summary.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/slot_picker.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Booking on the one shop screen: choose, then pay in a panel over it.
///
/// One route rather than three, because the state is one thing: the slot being
/// held, the payment opened against it and the booking it becomes all belong to
/// the same ten minutes, and a back gesture between them would strand a hold.
class BookingFlowView extends StatefulWidget {
  const BookingFlowView({super.key});

  @override
  State<BookingFlowView> createState() => _BookingFlowViewState();
}

class _BookingFlowViewState extends State<BookingFlowView> {
  /// How long the tick is on screen before the screen gives way.
  static const Duration _celebration = Duration(milliseconds: 1500);

  bool _leaving = false;

  void _leaveSoon() {
    if (_leaving) return;
    _leaving = true;
    HapticFeedback.mediumImpact();
    Future<void>.delayed(_celebration, () {
      if (mounted) context.router.maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingFlowCubit, BookingFlowState>(
      listenWhen: (before, after) =>
          before.failure != after.failure || before.step != after.step,
      listener: (context, state) {
        if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context));
        }
        if (state.step == BookingStep.done) _leaveSoon();
      },
      builder: (context, state) {
        final paying = state.step != BookingStep.slot;

        return PopScope(
          // Back closes the payment rather than the shop, and nothing closes
          // while a payment is running.
          canPop: !paying || state.step == BookingStep.done,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && state.step != BookingStep.paying && !state.isBusy) {
              context.read<BookingFlowCubit>().backToSlots();
            }
          },
          child: SlotPicker(
            state: state,
            overlay: state.step == BookingStep.done
                ? _Done(state: state)
                : paying
                ? BookingSummary(state: state)
                : null,
          ),
        );
      },
    );
  }
}

class _Done extends StatelessWidget {
  const _Done({required this.state});

  final BookingFlowState state;

  @override
  Widget build(BuildContext context) {
    final t = context.t.flow;
    final booking = state.booking;
    final start = state.start;
    // The webhook confirms the booking, so a payment can land a moment before
    // the status does. Saying "paid, confirming" is honest; a tick over a
    // booking the server has not confirmed yet is not.
    final confirmed = booking?.status == BookingStatus.confirmed;
    final zone = state.availability?.timeZone ?? 'Europe/Rome';

    return PayPanel(
      onDismiss: null,
      children: [
        PayDone(
          title: confirmed ? t.doneShort : t.confirmingTitle,
          line: confirmed && start != null
              ? [?state.shop?.name, flowWhen(context, start, zone)].join(' · ')
              : t.confirmingBody,
        ),
      ],
    );
  }
}

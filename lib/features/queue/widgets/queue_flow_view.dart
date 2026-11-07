import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/error/error_messages.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_state.dart';
import 'package:booknow_mobile/features/queue/widgets/queue_ended_view.dart';
import 'package:booknow_mobile/features/queue/widgets/queue_line_view.dart';
import 'package:booknow_mobile/features/queue/widgets/queue_overview.dart';
import 'package:booknow_mobile/features/queue/widgets/queue_summary.dart';
import 'package:booknow_mobile/localization/localization.dart';
import 'package:booknow_mobile/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A queue shop on the one shop screen.
///
/// Choosing and paying stay on it. Once the place lands the tick plays and the
/// screen gives way to the live bar, which is where the wait is followed.
class QueueFlowView extends StatefulWidget {
  const QueueFlowView({super.key});

  @override
  State<QueueFlowView> createState() => _QueueFlowViewState();
}

class _QueueFlowViewState extends State<QueueFlowView> {
  /// How long the tick is on screen before the live bar takes over.
  static const Duration _celebration = Duration(milliseconds: 1500);

  bool _placed = false;

  void _onPlaced() {
    HapticFeedback.mediumImpact();
    setState(() => _placed = true);
    Future<void>.delayed(_celebration, () {
      if (mounted) context.router.maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QueueFlowCubit, QueueFlowState>(
      listener: (context, state) {
        if (state.failure case final failure?) {
          AppSnackBar.error(context, failure.localized(context));
        }
      },
      listenWhen: (before, after) {
        if (before.step == QueueStep.paying && after.step == QueueStep.inLine) {
          _onPlaced();
        }
        return before.failure != after.failure;
      },
      builder: (context, state) {
        final cubit = context.read<QueueFlowCubit>();

        if (_placed) {
          final t = context.t.shopScreen;

          return QueueOverview(
            state: state,
            overlay: PayPanel(
              onDismiss: null,
              children: [
                PayDone(
                  title: t.placed,
                  line: t.placedAt(shop: state.shop?.name ?? ''),
                ),
              ],
            ),
          );
        }

        if (state.isLoading && state.queue == null) {
          return const AppScaffold(body: AppLoader.centered());
        }

        return switch (state.step) {
          QueueStep.inLine => AppScaffold(
            padding: EdgeInsets.zero,
            appBar: AppAppBar(title: state.shop?.name ?? ''),
            body: SafeArea(top: false, child: QueueLineView(state: state)),
          ),
          QueueStep.ended => AppScaffold(
            padding: EdgeInsets.zero,
            body: SafeArea(
              child: QueueEndedView(
                state: state,
                onDone: () => context.router.maybePop(),
              ),
            ),
          ),
          QueueStep.overview => QueueOverview(state: state),
          _ => PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop && !state.isBusy) cubit.back();
            },
            child: QueueOverview(
              state: state,
              overlay: QueueSummary(state: state),
            ),
          ),
        };
      },
    );
  }
}

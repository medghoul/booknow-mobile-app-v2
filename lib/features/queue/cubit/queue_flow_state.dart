import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_flow_state.freezed.dart';

/// Which of the queue screens is in front (queue spec §4).
enum QueueStep {
  /// The live line and the services: "Mettiti in coda".
  overview,

  /// The summary before paying.
  confirm,

  /// The Payment Sheet is up, or the app is waiting for the webhook to give
  /// the place.
  paying,

  /// The card was refused; nothing was charged.
  declined,

  /// In line: waiting, called, or in the chair.
  inLine,

  /// Out of line: left, removed, served, or the day ended.
  ended,
}

@freezed
abstract class QueueFlowState with _$QueueFlowState {
  const factory QueueFlowState({
    required String shopId,
    @Default(QueueStep.overview) QueueStep step,
    Shop? shop,
    ShopQueue? queue,
    ShopService? service,

    /// The pending place and its payment, kept so a closed sheet re-opens the
    /// same payment instead of asking the server for a second place.
    QueueJoin? join,

    /// The customer's own place while in line.
    QueueEntry? entry,

    /// Set once the customer left, to say whether the fee came back.
    bool? leftRefunded,
    @Default(true) bool isLoading,
    @Default(false) bool isBusy,

    /// The clock the "your turn" countdown is drawn against.
    required DateTime now,
    NetworkException? failure,
  }) = _QueueFlowState;

  const QueueFlowState._();

  List<ShopService> get services => shop?.activeServices ?? const [];

  bool get canJoin => (queue?.isAccepting ?? false) && service != null;

  /// What is left of the ten minutes after being called, or null.
  Duration? get turnLeft {
    final until = entry?.noShowFrom;
    if (until == null) return null;
    final left = until.difference(now);
    return left.isNegative ? Duration.zero : left;
  }

  bool get isCalled => entry?.status == QueueEntryStatus.called;

  bool get isServing => entry?.status == QueueEntryStatus.serving;
}

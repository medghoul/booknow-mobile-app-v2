import 'package:booknow_mobile/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// The live-queue states. Pills always carry text as well, so a state is never
/// told by colour alone.
@immutable
class QueueColors extends ThemeExtension<QueueColors> {
  const QueueColors({
    required this.waiting,
    required this.yourTurn,
    required this.closed,
  });

  final Color waiting;
  final Color yourTurn;
  final Color closed;

  static const QueueColors light = QueueColors(
    waiting: AppColors.lightWaiting,
    yourTurn: AppColors.lightYourTurn,
    closed: AppColors.lightClosed,
  );

  static const QueueColors dark = QueueColors(
    waiting: AppColors.darkWaiting,
    yourTurn: AppColors.darkYourTurn,
    closed: AppColors.darkClosed,
  );

  @override
  QueueColors copyWith({Color? waiting, Color? yourTurn, Color? closed}) =>
      QueueColors(
        waiting: waiting ?? this.waiting,
        yourTurn: yourTurn ?? this.yourTurn,
        closed: closed ?? this.closed,
      );

  @override
  QueueColors lerp(ThemeExtension<QueueColors>? other, double t) {
    if (other is! QueueColors) return this;
    return QueueColors(
      waiting: Color.lerp(waiting, other.waiting, t)!,
      yourTurn: Color.lerp(yourTurn, other.yourTurn, t)!,
      closed: Color.lerp(closed, other.closed, t)!,
    );
  }
}

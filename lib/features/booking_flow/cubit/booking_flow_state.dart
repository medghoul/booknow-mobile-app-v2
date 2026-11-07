import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_flow_state.freezed.dart';

/// Which of the flow's screens is in front (§3.3 – §3.5).
enum BookingStep {
  /// Choosing the day and the time.
  slot,

  /// Reading the summary before paying.
  confirm,

  /// The Payment Sheet is up, or the app is waiting for the webhook.
  paying,

  /// The card was refused and the slot is still held.
  declined,

  /// Paid and confirmed.
  done,
}

@freezed
abstract class BookingFlowState with _$BookingFlowState {
  const factory BookingFlowState({
    required String shopId,
    required String date,
    @Default(BookingStep.slot) BookingStep step,
    Shop? shop,
    ShopService? service,
    Availability? availability,
    DateTime? start,
    BookingHold? hold,
    Booking? booking,
    @Default(true) bool isLoading,
    @Default(false) bool isBusy,

    /// The clock the hold countdown is drawn against.
    required DateTime now,
    NetworkException? failure,
  }) = _BookingFlowState;

  const BookingFlowState._();

  /// The services the customer may choose between, cheapest order first.
  List<ShopService> get services => shop?.services ?? const [];

  /// Whether a service still has to be picked before times mean anything.
  bool get needsService => service == null && services.length > 1;

  /// What is left of the payment window, or null when nothing is held.
  Duration? get holdLeft {
    final expiry = hold?.holdExpiresAt;
    if (expiry == null) return null;

    final left = expiry.difference(now);
    return left.isNegative ? Duration.zero : left;
  }

  /// Whether the held slot has run out while the customer was deciding.
  bool get holdLapsed => holdLeft == Duration.zero;
}

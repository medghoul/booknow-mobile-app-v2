import 'package:freezed_annotation/freezed_annotation.dart';
import 'booking.dart';
import 'free_slot.dart';
import 'shop_summary.dart';

part 'customer_home.freezed.dart';

/// Everything the customer's home screen draws, from one call.
///
/// Three questions the screen asks at once — what have I booked, what is free
/// now, which shops are near me — so it draws once instead of settling in
/// three stages.
@freezed
abstract class CustomerHome with _$CustomerHome {
  const factory CustomerHome({
    required Booking? nextBooking,
    required List<FreeSlot> freeToday,

    /// How many free times there are in all, for the "+8 more times" card.
    required int freeTodayTotal,
    required List<ShopSummary> shops,
  }) = _CustomerHome;

  const CustomerHome._();

  /// How many free times the carousel is not showing.
  int get moreTimes => freeTodayTotal - freeToday.length < 0
      ? 0
      : freeTodayTotal - freeToday.length;
}

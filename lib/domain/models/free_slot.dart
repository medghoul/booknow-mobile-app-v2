import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_slot.freezed.dart';

/// One bookable start time, with the shop and service behind it.
///
/// The carousel shows the time first, then the shop and the price, because
/// once there is more than one shop "15:00" on its own means nothing. Tapping
/// one opens the summary already filled in, which is why the slot carries the
/// service and not only the hour.
@freezed
abstract class FreeSlot with _$FreeSlot {
  const factory FreeSlot({
    required String shopId,
    required String? shopName,
    required String serviceId,
    required String serviceName,
    required int durationMinutes,
    required int priceCents,
    required DateTime startUtc,
  }) = _FreeSlot;
}

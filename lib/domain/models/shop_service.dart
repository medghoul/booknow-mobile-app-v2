import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_service.freezed.dart';

/// A service a shop offers: what it is called, how long it takes, what it
/// costs.
///
/// [durationMinutes] is what decides slot length in the agenda, so it is not
/// cosmetic. [priceCents] is display-only in v0 — the haircut is paid in the
/// shop; only the BookNow fee goes through the app.
@freezed
abstract class ShopService with _$ShopService {
  const factory ShopService({
    required String id,
    required String name,
    required int durationMinutes,
    required int priceCents,
    @Default(true) bool isActive,
    @Default(0) int order,
  }) = _ShopService;

  const ShopService._();

  /// The four durations the design offers as chips.
  static const List<int> durationChoices = [15, 30, 45, 60];
}

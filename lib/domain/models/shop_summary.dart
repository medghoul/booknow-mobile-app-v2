import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_summary.freezed.dart';

/// A shop as the carousels and the directory show it.
///
/// Not [Shop]: that is the owner's own record, with hours, closures and draft
/// fields the customer has no use for. This is the card — where it is, whether
/// it is open, and what the cheapest thing in it costs.
@freezed
abstract class ShopSummary with _$ShopSummary {
  const factory ShopSummary({
    required String id,
    required String? name,
    required String? addressLine,
    required String? city,

    /// Null when the customer declined the location prompt, in which case the
    /// list is ordered by name instead.
    required int? distanceMeters,
    required bool openNow,

    /// Wall-clock time in the shop's own zone, while it is open.
    required String? closesAt,

    /// When it opens next, while it is shut.
    required String? opensAt,
    required int activeServices,
    required int? fromPriceCents,
    required String? photoUrl,

    /// Whether the card says "Su appuntamento" or "Senza appuntamento".
    @Default(ShopMode.booking) ShopMode mode,

    /// The business category, once the API sends one (roadmap step 4). Null
    /// until then, and a null shop stays visible in every category.
    String? category,
  }) = _ShopSummary;
}

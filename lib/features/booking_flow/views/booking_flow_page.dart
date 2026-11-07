import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/features/booking_flow/views/shop_flow.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:flutter/material.dart';

/// Choosing a time, paying for it, and the confirmation.
///
/// [startUtc] is set when the customer came in from a free-slot card or from
/// "Paga ora": the day opens on that time with it already chosen.
@RoutePage()
class BookingFlowPage extends StatelessWidget {
  const BookingFlowPage({
    super.key,
    @PathParam('shopId') required this.shopId,
    this.serviceId,
    this.startUtc,
    this.initialDate,
    this.preview = false,
    this.category,
    this.distanceMeters,
  });

  final String shopId;
  final String? serviceId;
  final DateTime? startUtc;

  /// `YYYY-MM-DD`: opens on this day, for "Tomorrow" on Discover.
  final String? initialDate;

  /// An owner looking at their own shop: nothing here can be booked.
  final bool preview;

  /// What the card that opened this already knew about the shop.
  final ShopCategory? category;
  final int? distanceMeters;

  @override
  Widget build(BuildContext context) {
    return ShopFlow(
      shopId: shopId,
      initial: ShopMode.booking,
      serviceId: serviceId,
      startUtc: startUtc,
      initialDate: initialDate,
      preview: preview,
      category: category,
      distanceMeters: distanceMeters,
    );
  }
}

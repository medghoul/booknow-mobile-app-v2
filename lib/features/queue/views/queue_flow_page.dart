import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/features/booking_flow/views/shop_flow.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:flutter/material.dart';

/// A shop's live line: joining it, and following it to the chair. Opened from a
/// shop card, and from the "Sei in coda" home card.
@RoutePage()
class QueueFlowPage extends StatelessWidget {
  const QueueFlowPage({
    super.key,
    @PathParam('shopId') required this.shopId,
    this.preview = false,
    this.category,
    this.distanceMeters,
  });

  final String shopId;

  /// An owner looking at their own shop: nothing here can be joined.
  final bool preview;

  /// What the card that opened this already knew about the shop.
  final ShopCategory? category;
  final int? distanceMeters;

  @override
  Widget build(BuildContext context) {
    return ShopFlow(
      shopId: shopId,
      initial: ShopMode.queue,
      preview: preview,
      category: category,
      distanceMeters: distanceMeters,
    );
  }
}

/// Where a shop is in its lifecycle.
///
/// Only [active] is ever visible to customers. A [draft] shop is the owner's
/// half-finished wizard and must stay out of every customer query; [deleted]
/// is what an owner's account deletion leaves behind, kept so past bookings
/// still resolve.
enum ShopStatus {
  draft('draft'),
  active('active'),
  deleted('deleted');

  const ShopStatus(this.wireName);

  final String wireName;

  bool get isPublished => this == ShopStatus.active;

  static ShopStatus fromWire(String? value) {
    for (final status in ShopStatus.values) {
      if (status.wireName == value) return status;
    }
    // An unknown status from a newer API must not read as published.
    return ShopStatus.draft;
  }
}

sealed class ShopOpenStatus {}

class ShopOpen extends ShopOpenStatus {
  final String closesAt;
  ShopOpen({required this.closesAt});
}

class ShopClosedUntil extends ShopOpenStatus {
  final String opensAt;
  ShopClosedUntil({required this.opensAt});
}

class ShopClosedToday extends ShopOpenStatus {
  ShopClosedToday();
}

import 'package:booknow_mobile/domain/models/opening_hours.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_provider.freezed.dart';

/// Who or what does the work in a shop: a barber, or a chair (providers §2).
enum ProviderType {
  person('person'),
  resource('resource');

  const ProviderType(this.wireName);

  final String wireName;

  /// Absent or unknown reads as [person], which is what every shop had before
  /// a type existed.
  static ProviderType fromWire(String? value) => ProviderType.values.firstWhere(
    (type) => type.wireName == value,
    orElse: () => ProviderType.person,
  );
}

/// One of the people (or chairs) in a shop, with their own week and services.
///
/// Every shop has one whose [id] is the shop's own: the default provider,
/// standing for the owner. A shop that never added anybody still has it, so
/// a shop with one provider is simply a shop.
///
/// The owner's own shop carries every field. The page a customer sees carries
/// only who can be chosen, so there [openingHours] and [timeOff] are left at
/// their defaults rather than meaning "the shop's hours, no days off".
@freezed
abstract class ShopProvider with _$ShopProvider {
  const factory ShopProvider({
    required String id,

    /// Null only on the default provider of a draft shop with no name yet; the
    /// server resolves it to the shop's name everywhere else.
    String? name,

    @Default(ProviderType.person) ProviderType type,

    /// Null means every active service, including ones added later.
    List<String>? serviceIds,

    /// Null means the shop's hours. Never wider than them: the server reads
    /// the two together.
    OpeningHours? openingHours,

    /// Days off, as `YYYY-MM-DD` in the shop's zone.
    @Default(<String>[]) List<String> timeOff,

    @Default(true) bool isActive,
    @Default(0) int order,
  }) = _ShopProvider;

  const ShopProvider._();

  bool get doesEveryService => serviceIds == null;

  bool get hasOwnHours => openingHours != null;

  bool does(String serviceId) =>
      serviceIds == null || serviceIds!.contains(serviceId);

  /// The default provider stands for the owner and can never be removed.
  bool isDefaultOf(String shopId) => id == shopId;
}

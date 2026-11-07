import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/opening_hours.dart';
import 'package:booknow_mobile/domain/models/shop_address.dart';
import 'package:booknow_mobile/domain/models/shop_provider.dart';
import 'package:booknow_mobile/domain/models/shop_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';

/// An owner's shop.
///
/// Everything except [id] and [status] is optional, because a shop exists as a
/// `draft` from the moment the owner picks the owner role — long before any of
/// it is filled in. What makes a shop publishable is [missingForPublish] being
/// empty, not the fields being non-null one by one.
@freezed
abstract class Shop with _$Shop {
  const factory Shop({
    required String id,
    required ShopStatus status,
    String? name,
    String? phone,
    String? photoUrl,
    ShopAddress? address,
    @Default(OpeningHours()) OpeningHours openingHours,
    @Default(<String>[]) List<String> closures,
    @Default(<ShopService>[]) List<ShopService> services,

    /// Who does the work, by display order. The owner's own shop lists the
    /// removed ones too; the page a customer sees lists only who can be chosen.
    @Default(<ShopProvider>[]) List<ShopProvider> providers,

    /// What holding a slot here costs, sent with the customer-facing shop page
    /// only. Null on the owner's own shop, which never shows it.
    int? feeCents,

    /// Bookings or a live queue; everything saved before queue mode reads as
    /// [ShopMode.booking].
    @Default(ShopMode.booking) ShopMode mode,
  }) = _Shop;

  const Shop._();

  List<ShopService> get activeServices =>
      services.where((service) => service.isActive).toList();

  List<ShopProvider> get activeProviders =>
      providers.where((provider) => provider.isActive).toList();

  /// More than one person to choose between. Below that, every screen reads
  /// exactly as it did before a shop could have a team (providers §0).
  bool get hasTeam => activeProviders.length > 1;

  /// Who does [serviceId], by display order.
  List<ShopProvider> providersFor(String serviceId) =>
      activeProviders.where((provider) => provider.does(serviceId)).toList();

  /// The name to show for [providerId]: theirs, or the shop's for a default
  /// provider not given one yet.
  String? providerName(String? providerId) {
    for (final provider in providers) {
      if (provider.id == providerId) return provider.name ?? name;
    }
    return null;
  }

  // ─── What publishing requires ───────────────────────────────────────────────
  // Mirrors the server's validation for `POST /shops/me/publish`, so the app
  // can keep the button honest instead of letting the owner tap it and read a
  // 422 back. The server stays the authority; this is only the local echo.

  bool get hasShopDetails =>
      (name?.trim().isNotEmpty ?? false) && (phone?.trim().isNotEmpty ?? false);

  bool get hasAddress => address?.isGeocoded ?? false;

  bool get hasServices => activeServices.isNotEmpty;

  bool get hasHours => openingHours.hasAnyOpenDay && openingHours.isValid;

  bool get canPublish =>
      hasShopDetails && hasAddress && hasServices && hasHours;

  /// The steps still missing, in wizard order — what the review screen lists
  /// and what decides where an interrupted wizard resumes.
  List<ShopSetupStep> get missingForPublish => [
    if (!hasShopDetails) ShopSetupStep.shop,
    if (!hasAddress) ShopSetupStep.address,
    if (!hasServices) ShopSetupStep.services,
    if (!hasHours) ShopSetupStep.hours,
  ];

  /// Where to drop an owner who left the wizard half-finished.
  ///
  /// The first incomplete step, or the review when everything is there — never
  /// back to step one, which would make a returning owner redo work.
  ShopSetupStep get resumeStep =>
      missingForPublish.firstOrNull ?? ShopSetupStep.review;

  ShopOpenStatus openStatusAt(DateTime dateTime) {
    // Return appropriate ShopOpenStatus based on business hours
    return ShopClosedToday();
  }

  bool isComplete(ShopSetupStep step) => switch (step) {
    ShopSetupStep.shop => hasShopDetails,
    ShopSetupStep.address => hasAddress,
    ShopSetupStep.services => hasServices,
    ShopSetupStep.hours => hasHours,
    ShopSetupStep.review => canPublish,
  };
}

extension ShopStatusExtension on Shop {
  ShopOpenStatus openStatusAt(DateTime dateTime) {
    // Add your business hours logic here.
    // For example:

    // If the shop is currently open:
    return ShopOpen(closesAt: '19:30');

    // If closed but opening later today:
    // return ShopClosedUntil(opensAt: '09:00');

    // If closed for the entire day:
    // return ShopClosedToday();
  }
}

import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_setup_state.freezed.dart';

@freezed
abstract class ShopSetupState with _$ShopSetupState {
  const factory ShopSetupState({
    @Default(ShopSetupStep.shop) ShopSetupStep step,

    /// Null only until the shop has been loaded or created.
    Shop? shop,

    @Default(<PlaceSuggestion>[]) List<PlaceSuggestion> suggestions,

    /// The initial load — `GET /me/shop`, and `POST /shops` if there isn't one.
    @Default(true) bool isLoading,

    /// A step is being saved. Blocks the step's own action, not the whole
    /// screen: the owner can still read what they typed.
    @Default(false) bool isSaving,

    @Default(false) bool isSearching,

    /// Publishing succeeded; the host navigates away on this.
    @Default(false) bool isPublished,

    /// The service the inline card is editing, or null when it is adding a new
    /// one. The card is the same either way — there is no modal to lose, which
    /// is the point of editing in place.
    String? editingServiceId,

    /// The file the owner just picked, shown while it uploads so the preview
    /// is instant. A path rather than an `XFile`, which has no value equality
    /// and would defeat the state's `==`.
    String? pendingPhotoPath,

    /// Separate from [isSaving] so a photo upload does not put the step's
    /// Continue button into a loading state it has nothing to do with.
    @Default(false) bool isUploadingPhoto,

    NetworkException? failure,
  }) = _ShopSetupState;

  const ShopSetupState._();

  bool get isBusy => isLoading || isSaving;

  bool get canPublish => shop?.canPublish ?? false;
}

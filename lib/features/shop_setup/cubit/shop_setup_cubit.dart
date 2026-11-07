import 'package:booknow_mobile/core/error/api_error_code.dart';
import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/utils/ui/debouncer.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_state.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Drives the owner's shop wizard.
///
/// Every step saves as it is completed, so there is never an unsaved draft
/// living only in the app — that is what lets an interrupted wizard resume
/// exactly where it stopped.
class ShopSetupCubit extends Cubit<ShopSetupState> {
  ShopSetupCubit(
    this._shops, {
    ShopSetupStep? startAt,
    bool returnToChecklist = false,
  }) : _startAt = startAt,
       _returnToChecklist = returnToChecklist,
       super(const ShopSetupState());

  final ShopRepository _shops;
  final ShopSetupStep? _startAt;

  /// First setup is a checklist: finishing a step goes back to it, rather than
  /// on to the next step.
  final bool _returnToChecklist;

  /// Address search runs per keystroke; without this it would be a request
  /// per character.
  final Debouncer _search = Debouncer(
    duration: const Duration(milliseconds: 350),
  );

  /// Loads the shop, creating it if the owner has none yet.
  Future<void> start() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final existing = await _shops.getMyShop();

    await existing.fold(
      onSuccess: (shop) async {
        if (shop != null) {
          emit(
            state.copyWith(
              shop: shop,
              // The caller may pin the step (resuming from the router);
              // otherwise the shop decides.
              step: _startAt ?? shop.resumeStep,
              isLoading: false,
            ),
          );
          return;
        }

        final created = await _shops.createShop();
        emit(
          created.fold(
            onSuccess: (shop) => state.copyWith(
              shop: shop,
              step: _startAt ?? ShopSetupStep.shop,
              isLoading: false,
            ),
            onFailure: (error) =>
                state.copyWith(isLoading: false, failure: error),
          ),
        );
      },
      onFailure: (error) async =>
          emit(state.copyWith(isLoading: false, failure: error)),
    );
  }

  void goTo(ShopSetupStep step) => emit(state.copyWith(step: step));

  /// The address step advances on its own button rather than on picking a
  /// suggestion, so the owner can see the pin land before committing.
  void goToServices() => stepDone(ShopSetupStep.services);

  /// A step's Continue: on to [next], or back to the checklist.
  void stepDone(ShopSetupStep next) =>
      goTo(_returnToChecklist ? ShopSetupStep.review : next);

  /// Re-reads the shop, after a screen outside this cubit may have changed it.
  Future<void> reload() => _reload();

  void back() {
    final previous = state.step.previous;
    if (previous != null) emit(state.copyWith(step: previous));
  }

  /// Saves step 1 and moves on.
  Future<void> saveShopDetails({required String name, required String phone}) =>
      _save(
        () => _shops.updateShop(name: name, phone: phone),
        then: ShopSetupStep.address,
      );

  /// Saves the shop's own details without moving the wizard on.
  ///
  /// The screen the owner reaches from their profile holds the same fields as
  /// step 1, but it is not a step: there is nowhere to advance to, and the
  /// save sends them back where they came from. Returns whether it landed,
  /// because that is what the screen pops on.
  Future<bool> saveShopInfo({
    required String name,
    required String phone,
  }) async {
    if (state.isSaving) return false;
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _shops.updateShop(name: name, phone: phone);
    if (isClosed) return false;

    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(shop: shop, isSaving: false),
        onFailure: (error) => state.copyWith(isSaving: false, failure: error),
      ),
    );

    return result.fold(onSuccess: (_) => true, onFailure: (_) => false);
  }

  /// Step 2. Only a chosen suggestion is accepted — free text cannot be
  /// geocoded reliably, so the server takes the id and resolves it.
  Future<void> chooseAddress(String placeId) async {
    if (state.isSaving) return;

    emit(
      state.copyWith(
        isSaving: true,
        failure: null,
        suggestions: const [],
        isSearching: false,
      ),
    );

    final result = await _shops.updateShop(placeId: placeId);
    if (isClosed) return;

    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(shop: shop, isSaving: false),
        onFailure: (error) => state.copyWith(isSaving: false, failure: error),
      ),
    );
  }

  /// Uploads the photo and keeps the local file on screen until the server
  /// has one to serve back.
  ///
  /// The preview switches from the file to the shop's own URL only once the
  /// upload has landed, so a failure leaves the owner looking at the photo
  /// they picked rather than at an empty panel.
  Future<void> uploadPhoto({
    required String filePath,
    required String contentType,
  }) async {
    if (state.isUploadingPhoto) return;

    emit(
      state.copyWith(
        pendingPhotoPath: filePath,
        isUploadingPhoto: true,
        failure: null,
      ),
    );

    final result = await _shops.uploadPhoto(
      filePath: filePath,
      contentType: contentType,
    );
    if (isClosed) return;

    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(
          shop: shop,
          isUploadingPhoto: false,
          pendingPhotoPath: null,
        ),
        // The file stays on screen: it is still the owner's choice, and
        // retrying is one tap rather than one tap plus finding it again.
        onFailure: (error) =>
            state.copyWith(isUploadingPhoto: false, failure: error),
      ),
    );
  }

  Future<void> removePhoto() async {
    if (state.isUploadingPhoto) return;

    emit(state.copyWith(isUploadingPhoto: true, failure: null));

    final result = await _shops.removePhoto();
    if (isClosed) return;

    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(
          shop: shop,
          isUploadingPhoto: false,
          pendingPhotoPath: null,
        ),
        onFailure: (error) =>
            state.copyWith(isUploadingPhoto: false, failure: error),
      ),
    );
  }

  void searchAddresses(String query) {
    if (query.trim().length < 3) {
      _search.cancel();
      emit(state.copyWith(suggestions: const [], isSearching: false));
      return;
    }

    emit(state.copyWith(isSearching: true));
    _search.run(() async {
      final result = await _shops.searchAddresses(query);
      if (isClosed) return;
      emit(
        result.fold(
          onSuccess: (suggestions) =>
              state.copyWith(suggestions: suggestions, isSearching: false),
          onFailure: (error) =>
              state.copyWith(isSearching: false, failure: error),
        ),
      );
    });
  }

  /// Step 3. Each service is saved as it is added, so the list the owner sees
  /// is the list the server has.
  Future<void> addService({
    required String name,
    required int durationMinutes,
    required int priceCents,
  }) async {
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _shops.addService(
      name: name,
      durationMinutes: durationMinutes,
      priceCents: priceCents,
    );

    if (result.isFailure) {
      emit(state.copyWith(isSaving: false, failure: result.errorOrNull));
      return;
    }
    await _reload();
  }

  /// Puts the inline card into edit mode for an existing service.
  void startEditingService(String serviceId) =>
      emit(state.copyWith(editingServiceId: serviceId, failure: null));

  void cancelEditingService() => emit(state.copyWith(editingServiceId: null));

  /// Saves the inline card — a new service, or the one being edited.
  Future<void> saveService({
    required String name,
    required int durationMinutes,
    required int priceCents,
  }) async {
    final editingId = state.editingServiceId;
    if (editingId == null) {
      return addService(
        name: name,
        durationMinutes: durationMinutes,
        priceCents: priceCents,
      );
    }

    emit(state.copyWith(isSaving: true, failure: null));
    final result = await _shops.updateService(
      editingId,
      name: name,
      durationMinutes: durationMinutes,
      priceCents: priceCents,
    );

    if (result.isFailure) {
      emit(state.copyWith(isSaving: false, failure: result.errorOrNull));
      return;
    }
    emit(state.copyWith(editingServiceId: null));
    await _reload();
  }

  /// Saves one service from the editor opened off the services screen, and
  /// says whether it landed.
  ///
  /// A null [serviceId] adds a new one. Separate from [saveService], which
  /// the wizard's inline card drives through [ShopSetupState.editingServiceId]:
  /// the editor is a sheet that already knows which service it is holding, so
  /// routing that through state would be a second answer to the same
  /// question. The bool is what the sheet closes on.
  Future<bool> saveServiceDetails({
    String? serviceId,
    required String name,
    required int durationMinutes,
    required int priceCents,
  }) async {
    if (state.isSaving) return false;
    emit(state.copyWith(isSaving: true, failure: null));

    final result = serviceId == null
        ? await _shops.addService(
            name: name,
            durationMinutes: durationMinutes,
            priceCents: priceCents,
          )
        : await _shops.updateService(
            serviceId,
            name: name,
            durationMinutes: durationMinutes,
            priceCents: priceCents,
          );
    if (isClosed) return false;

    if (result.isFailure) {
      emit(state.copyWith(isSaving: false, failure: result.errorOrNull));
      return false;
    }

    await _reload();
    return true;
  }

  /// Deletes a service and says whether it went.
  ///
  /// The caller confirms the message, not this: the wizard's step and the
  /// services screen both delete through here, and only they know which
  /// surface the owner is looking at.
  Future<bool> removeService(String serviceId) async {
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _shops.deleteService(serviceId);
    if (isClosed) return false;

    if (result.isFailure) {
      emit(state.copyWith(isSaving: false, failure: result.errorOrNull));
      return false;
    }

    await _reload();
    return true;
  }

  /// Saves one person on the team and says whether it landed.
  ///
  /// A null [providerId] adds someone. [name] and [type] are sent only when
  /// they changed: the owner's own provider shows the shop's name until it is
  /// given one, and saving it back unchanged would pin a copy that a later
  /// shop rename leaves behind.
  Future<bool> saveProvider({
    String? providerId,
    String? name,
    ProviderType? type,
    required List<String>? serviceIds,
    required OpeningHours? openingHours,
    required List<String> timeOff,
  }) => _write(
    () => providerId == null
        ? _shops.addProvider(
            name: name ?? '',
            type: type ?? ProviderType.person,
            serviceIds: serviceIds,
            openingHours: openingHours,
            timeOff: timeOff,
          )
        : _shops.updateProvider(
            providerId,
            name: name,
            type: type,
            serviceIds: serviceIds,
            openingHours: openingHours,
            timeOff: timeOff,
          ),
  );

  /// Takes someone off the team. The caller has already asked.
  Future<bool> removeProvider(String providerId) =>
      _write(() => _shops.removeProvider(providerId));

  /// Puts someone removed back on the team, with the same id and history.
  Future<bool> restoreProvider(String providerId) =>
      _write(() => _shops.restoreProvider(providerId));

  /// Runs one write, re-reads the shop on success, and says whether it
  /// landed. A failure stays in [ShopSetupState.failure] for the screen.
  Future<bool> _write(Future<ApiResult<Object?>> Function() call) async {
    if (state.isSaving) return false;
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await call();
    if (isClosed) return false;

    if (result.isFailure) {
      emit(state.copyWith(isSaving: false, failure: result.errorOrNull));
      return false;
    }

    await _reload();
    return true;
  }

  /// Step 4.
  Future<void> saveHours(OpeningHours hours, {List<String>? closures}) => _save(
    () => _shops.updateShop(openingHours: hours, closures: closures),
    then: ShopSetupStep.review,
  );

  /// Saves the weekly hours without moving the wizard on, and says whether it
  /// landed.
  ///
  /// The hours screen reached from the profile saves one day at a time — the
  /// sheet that edited it closes on this — so there is no step to advance and
  /// no Continue button to leave in a loading state.
  Future<bool> saveOpeningHours(OpeningHours hours) async {
    if (state.isSaving) return false;
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _shops.updateShop(openingHours: hours);
    if (isClosed) return false;

    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(shop: shop, isSaving: false),
        onFailure: (error) => state.copyWith(isSaving: false, failure: error),
      ),
    );

    return result.fold(onSuccess: (_) => true, onFailure: (_) => false);
  }

  /// Step 5 — validates server-side and flips the shop to active.
  ///
  /// A 422 means the owner is missing something; rather than only showing the
  /// message, the wizard jumps back to the first incomplete step so the fix is
  /// one tap away.
  Future<void> publish() async {
    emit(state.copyWith(isSaving: true, failure: null));

    final result = await _shops.publish();

    emit(
      result.fold(
        onSuccess: (shop) =>
            state.copyWith(shop: shop, isSaving: false, isPublished: true),
        onFailure: (error) => state.copyWith(
          isSaving: false,
          failure: error,
          step: error.code == ApiErrorCode.shopIncomplete
              ? (state.shop?.missingForPublish.firstOrNull ?? state.step)
              : state.step,
        ),
      ),
    );
  }

  /// Saves through [call] and, on success, advances to [then].
  Future<void> _save(
    Future<ApiResult<Shop>> Function() call, {
    required ShopSetupStep then,
  }) async {
    emit(state.copyWith(isSaving: true, failure: null));
    final result = await call();

    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(
          shop: shop,
          isSaving: false,
          step: _returnToChecklist ? ShopSetupStep.review : then,
        ),
        onFailure: (error) => state.copyWith(isSaving: false, failure: error),
      ),
    );
  }

  /// Re-reads the shop so the screen shows what the server holds, not what
  /// the app guessed.
  Future<void> _reload() async {
    final result = await _shops.getMyShop();
    emit(
      result.fold(
        onSuccess: (shop) => state.copyWith(shop: shop, isSaving: false),
        onFailure: (error) => state.copyWith(isSaving: false, failure: error),
      ),
    );
  }

  @override
  Future<void> close() {
    _search.dispose();
    return super.close();
  }
}

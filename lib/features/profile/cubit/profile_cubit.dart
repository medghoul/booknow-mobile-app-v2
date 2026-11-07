import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/services/push/push_service.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/profile/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Loads what the profile screen shows about the owner's shop.
///
/// Reloads on demand rather than listening: the screens that change a shop
/// are pushed over this one and pop back to it, and the page asks for a
/// reload when they do. Nothing rebuilds on its own — a tab's route outlives
/// everything pushed on top of it.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._shops, this._push) : super(const ProfileState());

  final ShopRepository _shops;
  final PushService _push;

  Future<void> load() async {
    if (!isClosed) emit(state.copyWith(isLoading: true, failure: null));

    final result = await _shops.getMyShop();
    if (isClosed) return;

    result.fold(
      onSuccess: (shop) =>
          emit(state.copyWith(shop: shop, isLoading: false, failure: null)),
      // A customer has no shop and never will; the owner sections simply do
      // not render. Only a real failure is worth surfacing.
      onFailure: (error) =>
          emit(state.copyWith(isLoading: false, failure: error)),
    );
  }

  /// Re-reads whether the phone will deliver notifications at all.
  ///
  /// The row says "Attive" or "Disattivate", and it has to agree with the
  /// phone: the user can revoke the permission in the OS settings — which is
  /// exactly where the notifications screen sends them — without the app
  /// hearing about it. A live read also outlives the FCM token, which is kept
  /// after the permission goes away and so would keep the row saying "Attive".
  Future<void> refreshNotifications() async {
    final isAllowed = await _push.hasPermission();
    if (isClosed) return;

    emit(state.copyWith(notificationsEnabled: isAllowed));
  }
}

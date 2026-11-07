import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

/// What the profile screen needs beyond the signed-in user.
///
/// The user comes from `AuthCubit`, which already holds it — re-fetching it
/// here would give the screen a second, staler copy of the same thing. The
/// shop is loaded here because only this screen and the wizard read it, and
/// the notification permission because only this screen reports it.
@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    Shop? shop,
    @Default(true) bool isLoading,
    NetworkException? failure,

    /// Whether the phone will deliver what the app sends, as the OS reports
    /// it — not whether the user wants it. Null until the first answer comes
    /// back, so the row shows no value rather than a guess it corrects a
    /// frame later.
    bool? notificationsEnabled,
  }) = _ProfileState;

  const ProfileState._();

  /// An owner who has not finished the wizard has a shop with no name yet.
  /// The row still shows — it is how they get back to finishing it.
  bool get hasShopDetails => shop?.name != null;
}

import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:booknow_mobile/data/dtos/notification_preferences_dto.dart';
import 'package:booknow_mobile/domain/models/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// `GET /me`, and the body `PATCH /me` and `POST /me/role` answer with.
///
/// Every field is nullable and loosely typed on purpose: this layer only has
/// to get the body in without throwing. What the domain actually requires is
/// enforced in [UserProfileDtoX.toDomain].
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    /// The Cognito subject. `id` is accepted as well because that is what a
    /// stubbed or older build sends.
    @JsonKey(name: 'sub') Object? sub,
    @JsonKey(name: 'id') Object? id,
    @JsonKey(name: 'name') Object? name,
    @JsonKey(name: 'email') Object? email,
    @JsonKey(name: 'phone') Object? phone,
    @JsonKey(name: 'role') Object? role,
    @JsonKey(name: 'profileSetupSeen') Object? profileSetupSeen,
    @JsonKey(name: 'notificationPrefs') Object? notificationPrefs,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}

extension UserProfileDtoX on UserProfileDto {
  UserProfile toDomain() => UserProfile(
    id: asText(sub, asText(id)),
    name: asText(name),
    email: asText(email),
    phone: asTextOrNull(phone),
    role: UserRole.fromWire(asTextOrNull(role)),
    profileSetupSeen: asBool(profileSetupSeen, fallback: false),
    notificationPrefs: NotificationPreferencesDto.fromJson(
      asMap(notificationPrefs),
    ).toDomain(),
  );
}

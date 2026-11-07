// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    _UserProfileDto(
      sub: json['sub'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      profileSetupSeen: json['profileSetupSeen'],
      notificationPrefs: json['notificationPrefs'],
    );

Map<String, dynamic> _$UserProfileDtoToJson(_UserProfileDto instance) =>
    <String, dynamic>{
      'sub': ?instance.sub,
      'id': ?instance.id,
      'name': ?instance.name,
      'email': ?instance.email,
      'phone': ?instance.phone,
      'role': ?instance.role,
      'profileSetupSeen': ?instance.profileSetupSeen,
      'notificationPrefs': ?instance.notificationPrefs,
    };

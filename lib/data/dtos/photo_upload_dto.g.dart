// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_upload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhotoUploadDto _$PhotoUploadDtoFromJson(Map<String, dynamic> json) =>
    _PhotoUploadDto(
      uploadUrl: json['uploadUrl'],
      photoKey: json['photoKey'],
      expiresIn: json['expiresIn'],
    );

Map<String, dynamic> _$PhotoUploadDtoToJson(_PhotoUploadDto instance) =>
    <String, dynamic>{
      'uploadUrl': ?instance.uploadUrl,
      'photoKey': ?instance.photoKey,
      'expiresIn': ?instance.expiresIn,
    };

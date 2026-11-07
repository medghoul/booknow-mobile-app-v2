import 'package:booknow_mobile/data/dtos/coercion.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_upload_dto.freezed.dart';
part 'photo_upload_dto.g.dart';

/// `POST /shops/me/photo` — where to put the bytes, and what to call them.
@freezed
abstract class PhotoUploadDto with _$PhotoUploadDto {
  const factory PhotoUploadDto({
    @JsonKey(name: 'uploadUrl') Object? uploadUrl,
    @JsonKey(name: 'photoKey') Object? photoKey,
    @JsonKey(name: 'expiresIn') Object? expiresIn,
  }) = _PhotoUploadDto;

  factory PhotoUploadDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoUploadDtoFromJson(json);
}

/// The two fields the upload actually needs, once they are known to be there.
class PhotoUpload {
  const PhotoUpload({required this.uploadUrl, required this.photoKey});

  final String uploadUrl;
  final String photoKey;
}

extension PhotoUploadDtoX on PhotoUploadDto {
  /// Null when the server did not send a usable pair — there is nothing to
  /// upload to, and guessing would mean PUTting bytes at an empty string.
  PhotoUpload? toDomain() {
    final url = asTextOrNull(uploadUrl);
    final key = asTextOrNull(photoKey);
    if (url == null || key == null) return null;
    return PhotoUpload(uploadUrl: url, photoKey: key);
  }
}

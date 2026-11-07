// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_upload_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoUploadDto {

@JsonKey(name: 'uploadUrl') Object? get uploadUrl;@JsonKey(name: 'photoKey') Object? get photoKey;@JsonKey(name: 'expiresIn') Object? get expiresIn;
/// Create a copy of PhotoUploadDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoUploadDtoCopyWith<PhotoUploadDto> get copyWith => _$PhotoUploadDtoCopyWithImpl<PhotoUploadDto>(this as PhotoUploadDto, _$identity);

  /// Serializes this PhotoUploadDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoUploadDto&&const DeepCollectionEquality().equals(other.uploadUrl, uploadUrl)&&const DeepCollectionEquality().equals(other.photoKey, photoKey)&&const DeepCollectionEquality().equals(other.expiresIn, expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(uploadUrl),const DeepCollectionEquality().hash(photoKey),const DeepCollectionEquality().hash(expiresIn));

@override
String toString() {
  return 'PhotoUploadDto(uploadUrl: $uploadUrl, photoKey: $photoKey, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class $PhotoUploadDtoCopyWith<$Res>  {
  factory $PhotoUploadDtoCopyWith(PhotoUploadDto value, $Res Function(PhotoUploadDto) _then) = _$PhotoUploadDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'uploadUrl') Object? uploadUrl,@JsonKey(name: 'photoKey') Object? photoKey,@JsonKey(name: 'expiresIn') Object? expiresIn
});




}
/// @nodoc
class _$PhotoUploadDtoCopyWithImpl<$Res>
    implements $PhotoUploadDtoCopyWith<$Res> {
  _$PhotoUploadDtoCopyWithImpl(this._self, this._then);

  final PhotoUploadDto _self;
  final $Res Function(PhotoUploadDto) _then;

/// Create a copy of PhotoUploadDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uploadUrl = freezed,Object? photoKey = freezed,Object? expiresIn = freezed,}) {
  return _then(_self.copyWith(
uploadUrl: freezed == uploadUrl ? _self.uploadUrl : uploadUrl ,photoKey: freezed == photoKey ? _self.photoKey : photoKey ,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn ,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoUploadDto].
extension PhotoUploadDtoPatterns on PhotoUploadDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoUploadDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoUploadDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoUploadDto value)  $default,){
final _that = this;
switch (_that) {
case _PhotoUploadDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoUploadDto value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoUploadDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'uploadUrl')  Object? uploadUrl, @JsonKey(name: 'photoKey')  Object? photoKey, @JsonKey(name: 'expiresIn')  Object? expiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoUploadDto() when $default != null:
return $default(_that.uploadUrl,_that.photoKey,_that.expiresIn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'uploadUrl')  Object? uploadUrl, @JsonKey(name: 'photoKey')  Object? photoKey, @JsonKey(name: 'expiresIn')  Object? expiresIn)  $default,) {final _that = this;
switch (_that) {
case _PhotoUploadDto():
return $default(_that.uploadUrl,_that.photoKey,_that.expiresIn);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'uploadUrl')  Object? uploadUrl, @JsonKey(name: 'photoKey')  Object? photoKey, @JsonKey(name: 'expiresIn')  Object? expiresIn)?  $default,) {final _that = this;
switch (_that) {
case _PhotoUploadDto() when $default != null:
return $default(_that.uploadUrl,_that.photoKey,_that.expiresIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoUploadDto implements PhotoUploadDto {
  const _PhotoUploadDto({@JsonKey(name: 'uploadUrl') this.uploadUrl, @JsonKey(name: 'photoKey') this.photoKey, @JsonKey(name: 'expiresIn') this.expiresIn});
  factory _PhotoUploadDto.fromJson(Map<String, dynamic> json) => _$PhotoUploadDtoFromJson(json);

@override@JsonKey(name: 'uploadUrl') final  Object? uploadUrl;
@override@JsonKey(name: 'photoKey') final  Object? photoKey;
@override@JsonKey(name: 'expiresIn') final  Object? expiresIn;

/// Create a copy of PhotoUploadDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoUploadDtoCopyWith<_PhotoUploadDto> get copyWith => __$PhotoUploadDtoCopyWithImpl<_PhotoUploadDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoUploadDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoUploadDto&&const DeepCollectionEquality().equals(other.uploadUrl, uploadUrl)&&const DeepCollectionEquality().equals(other.photoKey, photoKey)&&const DeepCollectionEquality().equals(other.expiresIn, expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(uploadUrl),const DeepCollectionEquality().hash(photoKey),const DeepCollectionEquality().hash(expiresIn));

@override
String toString() {
  return 'PhotoUploadDto(uploadUrl: $uploadUrl, photoKey: $photoKey, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class _$PhotoUploadDtoCopyWith<$Res> implements $PhotoUploadDtoCopyWith<$Res> {
  factory _$PhotoUploadDtoCopyWith(_PhotoUploadDto value, $Res Function(_PhotoUploadDto) _then) = __$PhotoUploadDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'uploadUrl') Object? uploadUrl,@JsonKey(name: 'photoKey') Object? photoKey,@JsonKey(name: 'expiresIn') Object? expiresIn
});




}
/// @nodoc
class __$PhotoUploadDtoCopyWithImpl<$Res>
    implements _$PhotoUploadDtoCopyWith<$Res> {
  __$PhotoUploadDtoCopyWithImpl(this._self, this._then);

  final _PhotoUploadDto _self;
  final $Res Function(_PhotoUploadDto) _then;

/// Create a copy of PhotoUploadDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uploadUrl = freezed,Object? photoKey = freezed,Object? expiresIn = freezed,}) {
  return _then(_PhotoUploadDto(
uploadUrl: freezed == uploadUrl ? _self.uploadUrl : uploadUrl ,photoKey: freezed == photoKey ? _self.photoKey : photoKey ,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn ,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {

/// The Cognito subject. `id` is accepted as well because that is what a
/// stubbed or older build sends.
@JsonKey(name: 'sub') Object? get sub;@JsonKey(name: 'id') Object? get id;@JsonKey(name: 'name') Object? get name;@JsonKey(name: 'email') Object? get email;@JsonKey(name: 'phone') Object? get phone;@JsonKey(name: 'role') Object? get role;@JsonKey(name: 'profileSetupSeen') Object? get profileSetupSeen;@JsonKey(name: 'notificationPrefs') Object? get notificationPrefs;
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<UserProfileDto> get copyWith => _$UserProfileDtoCopyWithImpl<UserProfileDto>(this as UserProfileDto, _$identity);

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDto&&const DeepCollectionEquality().equals(other.sub, sub)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.email, email)&&const DeepCollectionEquality().equals(other.phone, phone)&&const DeepCollectionEquality().equals(other.role, role)&&const DeepCollectionEquality().equals(other.profileSetupSeen, profileSetupSeen)&&const DeepCollectionEquality().equals(other.notificationPrefs, notificationPrefs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sub),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(email),const DeepCollectionEquality().hash(phone),const DeepCollectionEquality().hash(role),const DeepCollectionEquality().hash(profileSetupSeen),const DeepCollectionEquality().hash(notificationPrefs));

@override
String toString() {
  return 'UserProfileDto(sub: $sub, id: $id, name: $name, email: $email, phone: $phone, role: $role, profileSetupSeen: $profileSetupSeen, notificationPrefs: $notificationPrefs)';
}


}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res>  {
  factory $UserProfileDtoCopyWith(UserProfileDto value, $Res Function(UserProfileDto) _then) = _$UserProfileDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'sub') Object? sub,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'email') Object? email,@JsonKey(name: 'phone') Object? phone,@JsonKey(name: 'role') Object? role,@JsonKey(name: 'profileSetupSeen') Object? profileSetupSeen,@JsonKey(name: 'notificationPrefs') Object? notificationPrefs
});




}
/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sub = freezed,Object? id = freezed,Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? role = freezed,Object? profileSetupSeen = freezed,Object? notificationPrefs = freezed,}) {
  return _then(_self.copyWith(
sub: freezed == sub ? _self.sub : sub ,id: freezed == id ? _self.id : id ,name: freezed == name ? _self.name : name ,email: freezed == email ? _self.email : email ,phone: freezed == phone ? _self.phone : phone ,role: freezed == role ? _self.role : role ,profileSetupSeen: freezed == profileSetupSeen ? _self.profileSetupSeen : profileSetupSeen ,notificationPrefs: freezed == notificationPrefs ? _self.notificationPrefs : notificationPrefs ,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileDto].
extension UserProfileDtoPatterns on UserProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'sub')  Object? sub, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'email')  Object? email, @JsonKey(name: 'phone')  Object? phone, @JsonKey(name: 'role')  Object? role, @JsonKey(name: 'profileSetupSeen')  Object? profileSetupSeen, @JsonKey(name: 'notificationPrefs')  Object? notificationPrefs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.sub,_that.id,_that.name,_that.email,_that.phone,_that.role,_that.profileSetupSeen,_that.notificationPrefs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'sub')  Object? sub, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'email')  Object? email, @JsonKey(name: 'phone')  Object? phone, @JsonKey(name: 'role')  Object? role, @JsonKey(name: 'profileSetupSeen')  Object? profileSetupSeen, @JsonKey(name: 'notificationPrefs')  Object? notificationPrefs)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that.sub,_that.id,_that.name,_that.email,_that.phone,_that.role,_that.profileSetupSeen,_that.notificationPrefs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'sub')  Object? sub, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'email')  Object? email, @JsonKey(name: 'phone')  Object? phone, @JsonKey(name: 'role')  Object? role, @JsonKey(name: 'profileSetupSeen')  Object? profileSetupSeen, @JsonKey(name: 'notificationPrefs')  Object? notificationPrefs)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.sub,_that.id,_that.name,_that.email,_that.phone,_that.role,_that.profileSetupSeen,_that.notificationPrefs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDto implements UserProfileDto {
  const _UserProfileDto({@JsonKey(name: 'sub') this.sub, @JsonKey(name: 'id') this.id, @JsonKey(name: 'name') this.name, @JsonKey(name: 'email') this.email, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'role') this.role, @JsonKey(name: 'profileSetupSeen') this.profileSetupSeen, @JsonKey(name: 'notificationPrefs') this.notificationPrefs});
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

/// The Cognito subject. `id` is accepted as well because that is what a
/// stubbed or older build sends.
@override@JsonKey(name: 'sub') final  Object? sub;
@override@JsonKey(name: 'id') final  Object? id;
@override@JsonKey(name: 'name') final  Object? name;
@override@JsonKey(name: 'email') final  Object? email;
@override@JsonKey(name: 'phone') final  Object? phone;
@override@JsonKey(name: 'role') final  Object? role;
@override@JsonKey(name: 'profileSetupSeen') final  Object? profileSetupSeen;
@override@JsonKey(name: 'notificationPrefs') final  Object? notificationPrefs;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDtoCopyWith<_UserProfileDto> get copyWith => __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDto&&const DeepCollectionEquality().equals(other.sub, sub)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.email, email)&&const DeepCollectionEquality().equals(other.phone, phone)&&const DeepCollectionEquality().equals(other.role, role)&&const DeepCollectionEquality().equals(other.profileSetupSeen, profileSetupSeen)&&const DeepCollectionEquality().equals(other.notificationPrefs, notificationPrefs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sub),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(email),const DeepCollectionEquality().hash(phone),const DeepCollectionEquality().hash(role),const DeepCollectionEquality().hash(profileSetupSeen),const DeepCollectionEquality().hash(notificationPrefs));

@override
String toString() {
  return 'UserProfileDto(sub: $sub, id: $id, name: $name, email: $email, phone: $phone, role: $role, profileSetupSeen: $profileSetupSeen, notificationPrefs: $notificationPrefs)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res> implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(_UserProfileDto value, $Res Function(_UserProfileDto) _then) = __$UserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'sub') Object? sub,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'email') Object? email,@JsonKey(name: 'phone') Object? phone,@JsonKey(name: 'role') Object? role,@JsonKey(name: 'profileSetupSeen') Object? profileSetupSeen,@JsonKey(name: 'notificationPrefs') Object? notificationPrefs
});




}
/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sub = freezed,Object? id = freezed,Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? role = freezed,Object? profileSetupSeen = freezed,Object? notificationPrefs = freezed,}) {
  return _then(_UserProfileDto(
sub: freezed == sub ? _self.sub : sub ,id: freezed == id ? _self.id : id ,name: freezed == name ? _self.name : name ,email: freezed == email ? _self.email : email ,phone: freezed == phone ? _self.phone : phone ,role: freezed == role ? _self.role : role ,profileSetupSeen: freezed == profileSetupSeen ? _self.profileSetupSeen : profileSetupSeen ,notificationPrefs: freezed == notificationPrefs ? _self.notificationPrefs : notificationPrefs ,
  ));
}


}

// dart format on

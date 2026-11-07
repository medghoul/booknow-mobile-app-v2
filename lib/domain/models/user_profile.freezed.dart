// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; String get name; String get email; String? get phone; UserRole? get role; bool get profileSetupSeen;/// What the user may be sent, and when. Part of the profile because
/// the server returns it there and answers `PATCH
/// /me/notification-preferences` with the whole thing — so there is one
/// copy of it, held where every other `/me` field already is.
 NotificationPreferences get notificationPrefs;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profileSetupSeen, profileSetupSeen) || other.profileSetupSeen == profileSetupSeen)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,role,profileSetupSeen,notificationPrefs);

@override
String toString() {
  return 'UserProfile(id: $id, name: $name, email: $email, phone: $phone, role: $role, profileSetupSeen: $profileSetupSeen, notificationPrefs: $notificationPrefs)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String? phone, UserRole? role, bool profileSetupSeen, NotificationPreferences notificationPrefs
});


$NotificationPreferencesCopyWith<$Res> get notificationPrefs;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? role = freezed,Object? profileSetupSeen = null,Object? notificationPrefs = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole?,profileSetupSeen: null == profileSetupSeen ? _self.profileSetupSeen : profileSetupSeen // ignore: cast_nullable_to_non_nullable
as bool,notificationPrefs: null == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPreferences,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<$Res> get notificationPrefs {
  
  return $NotificationPreferencesCopyWith<$Res>(_self.notificationPrefs, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String? phone,  UserRole? role,  bool profileSetupSeen,  NotificationPreferences notificationPrefs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.role,_that.profileSetupSeen,_that.notificationPrefs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String? phone,  UserRole? role,  bool profileSetupSeen,  NotificationPreferences notificationPrefs)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.name,_that.email,_that.phone,_that.role,_that.profileSetupSeen,_that.notificationPrefs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String? phone,  UserRole? role,  bool profileSetupSeen,  NotificationPreferences notificationPrefs)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.role,_that.profileSetupSeen,_that.notificationPrefs);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.name, required this.email, this.phone, this.role, this.profileSetupSeen = false, this.notificationPrefs = const NotificationPreferences()}): super._();
  

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String? phone;
@override final  UserRole? role;
@override@JsonKey() final  bool profileSetupSeen;
/// What the user may be sent, and when. Part of the profile because
/// the server returns it there and answers `PATCH
/// /me/notification-preferences` with the whole thing — so there is one
/// copy of it, held where every other `/me` field already is.
@override@JsonKey() final  NotificationPreferences notificationPrefs;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profileSetupSeen, profileSetupSeen) || other.profileSetupSeen == profileSetupSeen)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,role,profileSetupSeen,notificationPrefs);

@override
String toString() {
  return 'UserProfile(id: $id, name: $name, email: $email, phone: $phone, role: $role, profileSetupSeen: $profileSetupSeen, notificationPrefs: $notificationPrefs)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String? phone, UserRole? role, bool profileSetupSeen, NotificationPreferences notificationPrefs
});


@override $NotificationPreferencesCopyWith<$Res> get notificationPrefs;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? role = freezed,Object? profileSetupSeen = null,Object? notificationPrefs = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole?,profileSetupSeen: null == profileSetupSeen ? _self.profileSetupSeen : profileSetupSeen // ignore: cast_nullable_to_non_nullable
as bool,notificationPrefs: null == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPreferences,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<$Res> get notificationPrefs {
  
  return $NotificationPreferencesCopyWith<$Res>(_self.notificationPrefs, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}

// dart format on

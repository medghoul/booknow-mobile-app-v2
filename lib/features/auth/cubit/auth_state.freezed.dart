// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

/// Where the user belongs, decided by `AuthRouter` from [profile] and
/// [shop]. Null while that is still being worked out — the splash shows
/// until it resolves.
 AuthDestination? get destination; AuthSession? get session;/// The server's view of the user, from `GET /me`. The authority on the
/// role — the ID token's claims are only a hint and go stale the moment a
/// role is set.
 UserProfile? get profile;/// Owners only, and null until `GET /me/shop` has answered.
 Shop? get shop;/// Tapped but not yet confirmed. Separate from [profile]'s role, which
/// changes only once the server has accepted it.
 UserRole? get selectedRole;/// Which provider button is waiting, so only that one spins.
 AuthProviderKind? get pendingProvider; bool get isSubmitting; NetworkException? get failure;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.session, session) || other.session == session)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.shop, shop) || other.shop == shop)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole)&&(identical(other.pendingProvider, pendingProvider) || other.pendingProvider == pendingProvider)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,destination,session,profile,shop,selectedRole,pendingProvider,isSubmitting,failure);

@override
String toString() {
  return 'AuthState(destination: $destination, session: $session, profile: $profile, shop: $shop, selectedRole: $selectedRole, pendingProvider: $pendingProvider, isSubmitting: $isSubmitting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthDestination? destination, AuthSession? session, UserProfile? profile, Shop? shop, UserRole? selectedRole, AuthProviderKind? pendingProvider, bool isSubmitting, NetworkException? failure
});


$AuthDestinationCopyWith<$Res>? get destination;$AuthSessionCopyWith<$Res>? get session;$UserProfileCopyWith<$Res>? get profile;$ShopCopyWith<$Res>? get shop;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destination = freezed,Object? session = freezed,Object? profile = freezed,Object? shop = freezed,Object? selectedRole = freezed,Object? pendingProvider = freezed,Object? isSubmitting = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as AuthDestination?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthSession?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,selectedRole: freezed == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as UserRole?,pendingProvider: freezed == pendingProvider ? _self.pendingProvider : pendingProvider // ignore: cast_nullable_to_non_nullable
as AuthProviderKind?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthDestinationCopyWith<$Res>? get destination {
    if (_self.destination == null) {
    return null;
  }

  return $AuthDestinationCopyWith<$Res>(_self.destination!, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $AuthSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopCopyWith<$Res>? get shop {
    if (_self.shop == null) {
    return null;
  }

  return $ShopCopyWith<$Res>(_self.shop!, (value) {
    return _then(_self.copyWith(shop: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthDestination? destination,  AuthSession? session,  UserProfile? profile,  Shop? shop,  UserRole? selectedRole,  AuthProviderKind? pendingProvider,  bool isSubmitting,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.destination,_that.session,_that.profile,_that.shop,_that.selectedRole,_that.pendingProvider,_that.isSubmitting,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthDestination? destination,  AuthSession? session,  UserProfile? profile,  Shop? shop,  UserRole? selectedRole,  AuthProviderKind? pendingProvider,  bool isSubmitting,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.destination,_that.session,_that.profile,_that.shop,_that.selectedRole,_that.pendingProvider,_that.isSubmitting,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthDestination? destination,  AuthSession? session,  UserProfile? profile,  Shop? shop,  UserRole? selectedRole,  AuthProviderKind? pendingProvider,  bool isSubmitting,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.destination,_that.session,_that.profile,_that.shop,_that.selectedRole,_that.pendingProvider,_that.isSubmitting,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState extends AuthState {
  const _AuthState({this.destination, this.session, this.profile, this.shop, this.selectedRole, this.pendingProvider, this.isSubmitting = false, this.failure}): super._();
  

/// Where the user belongs, decided by `AuthRouter` from [profile] and
/// [shop]. Null while that is still being worked out — the splash shows
/// until it resolves.
@override final  AuthDestination? destination;
@override final  AuthSession? session;
/// The server's view of the user, from `GET /me`. The authority on the
/// role — the ID token's claims are only a hint and go stale the moment a
/// role is set.
@override final  UserProfile? profile;
/// Owners only, and null until `GET /me/shop` has answered.
@override final  Shop? shop;
/// Tapped but not yet confirmed. Separate from [profile]'s role, which
/// changes only once the server has accepted it.
@override final  UserRole? selectedRole;
/// Which provider button is waiting, so only that one spins.
@override final  AuthProviderKind? pendingProvider;
@override@JsonKey() final  bool isSubmitting;
@override final  NetworkException? failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.session, session) || other.session == session)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.shop, shop) || other.shop == shop)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole)&&(identical(other.pendingProvider, pendingProvider) || other.pendingProvider == pendingProvider)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,destination,session,profile,shop,selectedRole,pendingProvider,isSubmitting,failure);

@override
String toString() {
  return 'AuthState(destination: $destination, session: $session, profile: $profile, shop: $shop, selectedRole: $selectedRole, pendingProvider: $pendingProvider, isSubmitting: $isSubmitting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthDestination? destination, AuthSession? session, UserProfile? profile, Shop? shop, UserRole? selectedRole, AuthProviderKind? pendingProvider, bool isSubmitting, NetworkException? failure
});


@override $AuthDestinationCopyWith<$Res>? get destination;@override $AuthSessionCopyWith<$Res>? get session;@override $UserProfileCopyWith<$Res>? get profile;@override $ShopCopyWith<$Res>? get shop;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destination = freezed,Object? session = freezed,Object? profile = freezed,Object? shop = freezed,Object? selectedRole = freezed,Object? pendingProvider = freezed,Object? isSubmitting = null,Object? failure = freezed,}) {
  return _then(_AuthState(
destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as AuthDestination?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthSession?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,selectedRole: freezed == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as UserRole?,pendingProvider: freezed == pendingProvider ? _self.pendingProvider : pendingProvider // ignore: cast_nullable_to_non_nullable
as AuthProviderKind?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthDestinationCopyWith<$Res>? get destination {
    if (_self.destination == null) {
    return null;
  }

  return $AuthDestinationCopyWith<$Res>(_self.destination!, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $AuthSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopCopyWith<$Res>? get shop {
    if (_self.shop == null) {
    return null;
  }

  return $ShopCopyWith<$Res>(_self.shop!, (value) {
    return _then(_self.copyWith(shop: value));
  });
}
}

// dart format on

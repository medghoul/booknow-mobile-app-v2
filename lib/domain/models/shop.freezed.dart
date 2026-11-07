// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Shop {

 String get id; ShopStatus get status; String? get name; String? get phone; String? get photoUrl; ShopAddress? get address; OpeningHours get openingHours; List<String> get closures; List<ShopService> get services;/// Who does the work, by display order. The owner's own shop lists the
/// removed ones too; the page a customer sees lists only who can be chosen.
 List<ShopProvider> get providers;/// What holding a slot here costs, sent with the customer-facing shop page
/// only. Null on the owner's own shop, which never shows it.
 int? get feeCents;/// Bookings or a live queue; everything saved before queue mode reads as
/// [ShopMode.booking].
 ShopMode get mode;
/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopCopyWith<Shop> get copyWith => _$ShopCopyWithImpl<Shop>(this as Shop, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Shop&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&const DeepCollectionEquality().equals(other.closures, closures)&&const DeepCollectionEquality().equals(other.services, services)&&const DeepCollectionEquality().equals(other.providers, providers)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,name,phone,photoUrl,address,openingHours,const DeepCollectionEquality().hash(closures),const DeepCollectionEquality().hash(services),const DeepCollectionEquality().hash(providers),feeCents,mode);

@override
String toString() {
  return 'Shop(id: $id, status: $status, name: $name, phone: $phone, photoUrl: $photoUrl, address: $address, openingHours: $openingHours, closures: $closures, services: $services, providers: $providers, feeCents: $feeCents, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ShopCopyWith<$Res>  {
  factory $ShopCopyWith(Shop value, $Res Function(Shop) _then) = _$ShopCopyWithImpl;
@useResult
$Res call({
 String id, ShopStatus status, String? name, String? phone, String? photoUrl, ShopAddress? address, OpeningHours openingHours, List<String> closures, List<ShopService> services, List<ShopProvider> providers, int? feeCents, ShopMode mode
});


$ShopAddressCopyWith<$Res>? get address;$OpeningHoursCopyWith<$Res> get openingHours;

}
/// @nodoc
class _$ShopCopyWithImpl<$Res>
    implements $ShopCopyWith<$Res> {
  _$ShopCopyWithImpl(this._self, this._then);

  final Shop _self;
  final $Res Function(Shop) _then;

/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? name = freezed,Object? phone = freezed,Object? photoUrl = freezed,Object? address = freezed,Object? openingHours = null,Object? closures = null,Object? services = null,Object? providers = null,Object? feeCents = freezed,Object? mode = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShopStatus,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShopAddress?,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as OpeningHours,closures: null == closures ? _self.closures : closures // ignore: cast_nullable_to_non_nullable
as List<String>,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<ShopService>,providers: null == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<ShopProvider>,feeCents: freezed == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ShopMode,
  ));
}
/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $ShopAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursCopyWith<$Res> get openingHours {
  
  return $OpeningHoursCopyWith<$Res>(_self.openingHours, (value) {
    return _then(_self.copyWith(openingHours: value));
  });
}
}


/// Adds pattern-matching-related methods to [Shop].
extension ShopPatterns on Shop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Shop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Shop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Shop value)  $default,){
final _that = this;
switch (_that) {
case _Shop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Shop value)?  $default,){
final _that = this;
switch (_that) {
case _Shop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ShopStatus status,  String? name,  String? phone,  String? photoUrl,  ShopAddress? address,  OpeningHours openingHours,  List<String> closures,  List<ShopService> services,  List<ShopProvider> providers,  int? feeCents,  ShopMode mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Shop() when $default != null:
return $default(_that.id,_that.status,_that.name,_that.phone,_that.photoUrl,_that.address,_that.openingHours,_that.closures,_that.services,_that.providers,_that.feeCents,_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ShopStatus status,  String? name,  String? phone,  String? photoUrl,  ShopAddress? address,  OpeningHours openingHours,  List<String> closures,  List<ShopService> services,  List<ShopProvider> providers,  int? feeCents,  ShopMode mode)  $default,) {final _that = this;
switch (_that) {
case _Shop():
return $default(_that.id,_that.status,_that.name,_that.phone,_that.photoUrl,_that.address,_that.openingHours,_that.closures,_that.services,_that.providers,_that.feeCents,_that.mode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ShopStatus status,  String? name,  String? phone,  String? photoUrl,  ShopAddress? address,  OpeningHours openingHours,  List<String> closures,  List<ShopService> services,  List<ShopProvider> providers,  int? feeCents,  ShopMode mode)?  $default,) {final _that = this;
switch (_that) {
case _Shop() when $default != null:
return $default(_that.id,_that.status,_that.name,_that.phone,_that.photoUrl,_that.address,_that.openingHours,_that.closures,_that.services,_that.providers,_that.feeCents,_that.mode);case _:
  return null;

}
}

}

/// @nodoc


class _Shop extends Shop {
  const _Shop({required this.id, required this.status, this.name, this.phone, this.photoUrl, this.address, this.openingHours = const OpeningHours(), final  List<String> closures = const <String>[], final  List<ShopService> services = const <ShopService>[], final  List<ShopProvider> providers = const <ShopProvider>[], this.feeCents, this.mode = ShopMode.booking}): _closures = closures,_services = services,_providers = providers,super._();
  

@override final  String id;
@override final  ShopStatus status;
@override final  String? name;
@override final  String? phone;
@override final  String? photoUrl;
@override final  ShopAddress? address;
@override@JsonKey() final  OpeningHours openingHours;
 final  List<String> _closures;
@override@JsonKey() List<String> get closures {
  if (_closures is EqualUnmodifiableListView) return _closures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_closures);
}

 final  List<ShopService> _services;
@override@JsonKey() List<ShopService> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

/// Who does the work, by display order. The owner's own shop lists the
/// removed ones too; the page a customer sees lists only who can be chosen.
 final  List<ShopProvider> _providers;
/// Who does the work, by display order. The owner's own shop lists the
/// removed ones too; the page a customer sees lists only who can be chosen.
@override@JsonKey() List<ShopProvider> get providers {
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providers);
}

/// What holding a slot here costs, sent with the customer-facing shop page
/// only. Null on the owner's own shop, which never shows it.
@override final  int? feeCents;
/// Bookings or a live queue; everything saved before queue mode reads as
/// [ShopMode.booking].
@override@JsonKey() final  ShopMode mode;

/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopCopyWith<_Shop> get copyWith => __$ShopCopyWithImpl<_Shop>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Shop&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&const DeepCollectionEquality().equals(other._closures, _closures)&&const DeepCollectionEquality().equals(other._services, _services)&&const DeepCollectionEquality().equals(other._providers, _providers)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,name,phone,photoUrl,address,openingHours,const DeepCollectionEquality().hash(_closures),const DeepCollectionEquality().hash(_services),const DeepCollectionEquality().hash(_providers),feeCents,mode);

@override
String toString() {
  return 'Shop(id: $id, status: $status, name: $name, phone: $phone, photoUrl: $photoUrl, address: $address, openingHours: $openingHours, closures: $closures, services: $services, providers: $providers, feeCents: $feeCents, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$ShopCopyWith<$Res> implements $ShopCopyWith<$Res> {
  factory _$ShopCopyWith(_Shop value, $Res Function(_Shop) _then) = __$ShopCopyWithImpl;
@override @useResult
$Res call({
 String id, ShopStatus status, String? name, String? phone, String? photoUrl, ShopAddress? address, OpeningHours openingHours, List<String> closures, List<ShopService> services, List<ShopProvider> providers, int? feeCents, ShopMode mode
});


@override $ShopAddressCopyWith<$Res>? get address;@override $OpeningHoursCopyWith<$Res> get openingHours;

}
/// @nodoc
class __$ShopCopyWithImpl<$Res>
    implements _$ShopCopyWith<$Res> {
  __$ShopCopyWithImpl(this._self, this._then);

  final _Shop _self;
  final $Res Function(_Shop) _then;

/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? name = freezed,Object? phone = freezed,Object? photoUrl = freezed,Object? address = freezed,Object? openingHours = null,Object? closures = null,Object? services = null,Object? providers = null,Object? feeCents = freezed,Object? mode = null,}) {
  return _then(_Shop(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShopStatus,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShopAddress?,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as OpeningHours,closures: null == closures ? _self._closures : closures // ignore: cast_nullable_to_non_nullable
as List<String>,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<ShopService>,providers: null == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<ShopProvider>,feeCents: freezed == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ShopMode,
  ));
}

/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $ShopAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of Shop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursCopyWith<$Res> get openingHours {
  
  return $OpeningHoursCopyWith<$Res>(_self.openingHours, (value) {
    return _then(_self.copyWith(openingHours: value));
  });
}
}

// dart format on

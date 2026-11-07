// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopDto {

@JsonKey(name: 'shopId') Object? get shopId;@JsonKey(name: 'id') Object? get id;@JsonKey(name: 'status') Object? get status;@JsonKey(name: 'name') Object? get name;@JsonKey(name: 'phone') Object? get phone;@JsonKey(name: 'photoUrl') Object? get photoUrl;@JsonKey(name: 'address') AddressDto? get address;@JsonKey(name: 'location') LocationDto? get location;/// `{ "mon": [], "tue": [{ "from": "09:00", "to": "13:00" }] }` — read as
/// a raw map because an unknown day key must be skipped, not throw.
@JsonKey(name: 'openingHours') Map<String, dynamic>? get openingHours;@JsonKey(name: 'closures') List<dynamic>? get closures;@JsonKey(name: 'services') List<dynamic>? get services;@JsonKey(name: 'providers') List<dynamic>? get providers;@JsonKey(name: 'feeAmountCents') Object? get feeAmountCents;@JsonKey(name: 'mode') Object? get mode;
/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopDtoCopyWith<ShopDto> get copyWith => _$ShopDtoCopyWithImpl<ShopDto>(this as ShopDto, _$identity);

  /// Serializes this ShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.phone, phone)&&const DeepCollectionEquality().equals(other.photoUrl, photoUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&const DeepCollectionEquality().equals(other.closures, closures)&&const DeepCollectionEquality().equals(other.services, services)&&const DeepCollectionEquality().equals(other.providers, providers)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.mode, mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(phone),const DeepCollectionEquality().hash(photoUrl),address,location,const DeepCollectionEquality().hash(openingHours),const DeepCollectionEquality().hash(closures),const DeepCollectionEquality().hash(services),const DeepCollectionEquality().hash(providers),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(mode));

@override
String toString() {
  return 'ShopDto(shopId: $shopId, id: $id, status: $status, name: $name, phone: $phone, photoUrl: $photoUrl, address: $address, location: $location, openingHours: $openingHours, closures: $closures, services: $services, providers: $providers, feeAmountCents: $feeAmountCents, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ShopDtoCopyWith<$Res>  {
  factory $ShopDtoCopyWith(ShopDto value, $Res Function(ShopDto) _then) = _$ShopDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'phone') Object? phone,@JsonKey(name: 'photoUrl') Object? photoUrl,@JsonKey(name: 'address') AddressDto? address,@JsonKey(name: 'location') LocationDto? location,@JsonKey(name: 'openingHours') Map<String, dynamic>? openingHours,@JsonKey(name: 'closures') List<dynamic>? closures,@JsonKey(name: 'services') List<dynamic>? services,@JsonKey(name: 'providers') List<dynamic>? providers,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'mode') Object? mode
});


$AddressDtoCopyWith<$Res>? get address;$LocationDtoCopyWith<$Res>? get location;

}
/// @nodoc
class _$ShopDtoCopyWithImpl<$Res>
    implements $ShopDtoCopyWith<$Res> {
  _$ShopDtoCopyWithImpl(this._self, this._then);

  final ShopDto _self;
  final $Res Function(ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = freezed,Object? id = freezed,Object? status = freezed,Object? name = freezed,Object? phone = freezed,Object? photoUrl = freezed,Object? address = freezed,Object? location = freezed,Object? openingHours = freezed,Object? closures = freezed,Object? services = freezed,Object? providers = freezed,Object? feeAmountCents = freezed,Object? mode = freezed,}) {
  return _then(_self.copyWith(
shopId: freezed == shopId ? _self.shopId : shopId ,id: freezed == id ? _self.id : id ,status: freezed == status ? _self.status : status ,name: freezed == name ? _self.name : name ,phone: freezed == phone ? _self.phone : phone ,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl ,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressDto?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationDto?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,closures: freezed == closures ? _self.closures : closures // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,services: freezed == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,providers: freezed == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,mode: freezed == mode ? _self.mode : mode ,
  ));
}
/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressDtoCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressDtoCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDtoCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocationDtoCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShopDto].
extension ShopDtoPatterns on ShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'phone')  Object? phone, @JsonKey(name: 'photoUrl')  Object? photoUrl, @JsonKey(name: 'address')  AddressDto? address, @JsonKey(name: 'location')  LocationDto? location, @JsonKey(name: 'openingHours')  Map<String, dynamic>? openingHours, @JsonKey(name: 'closures')  List<dynamic>? closures, @JsonKey(name: 'services')  List<dynamic>? services, @JsonKey(name: 'providers')  List<dynamic>? providers, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'mode')  Object? mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.shopId,_that.id,_that.status,_that.name,_that.phone,_that.photoUrl,_that.address,_that.location,_that.openingHours,_that.closures,_that.services,_that.providers,_that.feeAmountCents,_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'phone')  Object? phone, @JsonKey(name: 'photoUrl')  Object? photoUrl, @JsonKey(name: 'address')  AddressDto? address, @JsonKey(name: 'location')  LocationDto? location, @JsonKey(name: 'openingHours')  Map<String, dynamic>? openingHours, @JsonKey(name: 'closures')  List<dynamic>? closures, @JsonKey(name: 'services')  List<dynamic>? services, @JsonKey(name: 'providers')  List<dynamic>? providers, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'mode')  Object? mode)  $default,) {final _that = this;
switch (_that) {
case _ShopDto():
return $default(_that.shopId,_that.id,_that.status,_that.name,_that.phone,_that.photoUrl,_that.address,_that.location,_that.openingHours,_that.closures,_that.services,_that.providers,_that.feeAmountCents,_that.mode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'phone')  Object? phone, @JsonKey(name: 'photoUrl')  Object? photoUrl, @JsonKey(name: 'address')  AddressDto? address, @JsonKey(name: 'location')  LocationDto? location, @JsonKey(name: 'openingHours')  Map<String, dynamic>? openingHours, @JsonKey(name: 'closures')  List<dynamic>? closures, @JsonKey(name: 'services')  List<dynamic>? services, @JsonKey(name: 'providers')  List<dynamic>? providers, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'mode')  Object? mode)?  $default,) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.shopId,_that.id,_that.status,_that.name,_that.phone,_that.photoUrl,_that.address,_that.location,_that.openingHours,_that.closures,_that.services,_that.providers,_that.feeAmountCents,_that.mode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopDto implements ShopDto {
  const _ShopDto({@JsonKey(name: 'shopId') this.shopId, @JsonKey(name: 'id') this.id, @JsonKey(name: 'status') this.status, @JsonKey(name: 'name') this.name, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'photoUrl') this.photoUrl, @JsonKey(name: 'address') this.address, @JsonKey(name: 'location') this.location, @JsonKey(name: 'openingHours') final  Map<String, dynamic>? openingHours, @JsonKey(name: 'closures') final  List<dynamic>? closures, @JsonKey(name: 'services') final  List<dynamic>? services, @JsonKey(name: 'providers') final  List<dynamic>? providers, @JsonKey(name: 'feeAmountCents') this.feeAmountCents, @JsonKey(name: 'mode') this.mode}): _openingHours = openingHours,_closures = closures,_services = services,_providers = providers;
  factory _ShopDto.fromJson(Map<String, dynamic> json) => _$ShopDtoFromJson(json);

@override@JsonKey(name: 'shopId') final  Object? shopId;
@override@JsonKey(name: 'id') final  Object? id;
@override@JsonKey(name: 'status') final  Object? status;
@override@JsonKey(name: 'name') final  Object? name;
@override@JsonKey(name: 'phone') final  Object? phone;
@override@JsonKey(name: 'photoUrl') final  Object? photoUrl;
@override@JsonKey(name: 'address') final  AddressDto? address;
@override@JsonKey(name: 'location') final  LocationDto? location;
/// `{ "mon": [], "tue": [{ "from": "09:00", "to": "13:00" }] }` — read as
/// a raw map because an unknown day key must be skipped, not throw.
 final  Map<String, dynamic>? _openingHours;
/// `{ "mon": [], "tue": [{ "from": "09:00", "to": "13:00" }] }` — read as
/// a raw map because an unknown day key must be skipped, not throw.
@override@JsonKey(name: 'openingHours') Map<String, dynamic>? get openingHours {
  final value = _openingHours;
  if (value == null) return null;
  if (_openingHours is EqualUnmodifiableMapView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _closures;
@override@JsonKey(name: 'closures') List<dynamic>? get closures {
  final value = _closures;
  if (value == null) return null;
  if (_closures is EqualUnmodifiableListView) return _closures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _services;
@override@JsonKey(name: 'services') List<dynamic>? get services {
  final value = _services;
  if (value == null) return null;
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _providers;
@override@JsonKey(name: 'providers') List<dynamic>? get providers {
  final value = _providers;
  if (value == null) return null;
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'feeAmountCents') final  Object? feeAmountCents;
@override@JsonKey(name: 'mode') final  Object? mode;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopDtoCopyWith<_ShopDto> get copyWith => __$ShopDtoCopyWithImpl<_ShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.phone, phone)&&const DeepCollectionEquality().equals(other.photoUrl, photoUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&const DeepCollectionEquality().equals(other._closures, _closures)&&const DeepCollectionEquality().equals(other._services, _services)&&const DeepCollectionEquality().equals(other._providers, _providers)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.mode, mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(phone),const DeepCollectionEquality().hash(photoUrl),address,location,const DeepCollectionEquality().hash(_openingHours),const DeepCollectionEquality().hash(_closures),const DeepCollectionEquality().hash(_services),const DeepCollectionEquality().hash(_providers),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(mode));

@override
String toString() {
  return 'ShopDto(shopId: $shopId, id: $id, status: $status, name: $name, phone: $phone, photoUrl: $photoUrl, address: $address, location: $location, openingHours: $openingHours, closures: $closures, services: $services, providers: $providers, feeAmountCents: $feeAmountCents, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$ShopDtoCopyWith<$Res> implements $ShopDtoCopyWith<$Res> {
  factory _$ShopDtoCopyWith(_ShopDto value, $Res Function(_ShopDto) _then) = __$ShopDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'phone') Object? phone,@JsonKey(name: 'photoUrl') Object? photoUrl,@JsonKey(name: 'address') AddressDto? address,@JsonKey(name: 'location') LocationDto? location,@JsonKey(name: 'openingHours') Map<String, dynamic>? openingHours,@JsonKey(name: 'closures') List<dynamic>? closures,@JsonKey(name: 'services') List<dynamic>? services,@JsonKey(name: 'providers') List<dynamic>? providers,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'mode') Object? mode
});


@override $AddressDtoCopyWith<$Res>? get address;@override $LocationDtoCopyWith<$Res>? get location;

}
/// @nodoc
class __$ShopDtoCopyWithImpl<$Res>
    implements _$ShopDtoCopyWith<$Res> {
  __$ShopDtoCopyWithImpl(this._self, this._then);

  final _ShopDto _self;
  final $Res Function(_ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = freezed,Object? id = freezed,Object? status = freezed,Object? name = freezed,Object? phone = freezed,Object? photoUrl = freezed,Object? address = freezed,Object? location = freezed,Object? openingHours = freezed,Object? closures = freezed,Object? services = freezed,Object? providers = freezed,Object? feeAmountCents = freezed,Object? mode = freezed,}) {
  return _then(_ShopDto(
shopId: freezed == shopId ? _self.shopId : shopId ,id: freezed == id ? _self.id : id ,status: freezed == status ? _self.status : status ,name: freezed == name ? _self.name : name ,phone: freezed == phone ? _self.phone : phone ,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl ,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressDto?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationDto?,openingHours: freezed == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,closures: freezed == closures ? _self._closures : closures // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,services: freezed == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,providers: freezed == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,mode: freezed == mode ? _self.mode : mode ,
  ));
}

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressDtoCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressDtoCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDtoCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocationDtoCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$AddressDto {

@JsonKey(name: 'line') Object? get line;@JsonKey(name: 'city') Object? get city;@JsonKey(name: 'zip') Object? get zip;@JsonKey(name: 'country') Object? get country;
/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressDtoCopyWith<AddressDto> get copyWith => _$AddressDtoCopyWithImpl<AddressDto>(this as AddressDto, _$identity);

  /// Serializes this AddressDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressDto&&const DeepCollectionEquality().equals(other.line, line)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.zip, zip)&&const DeepCollectionEquality().equals(other.country, country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(line),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(zip),const DeepCollectionEquality().hash(country));

@override
String toString() {
  return 'AddressDto(line: $line, city: $city, zip: $zip, country: $country)';
}


}

/// @nodoc
abstract mixin class $AddressDtoCopyWith<$Res>  {
  factory $AddressDtoCopyWith(AddressDto value, $Res Function(AddressDto) _then) = _$AddressDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'line') Object? line,@JsonKey(name: 'city') Object? city,@JsonKey(name: 'zip') Object? zip,@JsonKey(name: 'country') Object? country
});




}
/// @nodoc
class _$AddressDtoCopyWithImpl<$Res>
    implements $AddressDtoCopyWith<$Res> {
  _$AddressDtoCopyWithImpl(this._self, this._then);

  final AddressDto _self;
  final $Res Function(AddressDto) _then;

/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line = freezed,Object? city = freezed,Object? zip = freezed,Object? country = freezed,}) {
  return _then(_self.copyWith(
line: freezed == line ? _self.line : line ,city: freezed == city ? _self.city : city ,zip: freezed == zip ? _self.zip : zip ,country: freezed == country ? _self.country : country ,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressDto].
extension AddressDtoPatterns on AddressDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressDto value)  $default,){
final _that = this;
switch (_that) {
case _AddressDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressDto value)?  $default,){
final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'line')  Object? line, @JsonKey(name: 'city')  Object? city, @JsonKey(name: 'zip')  Object? zip, @JsonKey(name: 'country')  Object? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
return $default(_that.line,_that.city,_that.zip,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'line')  Object? line, @JsonKey(name: 'city')  Object? city, @JsonKey(name: 'zip')  Object? zip, @JsonKey(name: 'country')  Object? country)  $default,) {final _that = this;
switch (_that) {
case _AddressDto():
return $default(_that.line,_that.city,_that.zip,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'line')  Object? line, @JsonKey(name: 'city')  Object? city, @JsonKey(name: 'zip')  Object? zip, @JsonKey(name: 'country')  Object? country)?  $default,) {final _that = this;
switch (_that) {
case _AddressDto() when $default != null:
return $default(_that.line,_that.city,_that.zip,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressDto implements AddressDto {
  const _AddressDto({@JsonKey(name: 'line') this.line, @JsonKey(name: 'city') this.city, @JsonKey(name: 'zip') this.zip, @JsonKey(name: 'country') this.country});
  factory _AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);

@override@JsonKey(name: 'line') final  Object? line;
@override@JsonKey(name: 'city') final  Object? city;
@override@JsonKey(name: 'zip') final  Object? zip;
@override@JsonKey(name: 'country') final  Object? country;

/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressDtoCopyWith<_AddressDto> get copyWith => __$AddressDtoCopyWithImpl<_AddressDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressDto&&const DeepCollectionEquality().equals(other.line, line)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.zip, zip)&&const DeepCollectionEquality().equals(other.country, country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(line),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(zip),const DeepCollectionEquality().hash(country));

@override
String toString() {
  return 'AddressDto(line: $line, city: $city, zip: $zip, country: $country)';
}


}

/// @nodoc
abstract mixin class _$AddressDtoCopyWith<$Res> implements $AddressDtoCopyWith<$Res> {
  factory _$AddressDtoCopyWith(_AddressDto value, $Res Function(_AddressDto) _then) = __$AddressDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'line') Object? line,@JsonKey(name: 'city') Object? city,@JsonKey(name: 'zip') Object? zip,@JsonKey(name: 'country') Object? country
});




}
/// @nodoc
class __$AddressDtoCopyWithImpl<$Res>
    implements _$AddressDtoCopyWith<$Res> {
  __$AddressDtoCopyWithImpl(this._self, this._then);

  final _AddressDto _self;
  final $Res Function(_AddressDto) _then;

/// Create a copy of AddressDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line = freezed,Object? city = freezed,Object? zip = freezed,Object? country = freezed,}) {
  return _then(_AddressDto(
line: freezed == line ? _self.line : line ,city: freezed == city ? _self.city : city ,zip: freezed == zip ? _self.zip : zip ,country: freezed == country ? _self.country : country ,
  ));
}


}


/// @nodoc
mixin _$LocationDto {

@JsonKey(name: 'lat') Object? get lat;@JsonKey(name: 'lng') Object? get lng;
/// Create a copy of LocationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationDtoCopyWith<LocationDto> get copyWith => _$LocationDtoCopyWithImpl<LocationDto>(this as LocationDto, _$identity);

  /// Serializes this LocationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationDto&&const DeepCollectionEquality().equals(other.lat, lat)&&const DeepCollectionEquality().equals(other.lng, lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lat),const DeepCollectionEquality().hash(lng));

@override
String toString() {
  return 'LocationDto(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $LocationDtoCopyWith<$Res>  {
  factory $LocationDtoCopyWith(LocationDto value, $Res Function(LocationDto) _then) = _$LocationDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'lat') Object? lat,@JsonKey(name: 'lng') Object? lng
});




}
/// @nodoc
class _$LocationDtoCopyWithImpl<$Res>
    implements $LocationDtoCopyWith<$Res> {
  _$LocationDtoCopyWithImpl(this._self, this._then);

  final LocationDto _self;
  final $Res Function(LocationDto) _then;

/// Create a copy of LocationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_self.copyWith(
lat: freezed == lat ? _self.lat : lat ,lng: freezed == lng ? _self.lng : lng ,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationDto].
extension LocationDtoPatterns on LocationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationDto value)  $default,){
final _that = this;
switch (_that) {
case _LocationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationDto value)?  $default,){
final _that = this;
switch (_that) {
case _LocationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'lat')  Object? lat, @JsonKey(name: 'lng')  Object? lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationDto() when $default != null:
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'lat')  Object? lat, @JsonKey(name: 'lng')  Object? lng)  $default,) {final _that = this;
switch (_that) {
case _LocationDto():
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'lat')  Object? lat, @JsonKey(name: 'lng')  Object? lng)?  $default,) {final _that = this;
switch (_that) {
case _LocationDto() when $default != null:
return $default(_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationDto implements LocationDto {
  const _LocationDto({@JsonKey(name: 'lat') this.lat, @JsonKey(name: 'lng') this.lng});
  factory _LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);

@override@JsonKey(name: 'lat') final  Object? lat;
@override@JsonKey(name: 'lng') final  Object? lng;

/// Create a copy of LocationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationDtoCopyWith<_LocationDto> get copyWith => __$LocationDtoCopyWithImpl<_LocationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationDto&&const DeepCollectionEquality().equals(other.lat, lat)&&const DeepCollectionEquality().equals(other.lng, lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lat),const DeepCollectionEquality().hash(lng));

@override
String toString() {
  return 'LocationDto(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$LocationDtoCopyWith<$Res> implements $LocationDtoCopyWith<$Res> {
  factory _$LocationDtoCopyWith(_LocationDto value, $Res Function(_LocationDto) _then) = __$LocationDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'lat') Object? lat,@JsonKey(name: 'lng') Object? lng
});




}
/// @nodoc
class __$LocationDtoCopyWithImpl<$Res>
    implements _$LocationDtoCopyWith<$Res> {
  __$LocationDtoCopyWithImpl(this._self, this._then);

  final _LocationDto _self;
  final $Res Function(_LocationDto) _then;

/// Create a copy of LocationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_LocationDto(
lat: freezed == lat ? _self.lat : lat ,lng: freezed == lng ? _self.lng : lng ,
  ));
}


}


/// @nodoc
mixin _$ServiceDto {

@JsonKey(name: 'serviceId') Object? get serviceId;@JsonKey(name: 'id') Object? get id;@JsonKey(name: 'name') Object? get name;@JsonKey(name: 'durationMin') Object? get durationMin;@JsonKey(name: 'priceCents') Object? get priceCents;@JsonKey(name: 'active') Object? get active;@JsonKey(name: 'order') Object? get order;
/// Create a copy of ServiceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceDtoCopyWith<ServiceDto> get copyWith => _$ServiceDtoCopyWithImpl<ServiceDto>(this as ServiceDto, _$identity);

  /// Serializes this ServiceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceDto&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.active, active)&&const DeepCollectionEquality().equals(other.order, order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(active),const DeepCollectionEquality().hash(order));

@override
String toString() {
  return 'ServiceDto(serviceId: $serviceId, id: $id, name: $name, durationMin: $durationMin, priceCents: $priceCents, active: $active, order: $order)';
}


}

/// @nodoc
abstract mixin class $ServiceDtoCopyWith<$Res>  {
  factory $ServiceDtoCopyWith(ServiceDto value, $Res Function(ServiceDto) _then) = _$ServiceDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'active') Object? active,@JsonKey(name: 'order') Object? order
});




}
/// @nodoc
class _$ServiceDtoCopyWithImpl<$Res>
    implements $ServiceDtoCopyWith<$Res> {
  _$ServiceDtoCopyWithImpl(this._self, this._then);

  final ServiceDto _self;
  final $Res Function(ServiceDto) _then;

/// Create a copy of ServiceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = freezed,Object? id = freezed,Object? name = freezed,Object? durationMin = freezed,Object? priceCents = freezed,Object? active = freezed,Object? order = freezed,}) {
  return _then(_self.copyWith(
serviceId: freezed == serviceId ? _self.serviceId : serviceId ,id: freezed == id ? _self.id : id ,name: freezed == name ? _self.name : name ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,active: freezed == active ? _self.active : active ,order: freezed == order ? _self.order : order ,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceDto].
extension ServiceDtoPatterns on ServiceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceDto value)  $default,){
final _that = this;
switch (_that) {
case _ServiceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceDto value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'active')  Object? active, @JsonKey(name: 'order')  Object? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceDto() when $default != null:
return $default(_that.serviceId,_that.id,_that.name,_that.durationMin,_that.priceCents,_that.active,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'active')  Object? active, @JsonKey(name: 'order')  Object? order)  $default,) {final _that = this;
switch (_that) {
case _ServiceDto():
return $default(_that.serviceId,_that.id,_that.name,_that.durationMin,_that.priceCents,_that.active,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'active')  Object? active, @JsonKey(name: 'order')  Object? order)?  $default,) {final _that = this;
switch (_that) {
case _ServiceDto() when $default != null:
return $default(_that.serviceId,_that.id,_that.name,_that.durationMin,_that.priceCents,_that.active,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceDto implements ServiceDto {
  const _ServiceDto({@JsonKey(name: 'serviceId') this.serviceId, @JsonKey(name: 'id') this.id, @JsonKey(name: 'name') this.name, @JsonKey(name: 'durationMin') this.durationMin, @JsonKey(name: 'priceCents') this.priceCents, @JsonKey(name: 'active') this.active, @JsonKey(name: 'order') this.order});
  factory _ServiceDto.fromJson(Map<String, dynamic> json) => _$ServiceDtoFromJson(json);

@override@JsonKey(name: 'serviceId') final  Object? serviceId;
@override@JsonKey(name: 'id') final  Object? id;
@override@JsonKey(name: 'name') final  Object? name;
@override@JsonKey(name: 'durationMin') final  Object? durationMin;
@override@JsonKey(name: 'priceCents') final  Object? priceCents;
@override@JsonKey(name: 'active') final  Object? active;
@override@JsonKey(name: 'order') final  Object? order;

/// Create a copy of ServiceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceDtoCopyWith<_ServiceDto> get copyWith => __$ServiceDtoCopyWithImpl<_ServiceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceDto&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.active, active)&&const DeepCollectionEquality().equals(other.order, order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(active),const DeepCollectionEquality().hash(order));

@override
String toString() {
  return 'ServiceDto(serviceId: $serviceId, id: $id, name: $name, durationMin: $durationMin, priceCents: $priceCents, active: $active, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ServiceDtoCopyWith<$Res> implements $ServiceDtoCopyWith<$Res> {
  factory _$ServiceDtoCopyWith(_ServiceDto value, $Res Function(_ServiceDto) _then) = __$ServiceDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'active') Object? active,@JsonKey(name: 'order') Object? order
});




}
/// @nodoc
class __$ServiceDtoCopyWithImpl<$Res>
    implements _$ServiceDtoCopyWith<$Res> {
  __$ServiceDtoCopyWithImpl(this._self, this._then);

  final _ServiceDto _self;
  final $Res Function(_ServiceDto) _then;

/// Create a copy of ServiceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = freezed,Object? id = freezed,Object? name = freezed,Object? durationMin = freezed,Object? priceCents = freezed,Object? active = freezed,Object? order = freezed,}) {
  return _then(_ServiceDto(
serviceId: freezed == serviceId ? _self.serviceId : serviceId ,id: freezed == id ? _self.id : id ,name: freezed == name ? _self.name : name ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,active: freezed == active ? _self.active : active ,order: freezed == order ? _self.order : order ,
  ));
}


}


/// @nodoc
mixin _$ProviderDto {

@JsonKey(name: 'providerId') Object? get providerId;@JsonKey(name: 'name') Object? get name;@JsonKey(name: 'type') Object? get type;@JsonKey(name: 'serviceIds') List<dynamic>? get serviceIds;@JsonKey(name: 'openingHours') Map<String, dynamic>? get openingHours;@JsonKey(name: 'timeOff') List<dynamic>? get timeOff;@JsonKey(name: 'active') Object? get active;@JsonKey(name: 'order') Object? get order;
/// Create a copy of ProviderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderDtoCopyWith<ProviderDto> get copyWith => _$ProviderDtoCopyWithImpl<ProviderDto>(this as ProviderDto, _$identity);

  /// Serializes this ProviderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderDto&&const DeepCollectionEquality().equals(other.providerId, providerId)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.serviceIds, serviceIds)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&const DeepCollectionEquality().equals(other.timeOff, timeOff)&&const DeepCollectionEquality().equals(other.active, active)&&const DeepCollectionEquality().equals(other.order, order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(providerId),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(serviceIds),const DeepCollectionEquality().hash(openingHours),const DeepCollectionEquality().hash(timeOff),const DeepCollectionEquality().hash(active),const DeepCollectionEquality().hash(order));

@override
String toString() {
  return 'ProviderDto(providerId: $providerId, name: $name, type: $type, serviceIds: $serviceIds, openingHours: $openingHours, timeOff: $timeOff, active: $active, order: $order)';
}


}

/// @nodoc
abstract mixin class $ProviderDtoCopyWith<$Res>  {
  factory $ProviderDtoCopyWith(ProviderDto value, $Res Function(ProviderDto) _then) = _$ProviderDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'providerId') Object? providerId,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'type') Object? type,@JsonKey(name: 'serviceIds') List<dynamic>? serviceIds,@JsonKey(name: 'openingHours') Map<String, dynamic>? openingHours,@JsonKey(name: 'timeOff') List<dynamic>? timeOff,@JsonKey(name: 'active') Object? active,@JsonKey(name: 'order') Object? order
});




}
/// @nodoc
class _$ProviderDtoCopyWithImpl<$Res>
    implements $ProviderDtoCopyWith<$Res> {
  _$ProviderDtoCopyWithImpl(this._self, this._then);

  final ProviderDto _self;
  final $Res Function(ProviderDto) _then;

/// Create a copy of ProviderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providerId = freezed,Object? name = freezed,Object? type = freezed,Object? serviceIds = freezed,Object? openingHours = freezed,Object? timeOff = freezed,Object? active = freezed,Object? order = freezed,}) {
  return _then(_self.copyWith(
providerId: freezed == providerId ? _self.providerId : providerId ,name: freezed == name ? _self.name : name ,type: freezed == type ? _self.type : type ,serviceIds: freezed == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timeOff: freezed == timeOff ? _self.timeOff : timeOff // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,active: freezed == active ? _self.active : active ,order: freezed == order ? _self.order : order ,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderDto].
extension ProviderDtoPatterns on ProviderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderDto value)  $default,){
final _that = this;
switch (_that) {
case _ProviderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'providerId')  Object? providerId, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'type')  Object? type, @JsonKey(name: 'serviceIds')  List<dynamic>? serviceIds, @JsonKey(name: 'openingHours')  Map<String, dynamic>? openingHours, @JsonKey(name: 'timeOff')  List<dynamic>? timeOff, @JsonKey(name: 'active')  Object? active, @JsonKey(name: 'order')  Object? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderDto() when $default != null:
return $default(_that.providerId,_that.name,_that.type,_that.serviceIds,_that.openingHours,_that.timeOff,_that.active,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'providerId')  Object? providerId, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'type')  Object? type, @JsonKey(name: 'serviceIds')  List<dynamic>? serviceIds, @JsonKey(name: 'openingHours')  Map<String, dynamic>? openingHours, @JsonKey(name: 'timeOff')  List<dynamic>? timeOff, @JsonKey(name: 'active')  Object? active, @JsonKey(name: 'order')  Object? order)  $default,) {final _that = this;
switch (_that) {
case _ProviderDto():
return $default(_that.providerId,_that.name,_that.type,_that.serviceIds,_that.openingHours,_that.timeOff,_that.active,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'providerId')  Object? providerId, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'type')  Object? type, @JsonKey(name: 'serviceIds')  List<dynamic>? serviceIds, @JsonKey(name: 'openingHours')  Map<String, dynamic>? openingHours, @JsonKey(name: 'timeOff')  List<dynamic>? timeOff, @JsonKey(name: 'active')  Object? active, @JsonKey(name: 'order')  Object? order)?  $default,) {final _that = this;
switch (_that) {
case _ProviderDto() when $default != null:
return $default(_that.providerId,_that.name,_that.type,_that.serviceIds,_that.openingHours,_that.timeOff,_that.active,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderDto implements ProviderDto {
  const _ProviderDto({@JsonKey(name: 'providerId') this.providerId, @JsonKey(name: 'name') this.name, @JsonKey(name: 'type') this.type, @JsonKey(name: 'serviceIds') final  List<dynamic>? serviceIds, @JsonKey(name: 'openingHours') final  Map<String, dynamic>? openingHours, @JsonKey(name: 'timeOff') final  List<dynamic>? timeOff, @JsonKey(name: 'active') this.active, @JsonKey(name: 'order') this.order}): _serviceIds = serviceIds,_openingHours = openingHours,_timeOff = timeOff;
  factory _ProviderDto.fromJson(Map<String, dynamic> json) => _$ProviderDtoFromJson(json);

@override@JsonKey(name: 'providerId') final  Object? providerId;
@override@JsonKey(name: 'name') final  Object? name;
@override@JsonKey(name: 'type') final  Object? type;
 final  List<dynamic>? _serviceIds;
@override@JsonKey(name: 'serviceIds') List<dynamic>? get serviceIds {
  final value = _serviceIds;
  if (value == null) return null;
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _openingHours;
@override@JsonKey(name: 'openingHours') Map<String, dynamic>? get openingHours {
  final value = _openingHours;
  if (value == null) return null;
  if (_openingHours is EqualUnmodifiableMapView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _timeOff;
@override@JsonKey(name: 'timeOff') List<dynamic>? get timeOff {
  final value = _timeOff;
  if (value == null) return null;
  if (_timeOff is EqualUnmodifiableListView) return _timeOff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'active') final  Object? active;
@override@JsonKey(name: 'order') final  Object? order;

/// Create a copy of ProviderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderDtoCopyWith<_ProviderDto> get copyWith => __$ProviderDtoCopyWithImpl<_ProviderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderDto&&const DeepCollectionEquality().equals(other.providerId, providerId)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other._serviceIds, _serviceIds)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&const DeepCollectionEquality().equals(other._timeOff, _timeOff)&&const DeepCollectionEquality().equals(other.active, active)&&const DeepCollectionEquality().equals(other.order, order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(providerId),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(_serviceIds),const DeepCollectionEquality().hash(_openingHours),const DeepCollectionEquality().hash(_timeOff),const DeepCollectionEquality().hash(active),const DeepCollectionEquality().hash(order));

@override
String toString() {
  return 'ProviderDto(providerId: $providerId, name: $name, type: $type, serviceIds: $serviceIds, openingHours: $openingHours, timeOff: $timeOff, active: $active, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProviderDtoCopyWith<$Res> implements $ProviderDtoCopyWith<$Res> {
  factory _$ProviderDtoCopyWith(_ProviderDto value, $Res Function(_ProviderDto) _then) = __$ProviderDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'providerId') Object? providerId,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'type') Object? type,@JsonKey(name: 'serviceIds') List<dynamic>? serviceIds,@JsonKey(name: 'openingHours') Map<String, dynamic>? openingHours,@JsonKey(name: 'timeOff') List<dynamic>? timeOff,@JsonKey(name: 'active') Object? active,@JsonKey(name: 'order') Object? order
});




}
/// @nodoc
class __$ProviderDtoCopyWithImpl<$Res>
    implements _$ProviderDtoCopyWith<$Res> {
  __$ProviderDtoCopyWithImpl(this._self, this._then);

  final _ProviderDto _self;
  final $Res Function(_ProviderDto) _then;

/// Create a copy of ProviderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providerId = freezed,Object? name = freezed,Object? type = freezed,Object? serviceIds = freezed,Object? openingHours = freezed,Object? timeOff = freezed,Object? active = freezed,Object? order = freezed,}) {
  return _then(_ProviderDto(
providerId: freezed == providerId ? _self.providerId : providerId ,name: freezed == name ? _self.name : name ,type: freezed == type ? _self.type : type ,serviceIds: freezed == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,openingHours: freezed == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timeOff: freezed == timeOff ? _self._timeOff : timeOff // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,active: freezed == active ? _self.active : active ,order: freezed == order ? _self.order : order ,
  ));
}


}

// dart format on

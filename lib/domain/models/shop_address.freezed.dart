// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopAddress {

 String get line; String get city; String get zip; String get country; double? get latitude; double? get longitude;
/// Create a copy of ShopAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopAddressCopyWith<ShopAddress> get copyWith => _$ShopAddressCopyWithImpl<ShopAddress>(this as ShopAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopAddress&&(identical(other.line, line) || other.line == line)&&(identical(other.city, city) || other.city == city)&&(identical(other.zip, zip) || other.zip == zip)&&(identical(other.country, country) || other.country == country)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,line,city,zip,country,latitude,longitude);

@override
String toString() {
  return 'ShopAddress(line: $line, city: $city, zip: $zip, country: $country, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ShopAddressCopyWith<$Res>  {
  factory $ShopAddressCopyWith(ShopAddress value, $Res Function(ShopAddress) _then) = _$ShopAddressCopyWithImpl;
@useResult
$Res call({
 String line, String city, String zip, String country, double? latitude, double? longitude
});




}
/// @nodoc
class _$ShopAddressCopyWithImpl<$Res>
    implements $ShopAddressCopyWith<$Res> {
  _$ShopAddressCopyWithImpl(this._self, this._then);

  final ShopAddress _self;
  final $Res Function(ShopAddress) _then;

/// Create a copy of ShopAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line = null,Object? city = null,Object? zip = null,Object? country = null,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,zip: null == zip ? _self.zip : zip // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopAddress].
extension ShopAddressPatterns on ShopAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopAddress value)  $default,){
final _that = this;
switch (_that) {
case _ShopAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopAddress value)?  $default,){
final _that = this;
switch (_that) {
case _ShopAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String line,  String city,  String zip,  String country,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopAddress() when $default != null:
return $default(_that.line,_that.city,_that.zip,_that.country,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String line,  String city,  String zip,  String country,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _ShopAddress():
return $default(_that.line,_that.city,_that.zip,_that.country,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String line,  String city,  String zip,  String country,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _ShopAddress() when $default != null:
return $default(_that.line,_that.city,_that.zip,_that.country,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _ShopAddress extends ShopAddress {
  const _ShopAddress({required this.line, required this.city, required this.zip, required this.country, this.latitude, this.longitude}): super._();
  

@override final  String line;
@override final  String city;
@override final  String zip;
@override final  String country;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of ShopAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopAddressCopyWith<_ShopAddress> get copyWith => __$ShopAddressCopyWithImpl<_ShopAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopAddress&&(identical(other.line, line) || other.line == line)&&(identical(other.city, city) || other.city == city)&&(identical(other.zip, zip) || other.zip == zip)&&(identical(other.country, country) || other.country == country)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,line,city,zip,country,latitude,longitude);

@override
String toString() {
  return 'ShopAddress(line: $line, city: $city, zip: $zip, country: $country, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ShopAddressCopyWith<$Res> implements $ShopAddressCopyWith<$Res> {
  factory _$ShopAddressCopyWith(_ShopAddress value, $Res Function(_ShopAddress) _then) = __$ShopAddressCopyWithImpl;
@override @useResult
$Res call({
 String line, String city, String zip, String country, double? latitude, double? longitude
});




}
/// @nodoc
class __$ShopAddressCopyWithImpl<$Res>
    implements _$ShopAddressCopyWith<$Res> {
  __$ShopAddressCopyWithImpl(this._self, this._then);

  final _ShopAddress _self;
  final $Res Function(_ShopAddress) _then;

/// Create a copy of ShopAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line = null,Object? city = null,Object? zip = null,Object? country = null,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_ShopAddress(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,zip: null == zip ? _self.zip : zip // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$PlaceSuggestion {

 String get placeId; String get label; String? get secondaryLabel;
/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSuggestionCopyWith<PlaceSuggestion> get copyWith => _$PlaceSuggestionCopyWithImpl<PlaceSuggestion>(this as PlaceSuggestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSuggestion&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.label, label) || other.label == label)&&(identical(other.secondaryLabel, secondaryLabel) || other.secondaryLabel == secondaryLabel));
}


@override
int get hashCode => Object.hash(runtimeType,placeId,label,secondaryLabel);

@override
String toString() {
  return 'PlaceSuggestion(placeId: $placeId, label: $label, secondaryLabel: $secondaryLabel)';
}


}

/// @nodoc
abstract mixin class $PlaceSuggestionCopyWith<$Res>  {
  factory $PlaceSuggestionCopyWith(PlaceSuggestion value, $Res Function(PlaceSuggestion) _then) = _$PlaceSuggestionCopyWithImpl;
@useResult
$Res call({
 String placeId, String label, String? secondaryLabel
});




}
/// @nodoc
class _$PlaceSuggestionCopyWithImpl<$Res>
    implements $PlaceSuggestionCopyWith<$Res> {
  _$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final PlaceSuggestion _self;
  final $Res Function(PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? label = null,Object? secondaryLabel = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,secondaryLabel: freezed == secondaryLabel ? _self.secondaryLabel : secondaryLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSuggestion].
extension PlaceSuggestionPatterns on PlaceSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String placeId,  String label,  String? secondaryLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.placeId,_that.label,_that.secondaryLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String placeId,  String label,  String? secondaryLabel)  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion():
return $default(_that.placeId,_that.label,_that.secondaryLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String placeId,  String label,  String? secondaryLabel)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.placeId,_that.label,_that.secondaryLabel);case _:
  return null;

}
}

}

/// @nodoc


class _PlaceSuggestion implements PlaceSuggestion {
  const _PlaceSuggestion({required this.placeId, required this.label, this.secondaryLabel});
  

@override final  String placeId;
@override final  String label;
@override final  String? secondaryLabel;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSuggestionCopyWith<_PlaceSuggestion> get copyWith => __$PlaceSuggestionCopyWithImpl<_PlaceSuggestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSuggestion&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.label, label) || other.label == label)&&(identical(other.secondaryLabel, secondaryLabel) || other.secondaryLabel == secondaryLabel));
}


@override
int get hashCode => Object.hash(runtimeType,placeId,label,secondaryLabel);

@override
String toString() {
  return 'PlaceSuggestion(placeId: $placeId, label: $label, secondaryLabel: $secondaryLabel)';
}


}

/// @nodoc
abstract mixin class _$PlaceSuggestionCopyWith<$Res> implements $PlaceSuggestionCopyWith<$Res> {
  factory _$PlaceSuggestionCopyWith(_PlaceSuggestion value, $Res Function(_PlaceSuggestion) _then) = __$PlaceSuggestionCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String label, String? secondaryLabel
});




}
/// @nodoc
class __$PlaceSuggestionCopyWithImpl<$Res>
    implements _$PlaceSuggestionCopyWith<$Res> {
  __$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final _PlaceSuggestion _self;
  final $Res Function(_PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? label = null,Object? secondaryLabel = freezed,}) {
  return _then(_PlaceSuggestion(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,secondaryLabel: freezed == secondaryLabel ? _self.secondaryLabel : secondaryLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

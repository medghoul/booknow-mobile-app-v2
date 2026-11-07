// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeDto {

@JsonKey(name: 'nextBooking') Map<String, dynamic>? get nextBooking;@JsonKey(name: 'freeToday') List<dynamic>? get freeToday;@JsonKey(name: 'freeTodayTotal') Object? get freeTodayTotal;@JsonKey(name: 'shopsNearby') List<dynamic>? get shopsNearby;
/// Create a copy of HomeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDtoCopyWith<HomeDto> get copyWith => _$HomeDtoCopyWithImpl<HomeDto>(this as HomeDto, _$identity);

  /// Serializes this HomeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDto&&const DeepCollectionEquality().equals(other.nextBooking, nextBooking)&&const DeepCollectionEquality().equals(other.freeToday, freeToday)&&const DeepCollectionEquality().equals(other.freeTodayTotal, freeTodayTotal)&&const DeepCollectionEquality().equals(other.shopsNearby, shopsNearby));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nextBooking),const DeepCollectionEquality().hash(freeToday),const DeepCollectionEquality().hash(freeTodayTotal),const DeepCollectionEquality().hash(shopsNearby));

@override
String toString() {
  return 'HomeDto(nextBooking: $nextBooking, freeToday: $freeToday, freeTodayTotal: $freeTodayTotal, shopsNearby: $shopsNearby)';
}


}

/// @nodoc
abstract mixin class $HomeDtoCopyWith<$Res>  {
  factory $HomeDtoCopyWith(HomeDto value, $Res Function(HomeDto) _then) = _$HomeDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'nextBooking') Map<String, dynamic>? nextBooking,@JsonKey(name: 'freeToday') List<dynamic>? freeToday,@JsonKey(name: 'freeTodayTotal') Object? freeTodayTotal,@JsonKey(name: 'shopsNearby') List<dynamic>? shopsNearby
});




}
/// @nodoc
class _$HomeDtoCopyWithImpl<$Res>
    implements $HomeDtoCopyWith<$Res> {
  _$HomeDtoCopyWithImpl(this._self, this._then);

  final HomeDto _self;
  final $Res Function(HomeDto) _then;

/// Create a copy of HomeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextBooking = freezed,Object? freeToday = freezed,Object? freeTodayTotal = freezed,Object? shopsNearby = freezed,}) {
  return _then(_self.copyWith(
nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,freeToday: freezed == freeToday ? _self.freeToday : freeToday // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,freeTodayTotal: freezed == freeTodayTotal ? _self.freeTodayTotal : freeTodayTotal ,shopsNearby: freezed == shopsNearby ? _self.shopsNearby : shopsNearby // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeDto].
extension HomeDtoPatterns on HomeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'nextBooking')  Map<String, dynamic>? nextBooking, @JsonKey(name: 'freeToday')  List<dynamic>? freeToday, @JsonKey(name: 'freeTodayTotal')  Object? freeTodayTotal, @JsonKey(name: 'shopsNearby')  List<dynamic>? shopsNearby)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeDto() when $default != null:
return $default(_that.nextBooking,_that.freeToday,_that.freeTodayTotal,_that.shopsNearby);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'nextBooking')  Map<String, dynamic>? nextBooking, @JsonKey(name: 'freeToday')  List<dynamic>? freeToday, @JsonKey(name: 'freeTodayTotal')  Object? freeTodayTotal, @JsonKey(name: 'shopsNearby')  List<dynamic>? shopsNearby)  $default,) {final _that = this;
switch (_that) {
case _HomeDto():
return $default(_that.nextBooking,_that.freeToday,_that.freeTodayTotal,_that.shopsNearby);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'nextBooking')  Map<String, dynamic>? nextBooking, @JsonKey(name: 'freeToday')  List<dynamic>? freeToday, @JsonKey(name: 'freeTodayTotal')  Object? freeTodayTotal, @JsonKey(name: 'shopsNearby')  List<dynamic>? shopsNearby)?  $default,) {final _that = this;
switch (_that) {
case _HomeDto() when $default != null:
return $default(_that.nextBooking,_that.freeToday,_that.freeTodayTotal,_that.shopsNearby);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeDto extends HomeDto {
  const _HomeDto({@JsonKey(name: 'nextBooking') final  Map<String, dynamic>? nextBooking, @JsonKey(name: 'freeToday') final  List<dynamic>? freeToday, @JsonKey(name: 'freeTodayTotal') this.freeTodayTotal, @JsonKey(name: 'shopsNearby') final  List<dynamic>? shopsNearby}): _nextBooking = nextBooking,_freeToday = freeToday,_shopsNearby = shopsNearby,super._();
  factory _HomeDto.fromJson(Map<String, dynamic> json) => _$HomeDtoFromJson(json);

 final  Map<String, dynamic>? _nextBooking;
@override@JsonKey(name: 'nextBooking') Map<String, dynamic>? get nextBooking {
  final value = _nextBooking;
  if (value == null) return null;
  if (_nextBooking is EqualUnmodifiableMapView) return _nextBooking;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _freeToday;
@override@JsonKey(name: 'freeToday') List<dynamic>? get freeToday {
  final value = _freeToday;
  if (value == null) return null;
  if (_freeToday is EqualUnmodifiableListView) return _freeToday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'freeTodayTotal') final  Object? freeTodayTotal;
 final  List<dynamic>? _shopsNearby;
@override@JsonKey(name: 'shopsNearby') List<dynamic>? get shopsNearby {
  final value = _shopsNearby;
  if (value == null) return null;
  if (_shopsNearby is EqualUnmodifiableListView) return _shopsNearby;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HomeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeDtoCopyWith<_HomeDto> get copyWith => __$HomeDtoCopyWithImpl<_HomeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeDto&&const DeepCollectionEquality().equals(other._nextBooking, _nextBooking)&&const DeepCollectionEquality().equals(other._freeToday, _freeToday)&&const DeepCollectionEquality().equals(other.freeTodayTotal, freeTodayTotal)&&const DeepCollectionEquality().equals(other._shopsNearby, _shopsNearby));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nextBooking),const DeepCollectionEquality().hash(_freeToday),const DeepCollectionEquality().hash(freeTodayTotal),const DeepCollectionEquality().hash(_shopsNearby));

@override
String toString() {
  return 'HomeDto(nextBooking: $nextBooking, freeToday: $freeToday, freeTodayTotal: $freeTodayTotal, shopsNearby: $shopsNearby)';
}


}

/// @nodoc
abstract mixin class _$HomeDtoCopyWith<$Res> implements $HomeDtoCopyWith<$Res> {
  factory _$HomeDtoCopyWith(_HomeDto value, $Res Function(_HomeDto) _then) = __$HomeDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'nextBooking') Map<String, dynamic>? nextBooking,@JsonKey(name: 'freeToday') List<dynamic>? freeToday,@JsonKey(name: 'freeTodayTotal') Object? freeTodayTotal,@JsonKey(name: 'shopsNearby') List<dynamic>? shopsNearby
});




}
/// @nodoc
class __$HomeDtoCopyWithImpl<$Res>
    implements _$HomeDtoCopyWith<$Res> {
  __$HomeDtoCopyWithImpl(this._self, this._then);

  final _HomeDto _self;
  final $Res Function(_HomeDto) _then;

/// Create a copy of HomeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextBooking = freezed,Object? freeToday = freezed,Object? freeTodayTotal = freezed,Object? shopsNearby = freezed,}) {
  return _then(_HomeDto(
nextBooking: freezed == nextBooking ? _self._nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,freeToday: freezed == freeToday ? _self._freeToday : freeToday // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,freeTodayTotal: freezed == freeTodayTotal ? _self.freeTodayTotal : freeTodayTotal ,shopsNearby: freezed == shopsNearby ? _self._shopsNearby : shopsNearby // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ShopDirectoryDto {

@JsonKey(name: 'shops') List<dynamic>? get shops;
/// Create a copy of ShopDirectoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopDirectoryDtoCopyWith<ShopDirectoryDto> get copyWith => _$ShopDirectoryDtoCopyWithImpl<ShopDirectoryDto>(this as ShopDirectoryDto, _$identity);

  /// Serializes this ShopDirectoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopDirectoryDto&&const DeepCollectionEquality().equals(other.shops, shops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shops));

@override
String toString() {
  return 'ShopDirectoryDto(shops: $shops)';
}


}

/// @nodoc
abstract mixin class $ShopDirectoryDtoCopyWith<$Res>  {
  factory $ShopDirectoryDtoCopyWith(ShopDirectoryDto value, $Res Function(ShopDirectoryDto) _then) = _$ShopDirectoryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'shops') List<dynamic>? shops
});




}
/// @nodoc
class _$ShopDirectoryDtoCopyWithImpl<$Res>
    implements $ShopDirectoryDtoCopyWith<$Res> {
  _$ShopDirectoryDtoCopyWithImpl(this._self, this._then);

  final ShopDirectoryDto _self;
  final $Res Function(ShopDirectoryDto) _then;

/// Create a copy of ShopDirectoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shops = freezed,}) {
  return _then(_self.copyWith(
shops: freezed == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopDirectoryDto].
extension ShopDirectoryDtoPatterns on ShopDirectoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopDirectoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopDirectoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopDirectoryDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopDirectoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopDirectoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopDirectoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'shops')  List<dynamic>? shops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopDirectoryDto() when $default != null:
return $default(_that.shops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'shops')  List<dynamic>? shops)  $default,) {final _that = this;
switch (_that) {
case _ShopDirectoryDto():
return $default(_that.shops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'shops')  List<dynamic>? shops)?  $default,) {final _that = this;
switch (_that) {
case _ShopDirectoryDto() when $default != null:
return $default(_that.shops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopDirectoryDto extends ShopDirectoryDto {
  const _ShopDirectoryDto({@JsonKey(name: 'shops') final  List<dynamic>? shops}): _shops = shops,super._();
  factory _ShopDirectoryDto.fromJson(Map<String, dynamic> json) => _$ShopDirectoryDtoFromJson(json);

 final  List<dynamic>? _shops;
@override@JsonKey(name: 'shops') List<dynamic>? get shops {
  final value = _shops;
  if (value == null) return null;
  if (_shops is EqualUnmodifiableListView) return _shops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ShopDirectoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopDirectoryDtoCopyWith<_ShopDirectoryDto> get copyWith => __$ShopDirectoryDtoCopyWithImpl<_ShopDirectoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopDirectoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopDirectoryDto&&const DeepCollectionEquality().equals(other._shops, _shops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shops));

@override
String toString() {
  return 'ShopDirectoryDto(shops: $shops)';
}


}

/// @nodoc
abstract mixin class _$ShopDirectoryDtoCopyWith<$Res> implements $ShopDirectoryDtoCopyWith<$Res> {
  factory _$ShopDirectoryDtoCopyWith(_ShopDirectoryDto value, $Res Function(_ShopDirectoryDto) _then) = __$ShopDirectoryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'shops') List<dynamic>? shops
});




}
/// @nodoc
class __$ShopDirectoryDtoCopyWithImpl<$Res>
    implements _$ShopDirectoryDtoCopyWith<$Res> {
  __$ShopDirectoryDtoCopyWithImpl(this._self, this._then);

  final _ShopDirectoryDto _self;
  final $Res Function(_ShopDirectoryDto) _then;

/// Create a copy of ShopDirectoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shops = freezed,}) {
  return _then(_ShopDirectoryDto(
shops: freezed == shops ? _self._shops : shops // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ShopSummaryDto {

@JsonKey(name: 'shopId') Object? get shopId;@JsonKey(name: 'name') Object? get name;@JsonKey(name: 'address') Object? get address;@JsonKey(name: 'city') Object? get city;@JsonKey(name: 'distanceM') Object? get distanceM;@JsonKey(name: 'openNow') Object? get openNow;@JsonKey(name: 'closesAt') Object? get closesAt;@JsonKey(name: 'opensAt') Object? get opensAt;@JsonKey(name: 'servicesCount') Object? get servicesCount;@JsonKey(name: 'fromPriceCents') Object? get fromPriceCents;@JsonKey(name: 'photoUrl') Object? get photoUrl;@JsonKey(name: 'mode') Object? get mode;@JsonKey(name: 'category') Object? get category;
/// Create a copy of ShopSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSummaryDtoCopyWith<ShopSummaryDto> get copyWith => _$ShopSummaryDtoCopyWithImpl<ShopSummaryDto>(this as ShopSummaryDto, _$identity);

  /// Serializes this ShopSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSummaryDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.distanceM, distanceM)&&const DeepCollectionEquality().equals(other.openNow, openNow)&&const DeepCollectionEquality().equals(other.closesAt, closesAt)&&const DeepCollectionEquality().equals(other.opensAt, opensAt)&&const DeepCollectionEquality().equals(other.servicesCount, servicesCount)&&const DeepCollectionEquality().equals(other.fromPriceCents, fromPriceCents)&&const DeepCollectionEquality().equals(other.photoUrl, photoUrl)&&const DeepCollectionEquality().equals(other.mode, mode)&&const DeepCollectionEquality().equals(other.category, category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(distanceM),const DeepCollectionEquality().hash(openNow),const DeepCollectionEquality().hash(closesAt),const DeepCollectionEquality().hash(opensAt),const DeepCollectionEquality().hash(servicesCount),const DeepCollectionEquality().hash(fromPriceCents),const DeepCollectionEquality().hash(photoUrl),const DeepCollectionEquality().hash(mode),const DeepCollectionEquality().hash(category));

@override
String toString() {
  return 'ShopSummaryDto(shopId: $shopId, name: $name, address: $address, city: $city, distanceM: $distanceM, openNow: $openNow, closesAt: $closesAt, opensAt: $opensAt, servicesCount: $servicesCount, fromPriceCents: $fromPriceCents, photoUrl: $photoUrl, mode: $mode, category: $category)';
}


}

/// @nodoc
abstract mixin class $ShopSummaryDtoCopyWith<$Res>  {
  factory $ShopSummaryDtoCopyWith(ShopSummaryDto value, $Res Function(ShopSummaryDto) _then) = _$ShopSummaryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'address') Object? address,@JsonKey(name: 'city') Object? city,@JsonKey(name: 'distanceM') Object? distanceM,@JsonKey(name: 'openNow') Object? openNow,@JsonKey(name: 'closesAt') Object? closesAt,@JsonKey(name: 'opensAt') Object? opensAt,@JsonKey(name: 'servicesCount') Object? servicesCount,@JsonKey(name: 'fromPriceCents') Object? fromPriceCents,@JsonKey(name: 'photoUrl') Object? photoUrl,@JsonKey(name: 'mode') Object? mode,@JsonKey(name: 'category') Object? category
});




}
/// @nodoc
class _$ShopSummaryDtoCopyWithImpl<$Res>
    implements $ShopSummaryDtoCopyWith<$Res> {
  _$ShopSummaryDtoCopyWithImpl(this._self, this._then);

  final ShopSummaryDto _self;
  final $Res Function(ShopSummaryDto) _then;

/// Create a copy of ShopSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = freezed,Object? name = freezed,Object? address = freezed,Object? city = freezed,Object? distanceM = freezed,Object? openNow = freezed,Object? closesAt = freezed,Object? opensAt = freezed,Object? servicesCount = freezed,Object? fromPriceCents = freezed,Object? photoUrl = freezed,Object? mode = freezed,Object? category = freezed,}) {
  return _then(_self.copyWith(
shopId: freezed == shopId ? _self.shopId : shopId ,name: freezed == name ? _self.name : name ,address: freezed == address ? _self.address : address ,city: freezed == city ? _self.city : city ,distanceM: freezed == distanceM ? _self.distanceM : distanceM ,openNow: freezed == openNow ? _self.openNow : openNow ,closesAt: freezed == closesAt ? _self.closesAt : closesAt ,opensAt: freezed == opensAt ? _self.opensAt : opensAt ,servicesCount: freezed == servicesCount ? _self.servicesCount : servicesCount ,fromPriceCents: freezed == fromPriceCents ? _self.fromPriceCents : fromPriceCents ,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl ,mode: freezed == mode ? _self.mode : mode ,category: freezed == category ? _self.category : category ,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopSummaryDto].
extension ShopSummaryDtoPatterns on ShopSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'address')  Object? address, @JsonKey(name: 'city')  Object? city, @JsonKey(name: 'distanceM')  Object? distanceM, @JsonKey(name: 'openNow')  Object? openNow, @JsonKey(name: 'closesAt')  Object? closesAt, @JsonKey(name: 'opensAt')  Object? opensAt, @JsonKey(name: 'servicesCount')  Object? servicesCount, @JsonKey(name: 'fromPriceCents')  Object? fromPriceCents, @JsonKey(name: 'photoUrl')  Object? photoUrl, @JsonKey(name: 'mode')  Object? mode, @JsonKey(name: 'category')  Object? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopSummaryDto() when $default != null:
return $default(_that.shopId,_that.name,_that.address,_that.city,_that.distanceM,_that.openNow,_that.closesAt,_that.opensAt,_that.servicesCount,_that.fromPriceCents,_that.photoUrl,_that.mode,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'address')  Object? address, @JsonKey(name: 'city')  Object? city, @JsonKey(name: 'distanceM')  Object? distanceM, @JsonKey(name: 'openNow')  Object? openNow, @JsonKey(name: 'closesAt')  Object? closesAt, @JsonKey(name: 'opensAt')  Object? opensAt, @JsonKey(name: 'servicesCount')  Object? servicesCount, @JsonKey(name: 'fromPriceCents')  Object? fromPriceCents, @JsonKey(name: 'photoUrl')  Object? photoUrl, @JsonKey(name: 'mode')  Object? mode, @JsonKey(name: 'category')  Object? category)  $default,) {final _that = this;
switch (_that) {
case _ShopSummaryDto():
return $default(_that.shopId,_that.name,_that.address,_that.city,_that.distanceM,_that.openNow,_that.closesAt,_that.opensAt,_that.servicesCount,_that.fromPriceCents,_that.photoUrl,_that.mode,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'name')  Object? name, @JsonKey(name: 'address')  Object? address, @JsonKey(name: 'city')  Object? city, @JsonKey(name: 'distanceM')  Object? distanceM, @JsonKey(name: 'openNow')  Object? openNow, @JsonKey(name: 'closesAt')  Object? closesAt, @JsonKey(name: 'opensAt')  Object? opensAt, @JsonKey(name: 'servicesCount')  Object? servicesCount, @JsonKey(name: 'fromPriceCents')  Object? fromPriceCents, @JsonKey(name: 'photoUrl')  Object? photoUrl, @JsonKey(name: 'mode')  Object? mode, @JsonKey(name: 'category')  Object? category)?  $default,) {final _that = this;
switch (_that) {
case _ShopSummaryDto() when $default != null:
return $default(_that.shopId,_that.name,_that.address,_that.city,_that.distanceM,_that.openNow,_that.closesAt,_that.opensAt,_that.servicesCount,_that.fromPriceCents,_that.photoUrl,_that.mode,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopSummaryDto extends ShopSummaryDto {
  const _ShopSummaryDto({@JsonKey(name: 'shopId') this.shopId, @JsonKey(name: 'name') this.name, @JsonKey(name: 'address') this.address, @JsonKey(name: 'city') this.city, @JsonKey(name: 'distanceM') this.distanceM, @JsonKey(name: 'openNow') this.openNow, @JsonKey(name: 'closesAt') this.closesAt, @JsonKey(name: 'opensAt') this.opensAt, @JsonKey(name: 'servicesCount') this.servicesCount, @JsonKey(name: 'fromPriceCents') this.fromPriceCents, @JsonKey(name: 'photoUrl') this.photoUrl, @JsonKey(name: 'mode') this.mode, @JsonKey(name: 'category') this.category}): super._();
  factory _ShopSummaryDto.fromJson(Map<String, dynamic> json) => _$ShopSummaryDtoFromJson(json);

@override@JsonKey(name: 'shopId') final  Object? shopId;
@override@JsonKey(name: 'name') final  Object? name;
@override@JsonKey(name: 'address') final  Object? address;
@override@JsonKey(name: 'city') final  Object? city;
@override@JsonKey(name: 'distanceM') final  Object? distanceM;
@override@JsonKey(name: 'openNow') final  Object? openNow;
@override@JsonKey(name: 'closesAt') final  Object? closesAt;
@override@JsonKey(name: 'opensAt') final  Object? opensAt;
@override@JsonKey(name: 'servicesCount') final  Object? servicesCount;
@override@JsonKey(name: 'fromPriceCents') final  Object? fromPriceCents;
@override@JsonKey(name: 'photoUrl') final  Object? photoUrl;
@override@JsonKey(name: 'mode') final  Object? mode;
@override@JsonKey(name: 'category') final  Object? category;

/// Create a copy of ShopSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopSummaryDtoCopyWith<_ShopSummaryDto> get copyWith => __$ShopSummaryDtoCopyWithImpl<_ShopSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopSummaryDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.distanceM, distanceM)&&const DeepCollectionEquality().equals(other.openNow, openNow)&&const DeepCollectionEquality().equals(other.closesAt, closesAt)&&const DeepCollectionEquality().equals(other.opensAt, opensAt)&&const DeepCollectionEquality().equals(other.servicesCount, servicesCount)&&const DeepCollectionEquality().equals(other.fromPriceCents, fromPriceCents)&&const DeepCollectionEquality().equals(other.photoUrl, photoUrl)&&const DeepCollectionEquality().equals(other.mode, mode)&&const DeepCollectionEquality().equals(other.category, category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(distanceM),const DeepCollectionEquality().hash(openNow),const DeepCollectionEquality().hash(closesAt),const DeepCollectionEquality().hash(opensAt),const DeepCollectionEquality().hash(servicesCount),const DeepCollectionEquality().hash(fromPriceCents),const DeepCollectionEquality().hash(photoUrl),const DeepCollectionEquality().hash(mode),const DeepCollectionEquality().hash(category));

@override
String toString() {
  return 'ShopSummaryDto(shopId: $shopId, name: $name, address: $address, city: $city, distanceM: $distanceM, openNow: $openNow, closesAt: $closesAt, opensAt: $opensAt, servicesCount: $servicesCount, fromPriceCents: $fromPriceCents, photoUrl: $photoUrl, mode: $mode, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ShopSummaryDtoCopyWith<$Res> implements $ShopSummaryDtoCopyWith<$Res> {
  factory _$ShopSummaryDtoCopyWith(_ShopSummaryDto value, $Res Function(_ShopSummaryDto) _then) = __$ShopSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'name') Object? name,@JsonKey(name: 'address') Object? address,@JsonKey(name: 'city') Object? city,@JsonKey(name: 'distanceM') Object? distanceM,@JsonKey(name: 'openNow') Object? openNow,@JsonKey(name: 'closesAt') Object? closesAt,@JsonKey(name: 'opensAt') Object? opensAt,@JsonKey(name: 'servicesCount') Object? servicesCount,@JsonKey(name: 'fromPriceCents') Object? fromPriceCents,@JsonKey(name: 'photoUrl') Object? photoUrl,@JsonKey(name: 'mode') Object? mode,@JsonKey(name: 'category') Object? category
});




}
/// @nodoc
class __$ShopSummaryDtoCopyWithImpl<$Res>
    implements _$ShopSummaryDtoCopyWith<$Res> {
  __$ShopSummaryDtoCopyWithImpl(this._self, this._then);

  final _ShopSummaryDto _self;
  final $Res Function(_ShopSummaryDto) _then;

/// Create a copy of ShopSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = freezed,Object? name = freezed,Object? address = freezed,Object? city = freezed,Object? distanceM = freezed,Object? openNow = freezed,Object? closesAt = freezed,Object? opensAt = freezed,Object? servicesCount = freezed,Object? fromPriceCents = freezed,Object? photoUrl = freezed,Object? mode = freezed,Object? category = freezed,}) {
  return _then(_ShopSummaryDto(
shopId: freezed == shopId ? _self.shopId : shopId ,name: freezed == name ? _self.name : name ,address: freezed == address ? _self.address : address ,city: freezed == city ? _self.city : city ,distanceM: freezed == distanceM ? _self.distanceM : distanceM ,openNow: freezed == openNow ? _self.openNow : openNow ,closesAt: freezed == closesAt ? _self.closesAt : closesAt ,opensAt: freezed == opensAt ? _self.opensAt : opensAt ,servicesCount: freezed == servicesCount ? _self.servicesCount : servicesCount ,fromPriceCents: freezed == fromPriceCents ? _self.fromPriceCents : fromPriceCents ,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl ,mode: freezed == mode ? _self.mode : mode ,category: freezed == category ? _self.category : category ,
  ));
}


}


/// @nodoc
mixin _$FreeSlotDto {

@JsonKey(name: 'shopId') Object? get shopId;@JsonKey(name: 'shopName') Object? get shopName;@JsonKey(name: 'serviceId') Object? get serviceId;@JsonKey(name: 'serviceName') Object? get serviceName;@JsonKey(name: 'durationMin') Object? get durationMin;@JsonKey(name: 'priceCents') Object? get priceCents;@JsonKey(name: 'startUtc') Object? get startUtc;
/// Create a copy of FreeSlotDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FreeSlotDtoCopyWith<FreeSlotDto> get copyWith => _$FreeSlotDtoCopyWithImpl<FreeSlotDto>(this as FreeSlotDto, _$identity);

  /// Serializes this FreeSlotDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeSlotDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.shopName, shopName)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.startUtc, startUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(shopName),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(startUtc));

@override
String toString() {
  return 'FreeSlotDto(shopId: $shopId, shopName: $shopName, serviceId: $serviceId, serviceName: $serviceName, durationMin: $durationMin, priceCents: $priceCents, startUtc: $startUtc)';
}


}

/// @nodoc
abstract mixin class $FreeSlotDtoCopyWith<$Res>  {
  factory $FreeSlotDtoCopyWith(FreeSlotDto value, $Res Function(FreeSlotDto) _then) = _$FreeSlotDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'shopName') Object? shopName,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'startUtc') Object? startUtc
});




}
/// @nodoc
class _$FreeSlotDtoCopyWithImpl<$Res>
    implements $FreeSlotDtoCopyWith<$Res> {
  _$FreeSlotDtoCopyWithImpl(this._self, this._then);

  final FreeSlotDto _self;
  final $Res Function(FreeSlotDto) _then;

/// Create a copy of FreeSlotDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = freezed,Object? shopName = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? durationMin = freezed,Object? priceCents = freezed,Object? startUtc = freezed,}) {
  return _then(_self.copyWith(
shopId: freezed == shopId ? _self.shopId : shopId ,shopName: freezed == shopName ? _self.shopName : shopName ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,startUtc: freezed == startUtc ? _self.startUtc : startUtc ,
  ));
}

}


/// Adds pattern-matching-related methods to [FreeSlotDto].
extension FreeSlotDtoPatterns on FreeSlotDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FreeSlotDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FreeSlotDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FreeSlotDto value)  $default,){
final _that = this;
switch (_that) {
case _FreeSlotDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FreeSlotDto value)?  $default,){
final _that = this;
switch (_that) {
case _FreeSlotDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'startUtc')  Object? startUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FreeSlotDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.serviceId,_that.serviceName,_that.durationMin,_that.priceCents,_that.startUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'startUtc')  Object? startUtc)  $default,) {final _that = this;
switch (_that) {
case _FreeSlotDto():
return $default(_that.shopId,_that.shopName,_that.serviceId,_that.serviceName,_that.durationMin,_that.priceCents,_that.startUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'startUtc')  Object? startUtc)?  $default,) {final _that = this;
switch (_that) {
case _FreeSlotDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.serviceId,_that.serviceName,_that.durationMin,_that.priceCents,_that.startUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FreeSlotDto extends FreeSlotDto {
  const _FreeSlotDto({@JsonKey(name: 'shopId') this.shopId, @JsonKey(name: 'shopName') this.shopName, @JsonKey(name: 'serviceId') this.serviceId, @JsonKey(name: 'serviceName') this.serviceName, @JsonKey(name: 'durationMin') this.durationMin, @JsonKey(name: 'priceCents') this.priceCents, @JsonKey(name: 'startUtc') this.startUtc}): super._();
  factory _FreeSlotDto.fromJson(Map<String, dynamic> json) => _$FreeSlotDtoFromJson(json);

@override@JsonKey(name: 'shopId') final  Object? shopId;
@override@JsonKey(name: 'shopName') final  Object? shopName;
@override@JsonKey(name: 'serviceId') final  Object? serviceId;
@override@JsonKey(name: 'serviceName') final  Object? serviceName;
@override@JsonKey(name: 'durationMin') final  Object? durationMin;
@override@JsonKey(name: 'priceCents') final  Object? priceCents;
@override@JsonKey(name: 'startUtc') final  Object? startUtc;

/// Create a copy of FreeSlotDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FreeSlotDtoCopyWith<_FreeSlotDto> get copyWith => __$FreeSlotDtoCopyWithImpl<_FreeSlotDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FreeSlotDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FreeSlotDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.shopName, shopName)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.startUtc, startUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(shopName),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(startUtc));

@override
String toString() {
  return 'FreeSlotDto(shopId: $shopId, shopName: $shopName, serviceId: $serviceId, serviceName: $serviceName, durationMin: $durationMin, priceCents: $priceCents, startUtc: $startUtc)';
}


}

/// @nodoc
abstract mixin class _$FreeSlotDtoCopyWith<$Res> implements $FreeSlotDtoCopyWith<$Res> {
  factory _$FreeSlotDtoCopyWith(_FreeSlotDto value, $Res Function(_FreeSlotDto) _then) = __$FreeSlotDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'shopName') Object? shopName,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'startUtc') Object? startUtc
});




}
/// @nodoc
class __$FreeSlotDtoCopyWithImpl<$Res>
    implements _$FreeSlotDtoCopyWith<$Res> {
  __$FreeSlotDtoCopyWithImpl(this._self, this._then);

  final _FreeSlotDto _self;
  final $Res Function(_FreeSlotDto) _then;

/// Create a copy of FreeSlotDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = freezed,Object? shopName = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? durationMin = freezed,Object? priceCents = freezed,Object? startUtc = freezed,}) {
  return _then(_FreeSlotDto(
shopId: freezed == shopId ? _self.shopId : shopId ,shopName: freezed == shopName ? _self.shopName : shopName ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,startUtc: freezed == startUtc ? _self.startUtc : startUtc ,
  ));
}


}

// dart format on

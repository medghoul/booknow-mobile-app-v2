// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopSummary {

 String get id; String? get name; String? get addressLine; String? get city;/// Null when the customer declined the location prompt, in which case the
/// list is ordered by name instead.
 int? get distanceMeters; bool get openNow;/// Wall-clock time in the shop's own zone, while it is open.
 String? get closesAt;/// When it opens next, while it is shut.
 String? get opensAt; int get activeServices; int? get fromPriceCents; String? get photoUrl;/// Whether the card says "Su appuntamento" or "Senza appuntamento".
 ShopMode get mode;/// The business category, once the API sends one (roadmap step 4). Null
/// until then, and a null shop stays visible in every category.
 String? get category;
/// Create a copy of ShopSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSummaryCopyWith<ShopSummary> get copyWith => _$ShopSummaryCopyWithImpl<ShopSummary>(this as ShopSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.city, city) || other.city == city)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.openNow, openNow) || other.openNow == openNow)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.activeServices, activeServices) || other.activeServices == activeServices)&&(identical(other.fromPriceCents, fromPriceCents) || other.fromPriceCents == fromPriceCents)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,addressLine,city,distanceMeters,openNow,closesAt,opensAt,activeServices,fromPriceCents,photoUrl,mode,category);

@override
String toString() {
  return 'ShopSummary(id: $id, name: $name, addressLine: $addressLine, city: $city, distanceMeters: $distanceMeters, openNow: $openNow, closesAt: $closesAt, opensAt: $opensAt, activeServices: $activeServices, fromPriceCents: $fromPriceCents, photoUrl: $photoUrl, mode: $mode, category: $category)';
}


}

/// @nodoc
abstract mixin class $ShopSummaryCopyWith<$Res>  {
  factory $ShopSummaryCopyWith(ShopSummary value, $Res Function(ShopSummary) _then) = _$ShopSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? addressLine, String? city, int? distanceMeters, bool openNow, String? closesAt, String? opensAt, int activeServices, int? fromPriceCents, String? photoUrl, ShopMode mode, String? category
});




}
/// @nodoc
class _$ShopSummaryCopyWithImpl<$Res>
    implements $ShopSummaryCopyWith<$Res> {
  _$ShopSummaryCopyWithImpl(this._self, this._then);

  final ShopSummary _self;
  final $Res Function(ShopSummary) _then;

/// Create a copy of ShopSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? addressLine = freezed,Object? city = freezed,Object? distanceMeters = freezed,Object? openNow = null,Object? closesAt = freezed,Object? opensAt = freezed,Object? activeServices = null,Object? fromPriceCents = freezed,Object? photoUrl = freezed,Object? mode = null,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,addressLine: freezed == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,openNow: null == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String?,activeServices: null == activeServices ? _self.activeServices : activeServices // ignore: cast_nullable_to_non_nullable
as int,fromPriceCents: freezed == fromPriceCents ? _self.fromPriceCents : fromPriceCents // ignore: cast_nullable_to_non_nullable
as int?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ShopMode,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopSummary].
extension ShopSummaryPatterns on ShopSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopSummary value)  $default,){
final _that = this;
switch (_that) {
case _ShopSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ShopSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? addressLine,  String? city,  int? distanceMeters,  bool openNow,  String? closesAt,  String? opensAt,  int activeServices,  int? fromPriceCents,  String? photoUrl,  ShopMode mode,  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopSummary() when $default != null:
return $default(_that.id,_that.name,_that.addressLine,_that.city,_that.distanceMeters,_that.openNow,_that.closesAt,_that.opensAt,_that.activeServices,_that.fromPriceCents,_that.photoUrl,_that.mode,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? addressLine,  String? city,  int? distanceMeters,  bool openNow,  String? closesAt,  String? opensAt,  int activeServices,  int? fromPriceCents,  String? photoUrl,  ShopMode mode,  String? category)  $default,) {final _that = this;
switch (_that) {
case _ShopSummary():
return $default(_that.id,_that.name,_that.addressLine,_that.city,_that.distanceMeters,_that.openNow,_that.closesAt,_that.opensAt,_that.activeServices,_that.fromPriceCents,_that.photoUrl,_that.mode,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? addressLine,  String? city,  int? distanceMeters,  bool openNow,  String? closesAt,  String? opensAt,  int activeServices,  int? fromPriceCents,  String? photoUrl,  ShopMode mode,  String? category)?  $default,) {final _that = this;
switch (_that) {
case _ShopSummary() when $default != null:
return $default(_that.id,_that.name,_that.addressLine,_that.city,_that.distanceMeters,_that.openNow,_that.closesAt,_that.opensAt,_that.activeServices,_that.fromPriceCents,_that.photoUrl,_that.mode,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _ShopSummary implements ShopSummary {
  const _ShopSummary({required this.id, required this.name, required this.addressLine, required this.city, required this.distanceMeters, required this.openNow, required this.closesAt, required this.opensAt, required this.activeServices, required this.fromPriceCents, required this.photoUrl, this.mode = ShopMode.booking, this.category});
  

@override final  String id;
@override final  String? name;
@override final  String? addressLine;
@override final  String? city;
/// Null when the customer declined the location prompt, in which case the
/// list is ordered by name instead.
@override final  int? distanceMeters;
@override final  bool openNow;
/// Wall-clock time in the shop's own zone, while it is open.
@override final  String? closesAt;
/// When it opens next, while it is shut.
@override final  String? opensAt;
@override final  int activeServices;
@override final  int? fromPriceCents;
@override final  String? photoUrl;
/// Whether the card says "Su appuntamento" or "Senza appuntamento".
@override@JsonKey() final  ShopMode mode;
/// The business category, once the API sends one (roadmap step 4). Null
/// until then, and a null shop stays visible in every category.
@override final  String? category;

/// Create a copy of ShopSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopSummaryCopyWith<_ShopSummary> get copyWith => __$ShopSummaryCopyWithImpl<_ShopSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.city, city) || other.city == city)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.openNow, openNow) || other.openNow == openNow)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.activeServices, activeServices) || other.activeServices == activeServices)&&(identical(other.fromPriceCents, fromPriceCents) || other.fromPriceCents == fromPriceCents)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,addressLine,city,distanceMeters,openNow,closesAt,opensAt,activeServices,fromPriceCents,photoUrl,mode,category);

@override
String toString() {
  return 'ShopSummary(id: $id, name: $name, addressLine: $addressLine, city: $city, distanceMeters: $distanceMeters, openNow: $openNow, closesAt: $closesAt, opensAt: $opensAt, activeServices: $activeServices, fromPriceCents: $fromPriceCents, photoUrl: $photoUrl, mode: $mode, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ShopSummaryCopyWith<$Res> implements $ShopSummaryCopyWith<$Res> {
  factory _$ShopSummaryCopyWith(_ShopSummary value, $Res Function(_ShopSummary) _then) = __$ShopSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? addressLine, String? city, int? distanceMeters, bool openNow, String? closesAt, String? opensAt, int activeServices, int? fromPriceCents, String? photoUrl, ShopMode mode, String? category
});




}
/// @nodoc
class __$ShopSummaryCopyWithImpl<$Res>
    implements _$ShopSummaryCopyWith<$Res> {
  __$ShopSummaryCopyWithImpl(this._self, this._then);

  final _ShopSummary _self;
  final $Res Function(_ShopSummary) _then;

/// Create a copy of ShopSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? addressLine = freezed,Object? city = freezed,Object? distanceMeters = freezed,Object? openNow = null,Object? closesAt = freezed,Object? opensAt = freezed,Object? activeServices = null,Object? fromPriceCents = freezed,Object? photoUrl = freezed,Object? mode = null,Object? category = freezed,}) {
  return _then(_ShopSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,addressLine: freezed == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,openNow: null == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String?,activeServices: null == activeServices ? _self.activeServices : activeServices // ignore: cast_nullable_to_non_nullable
as int,fromPriceCents: freezed == fromPriceCents ? _self.fromPriceCents : fromPriceCents // ignore: cast_nullable_to_non_nullable
as int?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ShopMode,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

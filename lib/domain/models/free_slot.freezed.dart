// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'free_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FreeSlot {

 String get shopId; String? get shopName; String get serviceId; String get serviceName; int get durationMinutes; int get priceCents; DateTime get startUtc;
/// Create a copy of FreeSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FreeSlotCopyWith<FreeSlot> get copyWith => _$FreeSlotCopyWithImpl<FreeSlot>(this as FreeSlot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeSlot&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,serviceId,serviceName,durationMinutes,priceCents,startUtc);

@override
String toString() {
  return 'FreeSlot(shopId: $shopId, shopName: $shopName, serviceId: $serviceId, serviceName: $serviceName, durationMinutes: $durationMinutes, priceCents: $priceCents, startUtc: $startUtc)';
}


}

/// @nodoc
abstract mixin class $FreeSlotCopyWith<$Res>  {
  factory $FreeSlotCopyWith(FreeSlot value, $Res Function(FreeSlot) _then) = _$FreeSlotCopyWithImpl;
@useResult
$Res call({
 String shopId, String? shopName, String serviceId, String serviceName, int durationMinutes, int priceCents, DateTime startUtc
});




}
/// @nodoc
class _$FreeSlotCopyWithImpl<$Res>
    implements $FreeSlotCopyWith<$Res> {
  _$FreeSlotCopyWithImpl(this._self, this._then);

  final FreeSlot _self;
  final $Res Function(FreeSlot) _then;

/// Create a copy of FreeSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? shopName = freezed,Object? serviceId = null,Object? serviceName = null,Object? durationMinutes = null,Object? priceCents = null,Object? startUtc = null,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FreeSlot].
extension FreeSlotPatterns on FreeSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FreeSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FreeSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FreeSlot value)  $default,){
final _that = this;
switch (_that) {
case _FreeSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FreeSlot value)?  $default,){
final _that = this;
switch (_that) {
case _FreeSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String? shopName,  String serviceId,  String serviceName,  int durationMinutes,  int priceCents,  DateTime startUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FreeSlot() when $default != null:
return $default(_that.shopId,_that.shopName,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.priceCents,_that.startUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String? shopName,  String serviceId,  String serviceName,  int durationMinutes,  int priceCents,  DateTime startUtc)  $default,) {final _that = this;
switch (_that) {
case _FreeSlot():
return $default(_that.shopId,_that.shopName,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.priceCents,_that.startUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String? shopName,  String serviceId,  String serviceName,  int durationMinutes,  int priceCents,  DateTime startUtc)?  $default,) {final _that = this;
switch (_that) {
case _FreeSlot() when $default != null:
return $default(_that.shopId,_that.shopName,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.priceCents,_that.startUtc);case _:
  return null;

}
}

}

/// @nodoc


class _FreeSlot implements FreeSlot {
  const _FreeSlot({required this.shopId, required this.shopName, required this.serviceId, required this.serviceName, required this.durationMinutes, required this.priceCents, required this.startUtc});
  

@override final  String shopId;
@override final  String? shopName;
@override final  String serviceId;
@override final  String serviceName;
@override final  int durationMinutes;
@override final  int priceCents;
@override final  DateTime startUtc;

/// Create a copy of FreeSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FreeSlotCopyWith<_FreeSlot> get copyWith => __$FreeSlotCopyWithImpl<_FreeSlot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FreeSlot&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,serviceId,serviceName,durationMinutes,priceCents,startUtc);

@override
String toString() {
  return 'FreeSlot(shopId: $shopId, shopName: $shopName, serviceId: $serviceId, serviceName: $serviceName, durationMinutes: $durationMinutes, priceCents: $priceCents, startUtc: $startUtc)';
}


}

/// @nodoc
abstract mixin class _$FreeSlotCopyWith<$Res> implements $FreeSlotCopyWith<$Res> {
  factory _$FreeSlotCopyWith(_FreeSlot value, $Res Function(_FreeSlot) _then) = __$FreeSlotCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String? shopName, String serviceId, String serviceName, int durationMinutes, int priceCents, DateTime startUtc
});




}
/// @nodoc
class __$FreeSlotCopyWithImpl<$Res>
    implements _$FreeSlotCopyWith<$Res> {
  __$FreeSlotCopyWithImpl(this._self, this._then);

  final _FreeSlot _self;
  final $Res Function(_FreeSlot) _then;

/// Create a copy of FreeSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = freezed,Object? serviceId = null,Object? serviceName = null,Object? durationMinutes = null,Object? priceCents = null,Object? startUtc = null,}) {
  return _then(_FreeSlot(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

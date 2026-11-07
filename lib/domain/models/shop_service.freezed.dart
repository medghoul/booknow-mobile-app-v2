// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopService {

 String get id; String get name; int get durationMinutes; int get priceCents; bool get isActive; int get order;
/// Create a copy of ShopService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopServiceCopyWith<ShopService> get copyWith => _$ShopServiceCopyWithImpl<ShopService>(this as ShopService, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,durationMinutes,priceCents,isActive,order);

@override
String toString() {
  return 'ShopService(id: $id, name: $name, durationMinutes: $durationMinutes, priceCents: $priceCents, isActive: $isActive, order: $order)';
}


}

/// @nodoc
abstract mixin class $ShopServiceCopyWith<$Res>  {
  factory $ShopServiceCopyWith(ShopService value, $Res Function(ShopService) _then) = _$ShopServiceCopyWithImpl;
@useResult
$Res call({
 String id, String name, int durationMinutes, int priceCents, bool isActive, int order
});




}
/// @nodoc
class _$ShopServiceCopyWithImpl<$Res>
    implements $ShopServiceCopyWith<$Res> {
  _$ShopServiceCopyWithImpl(this._self, this._then);

  final ShopService _self;
  final $Res Function(ShopService) _then;

/// Create a copy of ShopService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? durationMinutes = null,Object? priceCents = null,Object? isActive = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopService].
extension ShopServicePatterns on ShopService {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopService() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopService value)  $default,){
final _that = this;
switch (_that) {
case _ShopService():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopService value)?  $default,){
final _that = this;
switch (_that) {
case _ShopService() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int durationMinutes,  int priceCents,  bool isActive,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopService() when $default != null:
return $default(_that.id,_that.name,_that.durationMinutes,_that.priceCents,_that.isActive,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int durationMinutes,  int priceCents,  bool isActive,  int order)  $default,) {final _that = this;
switch (_that) {
case _ShopService():
return $default(_that.id,_that.name,_that.durationMinutes,_that.priceCents,_that.isActive,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int durationMinutes,  int priceCents,  bool isActive,  int order)?  $default,) {final _that = this;
switch (_that) {
case _ShopService() when $default != null:
return $default(_that.id,_that.name,_that.durationMinutes,_that.priceCents,_that.isActive,_that.order);case _:
  return null;

}
}

}

/// @nodoc


class _ShopService extends ShopService {
  const _ShopService({required this.id, required this.name, required this.durationMinutes, required this.priceCents, this.isActive = true, this.order = 0}): super._();
  

@override final  String id;
@override final  String name;
@override final  int durationMinutes;
@override final  int priceCents;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int order;

/// Create a copy of ShopService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopServiceCopyWith<_ShopService> get copyWith => __$ShopServiceCopyWithImpl<_ShopService>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,durationMinutes,priceCents,isActive,order);

@override
String toString() {
  return 'ShopService(id: $id, name: $name, durationMinutes: $durationMinutes, priceCents: $priceCents, isActive: $isActive, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ShopServiceCopyWith<$Res> implements $ShopServiceCopyWith<$Res> {
  factory _$ShopServiceCopyWith(_ShopService value, $Res Function(_ShopService) _then) = __$ShopServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int durationMinutes, int priceCents, bool isActive, int order
});




}
/// @nodoc
class __$ShopServiceCopyWithImpl<$Res>
    implements _$ShopServiceCopyWith<$Res> {
  __$ShopServiceCopyWithImpl(this._self, this._then);

  final _ShopService _self;
  final $Res Function(_ShopService) _then;

/// Create a copy of ShopService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? durationMinutes = null,Object? priceCents = null,Object? isActive = null,Object? order = null,}) {
  return _then(_ShopService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

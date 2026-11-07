// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopProvider {

 String get id;/// Null only on the default provider of a draft shop with no name yet; the
/// server resolves it to the shop's name everywhere else.
 String? get name; ProviderType get type;/// Null means every active service, including ones added later.
 List<String>? get serviceIds;/// Null means the shop's hours. Never wider than them: the server reads
/// the two together.
 OpeningHours? get openingHours;/// Days off, as `YYYY-MM-DD` in the shop's zone.
 List<String> get timeOff; bool get isActive; int get order;
/// Create a copy of ShopProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopProviderCopyWith<ShopProvider> get copyWith => _$ShopProviderCopyWithImpl<ShopProvider>(this as ShopProvider, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.serviceIds, serviceIds)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&const DeepCollectionEquality().equals(other.timeOff, timeOff)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,const DeepCollectionEquality().hash(serviceIds),openingHours,const DeepCollectionEquality().hash(timeOff),isActive,order);

@override
String toString() {
  return 'ShopProvider(id: $id, name: $name, type: $type, serviceIds: $serviceIds, openingHours: $openingHours, timeOff: $timeOff, isActive: $isActive, order: $order)';
}


}

/// @nodoc
abstract mixin class $ShopProviderCopyWith<$Res>  {
  factory $ShopProviderCopyWith(ShopProvider value, $Res Function(ShopProvider) _then) = _$ShopProviderCopyWithImpl;
@useResult
$Res call({
 String id, String? name, ProviderType type, List<String>? serviceIds, OpeningHours? openingHours, List<String> timeOff, bool isActive, int order
});


$OpeningHoursCopyWith<$Res>? get openingHours;

}
/// @nodoc
class _$ShopProviderCopyWithImpl<$Res>
    implements $ShopProviderCopyWith<$Res> {
  _$ShopProviderCopyWithImpl(this._self, this._then);

  final ShopProvider _self;
  final $Res Function(ShopProvider) _then;

/// Create a copy of ShopProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? type = null,Object? serviceIds = freezed,Object? openingHours = freezed,Object? timeOff = null,Object? isActive = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProviderType,serviceIds: freezed == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as OpeningHours?,timeOff: null == timeOff ? _self.timeOff : timeOff // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ShopProvider
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursCopyWith<$Res>? get openingHours {
    if (_self.openingHours == null) {
    return null;
  }

  return $OpeningHoursCopyWith<$Res>(_self.openingHours!, (value) {
    return _then(_self.copyWith(openingHours: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShopProvider].
extension ShopProviderPatterns on ShopProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopProvider value)  $default,){
final _that = this;
switch (_that) {
case _ShopProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopProvider value)?  $default,){
final _that = this;
switch (_that) {
case _ShopProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  ProviderType type,  List<String>? serviceIds,  OpeningHours? openingHours,  List<String> timeOff,  bool isActive,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopProvider() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.serviceIds,_that.openingHours,_that.timeOff,_that.isActive,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  ProviderType type,  List<String>? serviceIds,  OpeningHours? openingHours,  List<String> timeOff,  bool isActive,  int order)  $default,) {final _that = this;
switch (_that) {
case _ShopProvider():
return $default(_that.id,_that.name,_that.type,_that.serviceIds,_that.openingHours,_that.timeOff,_that.isActive,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  ProviderType type,  List<String>? serviceIds,  OpeningHours? openingHours,  List<String> timeOff,  bool isActive,  int order)?  $default,) {final _that = this;
switch (_that) {
case _ShopProvider() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.serviceIds,_that.openingHours,_that.timeOff,_that.isActive,_that.order);case _:
  return null;

}
}

}

/// @nodoc


class _ShopProvider extends ShopProvider {
  const _ShopProvider({required this.id, this.name, this.type = ProviderType.person, final  List<String>? serviceIds, this.openingHours, final  List<String> timeOff = const <String>[], this.isActive = true, this.order = 0}): _serviceIds = serviceIds,_timeOff = timeOff,super._();
  

@override final  String id;
/// Null only on the default provider of a draft shop with no name yet; the
/// server resolves it to the shop's name everywhere else.
@override final  String? name;
@override@JsonKey() final  ProviderType type;
/// Null means every active service, including ones added later.
 final  List<String>? _serviceIds;
/// Null means every active service, including ones added later.
@override List<String>? get serviceIds {
  final value = _serviceIds;
  if (value == null) return null;
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Null means the shop's hours. Never wider than them: the server reads
/// the two together.
@override final  OpeningHours? openingHours;
/// Days off, as `YYYY-MM-DD` in the shop's zone.
 final  List<String> _timeOff;
/// Days off, as `YYYY-MM-DD` in the shop's zone.
@override@JsonKey() List<String> get timeOff {
  if (_timeOff is EqualUnmodifiableListView) return _timeOff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeOff);
}

@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int order;

/// Create a copy of ShopProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopProviderCopyWith<_ShopProvider> get copyWith => __$ShopProviderCopyWithImpl<_ShopProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._serviceIds, _serviceIds)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&const DeepCollectionEquality().equals(other._timeOff, _timeOff)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,const DeepCollectionEquality().hash(_serviceIds),openingHours,const DeepCollectionEquality().hash(_timeOff),isActive,order);

@override
String toString() {
  return 'ShopProvider(id: $id, name: $name, type: $type, serviceIds: $serviceIds, openingHours: $openingHours, timeOff: $timeOff, isActive: $isActive, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ShopProviderCopyWith<$Res> implements $ShopProviderCopyWith<$Res> {
  factory _$ShopProviderCopyWith(_ShopProvider value, $Res Function(_ShopProvider) _then) = __$ShopProviderCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, ProviderType type, List<String>? serviceIds, OpeningHours? openingHours, List<String> timeOff, bool isActive, int order
});


@override $OpeningHoursCopyWith<$Res>? get openingHours;

}
/// @nodoc
class __$ShopProviderCopyWithImpl<$Res>
    implements _$ShopProviderCopyWith<$Res> {
  __$ShopProviderCopyWithImpl(this._self, this._then);

  final _ShopProvider _self;
  final $Res Function(_ShopProvider) _then;

/// Create a copy of ShopProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? type = null,Object? serviceIds = freezed,Object? openingHours = freezed,Object? timeOff = null,Object? isActive = null,Object? order = null,}) {
  return _then(_ShopProvider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProviderType,serviceIds: freezed == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as OpeningHours?,timeOff: null == timeOff ? _self._timeOff : timeOff // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ShopProvider
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpeningHoursCopyWith<$Res>? get openingHours {
    if (_self.openingHours == null) {
    return null;
  }

  return $OpeningHoursCopyWith<$Res>(_self.openingHours!, (value) {
    return _then(_self.copyWith(openingHours: value));
  });
}
}

// dart format on

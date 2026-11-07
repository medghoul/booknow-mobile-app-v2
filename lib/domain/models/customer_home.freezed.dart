// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_home.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerHome {

 Booking? get nextBooking; List<FreeSlot> get freeToday;/// How many free times there are in all, for the "+8 more times" card.
 int get freeTodayTotal; List<ShopSummary> get shops;
/// Create a copy of CustomerHome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerHomeCopyWith<CustomerHome> get copyWith => _$CustomerHomeCopyWithImpl<CustomerHome>(this as CustomerHome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerHome&&(identical(other.nextBooking, nextBooking) || other.nextBooking == nextBooking)&&const DeepCollectionEquality().equals(other.freeToday, freeToday)&&(identical(other.freeTodayTotal, freeTodayTotal) || other.freeTodayTotal == freeTodayTotal)&&const DeepCollectionEquality().equals(other.shops, shops));
}


@override
int get hashCode => Object.hash(runtimeType,nextBooking,const DeepCollectionEquality().hash(freeToday),freeTodayTotal,const DeepCollectionEquality().hash(shops));

@override
String toString() {
  return 'CustomerHome(nextBooking: $nextBooking, freeToday: $freeToday, freeTodayTotal: $freeTodayTotal, shops: $shops)';
}


}

/// @nodoc
abstract mixin class $CustomerHomeCopyWith<$Res>  {
  factory $CustomerHomeCopyWith(CustomerHome value, $Res Function(CustomerHome) _then) = _$CustomerHomeCopyWithImpl;
@useResult
$Res call({
 Booking? nextBooking, List<FreeSlot> freeToday, int freeTodayTotal, List<ShopSummary> shops
});


$BookingCopyWith<$Res>? get nextBooking;

}
/// @nodoc
class _$CustomerHomeCopyWithImpl<$Res>
    implements $CustomerHomeCopyWith<$Res> {
  _$CustomerHomeCopyWithImpl(this._self, this._then);

  final CustomerHome _self;
  final $Res Function(CustomerHome) _then;

/// Create a copy of CustomerHome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextBooking = freezed,Object? freeToday = null,Object? freeTodayTotal = null,Object? shops = null,}) {
  return _then(_self.copyWith(
nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as Booking?,freeToday: null == freeToday ? _self.freeToday : freeToday // ignore: cast_nullable_to_non_nullable
as List<FreeSlot>,freeTodayTotal: null == freeTodayTotal ? _self.freeTodayTotal : freeTodayTotal // ignore: cast_nullable_to_non_nullable
as int,shops: null == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopSummary>,
  ));
}
/// Create a copy of CustomerHome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get nextBooking {
    if (_self.nextBooking == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.nextBooking!, (value) {
    return _then(_self.copyWith(nextBooking: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerHome].
extension CustomerHomePatterns on CustomerHome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerHome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerHome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerHome value)  $default,){
final _that = this;
switch (_that) {
case _CustomerHome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerHome value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerHome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Booking? nextBooking,  List<FreeSlot> freeToday,  int freeTodayTotal,  List<ShopSummary> shops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerHome() when $default != null:
return $default(_that.nextBooking,_that.freeToday,_that.freeTodayTotal,_that.shops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Booking? nextBooking,  List<FreeSlot> freeToday,  int freeTodayTotal,  List<ShopSummary> shops)  $default,) {final _that = this;
switch (_that) {
case _CustomerHome():
return $default(_that.nextBooking,_that.freeToday,_that.freeTodayTotal,_that.shops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Booking? nextBooking,  List<FreeSlot> freeToday,  int freeTodayTotal,  List<ShopSummary> shops)?  $default,) {final _that = this;
switch (_that) {
case _CustomerHome() when $default != null:
return $default(_that.nextBooking,_that.freeToday,_that.freeTodayTotal,_that.shops);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerHome extends CustomerHome {
  const _CustomerHome({required this.nextBooking, required final  List<FreeSlot> freeToday, required this.freeTodayTotal, required final  List<ShopSummary> shops}): _freeToday = freeToday,_shops = shops,super._();
  

@override final  Booking? nextBooking;
 final  List<FreeSlot> _freeToday;
@override List<FreeSlot> get freeToday {
  if (_freeToday is EqualUnmodifiableListView) return _freeToday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_freeToday);
}

/// How many free times there are in all, for the "+8 more times" card.
@override final  int freeTodayTotal;
 final  List<ShopSummary> _shops;
@override List<ShopSummary> get shops {
  if (_shops is EqualUnmodifiableListView) return _shops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shops);
}


/// Create a copy of CustomerHome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerHomeCopyWith<_CustomerHome> get copyWith => __$CustomerHomeCopyWithImpl<_CustomerHome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerHome&&(identical(other.nextBooking, nextBooking) || other.nextBooking == nextBooking)&&const DeepCollectionEquality().equals(other._freeToday, _freeToday)&&(identical(other.freeTodayTotal, freeTodayTotal) || other.freeTodayTotal == freeTodayTotal)&&const DeepCollectionEquality().equals(other._shops, _shops));
}


@override
int get hashCode => Object.hash(runtimeType,nextBooking,const DeepCollectionEquality().hash(_freeToday),freeTodayTotal,const DeepCollectionEquality().hash(_shops));

@override
String toString() {
  return 'CustomerHome(nextBooking: $nextBooking, freeToday: $freeToday, freeTodayTotal: $freeTodayTotal, shops: $shops)';
}


}

/// @nodoc
abstract mixin class _$CustomerHomeCopyWith<$Res> implements $CustomerHomeCopyWith<$Res> {
  factory _$CustomerHomeCopyWith(_CustomerHome value, $Res Function(_CustomerHome) _then) = __$CustomerHomeCopyWithImpl;
@override @useResult
$Res call({
 Booking? nextBooking, List<FreeSlot> freeToday, int freeTodayTotal, List<ShopSummary> shops
});


@override $BookingCopyWith<$Res>? get nextBooking;

}
/// @nodoc
class __$CustomerHomeCopyWithImpl<$Res>
    implements _$CustomerHomeCopyWith<$Res> {
  __$CustomerHomeCopyWithImpl(this._self, this._then);

  final _CustomerHome _self;
  final $Res Function(_CustomerHome) _then;

/// Create a copy of CustomerHome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextBooking = freezed,Object? freeToday = null,Object? freeTodayTotal = null,Object? shops = null,}) {
  return _then(_CustomerHome(
nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as Booking?,freeToday: null == freeToday ? _self._freeToday : freeToday // ignore: cast_nullable_to_non_nullable
as List<FreeSlot>,freeTodayTotal: null == freeTodayTotal ? _self.freeTodayTotal : freeTodayTotal // ignore: cast_nullable_to_non_nullable
as int,shops: null == shops ? _self._shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopSummary>,
  ));
}

/// Create a copy of CustomerHome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get nextBooking {
    if (_self.nextBooking == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.nextBooking!, (value) {
    return _then(_self.copyWith(nextBooking: value));
  });
}
}

// dart format on

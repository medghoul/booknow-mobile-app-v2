// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingFlowState {

 String get shopId; String get date; BookingStep get step; Shop? get shop; ShopService? get service; Availability? get availability; DateTime? get start; BookingHold? get hold; Booking? get booking; bool get isLoading; bool get isBusy;/// The clock the hold countdown is drawn against.
 DateTime get now; NetworkException? get failure;
/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingFlowStateCopyWith<BookingFlowState> get copyWith => _$BookingFlowStateCopyWithImpl<BookingFlowState>(this as BookingFlowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingFlowState&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.date, date) || other.date == date)&&(identical(other.step, step) || other.step == step)&&(identical(other.shop, shop) || other.shop == shop)&&(identical(other.service, service) || other.service == service)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.start, start) || other.start == start)&&(identical(other.hold, hold) || other.hold == hold)&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,date,step,shop,service,availability,start,hold,booking,isLoading,isBusy,now,failure);

@override
String toString() {
  return 'BookingFlowState(shopId: $shopId, date: $date, step: $step, shop: $shop, service: $service, availability: $availability, start: $start, hold: $hold, booking: $booking, isLoading: $isLoading, isBusy: $isBusy, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BookingFlowStateCopyWith<$Res>  {
  factory $BookingFlowStateCopyWith(BookingFlowState value, $Res Function(BookingFlowState) _then) = _$BookingFlowStateCopyWithImpl;
@useResult
$Res call({
 String shopId, String date, BookingStep step, Shop? shop, ShopService? service, Availability? availability, DateTime? start, BookingHold? hold, Booking? booking, bool isLoading, bool isBusy, DateTime now, NetworkException? failure
});


$ShopCopyWith<$Res>? get shop;$ShopServiceCopyWith<$Res>? get service;$AvailabilityCopyWith<$Res>? get availability;$BookingHoldCopyWith<$Res>? get hold;$BookingCopyWith<$Res>? get booking;

}
/// @nodoc
class _$BookingFlowStateCopyWithImpl<$Res>
    implements $BookingFlowStateCopyWith<$Res> {
  _$BookingFlowStateCopyWithImpl(this._self, this._then);

  final BookingFlowState _self;
  final $Res Function(BookingFlowState) _then;

/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? date = null,Object? step = null,Object? shop = freezed,Object? service = freezed,Object? availability = freezed,Object? start = freezed,Object? hold = freezed,Object? booking = freezed,Object? isLoading = null,Object? isBusy = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BookingStep,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ShopService?,availability: freezed == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as Availability?,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,hold: freezed == hold ? _self.hold : hold // ignore: cast_nullable_to_non_nullable
as BookingHold?,booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of BookingFlowState
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
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopServiceCopyWith<$Res>? get service {
    if (_self.service == null) {
    return null;
  }

  return $ShopServiceCopyWith<$Res>(_self.service!, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilityCopyWith<$Res>? get availability {
    if (_self.availability == null) {
    return null;
  }

  return $AvailabilityCopyWith<$Res>(_self.availability!, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingHoldCopyWith<$Res>? get hold {
    if (_self.hold == null) {
    return null;
  }

  return $BookingHoldCopyWith<$Res>(_self.hold!, (value) {
    return _then(_self.copyWith(hold: value));
  });
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingFlowState].
extension BookingFlowStatePatterns on BookingFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingFlowState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingFlowState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingFlowState value)  $default,){
final _that = this;
switch (_that) {
case _BookingFlowState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingFlowState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingFlowState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String date,  BookingStep step,  Shop? shop,  ShopService? service,  Availability? availability,  DateTime? start,  BookingHold? hold,  Booking? booking,  bool isLoading,  bool isBusy,  DateTime now,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingFlowState() when $default != null:
return $default(_that.shopId,_that.date,_that.step,_that.shop,_that.service,_that.availability,_that.start,_that.hold,_that.booking,_that.isLoading,_that.isBusy,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String date,  BookingStep step,  Shop? shop,  ShopService? service,  Availability? availability,  DateTime? start,  BookingHold? hold,  Booking? booking,  bool isLoading,  bool isBusy,  DateTime now,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _BookingFlowState():
return $default(_that.shopId,_that.date,_that.step,_that.shop,_that.service,_that.availability,_that.start,_that.hold,_that.booking,_that.isLoading,_that.isBusy,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String date,  BookingStep step,  Shop? shop,  ShopService? service,  Availability? availability,  DateTime? start,  BookingHold? hold,  Booking? booking,  bool isLoading,  bool isBusy,  DateTime now,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _BookingFlowState() when $default != null:
return $default(_that.shopId,_that.date,_that.step,_that.shop,_that.service,_that.availability,_that.start,_that.hold,_that.booking,_that.isLoading,_that.isBusy,_that.now,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _BookingFlowState extends BookingFlowState {
  const _BookingFlowState({required this.shopId, required this.date, this.step = BookingStep.slot, this.shop, this.service, this.availability, this.start, this.hold, this.booking, this.isLoading = true, this.isBusy = false, required this.now, this.failure}): super._();
  

@override final  String shopId;
@override final  String date;
@override@JsonKey() final  BookingStep step;
@override final  Shop? shop;
@override final  ShopService? service;
@override final  Availability? availability;
@override final  DateTime? start;
@override final  BookingHold? hold;
@override final  Booking? booking;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isBusy;
/// The clock the hold countdown is drawn against.
@override final  DateTime now;
@override final  NetworkException? failure;

/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingFlowStateCopyWith<_BookingFlowState> get copyWith => __$BookingFlowStateCopyWithImpl<_BookingFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingFlowState&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.date, date) || other.date == date)&&(identical(other.step, step) || other.step == step)&&(identical(other.shop, shop) || other.shop == shop)&&(identical(other.service, service) || other.service == service)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.start, start) || other.start == start)&&(identical(other.hold, hold) || other.hold == hold)&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,date,step,shop,service,availability,start,hold,booking,isLoading,isBusy,now,failure);

@override
String toString() {
  return 'BookingFlowState(shopId: $shopId, date: $date, step: $step, shop: $shop, service: $service, availability: $availability, start: $start, hold: $hold, booking: $booking, isLoading: $isLoading, isBusy: $isBusy, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$BookingFlowStateCopyWith<$Res> implements $BookingFlowStateCopyWith<$Res> {
  factory _$BookingFlowStateCopyWith(_BookingFlowState value, $Res Function(_BookingFlowState) _then) = __$BookingFlowStateCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String date, BookingStep step, Shop? shop, ShopService? service, Availability? availability, DateTime? start, BookingHold? hold, Booking? booking, bool isLoading, bool isBusy, DateTime now, NetworkException? failure
});


@override $ShopCopyWith<$Res>? get shop;@override $ShopServiceCopyWith<$Res>? get service;@override $AvailabilityCopyWith<$Res>? get availability;@override $BookingHoldCopyWith<$Res>? get hold;@override $BookingCopyWith<$Res>? get booking;

}
/// @nodoc
class __$BookingFlowStateCopyWithImpl<$Res>
    implements _$BookingFlowStateCopyWith<$Res> {
  __$BookingFlowStateCopyWithImpl(this._self, this._then);

  final _BookingFlowState _self;
  final $Res Function(_BookingFlowState) _then;

/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? date = null,Object? step = null,Object? shop = freezed,Object? service = freezed,Object? availability = freezed,Object? start = freezed,Object? hold = freezed,Object? booking = freezed,Object? isLoading = null,Object? isBusy = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_BookingFlowState(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BookingStep,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ShopService?,availability: freezed == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as Availability?,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,hold: freezed == hold ? _self.hold : hold // ignore: cast_nullable_to_non_nullable
as BookingHold?,booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of BookingFlowState
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
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopServiceCopyWith<$Res>? get service {
    if (_self.service == null) {
    return null;
  }

  return $ShopServiceCopyWith<$Res>(_self.service!, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilityCopyWith<$Res>? get availability {
    if (_self.availability == null) {
    return null;
  }

  return $AvailabilityCopyWith<$Res>(_self.availability!, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingHoldCopyWith<$Res>? get hold {
    if (_self.hold == null) {
    return null;
  }

  return $BookingHoldCopyWith<$Res>(_self.hold!, (value) {
    return _then(_self.copyWith(hold: value));
  });
}/// Create a copy of BookingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $BookingCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on

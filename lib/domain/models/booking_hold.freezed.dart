// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_hold.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingHold {

 Booking get booking; String get clientSecret; DateTime get holdExpiresAt; int get feeCents;
/// Create a copy of BookingHold
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingHoldCopyWith<BookingHold> get copyWith => _$BookingHoldCopyWithImpl<BookingHold>(this as BookingHold, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingHold&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents));
}


@override
int get hashCode => Object.hash(runtimeType,booking,clientSecret,holdExpiresAt,feeCents);

@override
String toString() {
  return 'BookingHold(booking: $booking, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeCents: $feeCents)';
}


}

/// @nodoc
abstract mixin class $BookingHoldCopyWith<$Res>  {
  factory $BookingHoldCopyWith(BookingHold value, $Res Function(BookingHold) _then) = _$BookingHoldCopyWithImpl;
@useResult
$Res call({
 Booking booking, String clientSecret, DateTime holdExpiresAt, int feeCents
});


$BookingCopyWith<$Res> get booking;

}
/// @nodoc
class _$BookingHoldCopyWithImpl<$Res>
    implements $BookingHoldCopyWith<$Res> {
  _$BookingHoldCopyWithImpl(this._self, this._then);

  final BookingHold _self;
  final $Res Function(BookingHold) _then;

/// Create a copy of BookingHold
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = null,Object? clientSecret = null,Object? holdExpiresAt = null,Object? feeCents = null,}) {
  return _then(_self.copyWith(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,holdExpiresAt: null == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of BookingHold
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res> get booking {
  
  return $BookingCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingHold].
extension BookingHoldPatterns on BookingHold {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingHold value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingHold() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingHold value)  $default,){
final _that = this;
switch (_that) {
case _BookingHold():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingHold value)?  $default,){
final _that = this;
switch (_that) {
case _BookingHold() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Booking booking,  String clientSecret,  DateTime holdExpiresAt,  int feeCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingHold() when $default != null:
return $default(_that.booking,_that.clientSecret,_that.holdExpiresAt,_that.feeCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Booking booking,  String clientSecret,  DateTime holdExpiresAt,  int feeCents)  $default,) {final _that = this;
switch (_that) {
case _BookingHold():
return $default(_that.booking,_that.clientSecret,_that.holdExpiresAt,_that.feeCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Booking booking,  String clientSecret,  DateTime holdExpiresAt,  int feeCents)?  $default,) {final _that = this;
switch (_that) {
case _BookingHold() when $default != null:
return $default(_that.booking,_that.clientSecret,_that.holdExpiresAt,_that.feeCents);case _:
  return null;

}
}

}

/// @nodoc


class _BookingHold implements BookingHold {
  const _BookingHold({required this.booking, required this.clientSecret, required this.holdExpiresAt, required this.feeCents});
  

@override final  Booking booking;
@override final  String clientSecret;
@override final  DateTime holdExpiresAt;
@override final  int feeCents;

/// Create a copy of BookingHold
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingHoldCopyWith<_BookingHold> get copyWith => __$BookingHoldCopyWithImpl<_BookingHold>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingHold&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents));
}


@override
int get hashCode => Object.hash(runtimeType,booking,clientSecret,holdExpiresAt,feeCents);

@override
String toString() {
  return 'BookingHold(booking: $booking, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeCents: $feeCents)';
}


}

/// @nodoc
abstract mixin class _$BookingHoldCopyWith<$Res> implements $BookingHoldCopyWith<$Res> {
  factory _$BookingHoldCopyWith(_BookingHold value, $Res Function(_BookingHold) _then) = __$BookingHoldCopyWithImpl;
@override @useResult
$Res call({
 Booking booking, String clientSecret, DateTime holdExpiresAt, int feeCents
});


@override $BookingCopyWith<$Res> get booking;

}
/// @nodoc
class __$BookingHoldCopyWithImpl<$Res>
    implements _$BookingHoldCopyWith<$Res> {
  __$BookingHoldCopyWithImpl(this._self, this._then);

  final _BookingHold _self;
  final $Res Function(_BookingHold) _then;

/// Create a copy of BookingHold
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? clientSecret = null,Object? holdExpiresAt = null,Object? feeCents = null,}) {
  return _then(_BookingHold(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,holdExpiresAt: null == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of BookingHold
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res> get booking {
  
  return $BookingCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on

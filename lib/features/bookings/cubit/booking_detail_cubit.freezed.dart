// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDetailState {

 Booking? get booking; bool get isLoading; bool get isCancelling; NetworkException? get failure;
/// Create a copy of BookingDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailStateCopyWith<BookingDetailState> get copyWith => _$BookingDetailStateCopyWithImpl<BookingDetailState>(this as BookingDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailState&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,booking,isLoading,isCancelling,failure);

@override
String toString() {
  return 'BookingDetailState(booking: $booking, isLoading: $isLoading, isCancelling: $isCancelling, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BookingDetailStateCopyWith<$Res>  {
  factory $BookingDetailStateCopyWith(BookingDetailState value, $Res Function(BookingDetailState) _then) = _$BookingDetailStateCopyWithImpl;
@useResult
$Res call({
 Booking? booking, bool isLoading, bool isCancelling, NetworkException? failure
});


$BookingCopyWith<$Res>? get booking;

}
/// @nodoc
class _$BookingDetailStateCopyWithImpl<$Res>
    implements $BookingDetailStateCopyWith<$Res> {
  _$BookingDetailStateCopyWithImpl(this._self, this._then);

  final BookingDetailState _self;
  final $Res Function(BookingDetailState) _then;

/// Create a copy of BookingDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = freezed,Object? isLoading = null,Object? isCancelling = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of BookingDetailState
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


/// Adds pattern-matching-related methods to [BookingDetailState].
extension BookingDetailStatePatterns on BookingDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailState value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Booking? booking,  bool isLoading,  bool isCancelling,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailState() when $default != null:
return $default(_that.booking,_that.isLoading,_that.isCancelling,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Booking? booking,  bool isLoading,  bool isCancelling,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailState():
return $default(_that.booking,_that.isLoading,_that.isCancelling,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Booking? booking,  bool isLoading,  bool isCancelling,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailState() when $default != null:
return $default(_that.booking,_that.isLoading,_that.isCancelling,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _BookingDetailState implements BookingDetailState {
  const _BookingDetailState({this.booking, this.isLoading = false, this.isCancelling = false, this.failure});
  

@override final  Booking? booking;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isCancelling;
@override final  NetworkException? failure;

/// Create a copy of BookingDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailStateCopyWith<_BookingDetailState> get copyWith => __$BookingDetailStateCopyWithImpl<_BookingDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailState&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,booking,isLoading,isCancelling,failure);

@override
String toString() {
  return 'BookingDetailState(booking: $booking, isLoading: $isLoading, isCancelling: $isCancelling, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailStateCopyWith<$Res> implements $BookingDetailStateCopyWith<$Res> {
  factory _$BookingDetailStateCopyWith(_BookingDetailState value, $Res Function(_BookingDetailState) _then) = __$BookingDetailStateCopyWithImpl;
@override @useResult
$Res call({
 Booking? booking, bool isLoading, bool isCancelling, NetworkException? failure
});


@override $BookingCopyWith<$Res>? get booking;

}
/// @nodoc
class __$BookingDetailStateCopyWithImpl<$Res>
    implements _$BookingDetailStateCopyWith<$Res> {
  __$BookingDetailStateCopyWithImpl(this._self, this._then);

  final _BookingDetailState _self;
  final $Res Function(_BookingDetailState) _then;

/// Create a copy of BookingDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = freezed,Object? isLoading = null,Object? isCancelling = null,Object? failure = freezed,}) {
  return _then(_BookingDetailState(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of BookingDetailState
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

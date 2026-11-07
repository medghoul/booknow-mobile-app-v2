// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingsState {

 BookingScope get scope; List<Booking> get upcoming; List<Booking> get past; bool get isLoading;/// Set while a cancellation is in flight, so the sheet's button can wait
/// rather than letting a second tap start a second cancel.
 bool get isCancelling;/// The clock the list is drawn against — whether a hold has run out, and
/// whether free cancellation is still open, both move on their own.
 DateTime get now; NetworkException? get failure;
/// Create a copy of BookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingsStateCopyWith<BookingsState> get copyWith => _$BookingsStateCopyWithImpl<BookingsState>(this as BookingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingsState&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other.upcoming, upcoming)&&const DeepCollectionEquality().equals(other.past, past)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,scope,const DeepCollectionEquality().hash(upcoming),const DeepCollectionEquality().hash(past),isLoading,isCancelling,now,failure);

@override
String toString() {
  return 'BookingsState(scope: $scope, upcoming: $upcoming, past: $past, isLoading: $isLoading, isCancelling: $isCancelling, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BookingsStateCopyWith<$Res>  {
  factory $BookingsStateCopyWith(BookingsState value, $Res Function(BookingsState) _then) = _$BookingsStateCopyWithImpl;
@useResult
$Res call({
 BookingScope scope, List<Booking> upcoming, List<Booking> past, bool isLoading, bool isCancelling, DateTime now, NetworkException? failure
});




}
/// @nodoc
class _$BookingsStateCopyWithImpl<$Res>
    implements $BookingsStateCopyWith<$Res> {
  _$BookingsStateCopyWithImpl(this._self, this._then);

  final BookingsState _self;
  final $Res Function(BookingsState) _then;

/// Create a copy of BookingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scope = null,Object? upcoming = null,Object? past = null,Object? isLoading = null,Object? isCancelling = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as BookingScope,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Booking>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as List<Booking>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingsState].
extension BookingsStatePatterns on BookingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingsState value)  $default,){
final _that = this;
switch (_that) {
case _BookingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingsState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingScope scope,  List<Booking> upcoming,  List<Booking> past,  bool isLoading,  bool isCancelling,  DateTime now,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingsState() when $default != null:
return $default(_that.scope,_that.upcoming,_that.past,_that.isLoading,_that.isCancelling,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingScope scope,  List<Booking> upcoming,  List<Booking> past,  bool isLoading,  bool isCancelling,  DateTime now,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _BookingsState():
return $default(_that.scope,_that.upcoming,_that.past,_that.isLoading,_that.isCancelling,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingScope scope,  List<Booking> upcoming,  List<Booking> past,  bool isLoading,  bool isCancelling,  DateTime now,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _BookingsState() when $default != null:
return $default(_that.scope,_that.upcoming,_that.past,_that.isLoading,_that.isCancelling,_that.now,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _BookingsState extends BookingsState {
  const _BookingsState({this.scope = BookingScope.upcoming, final  List<Booking> upcoming = const <Booking>[], final  List<Booking> past = const <Booking>[], this.isLoading = true, this.isCancelling = false, required this.now, this.failure}): _upcoming = upcoming,_past = past,super._();
  

@override@JsonKey() final  BookingScope scope;
 final  List<Booking> _upcoming;
@override@JsonKey() List<Booking> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<Booking> _past;
@override@JsonKey() List<Booking> get past {
  if (_past is EqualUnmodifiableListView) return _past;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_past);
}

@override@JsonKey() final  bool isLoading;
/// Set while a cancellation is in flight, so the sheet's button can wait
/// rather than letting a second tap start a second cancel.
@override@JsonKey() final  bool isCancelling;
/// The clock the list is drawn against — whether a hold has run out, and
/// whether free cancellation is still open, both move on their own.
@override final  DateTime now;
@override final  NetworkException? failure;

/// Create a copy of BookingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingsStateCopyWith<_BookingsState> get copyWith => __$BookingsStateCopyWithImpl<_BookingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingsState&&(identical(other.scope, scope) || other.scope == scope)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&const DeepCollectionEquality().equals(other._past, _past)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,scope,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_past),isLoading,isCancelling,now,failure);

@override
String toString() {
  return 'BookingsState(scope: $scope, upcoming: $upcoming, past: $past, isLoading: $isLoading, isCancelling: $isCancelling, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$BookingsStateCopyWith<$Res> implements $BookingsStateCopyWith<$Res> {
  factory _$BookingsStateCopyWith(_BookingsState value, $Res Function(_BookingsState) _then) = __$BookingsStateCopyWithImpl;
@override @useResult
$Res call({
 BookingScope scope, List<Booking> upcoming, List<Booking> past, bool isLoading, bool isCancelling, DateTime now, NetworkException? failure
});




}
/// @nodoc
class __$BookingsStateCopyWithImpl<$Res>
    implements _$BookingsStateCopyWith<$Res> {
  __$BookingsStateCopyWithImpl(this._self, this._then);

  final _BookingsState _self;
  final $Res Function(_BookingsState) _then;

/// Create a copy of BookingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scope = null,Object? upcoming = null,Object? past = null,Object? isLoading = null,Object? isCancelling = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_BookingsState(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as BookingScope,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Booking>,past: null == past ? _self._past : past // ignore: cast_nullable_to_non_nullable
as List<Booking>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_agenda_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OwnerAgendaState {

/// The day being shown, as `YYYY-MM-DD`. Null until the first load
/// answers: which day "today" is, is the shop's question, not the phone's.
 String? get date; AgendaDay? get day;/// The first load, and every date change. A swipe of the strip replaces
/// the whole timeline, so it is a load rather than a refresh.
 bool get isLoading;/// A block is being written or removed. Blocks the sheet's own action, not
/// the day behind it.
 bool get isSaving;/// Re-read every minute so the current row keeps up with the clock
/// without the owner pulling to refresh. It is the device's clock — the
/// one instant in the screen that legitimately is — and it is compared
/// against instants, never against a wall time.
 DateTime get now; NetworkException? get failure;
/// Create a copy of OwnerAgendaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerAgendaStateCopyWith<OwnerAgendaState> get copyWith => _$OwnerAgendaStateCopyWithImpl<OwnerAgendaState>(this as OwnerAgendaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerAgendaState&&(identical(other.date, date) || other.date == date)&&(identical(other.day, day) || other.day == day)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,date,day,isLoading,isSaving,now,failure);

@override
String toString() {
  return 'OwnerAgendaState(date: $date, day: $day, isLoading: $isLoading, isSaving: $isSaving, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $OwnerAgendaStateCopyWith<$Res>  {
  factory $OwnerAgendaStateCopyWith(OwnerAgendaState value, $Res Function(OwnerAgendaState) _then) = _$OwnerAgendaStateCopyWithImpl;
@useResult
$Res call({
 String? date, AgendaDay? day, bool isLoading, bool isSaving, DateTime now, NetworkException? failure
});


$AgendaDayCopyWith<$Res>? get day;

}
/// @nodoc
class _$OwnerAgendaStateCopyWithImpl<$Res>
    implements $OwnerAgendaStateCopyWith<$Res> {
  _$OwnerAgendaStateCopyWithImpl(this._self, this._then);

  final OwnerAgendaState _self;
  final $Res Function(OwnerAgendaState) _then;

/// Create a copy of OwnerAgendaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? day = freezed,Object? isLoading = null,Object? isSaving = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as AgendaDay?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of OwnerAgendaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgendaDayCopyWith<$Res>? get day {
    if (_self.day == null) {
    return null;
  }

  return $AgendaDayCopyWith<$Res>(_self.day!, (value) {
    return _then(_self.copyWith(day: value));
  });
}
}


/// Adds pattern-matching-related methods to [OwnerAgendaState].
extension OwnerAgendaStatePatterns on OwnerAgendaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerAgendaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerAgendaState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerAgendaState value)  $default,){
final _that = this;
switch (_that) {
case _OwnerAgendaState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerAgendaState value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerAgendaState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  AgendaDay? day,  bool isLoading,  bool isSaving,  DateTime now,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerAgendaState() when $default != null:
return $default(_that.date,_that.day,_that.isLoading,_that.isSaving,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  AgendaDay? day,  bool isLoading,  bool isSaving,  DateTime now,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _OwnerAgendaState():
return $default(_that.date,_that.day,_that.isLoading,_that.isSaving,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  AgendaDay? day,  bool isLoading,  bool isSaving,  DateTime now,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _OwnerAgendaState() when $default != null:
return $default(_that.date,_that.day,_that.isLoading,_that.isSaving,_that.now,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _OwnerAgendaState extends OwnerAgendaState {
  const _OwnerAgendaState({this.date, this.day, this.isLoading = true, this.isSaving = false, required this.now, this.failure}): super._();
  

/// The day being shown, as `YYYY-MM-DD`. Null until the first load
/// answers: which day "today" is, is the shop's question, not the phone's.
@override final  String? date;
@override final  AgendaDay? day;
/// The first load, and every date change. A swipe of the strip replaces
/// the whole timeline, so it is a load rather than a refresh.
@override@JsonKey() final  bool isLoading;
/// A block is being written or removed. Blocks the sheet's own action, not
/// the day behind it.
@override@JsonKey() final  bool isSaving;
/// Re-read every minute so the current row keeps up with the clock
/// without the owner pulling to refresh. It is the device's clock — the
/// one instant in the screen that legitimately is — and it is compared
/// against instants, never against a wall time.
@override final  DateTime now;
@override final  NetworkException? failure;

/// Create a copy of OwnerAgendaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerAgendaStateCopyWith<_OwnerAgendaState> get copyWith => __$OwnerAgendaStateCopyWithImpl<_OwnerAgendaState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerAgendaState&&(identical(other.date, date) || other.date == date)&&(identical(other.day, day) || other.day == day)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,date,day,isLoading,isSaving,now,failure);

@override
String toString() {
  return 'OwnerAgendaState(date: $date, day: $day, isLoading: $isLoading, isSaving: $isSaving, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$OwnerAgendaStateCopyWith<$Res> implements $OwnerAgendaStateCopyWith<$Res> {
  factory _$OwnerAgendaStateCopyWith(_OwnerAgendaState value, $Res Function(_OwnerAgendaState) _then) = __$OwnerAgendaStateCopyWithImpl;
@override @useResult
$Res call({
 String? date, AgendaDay? day, bool isLoading, bool isSaving, DateTime now, NetworkException? failure
});


@override $AgendaDayCopyWith<$Res>? get day;

}
/// @nodoc
class __$OwnerAgendaStateCopyWithImpl<$Res>
    implements _$OwnerAgendaStateCopyWith<$Res> {
  __$OwnerAgendaStateCopyWithImpl(this._self, this._then);

  final _OwnerAgendaState _self;
  final $Res Function(_OwnerAgendaState) _then;

/// Create a copy of OwnerAgendaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? day = freezed,Object? isLoading = null,Object? isSaving = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_OwnerAgendaState(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as AgendaDay?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of OwnerAgendaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgendaDayCopyWith<$Res>? get day {
    if (_self.day == null) {
    return null;
  }

  return $AgendaDayCopyWith<$Res>(_self.day!, (value) {
    return _then(_self.copyWith(day: value));
  });
}
}

// dart format on

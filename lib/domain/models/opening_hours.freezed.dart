// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opening_hours.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimeRange {

 String get from; String get to;
/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeRangeCopyWith<TimeRange> get copyWith => _$TimeRangeCopyWithImpl<TimeRange>(this as TimeRange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeRange&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'TimeRange(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $TimeRangeCopyWith<$Res>  {
  factory $TimeRangeCopyWith(TimeRange value, $Res Function(TimeRange) _then) = _$TimeRangeCopyWithImpl;
@useResult
$Res call({
 String from, String to
});




}
/// @nodoc
class _$TimeRangeCopyWithImpl<$Res>
    implements $TimeRangeCopyWith<$Res> {
  _$TimeRangeCopyWithImpl(this._self, this._then);

  final TimeRange _self;
  final $Res Function(TimeRange) _then;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeRange].
extension TimeRangePatterns on TimeRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeRange value)  $default,){
final _that = this;
switch (_that) {
case _TimeRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeRange value)?  $default,){
final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String to)  $default,) {final _that = this;
switch (_that) {
case _TimeRange():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String to)?  $default,) {final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc


class _TimeRange extends TimeRange {
  const _TimeRange({required this.from, required this.to}): super._();
  

@override final  String from;
@override final  String to;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeRangeCopyWith<_TimeRange> get copyWith => __$TimeRangeCopyWithImpl<_TimeRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeRange&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'TimeRange(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$TimeRangeCopyWith<$Res> implements $TimeRangeCopyWith<$Res> {
  factory _$TimeRangeCopyWith(_TimeRange value, $Res Function(_TimeRange) _then) = __$TimeRangeCopyWithImpl;
@override @useResult
$Res call({
 String from, String to
});




}
/// @nodoc
class __$TimeRangeCopyWithImpl<$Res>
    implements _$TimeRangeCopyWith<$Res> {
  __$TimeRangeCopyWithImpl(this._self, this._then);

  final _TimeRange _self;
  final $Res Function(_TimeRange) _then;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_TimeRange(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OpeningHours {

 Map<Weekday, List<TimeRange>> get byDay;
/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpeningHoursCopyWith<OpeningHours> get copyWith => _$OpeningHoursCopyWithImpl<OpeningHours>(this as OpeningHours, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpeningHours&&const DeepCollectionEquality().equals(other.byDay, byDay));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(byDay));

@override
String toString() {
  return 'OpeningHours(byDay: $byDay)';
}


}

/// @nodoc
abstract mixin class $OpeningHoursCopyWith<$Res>  {
  factory $OpeningHoursCopyWith(OpeningHours value, $Res Function(OpeningHours) _then) = _$OpeningHoursCopyWithImpl;
@useResult
$Res call({
 Map<Weekday, List<TimeRange>> byDay
});




}
/// @nodoc
class _$OpeningHoursCopyWithImpl<$Res>
    implements $OpeningHoursCopyWith<$Res> {
  _$OpeningHoursCopyWithImpl(this._self, this._then);

  final OpeningHours _self;
  final $Res Function(OpeningHours) _then;

/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? byDay = null,}) {
  return _then(_self.copyWith(
byDay: null == byDay ? _self.byDay : byDay // ignore: cast_nullable_to_non_nullable
as Map<Weekday, List<TimeRange>>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpeningHours].
extension OpeningHoursPatterns on OpeningHours {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpeningHours value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpeningHours value)  $default,){
final _that = this;
switch (_that) {
case _OpeningHours():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpeningHours value)?  $default,){
final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<Weekday, List<TimeRange>> byDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
return $default(_that.byDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<Weekday, List<TimeRange>> byDay)  $default,) {final _that = this;
switch (_that) {
case _OpeningHours():
return $default(_that.byDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<Weekday, List<TimeRange>> byDay)?  $default,) {final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
return $default(_that.byDay);case _:
  return null;

}
}

}

/// @nodoc


class _OpeningHours extends OpeningHours {
  const _OpeningHours([final  Map<Weekday, List<TimeRange>> byDay = const <Weekday, List<TimeRange>>{}]): _byDay = byDay,super._();
  

 final  Map<Weekday, List<TimeRange>> _byDay;
@override@JsonKey() Map<Weekday, List<TimeRange>> get byDay {
  if (_byDay is EqualUnmodifiableMapView) return _byDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byDay);
}


/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpeningHoursCopyWith<_OpeningHours> get copyWith => __$OpeningHoursCopyWithImpl<_OpeningHours>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpeningHours&&const DeepCollectionEquality().equals(other._byDay, _byDay));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_byDay));

@override
String toString() {
  return 'OpeningHours(byDay: $byDay)';
}


}

/// @nodoc
abstract mixin class _$OpeningHoursCopyWith<$Res> implements $OpeningHoursCopyWith<$Res> {
  factory _$OpeningHoursCopyWith(_OpeningHours value, $Res Function(_OpeningHours) _then) = __$OpeningHoursCopyWithImpl;
@override @useResult
$Res call({
 Map<Weekday, List<TimeRange>> byDay
});




}
/// @nodoc
class __$OpeningHoursCopyWithImpl<$Res>
    implements _$OpeningHoursCopyWith<$Res> {
  __$OpeningHoursCopyWithImpl(this._self, this._then);

  final _OpeningHours _self;
  final $Res Function(_OpeningHours) _then;

/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? byDay = null,}) {
  return _then(_OpeningHours(
null == byDay ? _self._byDay : byDay // ignore: cast_nullable_to_non_nullable
as Map<Weekday, List<TimeRange>>,
  ));
}


}

// dart format on

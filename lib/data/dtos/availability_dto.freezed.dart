// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AvailabilityDto {

@JsonKey(name: 'date') Object? get date;@JsonKey(name: 'timeZone') Object? get timeZone;@JsonKey(name: 'durationMin') Object? get durationMin;@JsonKey(name: 'starts') List<dynamic>? get starts;
/// Create a copy of AvailabilityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityDtoCopyWith<AvailabilityDto> get copyWith => _$AvailabilityDtoCopyWithImpl<AvailabilityDto>(this as AvailabilityDto, _$identity);

  /// Serializes this AvailabilityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityDto&&const DeepCollectionEquality().equals(other.date, date)&&const DeepCollectionEquality().equals(other.timeZone, timeZone)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.starts, starts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(date),const DeepCollectionEquality().hash(timeZone),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(starts));

@override
String toString() {
  return 'AvailabilityDto(date: $date, timeZone: $timeZone, durationMin: $durationMin, starts: $starts)';
}


}

/// @nodoc
abstract mixin class $AvailabilityDtoCopyWith<$Res>  {
  factory $AvailabilityDtoCopyWith(AvailabilityDto value, $Res Function(AvailabilityDto) _then) = _$AvailabilityDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date') Object? date,@JsonKey(name: 'timeZone') Object? timeZone,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'starts') List<dynamic>? starts
});




}
/// @nodoc
class _$AvailabilityDtoCopyWithImpl<$Res>
    implements $AvailabilityDtoCopyWith<$Res> {
  _$AvailabilityDtoCopyWithImpl(this._self, this._then);

  final AvailabilityDto _self;
  final $Res Function(AvailabilityDto) _then;

/// Create a copy of AvailabilityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? timeZone = freezed,Object? durationMin = freezed,Object? starts = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date ,timeZone: freezed == timeZone ? _self.timeZone : timeZone ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,starts: freezed == starts ? _self.starts : starts // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityDto].
extension AvailabilityDtoPatterns on AvailabilityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityDto value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityDto value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date')  Object? date, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'starts')  List<dynamic>? starts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityDto() when $default != null:
return $default(_that.date,_that.timeZone,_that.durationMin,_that.starts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date')  Object? date, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'starts')  List<dynamic>? starts)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityDto():
return $default(_that.date,_that.timeZone,_that.durationMin,_that.starts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date')  Object? date, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'starts')  List<dynamic>? starts)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityDto() when $default != null:
return $default(_that.date,_that.timeZone,_that.durationMin,_that.starts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityDto extends AvailabilityDto {
  const _AvailabilityDto({@JsonKey(name: 'date') this.date, @JsonKey(name: 'timeZone') this.timeZone, @JsonKey(name: 'durationMin') this.durationMin, @JsonKey(name: 'starts') final  List<dynamic>? starts}): _starts = starts,super._();
  factory _AvailabilityDto.fromJson(Map<String, dynamic> json) => _$AvailabilityDtoFromJson(json);

@override@JsonKey(name: 'date') final  Object? date;
@override@JsonKey(name: 'timeZone') final  Object? timeZone;
@override@JsonKey(name: 'durationMin') final  Object? durationMin;
 final  List<dynamic>? _starts;
@override@JsonKey(name: 'starts') List<dynamic>? get starts {
  final value = _starts;
  if (value == null) return null;
  if (_starts is EqualUnmodifiableListView) return _starts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AvailabilityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityDtoCopyWith<_AvailabilityDto> get copyWith => __$AvailabilityDtoCopyWithImpl<_AvailabilityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityDto&&const DeepCollectionEquality().equals(other.date, date)&&const DeepCollectionEquality().equals(other.timeZone, timeZone)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other._starts, _starts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(date),const DeepCollectionEquality().hash(timeZone),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(_starts));

@override
String toString() {
  return 'AvailabilityDto(date: $date, timeZone: $timeZone, durationMin: $durationMin, starts: $starts)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityDtoCopyWith<$Res> implements $AvailabilityDtoCopyWith<$Res> {
  factory _$AvailabilityDtoCopyWith(_AvailabilityDto value, $Res Function(_AvailabilityDto) _then) = __$AvailabilityDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date') Object? date,@JsonKey(name: 'timeZone') Object? timeZone,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'starts') List<dynamic>? starts
});




}
/// @nodoc
class __$AvailabilityDtoCopyWithImpl<$Res>
    implements _$AvailabilityDtoCopyWith<$Res> {
  __$AvailabilityDtoCopyWithImpl(this._self, this._then);

  final _AvailabilityDto _self;
  final $Res Function(_AvailabilityDto) _then;

/// Create a copy of AvailabilityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? timeZone = freezed,Object? durationMin = freezed,Object? starts = freezed,}) {
  return _then(_AvailabilityDto(
date: freezed == date ? _self.date : date ,timeZone: freezed == timeZone ? _self.timeZone : timeZone ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,starts: freezed == starts ? _self._starts : starts // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}

// dart format on

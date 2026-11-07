// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AgendaDayDto {

@JsonKey(name: 'date') Object? get date;@JsonKey(name: 'timeZone') Object? get timeZone;@JsonKey(name: 'closed') Object? get closed;@JsonKey(name: 'closure') Object? get closure;@JsonKey(name: 'openingHours') List<dynamic>? get openingHours;@JsonKey(name: 'summary') Map<String, dynamic>? get summary;@JsonKey(name: 'days') List<dynamic>? get days;@JsonKey(name: 'rows') List<dynamic>? get rows;
/// Create a copy of AgendaDayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaDayDtoCopyWith<AgendaDayDto> get copyWith => _$AgendaDayDtoCopyWithImpl<AgendaDayDto>(this as AgendaDayDto, _$identity);

  /// Serializes this AgendaDayDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaDayDto&&const DeepCollectionEquality().equals(other.date, date)&&const DeepCollectionEquality().equals(other.timeZone, timeZone)&&const DeepCollectionEquality().equals(other.closed, closed)&&const DeepCollectionEquality().equals(other.closure, closure)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&const DeepCollectionEquality().equals(other.summary, summary)&&const DeepCollectionEquality().equals(other.days, days)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(date),const DeepCollectionEquality().hash(timeZone),const DeepCollectionEquality().hash(closed),const DeepCollectionEquality().hash(closure),const DeepCollectionEquality().hash(openingHours),const DeepCollectionEquality().hash(summary),const DeepCollectionEquality().hash(days),const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'AgendaDayDto(date: $date, timeZone: $timeZone, closed: $closed, closure: $closure, openingHours: $openingHours, summary: $summary, days: $days, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $AgendaDayDtoCopyWith<$Res>  {
  factory $AgendaDayDtoCopyWith(AgendaDayDto value, $Res Function(AgendaDayDto) _then) = _$AgendaDayDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date') Object? date,@JsonKey(name: 'timeZone') Object? timeZone,@JsonKey(name: 'closed') Object? closed,@JsonKey(name: 'closure') Object? closure,@JsonKey(name: 'openingHours') List<dynamic>? openingHours,@JsonKey(name: 'summary') Map<String, dynamic>? summary,@JsonKey(name: 'days') List<dynamic>? days,@JsonKey(name: 'rows') List<dynamic>? rows
});




}
/// @nodoc
class _$AgendaDayDtoCopyWithImpl<$Res>
    implements $AgendaDayDtoCopyWith<$Res> {
  _$AgendaDayDtoCopyWithImpl(this._self, this._then);

  final AgendaDayDto _self;
  final $Res Function(AgendaDayDto) _then;

/// Create a copy of AgendaDayDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? timeZone = freezed,Object? closed = freezed,Object? closure = freezed,Object? openingHours = freezed,Object? summary = freezed,Object? days = freezed,Object? rows = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date ,timeZone: freezed == timeZone ? _self.timeZone : timeZone ,closed: freezed == closed ? _self.closed : closed ,closure: freezed == closure ? _self.closure : closure ,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,days: freezed == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,rows: freezed == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaDayDto].
extension AgendaDayDtoPatterns on AgendaDayDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaDayDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaDayDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaDayDto value)  $default,){
final _that = this;
switch (_that) {
case _AgendaDayDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaDayDto value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaDayDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date')  Object? date, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'closed')  Object? closed, @JsonKey(name: 'closure')  Object? closure, @JsonKey(name: 'openingHours')  List<dynamic>? openingHours, @JsonKey(name: 'summary')  Map<String, dynamic>? summary, @JsonKey(name: 'days')  List<dynamic>? days, @JsonKey(name: 'rows')  List<dynamic>? rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaDayDto() when $default != null:
return $default(_that.date,_that.timeZone,_that.closed,_that.closure,_that.openingHours,_that.summary,_that.days,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date')  Object? date, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'closed')  Object? closed, @JsonKey(name: 'closure')  Object? closure, @JsonKey(name: 'openingHours')  List<dynamic>? openingHours, @JsonKey(name: 'summary')  Map<String, dynamic>? summary, @JsonKey(name: 'days')  List<dynamic>? days, @JsonKey(name: 'rows')  List<dynamic>? rows)  $default,) {final _that = this;
switch (_that) {
case _AgendaDayDto():
return $default(_that.date,_that.timeZone,_that.closed,_that.closure,_that.openingHours,_that.summary,_that.days,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date')  Object? date, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'closed')  Object? closed, @JsonKey(name: 'closure')  Object? closure, @JsonKey(name: 'openingHours')  List<dynamic>? openingHours, @JsonKey(name: 'summary')  Map<String, dynamic>? summary, @JsonKey(name: 'days')  List<dynamic>? days, @JsonKey(name: 'rows')  List<dynamic>? rows)?  $default,) {final _that = this;
switch (_that) {
case _AgendaDayDto() when $default != null:
return $default(_that.date,_that.timeZone,_that.closed,_that.closure,_that.openingHours,_that.summary,_that.days,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaDayDto implements AgendaDayDto {
  const _AgendaDayDto({@JsonKey(name: 'date') this.date, @JsonKey(name: 'timeZone') this.timeZone, @JsonKey(name: 'closed') this.closed, @JsonKey(name: 'closure') this.closure, @JsonKey(name: 'openingHours') final  List<dynamic>? openingHours, @JsonKey(name: 'summary') final  Map<String, dynamic>? summary, @JsonKey(name: 'days') final  List<dynamic>? days, @JsonKey(name: 'rows') final  List<dynamic>? rows}): _openingHours = openingHours,_summary = summary,_days = days,_rows = rows;
  factory _AgendaDayDto.fromJson(Map<String, dynamic> json) => _$AgendaDayDtoFromJson(json);

@override@JsonKey(name: 'date') final  Object? date;
@override@JsonKey(name: 'timeZone') final  Object? timeZone;
@override@JsonKey(name: 'closed') final  Object? closed;
@override@JsonKey(name: 'closure') final  Object? closure;
 final  List<dynamic>? _openingHours;
@override@JsonKey(name: 'openingHours') List<dynamic>? get openingHours {
  final value = _openingHours;
  if (value == null) return null;
  if (_openingHours is EqualUnmodifiableListView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _summary;
@override@JsonKey(name: 'summary') Map<String, dynamic>? get summary {
  final value = _summary;
  if (value == null) return null;
  if (_summary is EqualUnmodifiableMapView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _days;
@override@JsonKey(name: 'days') List<dynamic>? get days {
  final value = _days;
  if (value == null) return null;
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _rows;
@override@JsonKey(name: 'rows') List<dynamic>? get rows {
  final value = _rows;
  if (value == null) return null;
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AgendaDayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaDayDtoCopyWith<_AgendaDayDto> get copyWith => __$AgendaDayDtoCopyWithImpl<_AgendaDayDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaDayDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaDayDto&&const DeepCollectionEquality().equals(other.date, date)&&const DeepCollectionEquality().equals(other.timeZone, timeZone)&&const DeepCollectionEquality().equals(other.closed, closed)&&const DeepCollectionEquality().equals(other.closure, closure)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&const DeepCollectionEquality().equals(other._summary, _summary)&&const DeepCollectionEquality().equals(other._days, _days)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(date),const DeepCollectionEquality().hash(timeZone),const DeepCollectionEquality().hash(closed),const DeepCollectionEquality().hash(closure),const DeepCollectionEquality().hash(_openingHours),const DeepCollectionEquality().hash(_summary),const DeepCollectionEquality().hash(_days),const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'AgendaDayDto(date: $date, timeZone: $timeZone, closed: $closed, closure: $closure, openingHours: $openingHours, summary: $summary, days: $days, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$AgendaDayDtoCopyWith<$Res> implements $AgendaDayDtoCopyWith<$Res> {
  factory _$AgendaDayDtoCopyWith(_AgendaDayDto value, $Res Function(_AgendaDayDto) _then) = __$AgendaDayDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date') Object? date,@JsonKey(name: 'timeZone') Object? timeZone,@JsonKey(name: 'closed') Object? closed,@JsonKey(name: 'closure') Object? closure,@JsonKey(name: 'openingHours') List<dynamic>? openingHours,@JsonKey(name: 'summary') Map<String, dynamic>? summary,@JsonKey(name: 'days') List<dynamic>? days,@JsonKey(name: 'rows') List<dynamic>? rows
});




}
/// @nodoc
class __$AgendaDayDtoCopyWithImpl<$Res>
    implements _$AgendaDayDtoCopyWith<$Res> {
  __$AgendaDayDtoCopyWithImpl(this._self, this._then);

  final _AgendaDayDto _self;
  final $Res Function(_AgendaDayDto) _then;

/// Create a copy of AgendaDayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? timeZone = freezed,Object? closed = freezed,Object? closure = freezed,Object? openingHours = freezed,Object? summary = freezed,Object? days = freezed,Object? rows = freezed,}) {
  return _then(_AgendaDayDto(
date: freezed == date ? _self.date : date ,timeZone: freezed == timeZone ? _self.timeZone : timeZone ,closed: freezed == closed ? _self.closed : closed ,closure: freezed == closure ? _self.closure : closure ,openingHours: freezed == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,summary: freezed == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,days: freezed == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,rows: freezed == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$BlockDto {

@JsonKey(name: 'blockId') Object? get blockId;@JsonKey(name: 'id') Object? get id;@JsonKey(name: 'startUtc') Object? get startUtc;@JsonKey(name: 'endUtc') Object? get endUtc;@JsonKey(name: 'note') Object? get note;
/// Create a copy of BlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockDtoCopyWith<BlockDto> get copyWith => _$BlockDtoCopyWithImpl<BlockDto>(this as BlockDto, _$identity);

  /// Serializes this BlockDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockDto&&const DeepCollectionEquality().equals(other.blockId, blockId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.startUtc, startUtc)&&const DeepCollectionEquality().equals(other.endUtc, endUtc)&&const DeepCollectionEquality().equals(other.note, note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(blockId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(startUtc),const DeepCollectionEquality().hash(endUtc),const DeepCollectionEquality().hash(note));

@override
String toString() {
  return 'BlockDto(blockId: $blockId, id: $id, startUtc: $startUtc, endUtc: $endUtc, note: $note)';
}


}

/// @nodoc
abstract mixin class $BlockDtoCopyWith<$Res>  {
  factory $BlockDtoCopyWith(BlockDto value, $Res Function(BlockDto) _then) = _$BlockDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'blockId') Object? blockId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'startUtc') Object? startUtc,@JsonKey(name: 'endUtc') Object? endUtc,@JsonKey(name: 'note') Object? note
});




}
/// @nodoc
class _$BlockDtoCopyWithImpl<$Res>
    implements $BlockDtoCopyWith<$Res> {
  _$BlockDtoCopyWithImpl(this._self, this._then);

  final BlockDto _self;
  final $Res Function(BlockDto) _then;

/// Create a copy of BlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blockId = freezed,Object? id = freezed,Object? startUtc = freezed,Object? endUtc = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
blockId: freezed == blockId ? _self.blockId : blockId ,id: freezed == id ? _self.id : id ,startUtc: freezed == startUtc ? _self.startUtc : startUtc ,endUtc: freezed == endUtc ? _self.endUtc : endUtc ,note: freezed == note ? _self.note : note ,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockDto].
extension BlockDtoPatterns on BlockDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockDto value)  $default,){
final _that = this;
switch (_that) {
case _BlockDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockDto value)?  $default,){
final _that = this;
switch (_that) {
case _BlockDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'blockId')  Object? blockId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'startUtc')  Object? startUtc, @JsonKey(name: 'endUtc')  Object? endUtc, @JsonKey(name: 'note')  Object? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockDto() when $default != null:
return $default(_that.blockId,_that.id,_that.startUtc,_that.endUtc,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'blockId')  Object? blockId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'startUtc')  Object? startUtc, @JsonKey(name: 'endUtc')  Object? endUtc, @JsonKey(name: 'note')  Object? note)  $default,) {final _that = this;
switch (_that) {
case _BlockDto():
return $default(_that.blockId,_that.id,_that.startUtc,_that.endUtc,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'blockId')  Object? blockId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'startUtc')  Object? startUtc, @JsonKey(name: 'endUtc')  Object? endUtc, @JsonKey(name: 'note')  Object? note)?  $default,) {final _that = this;
switch (_that) {
case _BlockDto() when $default != null:
return $default(_that.blockId,_that.id,_that.startUtc,_that.endUtc,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockDto implements BlockDto {
  const _BlockDto({@JsonKey(name: 'blockId') this.blockId, @JsonKey(name: 'id') this.id, @JsonKey(name: 'startUtc') this.startUtc, @JsonKey(name: 'endUtc') this.endUtc, @JsonKey(name: 'note') this.note});
  factory _BlockDto.fromJson(Map<String, dynamic> json) => _$BlockDtoFromJson(json);

@override@JsonKey(name: 'blockId') final  Object? blockId;
@override@JsonKey(name: 'id') final  Object? id;
@override@JsonKey(name: 'startUtc') final  Object? startUtc;
@override@JsonKey(name: 'endUtc') final  Object? endUtc;
@override@JsonKey(name: 'note') final  Object? note;

/// Create a copy of BlockDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockDtoCopyWith<_BlockDto> get copyWith => __$BlockDtoCopyWithImpl<_BlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockDto&&const DeepCollectionEquality().equals(other.blockId, blockId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.startUtc, startUtc)&&const DeepCollectionEquality().equals(other.endUtc, endUtc)&&const DeepCollectionEquality().equals(other.note, note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(blockId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(startUtc),const DeepCollectionEquality().hash(endUtc),const DeepCollectionEquality().hash(note));

@override
String toString() {
  return 'BlockDto(blockId: $blockId, id: $id, startUtc: $startUtc, endUtc: $endUtc, note: $note)';
}


}

/// @nodoc
abstract mixin class _$BlockDtoCopyWith<$Res> implements $BlockDtoCopyWith<$Res> {
  factory _$BlockDtoCopyWith(_BlockDto value, $Res Function(_BlockDto) _then) = __$BlockDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'blockId') Object? blockId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'startUtc') Object? startUtc,@JsonKey(name: 'endUtc') Object? endUtc,@JsonKey(name: 'note') Object? note
});




}
/// @nodoc
class __$BlockDtoCopyWithImpl<$Res>
    implements _$BlockDtoCopyWith<$Res> {
  __$BlockDtoCopyWithImpl(this._self, this._then);

  final _BlockDto _self;
  final $Res Function(_BlockDto) _then;

/// Create a copy of BlockDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? blockId = freezed,Object? id = freezed,Object? startUtc = freezed,Object? endUtc = freezed,Object? note = freezed,}) {
  return _then(_BlockDto(
blockId: freezed == blockId ? _self.blockId : blockId ,id: freezed == id ? _self.id : id ,startUtc: freezed == startUtc ? _self.startUtc : startUtc ,endUtc: freezed == endUtc ? _self.endUtc : endUtc ,note: freezed == note ? _self.note : note ,
  ));
}


}

// dart format on

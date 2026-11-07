// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPreferencesDto {

@JsonKey(name: 'newBooking') Object? get newBooking;@JsonKey(name: 'cancellation') Object? get cancellation;@JsonKey(name: 'dailySummary') Object? get dailySummary;@JsonKey(name: 'reminder') Object? get reminder;
/// Create a copy of NotificationPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesDtoCopyWith<NotificationPreferencesDto> get copyWith => _$NotificationPreferencesDtoCopyWithImpl<NotificationPreferencesDto>(this as NotificationPreferencesDto, _$identity);

  /// Serializes this NotificationPreferencesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesDto&&const DeepCollectionEquality().equals(other.newBooking, newBooking)&&const DeepCollectionEquality().equals(other.cancellation, cancellation)&&const DeepCollectionEquality().equals(other.dailySummary, dailySummary)&&const DeepCollectionEquality().equals(other.reminder, reminder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(newBooking),const DeepCollectionEquality().hash(cancellation),const DeepCollectionEquality().hash(dailySummary),const DeepCollectionEquality().hash(reminder));

@override
String toString() {
  return 'NotificationPreferencesDto(newBooking: $newBooking, cancellation: $cancellation, dailySummary: $dailySummary, reminder: $reminder)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesDtoCopyWith<$Res>  {
  factory $NotificationPreferencesDtoCopyWith(NotificationPreferencesDto value, $Res Function(NotificationPreferencesDto) _then) = _$NotificationPreferencesDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'newBooking') Object? newBooking,@JsonKey(name: 'cancellation') Object? cancellation,@JsonKey(name: 'dailySummary') Object? dailySummary,@JsonKey(name: 'reminder') Object? reminder
});




}
/// @nodoc
class _$NotificationPreferencesDtoCopyWithImpl<$Res>
    implements $NotificationPreferencesDtoCopyWith<$Res> {
  _$NotificationPreferencesDtoCopyWithImpl(this._self, this._then);

  final NotificationPreferencesDto _self;
  final $Res Function(NotificationPreferencesDto) _then;

/// Create a copy of NotificationPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newBooking = freezed,Object? cancellation = freezed,Object? dailySummary = freezed,Object? reminder = freezed,}) {
  return _then(_self.copyWith(
newBooking: freezed == newBooking ? _self.newBooking : newBooking ,cancellation: freezed == cancellation ? _self.cancellation : cancellation ,dailySummary: freezed == dailySummary ? _self.dailySummary : dailySummary ,reminder: freezed == reminder ? _self.reminder : reminder ,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferencesDto].
extension NotificationPreferencesDtoPatterns on NotificationPreferencesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferencesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferencesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferencesDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferencesDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'newBooking')  Object? newBooking, @JsonKey(name: 'cancellation')  Object? cancellation, @JsonKey(name: 'dailySummary')  Object? dailySummary, @JsonKey(name: 'reminder')  Object? reminder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferencesDto() when $default != null:
return $default(_that.newBooking,_that.cancellation,_that.dailySummary,_that.reminder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'newBooking')  Object? newBooking, @JsonKey(name: 'cancellation')  Object? cancellation, @JsonKey(name: 'dailySummary')  Object? dailySummary, @JsonKey(name: 'reminder')  Object? reminder)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesDto():
return $default(_that.newBooking,_that.cancellation,_that.dailySummary,_that.reminder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'newBooking')  Object? newBooking, @JsonKey(name: 'cancellation')  Object? cancellation, @JsonKey(name: 'dailySummary')  Object? dailySummary, @JsonKey(name: 'reminder')  Object? reminder)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesDto() when $default != null:
return $default(_that.newBooking,_that.cancellation,_that.dailySummary,_that.reminder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferencesDto implements NotificationPreferencesDto {
  const _NotificationPreferencesDto({@JsonKey(name: 'newBooking') this.newBooking, @JsonKey(name: 'cancellation') this.cancellation, @JsonKey(name: 'dailySummary') this.dailySummary, @JsonKey(name: 'reminder') this.reminder});
  factory _NotificationPreferencesDto.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesDtoFromJson(json);

@override@JsonKey(name: 'newBooking') final  Object? newBooking;
@override@JsonKey(name: 'cancellation') final  Object? cancellation;
@override@JsonKey(name: 'dailySummary') final  Object? dailySummary;
@override@JsonKey(name: 'reminder') final  Object? reminder;

/// Create a copy of NotificationPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesDtoCopyWith<_NotificationPreferencesDto> get copyWith => __$NotificationPreferencesDtoCopyWithImpl<_NotificationPreferencesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferencesDto&&const DeepCollectionEquality().equals(other.newBooking, newBooking)&&const DeepCollectionEquality().equals(other.cancellation, cancellation)&&const DeepCollectionEquality().equals(other.dailySummary, dailySummary)&&const DeepCollectionEquality().equals(other.reminder, reminder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(newBooking),const DeepCollectionEquality().hash(cancellation),const DeepCollectionEquality().hash(dailySummary),const DeepCollectionEquality().hash(reminder));

@override
String toString() {
  return 'NotificationPreferencesDto(newBooking: $newBooking, cancellation: $cancellation, dailySummary: $dailySummary, reminder: $reminder)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesDtoCopyWith<$Res> implements $NotificationPreferencesDtoCopyWith<$Res> {
  factory _$NotificationPreferencesDtoCopyWith(_NotificationPreferencesDto value, $Res Function(_NotificationPreferencesDto) _then) = __$NotificationPreferencesDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'newBooking') Object? newBooking,@JsonKey(name: 'cancellation') Object? cancellation,@JsonKey(name: 'dailySummary') Object? dailySummary,@JsonKey(name: 'reminder') Object? reminder
});




}
/// @nodoc
class __$NotificationPreferencesDtoCopyWithImpl<$Res>
    implements _$NotificationPreferencesDtoCopyWith<$Res> {
  __$NotificationPreferencesDtoCopyWithImpl(this._self, this._then);

  final _NotificationPreferencesDto _self;
  final $Res Function(_NotificationPreferencesDto) _then;

/// Create a copy of NotificationPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newBooking = freezed,Object? cancellation = freezed,Object? dailySummary = freezed,Object? reminder = freezed,}) {
  return _then(_NotificationPreferencesDto(
newBooking: freezed == newBooking ? _self.newBooking : newBooking ,cancellation: freezed == cancellation ? _self.cancellation : cancellation ,dailySummary: freezed == dailySummary ? _self.dailySummary : dailySummary ,reminder: freezed == reminder ? _self.reminder : reminder ,
  ));
}


}

// dart format on

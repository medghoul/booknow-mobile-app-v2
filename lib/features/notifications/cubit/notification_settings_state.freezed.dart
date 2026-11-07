// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSettingsState {

 NotificationPreferences get preferences;/// Whether the OS delivers notifications for this app at all.
///
/// Starts true and is corrected by the first check: assuming the worst
/// would flash a warning banner onto every opening of the screen before
/// the platform has answered.
 bool get isSystemAllowed;/// Why the last change did not stick.
///
/// The switch has already gone back by the time this is set, so the
/// failure explains a row that moved on its own rather than announcing
/// something the user can see for themselves.
 NetworkException? get failure;
/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsStateCopyWith<NotificationSettingsState> get copyWith => _$NotificationSettingsStateCopyWithImpl<NotificationSettingsState>(this as NotificationSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsState&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.isSystemAllowed, isSystemAllowed) || other.isSystemAllowed == isSystemAllowed)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,preferences,isSystemAllowed,failure);

@override
String toString() {
  return 'NotificationSettingsState(preferences: $preferences, isSystemAllowed: $isSystemAllowed, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsStateCopyWith<$Res>  {
  factory $NotificationSettingsStateCopyWith(NotificationSettingsState value, $Res Function(NotificationSettingsState) _then) = _$NotificationSettingsStateCopyWithImpl;
@useResult
$Res call({
 NotificationPreferences preferences, bool isSystemAllowed, NetworkException? failure
});


$NotificationPreferencesCopyWith<$Res> get preferences;

}
/// @nodoc
class _$NotificationSettingsStateCopyWithImpl<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  _$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final NotificationSettingsState _self;
  final $Res Function(NotificationSettingsState) _then;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preferences = null,Object? isSystemAllowed = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as NotificationPreferences,isSystemAllowed: null == isSystemAllowed ? _self.isSystemAllowed : isSystemAllowed // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<$Res> get preferences {
  
  return $NotificationPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationSettingsState].
extension NotificationSettingsStatePatterns on NotificationSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationPreferences preferences,  bool isSystemAllowed,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsState() when $default != null:
return $default(_that.preferences,_that.isSystemAllowed,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationPreferences preferences,  bool isSystemAllowed,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsState():
return $default(_that.preferences,_that.isSystemAllowed,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationPreferences preferences,  bool isSystemAllowed,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsState() when $default != null:
return $default(_that.preferences,_that.isSystemAllowed,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationSettingsState extends NotificationSettingsState {
  const _NotificationSettingsState({this.preferences = const NotificationPreferences(), this.isSystemAllowed = true, this.failure}): super._();
  

@override@JsonKey() final  NotificationPreferences preferences;
/// Whether the OS delivers notifications for this app at all.
///
/// Starts true and is corrected by the first check: assuming the worst
/// would flash a warning banner onto every opening of the screen before
/// the platform has answered.
@override@JsonKey() final  bool isSystemAllowed;
/// Why the last change did not stick.
///
/// The switch has already gone back by the time this is set, so the
/// failure explains a row that moved on its own rather than announcing
/// something the user can see for themselves.
@override final  NetworkException? failure;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsStateCopyWith<_NotificationSettingsState> get copyWith => __$NotificationSettingsStateCopyWithImpl<_NotificationSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsState&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.isSystemAllowed, isSystemAllowed) || other.isSystemAllowed == isSystemAllowed)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,preferences,isSystemAllowed,failure);

@override
String toString() {
  return 'NotificationSettingsState(preferences: $preferences, isSystemAllowed: $isSystemAllowed, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsStateCopyWith<$Res> implements $NotificationSettingsStateCopyWith<$Res> {
  factory _$NotificationSettingsStateCopyWith(_NotificationSettingsState value, $Res Function(_NotificationSettingsState) _then) = __$NotificationSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 NotificationPreferences preferences, bool isSystemAllowed, NetworkException? failure
});


@override $NotificationPreferencesCopyWith<$Res> get preferences;

}
/// @nodoc
class __$NotificationSettingsStateCopyWithImpl<$Res>
    implements _$NotificationSettingsStateCopyWith<$Res> {
  __$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final _NotificationSettingsState _self;
  final $Res Function(_NotificationSettingsState) _then;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preferences = null,Object? isSystemAllowed = null,Object? failure = freezed,}) {
  return _then(_NotificationSettingsState(
preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as NotificationPreferences,isSystemAllowed: null == isSystemAllowed ? _self.isSystemAllowed : isSystemAllowed // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<$Res> get preferences {
  
  return $NotificationPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

// dart format on

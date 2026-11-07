// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPreferences {

// ─── Customer ───────────────────────────────────────────────────────────
 bool get appointmentReminder; ReminderLead get reminderLead;// ─── Owner ──────────────────────────────────────────────────────────────
 bool get newBookings; bool get cancellations; bool get dailySummary;/// When the daily summary goes out, as `HH:mm` wall-clock in the shop's
/// timezone — the same convention as [OpeningHours], and for the same
/// reason: 08:00 means eight in the morning where the shop is, whatever
/// the device thinks the time is.
///
/// Always on the quarter hour; see [quarterHour].
 String get summaryTime;
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<NotificationPreferences> get copyWith => _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(this as NotificationPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferences&&(identical(other.appointmentReminder, appointmentReminder) || other.appointmentReminder == appointmentReminder)&&(identical(other.reminderLead, reminderLead) || other.reminderLead == reminderLead)&&(identical(other.newBookings, newBookings) || other.newBookings == newBookings)&&(identical(other.cancellations, cancellations) || other.cancellations == cancellations)&&(identical(other.dailySummary, dailySummary) || other.dailySummary == dailySummary)&&(identical(other.summaryTime, summaryTime) || other.summaryTime == summaryTime));
}


@override
int get hashCode => Object.hash(runtimeType,appointmentReminder,reminderLead,newBookings,cancellations,dailySummary,summaryTime);

@override
String toString() {
  return 'NotificationPreferences(appointmentReminder: $appointmentReminder, reminderLead: $reminderLead, newBookings: $newBookings, cancellations: $cancellations, dailySummary: $dailySummary, summaryTime: $summaryTime)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res>  {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value, $Res Function(NotificationPreferences) _then) = _$NotificationPreferencesCopyWithImpl;
@useResult
$Res call({
 bool appointmentReminder, ReminderLead reminderLead, bool newBookings, bool cancellations, bool dailySummary, String summaryTime
});




}
/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentReminder = null,Object? reminderLead = null,Object? newBookings = null,Object? cancellations = null,Object? dailySummary = null,Object? summaryTime = null,}) {
  return _then(_self.copyWith(
appointmentReminder: null == appointmentReminder ? _self.appointmentReminder : appointmentReminder // ignore: cast_nullable_to_non_nullable
as bool,reminderLead: null == reminderLead ? _self.reminderLead : reminderLead // ignore: cast_nullable_to_non_nullable
as ReminderLead,newBookings: null == newBookings ? _self.newBookings : newBookings // ignore: cast_nullable_to_non_nullable
as bool,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as bool,dailySummary: null == dailySummary ? _self.dailySummary : dailySummary // ignore: cast_nullable_to_non_nullable
as bool,summaryTime: null == summaryTime ? _self.summaryTime : summaryTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferences value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool appointmentReminder,  ReminderLead reminderLead,  bool newBookings,  bool cancellations,  bool dailySummary,  String summaryTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.appointmentReminder,_that.reminderLead,_that.newBookings,_that.cancellations,_that.dailySummary,_that.summaryTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool appointmentReminder,  ReminderLead reminderLead,  bool newBookings,  bool cancellations,  bool dailySummary,  String summaryTime)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences():
return $default(_that.appointmentReminder,_that.reminderLead,_that.newBookings,_that.cancellations,_that.dailySummary,_that.summaryTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool appointmentReminder,  ReminderLead reminderLead,  bool newBookings,  bool cancellations,  bool dailySummary,  String summaryTime)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.appointmentReminder,_that.reminderLead,_that.newBookings,_that.cancellations,_that.dailySummary,_that.summaryTime);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPreferences extends NotificationPreferences {
  const _NotificationPreferences({this.appointmentReminder = true, this.reminderLead = ReminderLead.twoHours, this.newBookings = true, this.cancellations = true, this.dailySummary = true, this.summaryTime = defaultSummaryTime}): super._();
  

// ─── Customer ───────────────────────────────────────────────────────────
@override@JsonKey() final  bool appointmentReminder;
@override@JsonKey() final  ReminderLead reminderLead;
// ─── Owner ──────────────────────────────────────────────────────────────
@override@JsonKey() final  bool newBookings;
@override@JsonKey() final  bool cancellations;
@override@JsonKey() final  bool dailySummary;
/// When the daily summary goes out, as `HH:mm` wall-clock in the shop's
/// timezone — the same convention as [OpeningHours], and for the same
/// reason: 08:00 means eight in the morning where the shop is, whatever
/// the device thinks the time is.
///
/// Always on the quarter hour; see [quarterHour].
@override@JsonKey() final  String summaryTime;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith => __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferences&&(identical(other.appointmentReminder, appointmentReminder) || other.appointmentReminder == appointmentReminder)&&(identical(other.reminderLead, reminderLead) || other.reminderLead == reminderLead)&&(identical(other.newBookings, newBookings) || other.newBookings == newBookings)&&(identical(other.cancellations, cancellations) || other.cancellations == cancellations)&&(identical(other.dailySummary, dailySummary) || other.dailySummary == dailySummary)&&(identical(other.summaryTime, summaryTime) || other.summaryTime == summaryTime));
}


@override
int get hashCode => Object.hash(runtimeType,appointmentReminder,reminderLead,newBookings,cancellations,dailySummary,summaryTime);

@override
String toString() {
  return 'NotificationPreferences(appointmentReminder: $appointmentReminder, reminderLead: $reminderLead, newBookings: $newBookings, cancellations: $cancellations, dailySummary: $dailySummary, summaryTime: $summaryTime)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res> implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value, $Res Function(_NotificationPreferences) _then) = __$NotificationPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool appointmentReminder, ReminderLead reminderLead, bool newBookings, bool cancellations, bool dailySummary, String summaryTime
});




}
/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentReminder = null,Object? reminderLead = null,Object? newBookings = null,Object? cancellations = null,Object? dailySummary = null,Object? summaryTime = null,}) {
  return _then(_NotificationPreferences(
appointmentReminder: null == appointmentReminder ? _self.appointmentReminder : appointmentReminder // ignore: cast_nullable_to_non_nullable
as bool,reminderLead: null == reminderLead ? _self.reminderLead : reminderLead // ignore: cast_nullable_to_non_nullable
as ReminderLead,newBookings: null == newBookings ? _self.newBookings : newBookings // ignore: cast_nullable_to_non_nullable
as bool,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as bool,dailySummary: null == dailySummary ? _self.dailySummary : dailySummary // ignore: cast_nullable_to_non_nullable
as bool,summaryTime: null == summaryTime ? _self.summaryTime : summaryTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

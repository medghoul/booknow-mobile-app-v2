// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AgendaDay {

/// The day this is, as `YYYY-MM-DD` in the shop's own calendar.
 String get date;/// The zone every instant in here is read in — the shop's, never the
/// device's. Passed to `ShopClock`, not to `toLocal`.
 String get timeZone;/// No opening hours at all on this weekday.
 bool get closed;/// Closed because the owner closed it, rather than because the weekday is
/// not a working one. The strip looks the same; the empty day does not.
 bool get closure; List<AgendaOpening> get openingHours; AgendaSummary get summary; List<AgendaStripDay> get days; List<AgendaRow> get rows;/// Everyone working, by order, plus anyone removed since who still has a
/// row on this day, so every row can be labelled (providers §5).
 List<AgendaProvider> get providers;
/// Create a copy of AgendaDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaDayCopyWith<AgendaDay> get copyWith => _$AgendaDayCopyWithImpl<AgendaDay>(this as AgendaDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaDay&&(identical(other.date, date) || other.date == date)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.closure, closure) || other.closure == closure)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.days, days)&&const DeepCollectionEquality().equals(other.rows, rows)&&const DeepCollectionEquality().equals(other.providers, providers));
}


@override
int get hashCode => Object.hash(runtimeType,date,timeZone,closed,closure,const DeepCollectionEquality().hash(openingHours),summary,const DeepCollectionEquality().hash(days),const DeepCollectionEquality().hash(rows),const DeepCollectionEquality().hash(providers));

@override
String toString() {
  return 'AgendaDay(date: $date, timeZone: $timeZone, closed: $closed, closure: $closure, openingHours: $openingHours, summary: $summary, days: $days, rows: $rows, providers: $providers)';
}


}

/// @nodoc
abstract mixin class $AgendaDayCopyWith<$Res>  {
  factory $AgendaDayCopyWith(AgendaDay value, $Res Function(AgendaDay) _then) = _$AgendaDayCopyWithImpl;
@useResult
$Res call({
 String date, String timeZone, bool closed, bool closure, List<AgendaOpening> openingHours, AgendaSummary summary, List<AgendaStripDay> days, List<AgendaRow> rows, List<AgendaProvider> providers
});


$AgendaSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$AgendaDayCopyWithImpl<$Res>
    implements $AgendaDayCopyWith<$Res> {
  _$AgendaDayCopyWithImpl(this._self, this._then);

  final AgendaDay _self;
  final $Res Function(AgendaDay) _then;

/// Create a copy of AgendaDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? timeZone = null,Object? closed = null,Object? closure = null,Object? openingHours = null,Object? summary = null,Object? days = null,Object? rows = null,Object? providers = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,closure: null == closure ? _self.closure : closure // ignore: cast_nullable_to_non_nullable
as bool,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as List<AgendaOpening>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as AgendaSummary,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<AgendaStripDay>,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<AgendaRow>,providers: null == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<AgendaProvider>,
  ));
}
/// Create a copy of AgendaDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgendaSummaryCopyWith<$Res> get summary {
  
  return $AgendaSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [AgendaDay].
extension AgendaDayPatterns on AgendaDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaDay value)  $default,){
final _that = this;
switch (_that) {
case _AgendaDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaDay value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String timeZone,  bool closed,  bool closure,  List<AgendaOpening> openingHours,  AgendaSummary summary,  List<AgendaStripDay> days,  List<AgendaRow> rows,  List<AgendaProvider> providers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaDay() when $default != null:
return $default(_that.date,_that.timeZone,_that.closed,_that.closure,_that.openingHours,_that.summary,_that.days,_that.rows,_that.providers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String timeZone,  bool closed,  bool closure,  List<AgendaOpening> openingHours,  AgendaSummary summary,  List<AgendaStripDay> days,  List<AgendaRow> rows,  List<AgendaProvider> providers)  $default,) {final _that = this;
switch (_that) {
case _AgendaDay():
return $default(_that.date,_that.timeZone,_that.closed,_that.closure,_that.openingHours,_that.summary,_that.days,_that.rows,_that.providers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String timeZone,  bool closed,  bool closure,  List<AgendaOpening> openingHours,  AgendaSummary summary,  List<AgendaStripDay> days,  List<AgendaRow> rows,  List<AgendaProvider> providers)?  $default,) {final _that = this;
switch (_that) {
case _AgendaDay() when $default != null:
return $default(_that.date,_that.timeZone,_that.closed,_that.closure,_that.openingHours,_that.summary,_that.days,_that.rows,_that.providers);case _:
  return null;

}
}

}

/// @nodoc


class _AgendaDay extends AgendaDay {
  const _AgendaDay({required this.date, required this.timeZone, required this.closed, required this.closure, required final  List<AgendaOpening> openingHours, required this.summary, required final  List<AgendaStripDay> days, required final  List<AgendaRow> rows, final  List<AgendaProvider> providers = const <AgendaProvider>[]}): _openingHours = openingHours,_days = days,_rows = rows,_providers = providers,super._();
  

/// The day this is, as `YYYY-MM-DD` in the shop's own calendar.
@override final  String date;
/// The zone every instant in here is read in — the shop's, never the
/// device's. Passed to `ShopClock`, not to `toLocal`.
@override final  String timeZone;
/// No opening hours at all on this weekday.
@override final  bool closed;
/// Closed because the owner closed it, rather than because the weekday is
/// not a working one. The strip looks the same; the empty day does not.
@override final  bool closure;
 final  List<AgendaOpening> _openingHours;
@override List<AgendaOpening> get openingHours {
  if (_openingHours is EqualUnmodifiableListView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_openingHours);
}

@override final  AgendaSummary summary;
 final  List<AgendaStripDay> _days;
@override List<AgendaStripDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

 final  List<AgendaRow> _rows;
@override List<AgendaRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

/// Everyone working, by order, plus anyone removed since who still has a
/// row on this day, so every row can be labelled (providers §5).
 final  List<AgendaProvider> _providers;
/// Everyone working, by order, plus anyone removed since who still has a
/// row on this day, so every row can be labelled (providers §5).
@override@JsonKey() List<AgendaProvider> get providers {
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providers);
}


/// Create a copy of AgendaDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaDayCopyWith<_AgendaDay> get copyWith => __$AgendaDayCopyWithImpl<_AgendaDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaDay&&(identical(other.date, date) || other.date == date)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.closure, closure) || other.closure == closure)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._days, _days)&&const DeepCollectionEquality().equals(other._rows, _rows)&&const DeepCollectionEquality().equals(other._providers, _providers));
}


@override
int get hashCode => Object.hash(runtimeType,date,timeZone,closed,closure,const DeepCollectionEquality().hash(_openingHours),summary,const DeepCollectionEquality().hash(_days),const DeepCollectionEquality().hash(_rows),const DeepCollectionEquality().hash(_providers));

@override
String toString() {
  return 'AgendaDay(date: $date, timeZone: $timeZone, closed: $closed, closure: $closure, openingHours: $openingHours, summary: $summary, days: $days, rows: $rows, providers: $providers)';
}


}

/// @nodoc
abstract mixin class _$AgendaDayCopyWith<$Res> implements $AgendaDayCopyWith<$Res> {
  factory _$AgendaDayCopyWith(_AgendaDay value, $Res Function(_AgendaDay) _then) = __$AgendaDayCopyWithImpl;
@override @useResult
$Res call({
 String date, String timeZone, bool closed, bool closure, List<AgendaOpening> openingHours, AgendaSummary summary, List<AgendaStripDay> days, List<AgendaRow> rows, List<AgendaProvider> providers
});


@override $AgendaSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$AgendaDayCopyWithImpl<$Res>
    implements _$AgendaDayCopyWith<$Res> {
  __$AgendaDayCopyWithImpl(this._self, this._then);

  final _AgendaDay _self;
  final $Res Function(_AgendaDay) _then;

/// Create a copy of AgendaDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? timeZone = null,Object? closed = null,Object? closure = null,Object? openingHours = null,Object? summary = null,Object? days = null,Object? rows = null,Object? providers = null,}) {
  return _then(_AgendaDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,closure: null == closure ? _self.closure : closure // ignore: cast_nullable_to_non_nullable
as bool,openingHours: null == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as List<AgendaOpening>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as AgendaSummary,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<AgendaStripDay>,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<AgendaRow>,providers: null == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<AgendaProvider>,
  ));
}

/// Create a copy of AgendaDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgendaSummaryCopyWith<$Res> get summary {
  
  return $AgendaSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$AgendaProvider {

 String get id;/// The owner's own provider shows the shop's name until given one.
 String? get name;
/// Create a copy of AgendaProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaProviderCopyWith<AgendaProvider> get copyWith => _$AgendaProviderCopyWithImpl<AgendaProvider>(this as AgendaProvider, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'AgendaProvider(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $AgendaProviderCopyWith<$Res>  {
  factory $AgendaProviderCopyWith(AgendaProvider value, $Res Function(AgendaProvider) _then) = _$AgendaProviderCopyWithImpl;
@useResult
$Res call({
 String id, String? name
});




}
/// @nodoc
class _$AgendaProviderCopyWithImpl<$Res>
    implements $AgendaProviderCopyWith<$Res> {
  _$AgendaProviderCopyWithImpl(this._self, this._then);

  final AgendaProvider _self;
  final $Res Function(AgendaProvider) _then;

/// Create a copy of AgendaProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaProvider].
extension AgendaProviderPatterns on AgendaProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaProvider value)  $default,){
final _that = this;
switch (_that) {
case _AgendaProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaProvider value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaProvider() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name)  $default,) {final _that = this;
switch (_that) {
case _AgendaProvider():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _AgendaProvider() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _AgendaProvider implements AgendaProvider {
  const _AgendaProvider({required this.id, this.name});
  

@override final  String id;
/// The owner's own provider shows the shop's name until given one.
@override final  String? name;

/// Create a copy of AgendaProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaProviderCopyWith<_AgendaProvider> get copyWith => __$AgendaProviderCopyWithImpl<_AgendaProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'AgendaProvider(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AgendaProviderCopyWith<$Res> implements $AgendaProviderCopyWith<$Res> {
  factory _$AgendaProviderCopyWith(_AgendaProvider value, $Res Function(_AgendaProvider) _then) = __$AgendaProviderCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name
});




}
/// @nodoc
class __$AgendaProviderCopyWithImpl<$Res>
    implements _$AgendaProviderCopyWith<$Res> {
  __$AgendaProviderCopyWithImpl(this._self, this._then);

  final _AgendaProvider _self;
  final $Res Function(_AgendaProvider) _then;

/// Create a copy of AgendaProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,}) {
  return _then(_AgendaProvider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AgendaOpening {

 DateTime get fromUtc; DateTime get toUtc;
/// Create a copy of AgendaOpening
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaOpeningCopyWith<AgendaOpening> get copyWith => _$AgendaOpeningCopyWithImpl<AgendaOpening>(this as AgendaOpening, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaOpening&&(identical(other.fromUtc, fromUtc) || other.fromUtc == fromUtc)&&(identical(other.toUtc, toUtc) || other.toUtc == toUtc));
}


@override
int get hashCode => Object.hash(runtimeType,fromUtc,toUtc);

@override
String toString() {
  return 'AgendaOpening(fromUtc: $fromUtc, toUtc: $toUtc)';
}


}

/// @nodoc
abstract mixin class $AgendaOpeningCopyWith<$Res>  {
  factory $AgendaOpeningCopyWith(AgendaOpening value, $Res Function(AgendaOpening) _then) = _$AgendaOpeningCopyWithImpl;
@useResult
$Res call({
 DateTime fromUtc, DateTime toUtc
});




}
/// @nodoc
class _$AgendaOpeningCopyWithImpl<$Res>
    implements $AgendaOpeningCopyWith<$Res> {
  _$AgendaOpeningCopyWithImpl(this._self, this._then);

  final AgendaOpening _self;
  final $Res Function(AgendaOpening) _then;

/// Create a copy of AgendaOpening
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromUtc = null,Object? toUtc = null,}) {
  return _then(_self.copyWith(
fromUtc: null == fromUtc ? _self.fromUtc : fromUtc // ignore: cast_nullable_to_non_nullable
as DateTime,toUtc: null == toUtc ? _self.toUtc : toUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaOpening].
extension AgendaOpeningPatterns on AgendaOpening {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaOpening value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaOpening() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaOpening value)  $default,){
final _that = this;
switch (_that) {
case _AgendaOpening():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaOpening value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaOpening() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime fromUtc,  DateTime toUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaOpening() when $default != null:
return $default(_that.fromUtc,_that.toUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime fromUtc,  DateTime toUtc)  $default,) {final _that = this;
switch (_that) {
case _AgendaOpening():
return $default(_that.fromUtc,_that.toUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime fromUtc,  DateTime toUtc)?  $default,) {final _that = this;
switch (_that) {
case _AgendaOpening() when $default != null:
return $default(_that.fromUtc,_that.toUtc);case _:
  return null;

}
}

}

/// @nodoc


class _AgendaOpening implements AgendaOpening {
  const _AgendaOpening({required this.fromUtc, required this.toUtc});
  

@override final  DateTime fromUtc;
@override final  DateTime toUtc;

/// Create a copy of AgendaOpening
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaOpeningCopyWith<_AgendaOpening> get copyWith => __$AgendaOpeningCopyWithImpl<_AgendaOpening>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaOpening&&(identical(other.fromUtc, fromUtc) || other.fromUtc == fromUtc)&&(identical(other.toUtc, toUtc) || other.toUtc == toUtc));
}


@override
int get hashCode => Object.hash(runtimeType,fromUtc,toUtc);

@override
String toString() {
  return 'AgendaOpening(fromUtc: $fromUtc, toUtc: $toUtc)';
}


}

/// @nodoc
abstract mixin class _$AgendaOpeningCopyWith<$Res> implements $AgendaOpeningCopyWith<$Res> {
  factory _$AgendaOpeningCopyWith(_AgendaOpening value, $Res Function(_AgendaOpening) _then) = __$AgendaOpeningCopyWithImpl;
@override @useResult
$Res call({
 DateTime fromUtc, DateTime toUtc
});




}
/// @nodoc
class __$AgendaOpeningCopyWithImpl<$Res>
    implements _$AgendaOpeningCopyWith<$Res> {
  __$AgendaOpeningCopyWithImpl(this._self, this._then);

  final _AgendaOpening _self;
  final $Res Function(_AgendaOpening) _then;

/// Create a copy of AgendaOpening
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromUtc = null,Object? toUtc = null,}) {
  return _then(_AgendaOpening(
fromUtc: null == fromUtc ? _self.fromUtc : fromUtc // ignore: cast_nullable_to_non_nullable
as DateTime,toUtc: null == toUtc ? _self.toUtc : toUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$AgendaSummary {

 int get booked; int get free;/// Service money still to take in the shop. Never the €1.49 the app
/// charged — that one is BookNow's, and putting it here would overstate
/// the barber's day by it.
 int get toCollectCents;
/// Create a copy of AgendaSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaSummaryCopyWith<AgendaSummary> get copyWith => _$AgendaSummaryCopyWithImpl<AgendaSummary>(this as AgendaSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaSummary&&(identical(other.booked, booked) || other.booked == booked)&&(identical(other.free, free) || other.free == free)&&(identical(other.toCollectCents, toCollectCents) || other.toCollectCents == toCollectCents));
}


@override
int get hashCode => Object.hash(runtimeType,booked,free,toCollectCents);

@override
String toString() {
  return 'AgendaSummary(booked: $booked, free: $free, toCollectCents: $toCollectCents)';
}


}

/// @nodoc
abstract mixin class $AgendaSummaryCopyWith<$Res>  {
  factory $AgendaSummaryCopyWith(AgendaSummary value, $Res Function(AgendaSummary) _then) = _$AgendaSummaryCopyWithImpl;
@useResult
$Res call({
 int booked, int free, int toCollectCents
});




}
/// @nodoc
class _$AgendaSummaryCopyWithImpl<$Res>
    implements $AgendaSummaryCopyWith<$Res> {
  _$AgendaSummaryCopyWithImpl(this._self, this._then);

  final AgendaSummary _self;
  final $Res Function(AgendaSummary) _then;

/// Create a copy of AgendaSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booked = null,Object? free = null,Object? toCollectCents = null,}) {
  return _then(_self.copyWith(
booked: null == booked ? _self.booked : booked // ignore: cast_nullable_to_non_nullable
as int,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as int,toCollectCents: null == toCollectCents ? _self.toCollectCents : toCollectCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaSummary].
extension AgendaSummaryPatterns on AgendaSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaSummary value)  $default,){
final _that = this;
switch (_that) {
case _AgendaSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int booked,  int free,  int toCollectCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaSummary() when $default != null:
return $default(_that.booked,_that.free,_that.toCollectCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int booked,  int free,  int toCollectCents)  $default,) {final _that = this;
switch (_that) {
case _AgendaSummary():
return $default(_that.booked,_that.free,_that.toCollectCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int booked,  int free,  int toCollectCents)?  $default,) {final _that = this;
switch (_that) {
case _AgendaSummary() when $default != null:
return $default(_that.booked,_that.free,_that.toCollectCents);case _:
  return null;

}
}

}

/// @nodoc


class _AgendaSummary implements AgendaSummary {
  const _AgendaSummary({required this.booked, required this.free, required this.toCollectCents});
  

@override final  int booked;
@override final  int free;
/// Service money still to take in the shop. Never the €1.49 the app
/// charged — that one is BookNow's, and putting it here would overstate
/// the barber's day by it.
@override final  int toCollectCents;

/// Create a copy of AgendaSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaSummaryCopyWith<_AgendaSummary> get copyWith => __$AgendaSummaryCopyWithImpl<_AgendaSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaSummary&&(identical(other.booked, booked) || other.booked == booked)&&(identical(other.free, free) || other.free == free)&&(identical(other.toCollectCents, toCollectCents) || other.toCollectCents == toCollectCents));
}


@override
int get hashCode => Object.hash(runtimeType,booked,free,toCollectCents);

@override
String toString() {
  return 'AgendaSummary(booked: $booked, free: $free, toCollectCents: $toCollectCents)';
}


}

/// @nodoc
abstract mixin class _$AgendaSummaryCopyWith<$Res> implements $AgendaSummaryCopyWith<$Res> {
  factory _$AgendaSummaryCopyWith(_AgendaSummary value, $Res Function(_AgendaSummary) _then) = __$AgendaSummaryCopyWithImpl;
@override @useResult
$Res call({
 int booked, int free, int toCollectCents
});




}
/// @nodoc
class __$AgendaSummaryCopyWithImpl<$Res>
    implements _$AgendaSummaryCopyWith<$Res> {
  __$AgendaSummaryCopyWithImpl(this._self, this._then);

  final _AgendaSummary _self;
  final $Res Function(_AgendaSummary) _then;

/// Create a copy of AgendaSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booked = null,Object? free = null,Object? toCollectCents = null,}) {
  return _then(_AgendaSummary(
booked: null == booked ? _self.booked : booked // ignore: cast_nullable_to_non_nullable
as int,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as int,toCollectCents: null == toCollectCents ? _self.toCollectCents : toCollectCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$AgendaStripDay {

 String get date; int get bookings; bool get closed;
/// Create a copy of AgendaStripDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaStripDayCopyWith<AgendaStripDay> get copyWith => _$AgendaStripDayCopyWithImpl<AgendaStripDay>(this as AgendaStripDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaStripDay&&(identical(other.date, date) || other.date == date)&&(identical(other.bookings, bookings) || other.bookings == bookings)&&(identical(other.closed, closed) || other.closed == closed));
}


@override
int get hashCode => Object.hash(runtimeType,date,bookings,closed);

@override
String toString() {
  return 'AgendaStripDay(date: $date, bookings: $bookings, closed: $closed)';
}


}

/// @nodoc
abstract mixin class $AgendaStripDayCopyWith<$Res>  {
  factory $AgendaStripDayCopyWith(AgendaStripDay value, $Res Function(AgendaStripDay) _then) = _$AgendaStripDayCopyWithImpl;
@useResult
$Res call({
 String date, int bookings, bool closed
});




}
/// @nodoc
class _$AgendaStripDayCopyWithImpl<$Res>
    implements $AgendaStripDayCopyWith<$Res> {
  _$AgendaStripDayCopyWithImpl(this._self, this._then);

  final AgendaStripDay _self;
  final $Res Function(AgendaStripDay) _then;

/// Create a copy of AgendaStripDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? bookings = null,Object? closed = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as int,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaStripDay].
extension AgendaStripDayPatterns on AgendaStripDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaStripDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaStripDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaStripDay value)  $default,){
final _that = this;
switch (_that) {
case _AgendaStripDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaStripDay value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaStripDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int bookings,  bool closed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaStripDay() when $default != null:
return $default(_that.date,_that.bookings,_that.closed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int bookings,  bool closed)  $default,) {final _that = this;
switch (_that) {
case _AgendaStripDay():
return $default(_that.date,_that.bookings,_that.closed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int bookings,  bool closed)?  $default,) {final _that = this;
switch (_that) {
case _AgendaStripDay() when $default != null:
return $default(_that.date,_that.bookings,_that.closed);case _:
  return null;

}
}

}

/// @nodoc


class _AgendaStripDay implements AgendaStripDay {
  const _AgendaStripDay({required this.date, required this.bookings, required this.closed});
  

@override final  String date;
@override final  int bookings;
@override final  bool closed;

/// Create a copy of AgendaStripDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaStripDayCopyWith<_AgendaStripDay> get copyWith => __$AgendaStripDayCopyWithImpl<_AgendaStripDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaStripDay&&(identical(other.date, date) || other.date == date)&&(identical(other.bookings, bookings) || other.bookings == bookings)&&(identical(other.closed, closed) || other.closed == closed));
}


@override
int get hashCode => Object.hash(runtimeType,date,bookings,closed);

@override
String toString() {
  return 'AgendaStripDay(date: $date, bookings: $bookings, closed: $closed)';
}


}

/// @nodoc
abstract mixin class _$AgendaStripDayCopyWith<$Res> implements $AgendaStripDayCopyWith<$Res> {
  factory _$AgendaStripDayCopyWith(_AgendaStripDay value, $Res Function(_AgendaStripDay) _then) = __$AgendaStripDayCopyWithImpl;
@override @useResult
$Res call({
 String date, int bookings, bool closed
});




}
/// @nodoc
class __$AgendaStripDayCopyWithImpl<$Res>
    implements _$AgendaStripDayCopyWith<$Res> {
  __$AgendaStripDayCopyWithImpl(this._self, this._then);

  final _AgendaStripDay _self;
  final $Res Function(_AgendaStripDay) _then;

/// Create a copy of AgendaStripDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? bookings = null,Object? closed = null,}) {
  return _then(_AgendaStripDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as int,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

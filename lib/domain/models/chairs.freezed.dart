// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chairs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChairVisit {

 VisitKind get kind; String get id;/// Null for a walk-in who gave no name.
 String? get customerName; String get serviceName; int get plannedMinutes;/// A booking's time; null for someone from the line.
 DateTime? get scheduledAt; DateTime? get startedAt;/// When someone called may be marked a no-show.
 DateTime? get noShowFrom;
/// Create a copy of ChairVisit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<ChairVisit> get copyWith => _$ChairVisitCopyWithImpl<ChairVisit>(this as ChairVisit, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChairVisit&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.plannedMinutes, plannedMinutes) || other.plannedMinutes == plannedMinutes)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.noShowFrom, noShowFrom) || other.noShowFrom == noShowFrom));
}


@override
int get hashCode => Object.hash(runtimeType,kind,id,customerName,serviceName,plannedMinutes,scheduledAt,startedAt,noShowFrom);

@override
String toString() {
  return 'ChairVisit(kind: $kind, id: $id, customerName: $customerName, serviceName: $serviceName, plannedMinutes: $plannedMinutes, scheduledAt: $scheduledAt, startedAt: $startedAt, noShowFrom: $noShowFrom)';
}


}

/// @nodoc
abstract mixin class $ChairVisitCopyWith<$Res>  {
  factory $ChairVisitCopyWith(ChairVisit value, $Res Function(ChairVisit) _then) = _$ChairVisitCopyWithImpl;
@useResult
$Res call({
 VisitKind kind, String id, String? customerName, String serviceName, int plannedMinutes, DateTime? scheduledAt, DateTime? startedAt, DateTime? noShowFrom
});




}
/// @nodoc
class _$ChairVisitCopyWithImpl<$Res>
    implements $ChairVisitCopyWith<$Res> {
  _$ChairVisitCopyWithImpl(this._self, this._then);

  final ChairVisit _self;
  final $Res Function(ChairVisit) _then;

/// Create a copy of ChairVisit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? id = null,Object? customerName = freezed,Object? serviceName = null,Object? plannedMinutes = null,Object? scheduledAt = freezed,Object? startedAt = freezed,Object? noShowFrom = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as VisitKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,plannedMinutes: null == plannedMinutes ? _self.plannedMinutes : plannedMinutes // ignore: cast_nullable_to_non_nullable
as int,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChairVisit].
extension ChairVisitPatterns on ChairVisit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChairVisit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChairVisit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChairVisit value)  $default,){
final _that = this;
switch (_that) {
case _ChairVisit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChairVisit value)?  $default,){
final _that = this;
switch (_that) {
case _ChairVisit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VisitKind kind,  String id,  String? customerName,  String serviceName,  int plannedMinutes,  DateTime? scheduledAt,  DateTime? startedAt,  DateTime? noShowFrom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChairVisit() when $default != null:
return $default(_that.kind,_that.id,_that.customerName,_that.serviceName,_that.plannedMinutes,_that.scheduledAt,_that.startedAt,_that.noShowFrom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VisitKind kind,  String id,  String? customerName,  String serviceName,  int plannedMinutes,  DateTime? scheduledAt,  DateTime? startedAt,  DateTime? noShowFrom)  $default,) {final _that = this;
switch (_that) {
case _ChairVisit():
return $default(_that.kind,_that.id,_that.customerName,_that.serviceName,_that.plannedMinutes,_that.scheduledAt,_that.startedAt,_that.noShowFrom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VisitKind kind,  String id,  String? customerName,  String serviceName,  int plannedMinutes,  DateTime? scheduledAt,  DateTime? startedAt,  DateTime? noShowFrom)?  $default,) {final _that = this;
switch (_that) {
case _ChairVisit() when $default != null:
return $default(_that.kind,_that.id,_that.customerName,_that.serviceName,_that.plannedMinutes,_that.scheduledAt,_that.startedAt,_that.noShowFrom);case _:
  return null;

}
}

}

/// @nodoc


class _ChairVisit extends ChairVisit {
  const _ChairVisit({required this.kind, required this.id, required this.customerName, required this.serviceName, required this.plannedMinutes, required this.scheduledAt, required this.startedAt, required this.noShowFrom}): super._();
  

@override final  VisitKind kind;
@override final  String id;
/// Null for a walk-in who gave no name.
@override final  String? customerName;
@override final  String serviceName;
@override final  int plannedMinutes;
/// A booking's time; null for someone from the line.
@override final  DateTime? scheduledAt;
@override final  DateTime? startedAt;
/// When someone called may be marked a no-show.
@override final  DateTime? noShowFrom;

/// Create a copy of ChairVisit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChairVisitCopyWith<_ChairVisit> get copyWith => __$ChairVisitCopyWithImpl<_ChairVisit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChairVisit&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.plannedMinutes, plannedMinutes) || other.plannedMinutes == plannedMinutes)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.noShowFrom, noShowFrom) || other.noShowFrom == noShowFrom));
}


@override
int get hashCode => Object.hash(runtimeType,kind,id,customerName,serviceName,plannedMinutes,scheduledAt,startedAt,noShowFrom);

@override
String toString() {
  return 'ChairVisit(kind: $kind, id: $id, customerName: $customerName, serviceName: $serviceName, plannedMinutes: $plannedMinutes, scheduledAt: $scheduledAt, startedAt: $startedAt, noShowFrom: $noShowFrom)';
}


}

/// @nodoc
abstract mixin class _$ChairVisitCopyWith<$Res> implements $ChairVisitCopyWith<$Res> {
  factory _$ChairVisitCopyWith(_ChairVisit value, $Res Function(_ChairVisit) _then) = __$ChairVisitCopyWithImpl;
@override @useResult
$Res call({
 VisitKind kind, String id, String? customerName, String serviceName, int plannedMinutes, DateTime? scheduledAt, DateTime? startedAt, DateTime? noShowFrom
});




}
/// @nodoc
class __$ChairVisitCopyWithImpl<$Res>
    implements _$ChairVisitCopyWith<$Res> {
  __$ChairVisitCopyWithImpl(this._self, this._then);

  final _ChairVisit _self;
  final $Res Function(_ChairVisit) _then;

/// Create a copy of ChairVisit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? id = null,Object? customerName = freezed,Object? serviceName = null,Object? plannedMinutes = null,Object? scheduledAt = freezed,Object? startedAt = freezed,Object? noShowFrom = freezed,}) {
  return _then(_ChairVisit(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as VisitKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,plannedMinutes: null == plannedMinutes ? _self.plannedMinutes : plannedMinutes // ignore: cast_nullable_to_non_nullable
as int,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$Chair {

 String get providerId;/// The owner's own chair shows the shop's name until given one.
 String? get name; ChairVisit? get current; ChairVisit? get called; ChairNextAction? get nextAction; ChairVisit? get nextVisit; ChairVisit? get nextInQueue; ChairVisit? get nextBooking;
/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChairCopyWith<Chair> get copyWith => _$ChairCopyWithImpl<Chair>(this as Chair, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chair&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.current, current) || other.current == current)&&(identical(other.called, called) || other.called == called)&&(identical(other.nextAction, nextAction) || other.nextAction == nextAction)&&(identical(other.nextVisit, nextVisit) || other.nextVisit == nextVisit)&&(identical(other.nextInQueue, nextInQueue) || other.nextInQueue == nextInQueue)&&(identical(other.nextBooking, nextBooking) || other.nextBooking == nextBooking));
}


@override
int get hashCode => Object.hash(runtimeType,providerId,name,current,called,nextAction,nextVisit,nextInQueue,nextBooking);

@override
String toString() {
  return 'Chair(providerId: $providerId, name: $name, current: $current, called: $called, nextAction: $nextAction, nextVisit: $nextVisit, nextInQueue: $nextInQueue, nextBooking: $nextBooking)';
}


}

/// @nodoc
abstract mixin class $ChairCopyWith<$Res>  {
  factory $ChairCopyWith(Chair value, $Res Function(Chair) _then) = _$ChairCopyWithImpl;
@useResult
$Res call({
 String providerId, String? name, ChairVisit? current, ChairVisit? called, ChairNextAction? nextAction, ChairVisit? nextVisit, ChairVisit? nextInQueue, ChairVisit? nextBooking
});


$ChairVisitCopyWith<$Res>? get current;$ChairVisitCopyWith<$Res>? get called;$ChairVisitCopyWith<$Res>? get nextVisit;$ChairVisitCopyWith<$Res>? get nextInQueue;$ChairVisitCopyWith<$Res>? get nextBooking;

}
/// @nodoc
class _$ChairCopyWithImpl<$Res>
    implements $ChairCopyWith<$Res> {
  _$ChairCopyWithImpl(this._self, this._then);

  final Chair _self;
  final $Res Function(Chair) _then;

/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providerId = null,Object? name = freezed,Object? current = freezed,Object? called = freezed,Object? nextAction = freezed,Object? nextVisit = freezed,Object? nextInQueue = freezed,Object? nextBooking = freezed,}) {
  return _then(_self.copyWith(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as ChairVisit?,called: freezed == called ? _self.called : called // ignore: cast_nullable_to_non_nullable
as ChairVisit?,nextAction: freezed == nextAction ? _self.nextAction : nextAction // ignore: cast_nullable_to_non_nullable
as ChairNextAction?,nextVisit: freezed == nextVisit ? _self.nextVisit : nextVisit // ignore: cast_nullable_to_non_nullable
as ChairVisit?,nextInQueue: freezed == nextInQueue ? _self.nextInQueue : nextInQueue // ignore: cast_nullable_to_non_nullable
as ChairVisit?,nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as ChairVisit?,
  ));
}
/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get current {
    if (_self.current == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.current!, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get called {
    if (_self.called == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.called!, (value) {
    return _then(_self.copyWith(called: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get nextVisit {
    if (_self.nextVisit == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.nextVisit!, (value) {
    return _then(_self.copyWith(nextVisit: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get nextInQueue {
    if (_self.nextInQueue == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.nextInQueue!, (value) {
    return _then(_self.copyWith(nextInQueue: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get nextBooking {
    if (_self.nextBooking == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.nextBooking!, (value) {
    return _then(_self.copyWith(nextBooking: value));
  });
}
}


/// Adds pattern-matching-related methods to [Chair].
extension ChairPatterns on Chair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chair value)  $default,){
final _that = this;
switch (_that) {
case _Chair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chair value)?  $default,){
final _that = this;
switch (_that) {
case _Chair() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String providerId,  String? name,  ChairVisit? current,  ChairVisit? called,  ChairNextAction? nextAction,  ChairVisit? nextVisit,  ChairVisit? nextInQueue,  ChairVisit? nextBooking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chair() when $default != null:
return $default(_that.providerId,_that.name,_that.current,_that.called,_that.nextAction,_that.nextVisit,_that.nextInQueue,_that.nextBooking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String providerId,  String? name,  ChairVisit? current,  ChairVisit? called,  ChairNextAction? nextAction,  ChairVisit? nextVisit,  ChairVisit? nextInQueue,  ChairVisit? nextBooking)  $default,) {final _that = this;
switch (_that) {
case _Chair():
return $default(_that.providerId,_that.name,_that.current,_that.called,_that.nextAction,_that.nextVisit,_that.nextInQueue,_that.nextBooking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String providerId,  String? name,  ChairVisit? current,  ChairVisit? called,  ChairNextAction? nextAction,  ChairVisit? nextVisit,  ChairVisit? nextInQueue,  ChairVisit? nextBooking)?  $default,) {final _that = this;
switch (_that) {
case _Chair() when $default != null:
return $default(_that.providerId,_that.name,_that.current,_that.called,_that.nextAction,_that.nextVisit,_that.nextInQueue,_that.nextBooking);case _:
  return null;

}
}

}

/// @nodoc


class _Chair implements Chair {
  const _Chair({required this.providerId, required this.name, required this.current, required this.called, required this.nextAction, required this.nextVisit, required this.nextInQueue, required this.nextBooking});
  

@override final  String providerId;
/// The owner's own chair shows the shop's name until given one.
@override final  String? name;
@override final  ChairVisit? current;
@override final  ChairVisit? called;
@override final  ChairNextAction? nextAction;
@override final  ChairVisit? nextVisit;
@override final  ChairVisit? nextInQueue;
@override final  ChairVisit? nextBooking;

/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChairCopyWith<_Chair> get copyWith => __$ChairCopyWithImpl<_Chair>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chair&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.current, current) || other.current == current)&&(identical(other.called, called) || other.called == called)&&(identical(other.nextAction, nextAction) || other.nextAction == nextAction)&&(identical(other.nextVisit, nextVisit) || other.nextVisit == nextVisit)&&(identical(other.nextInQueue, nextInQueue) || other.nextInQueue == nextInQueue)&&(identical(other.nextBooking, nextBooking) || other.nextBooking == nextBooking));
}


@override
int get hashCode => Object.hash(runtimeType,providerId,name,current,called,nextAction,nextVisit,nextInQueue,nextBooking);

@override
String toString() {
  return 'Chair(providerId: $providerId, name: $name, current: $current, called: $called, nextAction: $nextAction, nextVisit: $nextVisit, nextInQueue: $nextInQueue, nextBooking: $nextBooking)';
}


}

/// @nodoc
abstract mixin class _$ChairCopyWith<$Res> implements $ChairCopyWith<$Res> {
  factory _$ChairCopyWith(_Chair value, $Res Function(_Chair) _then) = __$ChairCopyWithImpl;
@override @useResult
$Res call({
 String providerId, String? name, ChairVisit? current, ChairVisit? called, ChairNextAction? nextAction, ChairVisit? nextVisit, ChairVisit? nextInQueue, ChairVisit? nextBooking
});


@override $ChairVisitCopyWith<$Res>? get current;@override $ChairVisitCopyWith<$Res>? get called;@override $ChairVisitCopyWith<$Res>? get nextVisit;@override $ChairVisitCopyWith<$Res>? get nextInQueue;@override $ChairVisitCopyWith<$Res>? get nextBooking;

}
/// @nodoc
class __$ChairCopyWithImpl<$Res>
    implements _$ChairCopyWith<$Res> {
  __$ChairCopyWithImpl(this._self, this._then);

  final _Chair _self;
  final $Res Function(_Chair) _then;

/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? name = freezed,Object? current = freezed,Object? called = freezed,Object? nextAction = freezed,Object? nextVisit = freezed,Object? nextInQueue = freezed,Object? nextBooking = freezed,}) {
  return _then(_Chair(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as ChairVisit?,called: freezed == called ? _self.called : called // ignore: cast_nullable_to_non_nullable
as ChairVisit?,nextAction: freezed == nextAction ? _self.nextAction : nextAction // ignore: cast_nullable_to_non_nullable
as ChairNextAction?,nextVisit: freezed == nextVisit ? _self.nextVisit : nextVisit // ignore: cast_nullable_to_non_nullable
as ChairVisit?,nextInQueue: freezed == nextInQueue ? _self.nextInQueue : nextInQueue // ignore: cast_nullable_to_non_nullable
as ChairVisit?,nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as ChairVisit?,
  ));
}

/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get current {
    if (_self.current == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.current!, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get called {
    if (_self.called == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.called!, (value) {
    return _then(_self.copyWith(called: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get nextVisit {
    if (_self.nextVisit == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.nextVisit!, (value) {
    return _then(_self.copyWith(nextVisit: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get nextInQueue {
    if (_self.nextInQueue == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.nextInQueue!, (value) {
    return _then(_self.copyWith(nextInQueue: value));
  });
}/// Create a copy of Chair
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChairVisitCopyWith<$Res>? get nextBooking {
    if (_self.nextBooking == null) {
    return null;
  }

  return $ChairVisitCopyWith<$Res>(_self.nextBooking!, (value) {
    return _then(_self.copyWith(nextBooking: value));
  });
}
}

/// @nodoc
mixin _$ChairBoard {

 String get localDate;/// The shop's zone, which every time on the board is shown in.
 String get timeZone; List<Chair> get chairs;
/// Create a copy of ChairBoard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChairBoardCopyWith<ChairBoard> get copyWith => _$ChairBoardCopyWithImpl<ChairBoard>(this as ChairBoard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChairBoard&&(identical(other.localDate, localDate) || other.localDate == localDate)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&const DeepCollectionEquality().equals(other.chairs, chairs));
}


@override
int get hashCode => Object.hash(runtimeType,localDate,timeZone,const DeepCollectionEquality().hash(chairs));

@override
String toString() {
  return 'ChairBoard(localDate: $localDate, timeZone: $timeZone, chairs: $chairs)';
}


}

/// @nodoc
abstract mixin class $ChairBoardCopyWith<$Res>  {
  factory $ChairBoardCopyWith(ChairBoard value, $Res Function(ChairBoard) _then) = _$ChairBoardCopyWithImpl;
@useResult
$Res call({
 String localDate, String timeZone, List<Chair> chairs
});




}
/// @nodoc
class _$ChairBoardCopyWithImpl<$Res>
    implements $ChairBoardCopyWith<$Res> {
  _$ChairBoardCopyWithImpl(this._self, this._then);

  final ChairBoard _self;
  final $Res Function(ChairBoard) _then;

/// Create a copy of ChairBoard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localDate = null,Object? timeZone = null,Object? chairs = null,}) {
  return _then(_self.copyWith(
localDate: null == localDate ? _self.localDate : localDate // ignore: cast_nullable_to_non_nullable
as String,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,chairs: null == chairs ? _self.chairs : chairs // ignore: cast_nullable_to_non_nullable
as List<Chair>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChairBoard].
extension ChairBoardPatterns on ChairBoard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChairBoard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChairBoard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChairBoard value)  $default,){
final _that = this;
switch (_that) {
case _ChairBoard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChairBoard value)?  $default,){
final _that = this;
switch (_that) {
case _ChairBoard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localDate,  String timeZone,  List<Chair> chairs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChairBoard() when $default != null:
return $default(_that.localDate,_that.timeZone,_that.chairs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localDate,  String timeZone,  List<Chair> chairs)  $default,) {final _that = this;
switch (_that) {
case _ChairBoard():
return $default(_that.localDate,_that.timeZone,_that.chairs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localDate,  String timeZone,  List<Chair> chairs)?  $default,) {final _that = this;
switch (_that) {
case _ChairBoard() when $default != null:
return $default(_that.localDate,_that.timeZone,_that.chairs);case _:
  return null;

}
}

}

/// @nodoc


class _ChairBoard implements ChairBoard {
  const _ChairBoard({required this.localDate, required this.timeZone, required final  List<Chair> chairs}): _chairs = chairs;
  

@override final  String localDate;
/// The shop's zone, which every time on the board is shown in.
@override final  String timeZone;
 final  List<Chair> _chairs;
@override List<Chair> get chairs {
  if (_chairs is EqualUnmodifiableListView) return _chairs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chairs);
}


/// Create a copy of ChairBoard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChairBoardCopyWith<_ChairBoard> get copyWith => __$ChairBoardCopyWithImpl<_ChairBoard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChairBoard&&(identical(other.localDate, localDate) || other.localDate == localDate)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&const DeepCollectionEquality().equals(other._chairs, _chairs));
}


@override
int get hashCode => Object.hash(runtimeType,localDate,timeZone,const DeepCollectionEquality().hash(_chairs));

@override
String toString() {
  return 'ChairBoard(localDate: $localDate, timeZone: $timeZone, chairs: $chairs)';
}


}

/// @nodoc
abstract mixin class _$ChairBoardCopyWith<$Res> implements $ChairBoardCopyWith<$Res> {
  factory _$ChairBoardCopyWith(_ChairBoard value, $Res Function(_ChairBoard) _then) = __$ChairBoardCopyWithImpl;
@override @useResult
$Res call({
 String localDate, String timeZone, List<Chair> chairs
});




}
/// @nodoc
class __$ChairBoardCopyWithImpl<$Res>
    implements _$ChairBoardCopyWith<$Res> {
  __$ChairBoardCopyWithImpl(this._self, this._then);

  final _ChairBoard _self;
  final $Res Function(_ChairBoard) _then;

/// Create a copy of ChairBoard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localDate = null,Object? timeZone = null,Object? chairs = null,}) {
  return _then(_ChairBoard(
localDate: null == localDate ? _self.localDate : localDate // ignore: cast_nullable_to_non_nullable
as String,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,chairs: null == chairs ? _self._chairs : chairs // ignore: cast_nullable_to_non_nullable
as List<Chair>,
  ));
}


}

// dart format on

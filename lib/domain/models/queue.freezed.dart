// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WaitRange {

 int get fromMin; int get toMin;
/// Create a copy of WaitRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<WaitRange> get copyWith => _$WaitRangeCopyWithImpl<WaitRange>(this as WaitRange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitRange&&(identical(other.fromMin, fromMin) || other.fromMin == fromMin)&&(identical(other.toMin, toMin) || other.toMin == toMin));
}


@override
int get hashCode => Object.hash(runtimeType,fromMin,toMin);

@override
String toString() {
  return 'WaitRange(fromMin: $fromMin, toMin: $toMin)';
}


}

/// @nodoc
abstract mixin class $WaitRangeCopyWith<$Res>  {
  factory $WaitRangeCopyWith(WaitRange value, $Res Function(WaitRange) _then) = _$WaitRangeCopyWithImpl;
@useResult
$Res call({
 int fromMin, int toMin
});




}
/// @nodoc
class _$WaitRangeCopyWithImpl<$Res>
    implements $WaitRangeCopyWith<$Res> {
  _$WaitRangeCopyWithImpl(this._self, this._then);

  final WaitRange _self;
  final $Res Function(WaitRange) _then;

/// Create a copy of WaitRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromMin = null,Object? toMin = null,}) {
  return _then(_self.copyWith(
fromMin: null == fromMin ? _self.fromMin : fromMin // ignore: cast_nullable_to_non_nullable
as int,toMin: null == toMin ? _self.toMin : toMin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitRange].
extension WaitRangePatterns on WaitRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaitRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaitRange value)  $default,){
final _that = this;
switch (_that) {
case _WaitRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaitRange value)?  $default,){
final _that = this;
switch (_that) {
case _WaitRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fromMin,  int toMin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitRange() when $default != null:
return $default(_that.fromMin,_that.toMin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fromMin,  int toMin)  $default,) {final _that = this;
switch (_that) {
case _WaitRange():
return $default(_that.fromMin,_that.toMin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fromMin,  int toMin)?  $default,) {final _that = this;
switch (_that) {
case _WaitRange() when $default != null:
return $default(_that.fromMin,_that.toMin);case _:
  return null;

}
}

}

/// @nodoc


class _WaitRange implements WaitRange {
  const _WaitRange({required this.fromMin, required this.toMin});
  

@override final  int fromMin;
@override final  int toMin;

/// Create a copy of WaitRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitRangeCopyWith<_WaitRange> get copyWith => __$WaitRangeCopyWithImpl<_WaitRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitRange&&(identical(other.fromMin, fromMin) || other.fromMin == fromMin)&&(identical(other.toMin, toMin) || other.toMin == toMin));
}


@override
int get hashCode => Object.hash(runtimeType,fromMin,toMin);

@override
String toString() {
  return 'WaitRange(fromMin: $fromMin, toMin: $toMin)';
}


}

/// @nodoc
abstract mixin class _$WaitRangeCopyWith<$Res> implements $WaitRangeCopyWith<$Res> {
  factory _$WaitRangeCopyWith(_WaitRange value, $Res Function(_WaitRange) _then) = __$WaitRangeCopyWithImpl;
@override @useResult
$Res call({
 int fromMin, int toMin
});




}
/// @nodoc
class __$WaitRangeCopyWithImpl<$Res>
    implements _$WaitRangeCopyWith<$Res> {
  __$WaitRangeCopyWithImpl(this._self, this._then);

  final _WaitRange _self;
  final $Res Function(_WaitRange) _then;

/// Create a copy of WaitRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromMin = null,Object? toMin = null,}) {
  return _then(_WaitRange(
fromMin: null == fromMin ? _self.fromMin : fromMin // ignore: cast_nullable_to_non_nullable
as int,toMin: null == toMin ? _self.toMin : toMin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$QueueEntry {

 String get id; String get shopId; String? get shopName; QueueEntryStatus get status; String get serviceId; String get serviceName; int get durationMinutes;/// Paid in the shop.
 int get priceCents;/// The BookNow fee paid to join.
 int? get feeCents;/// 1 is next. Set only while waiting; the person in the chair is not
/// counted.
 int? get position; int? get aheadCount; WaitRange? get estimate;/// Whether leaving now gives the fee back — the server's verdict, shown
/// before the customer taps rather than after (queue spec §8).
 bool get refundIfLeaving; DateTime? get holdExpiresAt; DateTime? get calledAt;/// When the owner may mark a no-show: ten minutes after the call.
 DateTime? get noShowFrom; bool get refunded;
/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<QueueEntry> get copyWith => _$QueueEntryCopyWithImpl<QueueEntry>(this as QueueEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.status, status) || other.status == status)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.position, position) || other.position == position)&&(identical(other.aheadCount, aheadCount) || other.aheadCount == aheadCount)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.refundIfLeaving, refundIfLeaving) || other.refundIfLeaving == refundIfLeaving)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.calledAt, calledAt) || other.calledAt == calledAt)&&(identical(other.noShowFrom, noShowFrom) || other.noShowFrom == noShowFrom)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopId,shopName,status,serviceId,serviceName,durationMinutes,priceCents,feeCents,position,aheadCount,estimate,refundIfLeaving,holdExpiresAt,calledAt,noShowFrom,refunded);

@override
String toString() {
  return 'QueueEntry(id: $id, shopId: $shopId, shopName: $shopName, status: $status, serviceId: $serviceId, serviceName: $serviceName, durationMinutes: $durationMinutes, priceCents: $priceCents, feeCents: $feeCents, position: $position, aheadCount: $aheadCount, estimate: $estimate, refundIfLeaving: $refundIfLeaving, holdExpiresAt: $holdExpiresAt, calledAt: $calledAt, noShowFrom: $noShowFrom, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class $QueueEntryCopyWith<$Res>  {
  factory $QueueEntryCopyWith(QueueEntry value, $Res Function(QueueEntry) _then) = _$QueueEntryCopyWithImpl;
@useResult
$Res call({
 String id, String shopId, String? shopName, QueueEntryStatus status, String serviceId, String serviceName, int durationMinutes, int priceCents, int? feeCents, int? position, int? aheadCount, WaitRange? estimate, bool refundIfLeaving, DateTime? holdExpiresAt, DateTime? calledAt, DateTime? noShowFrom, bool refunded
});


$WaitRangeCopyWith<$Res>? get estimate;

}
/// @nodoc
class _$QueueEntryCopyWithImpl<$Res>
    implements $QueueEntryCopyWith<$Res> {
  _$QueueEntryCopyWithImpl(this._self, this._then);

  final QueueEntry _self;
  final $Res Function(QueueEntry) _then;

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopId = null,Object? shopName = freezed,Object? status = null,Object? serviceId = null,Object? serviceName = null,Object? durationMinutes = null,Object? priceCents = null,Object? feeCents = freezed,Object? position = freezed,Object? aheadCount = freezed,Object? estimate = freezed,Object? refundIfLeaving = null,Object? holdExpiresAt = freezed,Object? calledAt = freezed,Object? noShowFrom = freezed,Object? refunded = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueEntryStatus,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,feeCents: freezed == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,aheadCount: freezed == aheadCount ? _self.aheadCount : aheadCount // ignore: cast_nullable_to_non_nullable
as int?,estimate: freezed == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as WaitRange?,refundIfLeaving: null == refundIfLeaving ? _self.refundIfLeaving : refundIfLeaving // ignore: cast_nullable_to_non_nullable
as bool,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,calledAt: freezed == calledAt ? _self.calledAt : calledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<$Res>? get estimate {
    if (_self.estimate == null) {
    return null;
  }

  return $WaitRangeCopyWith<$Res>(_self.estimate!, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueEntry].
extension QueueEntryPatterns on QueueEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueEntry value)  $default,){
final _that = this;
switch (_that) {
case _QueueEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueEntry value)?  $default,){
final _that = this;
switch (_that) {
case _QueueEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String shopId,  String? shopName,  QueueEntryStatus status,  String serviceId,  String serviceName,  int durationMinutes,  int priceCents,  int? feeCents,  int? position,  int? aheadCount,  WaitRange? estimate,  bool refundIfLeaving,  DateTime? holdExpiresAt,  DateTime? calledAt,  DateTime? noShowFrom,  bool refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueEntry() when $default != null:
return $default(_that.id,_that.shopId,_that.shopName,_that.status,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.priceCents,_that.feeCents,_that.position,_that.aheadCount,_that.estimate,_that.refundIfLeaving,_that.holdExpiresAt,_that.calledAt,_that.noShowFrom,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String shopId,  String? shopName,  QueueEntryStatus status,  String serviceId,  String serviceName,  int durationMinutes,  int priceCents,  int? feeCents,  int? position,  int? aheadCount,  WaitRange? estimate,  bool refundIfLeaving,  DateTime? holdExpiresAt,  DateTime? calledAt,  DateTime? noShowFrom,  bool refunded)  $default,) {final _that = this;
switch (_that) {
case _QueueEntry():
return $default(_that.id,_that.shopId,_that.shopName,_that.status,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.priceCents,_that.feeCents,_that.position,_that.aheadCount,_that.estimate,_that.refundIfLeaving,_that.holdExpiresAt,_that.calledAt,_that.noShowFrom,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String shopId,  String? shopName,  QueueEntryStatus status,  String serviceId,  String serviceName,  int durationMinutes,  int priceCents,  int? feeCents,  int? position,  int? aheadCount,  WaitRange? estimate,  bool refundIfLeaving,  DateTime? holdExpiresAt,  DateTime? calledAt,  DateTime? noShowFrom,  bool refunded)?  $default,) {final _that = this;
switch (_that) {
case _QueueEntry() when $default != null:
return $default(_that.id,_that.shopId,_that.shopName,_that.status,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.priceCents,_that.feeCents,_that.position,_that.aheadCount,_that.estimate,_that.refundIfLeaving,_that.holdExpiresAt,_that.calledAt,_that.noShowFrom,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc


class _QueueEntry implements QueueEntry {
  const _QueueEntry({required this.id, required this.shopId, required this.shopName, required this.status, required this.serviceId, required this.serviceName, required this.durationMinutes, required this.priceCents, required this.feeCents, required this.position, required this.aheadCount, required this.estimate, required this.refundIfLeaving, required this.holdExpiresAt, required this.calledAt, required this.noShowFrom, required this.refunded});
  

@override final  String id;
@override final  String shopId;
@override final  String? shopName;
@override final  QueueEntryStatus status;
@override final  String serviceId;
@override final  String serviceName;
@override final  int durationMinutes;
/// Paid in the shop.
@override final  int priceCents;
/// The BookNow fee paid to join.
@override final  int? feeCents;
/// 1 is next. Set only while waiting; the person in the chair is not
/// counted.
@override final  int? position;
@override final  int? aheadCount;
@override final  WaitRange? estimate;
/// Whether leaving now gives the fee back — the server's verdict, shown
/// before the customer taps rather than after (queue spec §8).
@override final  bool refundIfLeaving;
@override final  DateTime? holdExpiresAt;
@override final  DateTime? calledAt;
/// When the owner may mark a no-show: ten minutes after the call.
@override final  DateTime? noShowFrom;
@override final  bool refunded;

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueEntryCopyWith<_QueueEntry> get copyWith => __$QueueEntryCopyWithImpl<_QueueEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.status, status) || other.status == status)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.position, position) || other.position == position)&&(identical(other.aheadCount, aheadCount) || other.aheadCount == aheadCount)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.refundIfLeaving, refundIfLeaving) || other.refundIfLeaving == refundIfLeaving)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.calledAt, calledAt) || other.calledAt == calledAt)&&(identical(other.noShowFrom, noShowFrom) || other.noShowFrom == noShowFrom)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopId,shopName,status,serviceId,serviceName,durationMinutes,priceCents,feeCents,position,aheadCount,estimate,refundIfLeaving,holdExpiresAt,calledAt,noShowFrom,refunded);

@override
String toString() {
  return 'QueueEntry(id: $id, shopId: $shopId, shopName: $shopName, status: $status, serviceId: $serviceId, serviceName: $serviceName, durationMinutes: $durationMinutes, priceCents: $priceCents, feeCents: $feeCents, position: $position, aheadCount: $aheadCount, estimate: $estimate, refundIfLeaving: $refundIfLeaving, holdExpiresAt: $holdExpiresAt, calledAt: $calledAt, noShowFrom: $noShowFrom, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$QueueEntryCopyWith<$Res> implements $QueueEntryCopyWith<$Res> {
  factory _$QueueEntryCopyWith(_QueueEntry value, $Res Function(_QueueEntry) _then) = __$QueueEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String shopId, String? shopName, QueueEntryStatus status, String serviceId, String serviceName, int durationMinutes, int priceCents, int? feeCents, int? position, int? aheadCount, WaitRange? estimate, bool refundIfLeaving, DateTime? holdExpiresAt, DateTime? calledAt, DateTime? noShowFrom, bool refunded
});


@override $WaitRangeCopyWith<$Res>? get estimate;

}
/// @nodoc
class __$QueueEntryCopyWithImpl<$Res>
    implements _$QueueEntryCopyWith<$Res> {
  __$QueueEntryCopyWithImpl(this._self, this._then);

  final _QueueEntry _self;
  final $Res Function(_QueueEntry) _then;

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopId = null,Object? shopName = freezed,Object? status = null,Object? serviceId = null,Object? serviceName = null,Object? durationMinutes = null,Object? priceCents = null,Object? feeCents = freezed,Object? position = freezed,Object? aheadCount = freezed,Object? estimate = freezed,Object? refundIfLeaving = null,Object? holdExpiresAt = freezed,Object? calledAt = freezed,Object? noShowFrom = freezed,Object? refunded = null,}) {
  return _then(_QueueEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueEntryStatus,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,feeCents: freezed == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,aheadCount: freezed == aheadCount ? _self.aheadCount : aheadCount // ignore: cast_nullable_to_non_nullable
as int?,estimate: freezed == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as WaitRange?,refundIfLeaving: null == refundIfLeaving ? _self.refundIfLeaving : refundIfLeaving // ignore: cast_nullable_to_non_nullable
as bool,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,calledAt: freezed == calledAt ? _self.calledAt : calledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<$Res>? get estimate {
    if (_self.estimate == null) {
    return null;
  }

  return $WaitRangeCopyWith<$Res>(_self.estimate!, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}
}

/// @nodoc
mixin _$ShopQueue {

 String get shopId; QueueState get state;/// Null while the queue is taking people.
 QueueClosedReason? get closedReason;/// People waiting, not counting the one in the chair.
 int get waitingCount; bool get inChair;/// For someone joining now.
 WaitRange get estimate; int get feeCents;/// The caller's own place, when they are already in this queue.
 QueueEntry? get myEntry;
/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopQueueCopyWith<ShopQueue> get copyWith => _$ShopQueueCopyWithImpl<ShopQueue>(this as ShopQueue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopQueue&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.state, state) || other.state == state)&&(identical(other.closedReason, closedReason) || other.closedReason == closedReason)&&(identical(other.waitingCount, waitingCount) || other.waitingCount == waitingCount)&&(identical(other.inChair, inChair) || other.inChair == inChair)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.myEntry, myEntry) || other.myEntry == myEntry));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,state,closedReason,waitingCount,inChair,estimate,feeCents,myEntry);

@override
String toString() {
  return 'ShopQueue(shopId: $shopId, state: $state, closedReason: $closedReason, waitingCount: $waitingCount, inChair: $inChair, estimate: $estimate, feeCents: $feeCents, myEntry: $myEntry)';
}


}

/// @nodoc
abstract mixin class $ShopQueueCopyWith<$Res>  {
  factory $ShopQueueCopyWith(ShopQueue value, $Res Function(ShopQueue) _then) = _$ShopQueueCopyWithImpl;
@useResult
$Res call({
 String shopId, QueueState state, QueueClosedReason? closedReason, int waitingCount, bool inChair, WaitRange estimate, int feeCents, QueueEntry? myEntry
});


$WaitRangeCopyWith<$Res> get estimate;$QueueEntryCopyWith<$Res>? get myEntry;

}
/// @nodoc
class _$ShopQueueCopyWithImpl<$Res>
    implements $ShopQueueCopyWith<$Res> {
  _$ShopQueueCopyWithImpl(this._self, this._then);

  final ShopQueue _self;
  final $Res Function(ShopQueue) _then;

/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? state = null,Object? closedReason = freezed,Object? waitingCount = null,Object? inChair = null,Object? estimate = null,Object? feeCents = null,Object? myEntry = freezed,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as QueueState,closedReason: freezed == closedReason ? _self.closedReason : closedReason // ignore: cast_nullable_to_non_nullable
as QueueClosedReason?,waitingCount: null == waitingCount ? _self.waitingCount : waitingCount // ignore: cast_nullable_to_non_nullable
as int,inChair: null == inChair ? _self.inChair : inChair // ignore: cast_nullable_to_non_nullable
as bool,estimate: null == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as WaitRange,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,myEntry: freezed == myEntry ? _self.myEntry : myEntry // ignore: cast_nullable_to_non_nullable
as QueueEntry?,
  ));
}
/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<$Res> get estimate {
  
  return $WaitRangeCopyWith<$Res>(_self.estimate, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res>? get myEntry {
    if (_self.myEntry == null) {
    return null;
  }

  return $QueueEntryCopyWith<$Res>(_self.myEntry!, (value) {
    return _then(_self.copyWith(myEntry: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShopQueue].
extension ShopQueuePatterns on ShopQueue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopQueue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopQueue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopQueue value)  $default,){
final _that = this;
switch (_that) {
case _ShopQueue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopQueue value)?  $default,){
final _that = this;
switch (_that) {
case _ShopQueue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  QueueState state,  QueueClosedReason? closedReason,  int waitingCount,  bool inChair,  WaitRange estimate,  int feeCents,  QueueEntry? myEntry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopQueue() when $default != null:
return $default(_that.shopId,_that.state,_that.closedReason,_that.waitingCount,_that.inChair,_that.estimate,_that.feeCents,_that.myEntry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  QueueState state,  QueueClosedReason? closedReason,  int waitingCount,  bool inChair,  WaitRange estimate,  int feeCents,  QueueEntry? myEntry)  $default,) {final _that = this;
switch (_that) {
case _ShopQueue():
return $default(_that.shopId,_that.state,_that.closedReason,_that.waitingCount,_that.inChair,_that.estimate,_that.feeCents,_that.myEntry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  QueueState state,  QueueClosedReason? closedReason,  int waitingCount,  bool inChair,  WaitRange estimate,  int feeCents,  QueueEntry? myEntry)?  $default,) {final _that = this;
switch (_that) {
case _ShopQueue() when $default != null:
return $default(_that.shopId,_that.state,_that.closedReason,_that.waitingCount,_that.inChair,_that.estimate,_that.feeCents,_that.myEntry);case _:
  return null;

}
}

}

/// @nodoc


class _ShopQueue extends ShopQueue {
  const _ShopQueue({required this.shopId, required this.state, required this.closedReason, required this.waitingCount, required this.inChair, required this.estimate, required this.feeCents, required this.myEntry}): super._();
  

@override final  String shopId;
@override final  QueueState state;
/// Null while the queue is taking people.
@override final  QueueClosedReason? closedReason;
/// People waiting, not counting the one in the chair.
@override final  int waitingCount;
@override final  bool inChair;
/// For someone joining now.
@override final  WaitRange estimate;
@override final  int feeCents;
/// The caller's own place, when they are already in this queue.
@override final  QueueEntry? myEntry;

/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopQueueCopyWith<_ShopQueue> get copyWith => __$ShopQueueCopyWithImpl<_ShopQueue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopQueue&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.state, state) || other.state == state)&&(identical(other.closedReason, closedReason) || other.closedReason == closedReason)&&(identical(other.waitingCount, waitingCount) || other.waitingCount == waitingCount)&&(identical(other.inChair, inChair) || other.inChair == inChair)&&(identical(other.estimate, estimate) || other.estimate == estimate)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.myEntry, myEntry) || other.myEntry == myEntry));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,state,closedReason,waitingCount,inChair,estimate,feeCents,myEntry);

@override
String toString() {
  return 'ShopQueue(shopId: $shopId, state: $state, closedReason: $closedReason, waitingCount: $waitingCount, inChair: $inChair, estimate: $estimate, feeCents: $feeCents, myEntry: $myEntry)';
}


}

/// @nodoc
abstract mixin class _$ShopQueueCopyWith<$Res> implements $ShopQueueCopyWith<$Res> {
  factory _$ShopQueueCopyWith(_ShopQueue value, $Res Function(_ShopQueue) _then) = __$ShopQueueCopyWithImpl;
@override @useResult
$Res call({
 String shopId, QueueState state, QueueClosedReason? closedReason, int waitingCount, bool inChair, WaitRange estimate, int feeCents, QueueEntry? myEntry
});


@override $WaitRangeCopyWith<$Res> get estimate;@override $QueueEntryCopyWith<$Res>? get myEntry;

}
/// @nodoc
class __$ShopQueueCopyWithImpl<$Res>
    implements _$ShopQueueCopyWith<$Res> {
  __$ShopQueueCopyWithImpl(this._self, this._then);

  final _ShopQueue _self;
  final $Res Function(_ShopQueue) _then;

/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? state = null,Object? closedReason = freezed,Object? waitingCount = null,Object? inChair = null,Object? estimate = null,Object? feeCents = null,Object? myEntry = freezed,}) {
  return _then(_ShopQueue(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as QueueState,closedReason: freezed == closedReason ? _self.closedReason : closedReason // ignore: cast_nullable_to_non_nullable
as QueueClosedReason?,waitingCount: null == waitingCount ? _self.waitingCount : waitingCount // ignore: cast_nullable_to_non_nullable
as int,inChair: null == inChair ? _self.inChair : inChair // ignore: cast_nullable_to_non_nullable
as bool,estimate: null == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as WaitRange,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,myEntry: freezed == myEntry ? _self.myEntry : myEntry // ignore: cast_nullable_to_non_nullable
as QueueEntry?,
  ));
}

/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<$Res> get estimate {
  
  return $WaitRangeCopyWith<$Res>(_self.estimate, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}/// Create a copy of ShopQueue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res>? get myEntry {
    if (_self.myEntry == null) {
    return null;
  }

  return $QueueEntryCopyWith<$Res>(_self.myEntry!, (value) {
    return _then(_self.copyWith(myEntry: value));
  });
}
}

/// @nodoc
mixin _$QueueJoin {

 QueueEntry get entry; String get clientSecret; DateTime get holdExpiresAt; int get feeCents; WaitRange get estimate;
/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueJoinCopyWith<QueueJoin> get copyWith => _$QueueJoinCopyWithImpl<QueueJoin>(this as QueueJoin, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueJoin&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.estimate, estimate) || other.estimate == estimate));
}


@override
int get hashCode => Object.hash(runtimeType,entry,clientSecret,holdExpiresAt,feeCents,estimate);

@override
String toString() {
  return 'QueueJoin(entry: $entry, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeCents: $feeCents, estimate: $estimate)';
}


}

/// @nodoc
abstract mixin class $QueueJoinCopyWith<$Res>  {
  factory $QueueJoinCopyWith(QueueJoin value, $Res Function(QueueJoin) _then) = _$QueueJoinCopyWithImpl;
@useResult
$Res call({
 QueueEntry entry, String clientSecret, DateTime holdExpiresAt, int feeCents, WaitRange estimate
});


$QueueEntryCopyWith<$Res> get entry;$WaitRangeCopyWith<$Res> get estimate;

}
/// @nodoc
class _$QueueJoinCopyWithImpl<$Res>
    implements $QueueJoinCopyWith<$Res> {
  _$QueueJoinCopyWithImpl(this._self, this._then);

  final QueueJoin _self;
  final $Res Function(QueueJoin) _then;

/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = null,Object? clientSecret = null,Object? holdExpiresAt = null,Object? feeCents = null,Object? estimate = null,}) {
  return _then(_self.copyWith(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as QueueEntry,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,holdExpiresAt: null == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,estimate: null == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as WaitRange,
  ));
}
/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res> get entry {
  
  return $QueueEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<$Res> get estimate {
  
  return $WaitRangeCopyWith<$Res>(_self.estimate, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueJoin].
extension QueueJoinPatterns on QueueJoin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueJoin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueJoin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueJoin value)  $default,){
final _that = this;
switch (_that) {
case _QueueJoin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueJoin value)?  $default,){
final _that = this;
switch (_that) {
case _QueueJoin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QueueEntry entry,  String clientSecret,  DateTime holdExpiresAt,  int feeCents,  WaitRange estimate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueJoin() when $default != null:
return $default(_that.entry,_that.clientSecret,_that.holdExpiresAt,_that.feeCents,_that.estimate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QueueEntry entry,  String clientSecret,  DateTime holdExpiresAt,  int feeCents,  WaitRange estimate)  $default,) {final _that = this;
switch (_that) {
case _QueueJoin():
return $default(_that.entry,_that.clientSecret,_that.holdExpiresAt,_that.feeCents,_that.estimate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QueueEntry entry,  String clientSecret,  DateTime holdExpiresAt,  int feeCents,  WaitRange estimate)?  $default,) {final _that = this;
switch (_that) {
case _QueueJoin() when $default != null:
return $default(_that.entry,_that.clientSecret,_that.holdExpiresAt,_that.feeCents,_that.estimate);case _:
  return null;

}
}

}

/// @nodoc


class _QueueJoin implements QueueJoin {
  const _QueueJoin({required this.entry, required this.clientSecret, required this.holdExpiresAt, required this.feeCents, required this.estimate});
  

@override final  QueueEntry entry;
@override final  String clientSecret;
@override final  DateTime holdExpiresAt;
@override final  int feeCents;
@override final  WaitRange estimate;

/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueJoinCopyWith<_QueueJoin> get copyWith => __$QueueJoinCopyWithImpl<_QueueJoin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueJoin&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.estimate, estimate) || other.estimate == estimate));
}


@override
int get hashCode => Object.hash(runtimeType,entry,clientSecret,holdExpiresAt,feeCents,estimate);

@override
String toString() {
  return 'QueueJoin(entry: $entry, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeCents: $feeCents, estimate: $estimate)';
}


}

/// @nodoc
abstract mixin class _$QueueJoinCopyWith<$Res> implements $QueueJoinCopyWith<$Res> {
  factory _$QueueJoinCopyWith(_QueueJoin value, $Res Function(_QueueJoin) _then) = __$QueueJoinCopyWithImpl;
@override @useResult
$Res call({
 QueueEntry entry, String clientSecret, DateTime holdExpiresAt, int feeCents, WaitRange estimate
});


@override $QueueEntryCopyWith<$Res> get entry;@override $WaitRangeCopyWith<$Res> get estimate;

}
/// @nodoc
class __$QueueJoinCopyWithImpl<$Res>
    implements _$QueueJoinCopyWith<$Res> {
  __$QueueJoinCopyWithImpl(this._self, this._then);

  final _QueueJoin _self;
  final $Res Function(_QueueJoin) _then;

/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = null,Object? clientSecret = null,Object? holdExpiresAt = null,Object? feeCents = null,Object? estimate = null,}) {
  return _then(_QueueJoin(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as QueueEntry,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,holdExpiresAt: null == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,estimate: null == estimate ? _self.estimate : estimate // ignore: cast_nullable_to_non_nullable
as WaitRange,
  ));
}

/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res> get entry {
  
  return $QueueEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}/// Create a copy of QueueJoin
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitRangeCopyWith<$Res> get estimate {
  
  return $WaitRangeCopyWith<$Res>(_self.estimate, (value) {
    return _then(_self.copyWith(estimate: value));
  });
}
}

/// @nodoc
mixin _$OwnerQueueEntry {

 String get id; QueueEntryStatus get status; QueueEntryKind get kind;/// Null for a walk-in who gave no name: the screen says "Walk-in".
 String? get customerName; String get serviceId; String get serviceName; int get durationMinutes; DateTime? get joinedAt; DateTime? get calledAt; DateTime? get startedAt; DateTime? get noShowFrom;
/// Create a copy of OwnerQueueEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerQueueEntryCopyWith<OwnerQueueEntry> get copyWith => _$OwnerQueueEntryCopyWithImpl<OwnerQueueEntry>(this as OwnerQueueEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerQueueEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.calledAt, calledAt) || other.calledAt == calledAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.noShowFrom, noShowFrom) || other.noShowFrom == noShowFrom));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,kind,customerName,serviceId,serviceName,durationMinutes,joinedAt,calledAt,startedAt,noShowFrom);

@override
String toString() {
  return 'OwnerQueueEntry(id: $id, status: $status, kind: $kind, customerName: $customerName, serviceId: $serviceId, serviceName: $serviceName, durationMinutes: $durationMinutes, joinedAt: $joinedAt, calledAt: $calledAt, startedAt: $startedAt, noShowFrom: $noShowFrom)';
}


}

/// @nodoc
abstract mixin class $OwnerQueueEntryCopyWith<$Res>  {
  factory $OwnerQueueEntryCopyWith(OwnerQueueEntry value, $Res Function(OwnerQueueEntry) _then) = _$OwnerQueueEntryCopyWithImpl;
@useResult
$Res call({
 String id, QueueEntryStatus status, QueueEntryKind kind, String? customerName, String serviceId, String serviceName, int durationMinutes, DateTime? joinedAt, DateTime? calledAt, DateTime? startedAt, DateTime? noShowFrom
});




}
/// @nodoc
class _$OwnerQueueEntryCopyWithImpl<$Res>
    implements $OwnerQueueEntryCopyWith<$Res> {
  _$OwnerQueueEntryCopyWithImpl(this._self, this._then);

  final OwnerQueueEntry _self;
  final $Res Function(OwnerQueueEntry) _then;

/// Create a copy of OwnerQueueEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? kind = null,Object? customerName = freezed,Object? serviceId = null,Object? serviceName = null,Object? durationMinutes = null,Object? joinedAt = freezed,Object? calledAt = freezed,Object? startedAt = freezed,Object? noShowFrom = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueEntryStatus,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as QueueEntryKind,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,calledAt: freezed == calledAt ? _self.calledAt : calledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerQueueEntry].
extension OwnerQueueEntryPatterns on OwnerQueueEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerQueueEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerQueueEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerQueueEntry value)  $default,){
final _that = this;
switch (_that) {
case _OwnerQueueEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerQueueEntry value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerQueueEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  QueueEntryStatus status,  QueueEntryKind kind,  String? customerName,  String serviceId,  String serviceName,  int durationMinutes,  DateTime? joinedAt,  DateTime? calledAt,  DateTime? startedAt,  DateTime? noShowFrom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerQueueEntry() when $default != null:
return $default(_that.id,_that.status,_that.kind,_that.customerName,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.joinedAt,_that.calledAt,_that.startedAt,_that.noShowFrom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  QueueEntryStatus status,  QueueEntryKind kind,  String? customerName,  String serviceId,  String serviceName,  int durationMinutes,  DateTime? joinedAt,  DateTime? calledAt,  DateTime? startedAt,  DateTime? noShowFrom)  $default,) {final _that = this;
switch (_that) {
case _OwnerQueueEntry():
return $default(_that.id,_that.status,_that.kind,_that.customerName,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.joinedAt,_that.calledAt,_that.startedAt,_that.noShowFrom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  QueueEntryStatus status,  QueueEntryKind kind,  String? customerName,  String serviceId,  String serviceName,  int durationMinutes,  DateTime? joinedAt,  DateTime? calledAt,  DateTime? startedAt,  DateTime? noShowFrom)?  $default,) {final _that = this;
switch (_that) {
case _OwnerQueueEntry() when $default != null:
return $default(_that.id,_that.status,_that.kind,_that.customerName,_that.serviceId,_that.serviceName,_that.durationMinutes,_that.joinedAt,_that.calledAt,_that.startedAt,_that.noShowFrom);case _:
  return null;

}
}

}

/// @nodoc


class _OwnerQueueEntry implements OwnerQueueEntry {
  const _OwnerQueueEntry({required this.id, required this.status, required this.kind, required this.customerName, required this.serviceId, required this.serviceName, required this.durationMinutes, required this.joinedAt, required this.calledAt, required this.startedAt, required this.noShowFrom});
  

@override final  String id;
@override final  QueueEntryStatus status;
@override final  QueueEntryKind kind;
/// Null for a walk-in who gave no name: the screen says "Walk-in".
@override final  String? customerName;
@override final  String serviceId;
@override final  String serviceName;
@override final  int durationMinutes;
@override final  DateTime? joinedAt;
@override final  DateTime? calledAt;
@override final  DateTime? startedAt;
@override final  DateTime? noShowFrom;

/// Create a copy of OwnerQueueEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerQueueEntryCopyWith<_OwnerQueueEntry> get copyWith => __$OwnerQueueEntryCopyWithImpl<_OwnerQueueEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerQueueEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.calledAt, calledAt) || other.calledAt == calledAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.noShowFrom, noShowFrom) || other.noShowFrom == noShowFrom));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,kind,customerName,serviceId,serviceName,durationMinutes,joinedAt,calledAt,startedAt,noShowFrom);

@override
String toString() {
  return 'OwnerQueueEntry(id: $id, status: $status, kind: $kind, customerName: $customerName, serviceId: $serviceId, serviceName: $serviceName, durationMinutes: $durationMinutes, joinedAt: $joinedAt, calledAt: $calledAt, startedAt: $startedAt, noShowFrom: $noShowFrom)';
}


}

/// @nodoc
abstract mixin class _$OwnerQueueEntryCopyWith<$Res> implements $OwnerQueueEntryCopyWith<$Res> {
  factory _$OwnerQueueEntryCopyWith(_OwnerQueueEntry value, $Res Function(_OwnerQueueEntry) _then) = __$OwnerQueueEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, QueueEntryStatus status, QueueEntryKind kind, String? customerName, String serviceId, String serviceName, int durationMinutes, DateTime? joinedAt, DateTime? calledAt, DateTime? startedAt, DateTime? noShowFrom
});




}
/// @nodoc
class __$OwnerQueueEntryCopyWithImpl<$Res>
    implements _$OwnerQueueEntryCopyWith<$Res> {
  __$OwnerQueueEntryCopyWithImpl(this._self, this._then);

  final _OwnerQueueEntry _self;
  final $Res Function(_OwnerQueueEntry) _then;

/// Create a copy of OwnerQueueEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? kind = null,Object? customerName = freezed,Object? serviceId = null,Object? serviceName = null,Object? durationMinutes = null,Object? joinedAt = freezed,Object? calledAt = freezed,Object? startedAt = freezed,Object? noShowFrom = freezed,}) {
  return _then(_OwnerQueueEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueEntryStatus,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as QueueEntryKind,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,calledAt: freezed == calledAt ? _self.calledAt : calledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$OwnerQueue {

/// `yyyy-MM-dd` in the shop's own calendar.
 String get localDate; QueueState get state; int get waitingCount;/// When the line is estimated to be empty; null when it already is.
 DateTime? get emptiesAt;/// In serving order: in the chair, called, then waiting.
 List<OwnerQueueEntry> get entries;
/// Create a copy of OwnerQueue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerQueueCopyWith<OwnerQueue> get copyWith => _$OwnerQueueCopyWithImpl<OwnerQueue>(this as OwnerQueue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerQueue&&(identical(other.localDate, localDate) || other.localDate == localDate)&&(identical(other.state, state) || other.state == state)&&(identical(other.waitingCount, waitingCount) || other.waitingCount == waitingCount)&&(identical(other.emptiesAt, emptiesAt) || other.emptiesAt == emptiesAt)&&const DeepCollectionEquality().equals(other.entries, entries));
}


@override
int get hashCode => Object.hash(runtimeType,localDate,state,waitingCount,emptiesAt,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'OwnerQueue(localDate: $localDate, state: $state, waitingCount: $waitingCount, emptiesAt: $emptiesAt, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $OwnerQueueCopyWith<$Res>  {
  factory $OwnerQueueCopyWith(OwnerQueue value, $Res Function(OwnerQueue) _then) = _$OwnerQueueCopyWithImpl;
@useResult
$Res call({
 String localDate, QueueState state, int waitingCount, DateTime? emptiesAt, List<OwnerQueueEntry> entries
});




}
/// @nodoc
class _$OwnerQueueCopyWithImpl<$Res>
    implements $OwnerQueueCopyWith<$Res> {
  _$OwnerQueueCopyWithImpl(this._self, this._then);

  final OwnerQueue _self;
  final $Res Function(OwnerQueue) _then;

/// Create a copy of OwnerQueue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localDate = null,Object? state = null,Object? waitingCount = null,Object? emptiesAt = freezed,Object? entries = null,}) {
  return _then(_self.copyWith(
localDate: null == localDate ? _self.localDate : localDate // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as QueueState,waitingCount: null == waitingCount ? _self.waitingCount : waitingCount // ignore: cast_nullable_to_non_nullable
as int,emptiesAt: freezed == emptiesAt ? _self.emptiesAt : emptiesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<OwnerQueueEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerQueue].
extension OwnerQueuePatterns on OwnerQueue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerQueue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerQueue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerQueue value)  $default,){
final _that = this;
switch (_that) {
case _OwnerQueue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerQueue value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerQueue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localDate,  QueueState state,  int waitingCount,  DateTime? emptiesAt,  List<OwnerQueueEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerQueue() when $default != null:
return $default(_that.localDate,_that.state,_that.waitingCount,_that.emptiesAt,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localDate,  QueueState state,  int waitingCount,  DateTime? emptiesAt,  List<OwnerQueueEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _OwnerQueue():
return $default(_that.localDate,_that.state,_that.waitingCount,_that.emptiesAt,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localDate,  QueueState state,  int waitingCount,  DateTime? emptiesAt,  List<OwnerQueueEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _OwnerQueue() when $default != null:
return $default(_that.localDate,_that.state,_that.waitingCount,_that.emptiesAt,_that.entries);case _:
  return null;

}
}

}

/// @nodoc


class _OwnerQueue extends OwnerQueue {
  const _OwnerQueue({required this.localDate, required this.state, required this.waitingCount, required this.emptiesAt, required final  List<OwnerQueueEntry> entries}): _entries = entries,super._();
  

/// `yyyy-MM-dd` in the shop's own calendar.
@override final  String localDate;
@override final  QueueState state;
@override final  int waitingCount;
/// When the line is estimated to be empty; null when it already is.
@override final  DateTime? emptiesAt;
/// In serving order: in the chair, called, then waiting.
 final  List<OwnerQueueEntry> _entries;
/// In serving order: in the chair, called, then waiting.
@override List<OwnerQueueEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of OwnerQueue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerQueueCopyWith<_OwnerQueue> get copyWith => __$OwnerQueueCopyWithImpl<_OwnerQueue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerQueue&&(identical(other.localDate, localDate) || other.localDate == localDate)&&(identical(other.state, state) || other.state == state)&&(identical(other.waitingCount, waitingCount) || other.waitingCount == waitingCount)&&(identical(other.emptiesAt, emptiesAt) || other.emptiesAt == emptiesAt)&&const DeepCollectionEquality().equals(other._entries, _entries));
}


@override
int get hashCode => Object.hash(runtimeType,localDate,state,waitingCount,emptiesAt,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'OwnerQueue(localDate: $localDate, state: $state, waitingCount: $waitingCount, emptiesAt: $emptiesAt, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$OwnerQueueCopyWith<$Res> implements $OwnerQueueCopyWith<$Res> {
  factory _$OwnerQueueCopyWith(_OwnerQueue value, $Res Function(_OwnerQueue) _then) = __$OwnerQueueCopyWithImpl;
@override @useResult
$Res call({
 String localDate, QueueState state, int waitingCount, DateTime? emptiesAt, List<OwnerQueueEntry> entries
});




}
/// @nodoc
class __$OwnerQueueCopyWithImpl<$Res>
    implements _$OwnerQueueCopyWith<$Res> {
  __$OwnerQueueCopyWithImpl(this._self, this._then);

  final _OwnerQueue _self;
  final $Res Function(_OwnerQueue) _then;

/// Create a copy of OwnerQueue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localDate = null,Object? state = null,Object? waitingCount = null,Object? emptiesAt = freezed,Object? entries = null,}) {
  return _then(_OwnerQueue(
localDate: null == localDate ? _self.localDate : localDate // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as QueueState,waitingCount: null == waitingCount ? _self.waitingCount : waitingCount // ignore: cast_nullable_to_non_nullable
as int,emptiesAt: freezed == emptiesAt ? _self.emptiesAt : emptiesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<OwnerQueueEntry>,
  ));
}


}

// dart format on

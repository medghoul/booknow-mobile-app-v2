// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueEntryDto {

@JsonKey(name: 'entryId') Object? get entryId;@JsonKey(name: 'shopId') Object? get shopId;@JsonKey(name: 'shopName') Object? get shopName;@JsonKey(name: 'status') Object? get status;@JsonKey(name: 'serviceId') Object? get serviceId;@JsonKey(name: 'serviceName') Object? get serviceName;@JsonKey(name: 'durationMin') Object? get durationMin;@JsonKey(name: 'priceCents') Object? get priceCents;@JsonKey(name: 'feeAmountCents') Object? get feeAmountCents;@JsonKey(name: 'position') Object? get position;@JsonKey(name: 'aheadCount') Object? get aheadCount;@JsonKey(name: 'estimate') Object? get estimate;@JsonKey(name: 'refundIfLeaving') Object? get refundIfLeaving;@JsonKey(name: 'holdExpiresAt') Object? get holdExpiresAt;@JsonKey(name: 'calledAt') Object? get calledAt;@JsonKey(name: 'noShowFrom') Object? get noShowFrom;@JsonKey(name: 'refunded') Object? get refunded;
/// Create a copy of QueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueEntryDtoCopyWith<QueueEntryDto> get copyWith => _$QueueEntryDtoCopyWithImpl<QueueEntryDto>(this as QueueEntryDto, _$identity);

  /// Serializes this QueueEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueEntryDto&&const DeepCollectionEquality().equals(other.entryId, entryId)&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.shopName, shopName)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.position, position)&&const DeepCollectionEquality().equals(other.aheadCount, aheadCount)&&const DeepCollectionEquality().equals(other.estimate, estimate)&&const DeepCollectionEquality().equals(other.refundIfLeaving, refundIfLeaving)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.calledAt, calledAt)&&const DeepCollectionEquality().equals(other.noShowFrom, noShowFrom)&&const DeepCollectionEquality().equals(other.refunded, refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entryId),const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(shopName),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(position),const DeepCollectionEquality().hash(aheadCount),const DeepCollectionEquality().hash(estimate),const DeepCollectionEquality().hash(refundIfLeaving),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(calledAt),const DeepCollectionEquality().hash(noShowFrom),const DeepCollectionEquality().hash(refunded));

@override
String toString() {
  return 'QueueEntryDto(entryId: $entryId, shopId: $shopId, shopName: $shopName, status: $status, serviceId: $serviceId, serviceName: $serviceName, durationMin: $durationMin, priceCents: $priceCents, feeAmountCents: $feeAmountCents, position: $position, aheadCount: $aheadCount, estimate: $estimate, refundIfLeaving: $refundIfLeaving, holdExpiresAt: $holdExpiresAt, calledAt: $calledAt, noShowFrom: $noShowFrom, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class $QueueEntryDtoCopyWith<$Res>  {
  factory $QueueEntryDtoCopyWith(QueueEntryDto value, $Res Function(QueueEntryDto) _then) = _$QueueEntryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'entryId') Object? entryId,@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'shopName') Object? shopName,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'position') Object? position,@JsonKey(name: 'aheadCount') Object? aheadCount,@JsonKey(name: 'estimate') Object? estimate,@JsonKey(name: 'refundIfLeaving') Object? refundIfLeaving,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'calledAt') Object? calledAt,@JsonKey(name: 'noShowFrom') Object? noShowFrom,@JsonKey(name: 'refunded') Object? refunded
});




}
/// @nodoc
class _$QueueEntryDtoCopyWithImpl<$Res>
    implements $QueueEntryDtoCopyWith<$Res> {
  _$QueueEntryDtoCopyWithImpl(this._self, this._then);

  final QueueEntryDto _self;
  final $Res Function(QueueEntryDto) _then;

/// Create a copy of QueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = freezed,Object? shopId = freezed,Object? shopName = freezed,Object? status = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? durationMin = freezed,Object? priceCents = freezed,Object? feeAmountCents = freezed,Object? position = freezed,Object? aheadCount = freezed,Object? estimate = freezed,Object? refundIfLeaving = freezed,Object? holdExpiresAt = freezed,Object? calledAt = freezed,Object? noShowFrom = freezed,Object? refunded = freezed,}) {
  return _then(_self.copyWith(
entryId: freezed == entryId ? _self.entryId : entryId ,shopId: freezed == shopId ? _self.shopId : shopId ,shopName: freezed == shopName ? _self.shopName : shopName ,status: freezed == status ? _self.status : status ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,position: freezed == position ? _self.position : position ,aheadCount: freezed == aheadCount ? _self.aheadCount : aheadCount ,estimate: freezed == estimate ? _self.estimate : estimate ,refundIfLeaving: freezed == refundIfLeaving ? _self.refundIfLeaving : refundIfLeaving ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,calledAt: freezed == calledAt ? _self.calledAt : calledAt ,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom ,refunded: freezed == refunded ? _self.refunded : refunded ,
  ));
}

}


/// Adds pattern-matching-related methods to [QueueEntryDto].
extension QueueEntryDtoPatterns on QueueEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _QueueEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _QueueEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'entryId')  Object? entryId, @JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'position')  Object? position, @JsonKey(name: 'aheadCount')  Object? aheadCount, @JsonKey(name: 'estimate')  Object? estimate, @JsonKey(name: 'refundIfLeaving')  Object? refundIfLeaving, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'calledAt')  Object? calledAt, @JsonKey(name: 'noShowFrom')  Object? noShowFrom, @JsonKey(name: 'refunded')  Object? refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueEntryDto() when $default != null:
return $default(_that.entryId,_that.shopId,_that.shopName,_that.status,_that.serviceId,_that.serviceName,_that.durationMin,_that.priceCents,_that.feeAmountCents,_that.position,_that.aheadCount,_that.estimate,_that.refundIfLeaving,_that.holdExpiresAt,_that.calledAt,_that.noShowFrom,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'entryId')  Object? entryId, @JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'position')  Object? position, @JsonKey(name: 'aheadCount')  Object? aheadCount, @JsonKey(name: 'estimate')  Object? estimate, @JsonKey(name: 'refundIfLeaving')  Object? refundIfLeaving, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'calledAt')  Object? calledAt, @JsonKey(name: 'noShowFrom')  Object? noShowFrom, @JsonKey(name: 'refunded')  Object? refunded)  $default,) {final _that = this;
switch (_that) {
case _QueueEntryDto():
return $default(_that.entryId,_that.shopId,_that.shopName,_that.status,_that.serviceId,_that.serviceName,_that.durationMin,_that.priceCents,_that.feeAmountCents,_that.position,_that.aheadCount,_that.estimate,_that.refundIfLeaving,_that.holdExpiresAt,_that.calledAt,_that.noShowFrom,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'entryId')  Object? entryId, @JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'position')  Object? position, @JsonKey(name: 'aheadCount')  Object? aheadCount, @JsonKey(name: 'estimate')  Object? estimate, @JsonKey(name: 'refundIfLeaving')  Object? refundIfLeaving, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'calledAt')  Object? calledAt, @JsonKey(name: 'noShowFrom')  Object? noShowFrom, @JsonKey(name: 'refunded')  Object? refunded)?  $default,) {final _that = this;
switch (_that) {
case _QueueEntryDto() when $default != null:
return $default(_that.entryId,_that.shopId,_that.shopName,_that.status,_that.serviceId,_that.serviceName,_that.durationMin,_that.priceCents,_that.feeAmountCents,_that.position,_that.aheadCount,_that.estimate,_that.refundIfLeaving,_that.holdExpiresAt,_that.calledAt,_that.noShowFrom,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueEntryDto extends QueueEntryDto {
  const _QueueEntryDto({@JsonKey(name: 'entryId') this.entryId, @JsonKey(name: 'shopId') this.shopId, @JsonKey(name: 'shopName') this.shopName, @JsonKey(name: 'status') this.status, @JsonKey(name: 'serviceId') this.serviceId, @JsonKey(name: 'serviceName') this.serviceName, @JsonKey(name: 'durationMin') this.durationMin, @JsonKey(name: 'priceCents') this.priceCents, @JsonKey(name: 'feeAmountCents') this.feeAmountCents, @JsonKey(name: 'position') this.position, @JsonKey(name: 'aheadCount') this.aheadCount, @JsonKey(name: 'estimate') this.estimate, @JsonKey(name: 'refundIfLeaving') this.refundIfLeaving, @JsonKey(name: 'holdExpiresAt') this.holdExpiresAt, @JsonKey(name: 'calledAt') this.calledAt, @JsonKey(name: 'noShowFrom') this.noShowFrom, @JsonKey(name: 'refunded') this.refunded}): super._();
  factory _QueueEntryDto.fromJson(Map<String, dynamic> json) => _$QueueEntryDtoFromJson(json);

@override@JsonKey(name: 'entryId') final  Object? entryId;
@override@JsonKey(name: 'shopId') final  Object? shopId;
@override@JsonKey(name: 'shopName') final  Object? shopName;
@override@JsonKey(name: 'status') final  Object? status;
@override@JsonKey(name: 'serviceId') final  Object? serviceId;
@override@JsonKey(name: 'serviceName') final  Object? serviceName;
@override@JsonKey(name: 'durationMin') final  Object? durationMin;
@override@JsonKey(name: 'priceCents') final  Object? priceCents;
@override@JsonKey(name: 'feeAmountCents') final  Object? feeAmountCents;
@override@JsonKey(name: 'position') final  Object? position;
@override@JsonKey(name: 'aheadCount') final  Object? aheadCount;
@override@JsonKey(name: 'estimate') final  Object? estimate;
@override@JsonKey(name: 'refundIfLeaving') final  Object? refundIfLeaving;
@override@JsonKey(name: 'holdExpiresAt') final  Object? holdExpiresAt;
@override@JsonKey(name: 'calledAt') final  Object? calledAt;
@override@JsonKey(name: 'noShowFrom') final  Object? noShowFrom;
@override@JsonKey(name: 'refunded') final  Object? refunded;

/// Create a copy of QueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueEntryDtoCopyWith<_QueueEntryDto> get copyWith => __$QueueEntryDtoCopyWithImpl<_QueueEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueEntryDto&&const DeepCollectionEquality().equals(other.entryId, entryId)&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.shopName, shopName)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.position, position)&&const DeepCollectionEquality().equals(other.aheadCount, aheadCount)&&const DeepCollectionEquality().equals(other.estimate, estimate)&&const DeepCollectionEquality().equals(other.refundIfLeaving, refundIfLeaving)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.calledAt, calledAt)&&const DeepCollectionEquality().equals(other.noShowFrom, noShowFrom)&&const DeepCollectionEquality().equals(other.refunded, refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entryId),const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(shopName),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(position),const DeepCollectionEquality().hash(aheadCount),const DeepCollectionEquality().hash(estimate),const DeepCollectionEquality().hash(refundIfLeaving),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(calledAt),const DeepCollectionEquality().hash(noShowFrom),const DeepCollectionEquality().hash(refunded));

@override
String toString() {
  return 'QueueEntryDto(entryId: $entryId, shopId: $shopId, shopName: $shopName, status: $status, serviceId: $serviceId, serviceName: $serviceName, durationMin: $durationMin, priceCents: $priceCents, feeAmountCents: $feeAmountCents, position: $position, aheadCount: $aheadCount, estimate: $estimate, refundIfLeaving: $refundIfLeaving, holdExpiresAt: $holdExpiresAt, calledAt: $calledAt, noShowFrom: $noShowFrom, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$QueueEntryDtoCopyWith<$Res> implements $QueueEntryDtoCopyWith<$Res> {
  factory _$QueueEntryDtoCopyWith(_QueueEntryDto value, $Res Function(_QueueEntryDto) _then) = __$QueueEntryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'entryId') Object? entryId,@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'shopName') Object? shopName,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'position') Object? position,@JsonKey(name: 'aheadCount') Object? aheadCount,@JsonKey(name: 'estimate') Object? estimate,@JsonKey(name: 'refundIfLeaving') Object? refundIfLeaving,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'calledAt') Object? calledAt,@JsonKey(name: 'noShowFrom') Object? noShowFrom,@JsonKey(name: 'refunded') Object? refunded
});




}
/// @nodoc
class __$QueueEntryDtoCopyWithImpl<$Res>
    implements _$QueueEntryDtoCopyWith<$Res> {
  __$QueueEntryDtoCopyWithImpl(this._self, this._then);

  final _QueueEntryDto _self;
  final $Res Function(_QueueEntryDto) _then;

/// Create a copy of QueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = freezed,Object? shopId = freezed,Object? shopName = freezed,Object? status = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? durationMin = freezed,Object? priceCents = freezed,Object? feeAmountCents = freezed,Object? position = freezed,Object? aheadCount = freezed,Object? estimate = freezed,Object? refundIfLeaving = freezed,Object? holdExpiresAt = freezed,Object? calledAt = freezed,Object? noShowFrom = freezed,Object? refunded = freezed,}) {
  return _then(_QueueEntryDto(
entryId: freezed == entryId ? _self.entryId : entryId ,shopId: freezed == shopId ? _self.shopId : shopId ,shopName: freezed == shopName ? _self.shopName : shopName ,status: freezed == status ? _self.status : status ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,position: freezed == position ? _self.position : position ,aheadCount: freezed == aheadCount ? _self.aheadCount : aheadCount ,estimate: freezed == estimate ? _self.estimate : estimate ,refundIfLeaving: freezed == refundIfLeaving ? _self.refundIfLeaving : refundIfLeaving ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,calledAt: freezed == calledAt ? _self.calledAt : calledAt ,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom ,refunded: freezed == refunded ? _self.refunded : refunded ,
  ));
}


}


/// @nodoc
mixin _$ShopQueueDto {

@JsonKey(name: 'shopId') Object? get shopId;@JsonKey(name: 'state') Object? get state;@JsonKey(name: 'notAccepting') Object? get notAccepting;@JsonKey(name: 'waitingCount') Object? get waitingCount;@JsonKey(name: 'inChair') Object? get inChair;@JsonKey(name: 'estimate') Object? get estimate;@JsonKey(name: 'feeAmountCents') Object? get feeAmountCents;@JsonKey(name: 'myEntry') Object? get myEntry;
/// Create a copy of ShopQueueDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopQueueDtoCopyWith<ShopQueueDto> get copyWith => _$ShopQueueDtoCopyWithImpl<ShopQueueDto>(this as ShopQueueDto, _$identity);

  /// Serializes this ShopQueueDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopQueueDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.state, state)&&const DeepCollectionEquality().equals(other.notAccepting, notAccepting)&&const DeepCollectionEquality().equals(other.waitingCount, waitingCount)&&const DeepCollectionEquality().equals(other.inChair, inChair)&&const DeepCollectionEquality().equals(other.estimate, estimate)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.myEntry, myEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(state),const DeepCollectionEquality().hash(notAccepting),const DeepCollectionEquality().hash(waitingCount),const DeepCollectionEquality().hash(inChair),const DeepCollectionEquality().hash(estimate),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(myEntry));

@override
String toString() {
  return 'ShopQueueDto(shopId: $shopId, state: $state, notAccepting: $notAccepting, waitingCount: $waitingCount, inChair: $inChair, estimate: $estimate, feeAmountCents: $feeAmountCents, myEntry: $myEntry)';
}


}

/// @nodoc
abstract mixin class $ShopQueueDtoCopyWith<$Res>  {
  factory $ShopQueueDtoCopyWith(ShopQueueDto value, $Res Function(ShopQueueDto) _then) = _$ShopQueueDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'state') Object? state,@JsonKey(name: 'notAccepting') Object? notAccepting,@JsonKey(name: 'waitingCount') Object? waitingCount,@JsonKey(name: 'inChair') Object? inChair,@JsonKey(name: 'estimate') Object? estimate,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'myEntry') Object? myEntry
});




}
/// @nodoc
class _$ShopQueueDtoCopyWithImpl<$Res>
    implements $ShopQueueDtoCopyWith<$Res> {
  _$ShopQueueDtoCopyWithImpl(this._self, this._then);

  final ShopQueueDto _self;
  final $Res Function(ShopQueueDto) _then;

/// Create a copy of ShopQueueDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = freezed,Object? state = freezed,Object? notAccepting = freezed,Object? waitingCount = freezed,Object? inChair = freezed,Object? estimate = freezed,Object? feeAmountCents = freezed,Object? myEntry = freezed,}) {
  return _then(_self.copyWith(
shopId: freezed == shopId ? _self.shopId : shopId ,state: freezed == state ? _self.state : state ,notAccepting: freezed == notAccepting ? _self.notAccepting : notAccepting ,waitingCount: freezed == waitingCount ? _self.waitingCount : waitingCount ,inChair: freezed == inChair ? _self.inChair : inChair ,estimate: freezed == estimate ? _self.estimate : estimate ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,myEntry: freezed == myEntry ? _self.myEntry : myEntry ,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopQueueDto].
extension ShopQueueDtoPatterns on ShopQueueDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopQueueDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopQueueDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopQueueDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopQueueDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopQueueDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopQueueDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'state')  Object? state, @JsonKey(name: 'notAccepting')  Object? notAccepting, @JsonKey(name: 'waitingCount')  Object? waitingCount, @JsonKey(name: 'inChair')  Object? inChair, @JsonKey(name: 'estimate')  Object? estimate, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'myEntry')  Object? myEntry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopQueueDto() when $default != null:
return $default(_that.shopId,_that.state,_that.notAccepting,_that.waitingCount,_that.inChair,_that.estimate,_that.feeAmountCents,_that.myEntry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'state')  Object? state, @JsonKey(name: 'notAccepting')  Object? notAccepting, @JsonKey(name: 'waitingCount')  Object? waitingCount, @JsonKey(name: 'inChair')  Object? inChair, @JsonKey(name: 'estimate')  Object? estimate, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'myEntry')  Object? myEntry)  $default,) {final _that = this;
switch (_that) {
case _ShopQueueDto():
return $default(_that.shopId,_that.state,_that.notAccepting,_that.waitingCount,_that.inChair,_that.estimate,_that.feeAmountCents,_that.myEntry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'state')  Object? state, @JsonKey(name: 'notAccepting')  Object? notAccepting, @JsonKey(name: 'waitingCount')  Object? waitingCount, @JsonKey(name: 'inChair')  Object? inChair, @JsonKey(name: 'estimate')  Object? estimate, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'myEntry')  Object? myEntry)?  $default,) {final _that = this;
switch (_that) {
case _ShopQueueDto() when $default != null:
return $default(_that.shopId,_that.state,_that.notAccepting,_that.waitingCount,_that.inChair,_that.estimate,_that.feeAmountCents,_that.myEntry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopQueueDto extends ShopQueueDto {
  const _ShopQueueDto({@JsonKey(name: 'shopId') this.shopId, @JsonKey(name: 'state') this.state, @JsonKey(name: 'notAccepting') this.notAccepting, @JsonKey(name: 'waitingCount') this.waitingCount, @JsonKey(name: 'inChair') this.inChair, @JsonKey(name: 'estimate') this.estimate, @JsonKey(name: 'feeAmountCents') this.feeAmountCents, @JsonKey(name: 'myEntry') this.myEntry}): super._();
  factory _ShopQueueDto.fromJson(Map<String, dynamic> json) => _$ShopQueueDtoFromJson(json);

@override@JsonKey(name: 'shopId') final  Object? shopId;
@override@JsonKey(name: 'state') final  Object? state;
@override@JsonKey(name: 'notAccepting') final  Object? notAccepting;
@override@JsonKey(name: 'waitingCount') final  Object? waitingCount;
@override@JsonKey(name: 'inChair') final  Object? inChair;
@override@JsonKey(name: 'estimate') final  Object? estimate;
@override@JsonKey(name: 'feeAmountCents') final  Object? feeAmountCents;
@override@JsonKey(name: 'myEntry') final  Object? myEntry;

/// Create a copy of ShopQueueDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopQueueDtoCopyWith<_ShopQueueDto> get copyWith => __$ShopQueueDtoCopyWithImpl<_ShopQueueDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopQueueDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopQueueDto&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.state, state)&&const DeepCollectionEquality().equals(other.notAccepting, notAccepting)&&const DeepCollectionEquality().equals(other.waitingCount, waitingCount)&&const DeepCollectionEquality().equals(other.inChair, inChair)&&const DeepCollectionEquality().equals(other.estimate, estimate)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.myEntry, myEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(state),const DeepCollectionEquality().hash(notAccepting),const DeepCollectionEquality().hash(waitingCount),const DeepCollectionEquality().hash(inChair),const DeepCollectionEquality().hash(estimate),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(myEntry));

@override
String toString() {
  return 'ShopQueueDto(shopId: $shopId, state: $state, notAccepting: $notAccepting, waitingCount: $waitingCount, inChair: $inChair, estimate: $estimate, feeAmountCents: $feeAmountCents, myEntry: $myEntry)';
}


}

/// @nodoc
abstract mixin class _$ShopQueueDtoCopyWith<$Res> implements $ShopQueueDtoCopyWith<$Res> {
  factory _$ShopQueueDtoCopyWith(_ShopQueueDto value, $Res Function(_ShopQueueDto) _then) = __$ShopQueueDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'state') Object? state,@JsonKey(name: 'notAccepting') Object? notAccepting,@JsonKey(name: 'waitingCount') Object? waitingCount,@JsonKey(name: 'inChair') Object? inChair,@JsonKey(name: 'estimate') Object? estimate,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'myEntry') Object? myEntry
});




}
/// @nodoc
class __$ShopQueueDtoCopyWithImpl<$Res>
    implements _$ShopQueueDtoCopyWith<$Res> {
  __$ShopQueueDtoCopyWithImpl(this._self, this._then);

  final _ShopQueueDto _self;
  final $Res Function(_ShopQueueDto) _then;

/// Create a copy of ShopQueueDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = freezed,Object? state = freezed,Object? notAccepting = freezed,Object? waitingCount = freezed,Object? inChair = freezed,Object? estimate = freezed,Object? feeAmountCents = freezed,Object? myEntry = freezed,}) {
  return _then(_ShopQueueDto(
shopId: freezed == shopId ? _self.shopId : shopId ,state: freezed == state ? _self.state : state ,notAccepting: freezed == notAccepting ? _self.notAccepting : notAccepting ,waitingCount: freezed == waitingCount ? _self.waitingCount : waitingCount ,inChair: freezed == inChair ? _self.inChair : inChair ,estimate: freezed == estimate ? _self.estimate : estimate ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,myEntry: freezed == myEntry ? _self.myEntry : myEntry ,
  ));
}


}


/// @nodoc
mixin _$QueueJoinDto {

@JsonKey(name: 'entry') Object? get entry;@JsonKey(name: 'clientSecret') Object? get clientSecret;@JsonKey(name: 'holdExpiresAt') Object? get holdExpiresAt;@JsonKey(name: 'feeAmountCents') Object? get feeAmountCents;@JsonKey(name: 'estimate') Object? get estimate;
/// Create a copy of QueueJoinDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueJoinDtoCopyWith<QueueJoinDto> get copyWith => _$QueueJoinDtoCopyWithImpl<QueueJoinDto>(this as QueueJoinDto, _$identity);

  /// Serializes this QueueJoinDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueJoinDto&&const DeepCollectionEquality().equals(other.entry, entry)&&const DeepCollectionEquality().equals(other.clientSecret, clientSecret)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.estimate, estimate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entry),const DeepCollectionEquality().hash(clientSecret),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(estimate));

@override
String toString() {
  return 'QueueJoinDto(entry: $entry, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeAmountCents: $feeAmountCents, estimate: $estimate)';
}


}

/// @nodoc
abstract mixin class $QueueJoinDtoCopyWith<$Res>  {
  factory $QueueJoinDtoCopyWith(QueueJoinDto value, $Res Function(QueueJoinDto) _then) = _$QueueJoinDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'entry') Object? entry,@JsonKey(name: 'clientSecret') Object? clientSecret,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'estimate') Object? estimate
});




}
/// @nodoc
class _$QueueJoinDtoCopyWithImpl<$Res>
    implements $QueueJoinDtoCopyWith<$Res> {
  _$QueueJoinDtoCopyWithImpl(this._self, this._then);

  final QueueJoinDto _self;
  final $Res Function(QueueJoinDto) _then;

/// Create a copy of QueueJoinDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = freezed,Object? clientSecret = freezed,Object? holdExpiresAt = freezed,Object? feeAmountCents = freezed,Object? estimate = freezed,}) {
  return _then(_self.copyWith(
entry: freezed == entry ? _self.entry : entry ,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,estimate: freezed == estimate ? _self.estimate : estimate ,
  ));
}

}


/// Adds pattern-matching-related methods to [QueueJoinDto].
extension QueueJoinDtoPatterns on QueueJoinDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueJoinDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueJoinDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueJoinDto value)  $default,){
final _that = this;
switch (_that) {
case _QueueJoinDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueJoinDto value)?  $default,){
final _that = this;
switch (_that) {
case _QueueJoinDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'entry')  Object? entry, @JsonKey(name: 'clientSecret')  Object? clientSecret, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'estimate')  Object? estimate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueJoinDto() when $default != null:
return $default(_that.entry,_that.clientSecret,_that.holdExpiresAt,_that.feeAmountCents,_that.estimate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'entry')  Object? entry, @JsonKey(name: 'clientSecret')  Object? clientSecret, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'estimate')  Object? estimate)  $default,) {final _that = this;
switch (_that) {
case _QueueJoinDto():
return $default(_that.entry,_that.clientSecret,_that.holdExpiresAt,_that.feeAmountCents,_that.estimate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'entry')  Object? entry, @JsonKey(name: 'clientSecret')  Object? clientSecret, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'estimate')  Object? estimate)?  $default,) {final _that = this;
switch (_that) {
case _QueueJoinDto() when $default != null:
return $default(_that.entry,_that.clientSecret,_that.holdExpiresAt,_that.feeAmountCents,_that.estimate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueJoinDto extends QueueJoinDto {
  const _QueueJoinDto({@JsonKey(name: 'entry') this.entry, @JsonKey(name: 'clientSecret') this.clientSecret, @JsonKey(name: 'holdExpiresAt') this.holdExpiresAt, @JsonKey(name: 'feeAmountCents') this.feeAmountCents, @JsonKey(name: 'estimate') this.estimate}): super._();
  factory _QueueJoinDto.fromJson(Map<String, dynamic> json) => _$QueueJoinDtoFromJson(json);

@override@JsonKey(name: 'entry') final  Object? entry;
@override@JsonKey(name: 'clientSecret') final  Object? clientSecret;
@override@JsonKey(name: 'holdExpiresAt') final  Object? holdExpiresAt;
@override@JsonKey(name: 'feeAmountCents') final  Object? feeAmountCents;
@override@JsonKey(name: 'estimate') final  Object? estimate;

/// Create a copy of QueueJoinDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueJoinDtoCopyWith<_QueueJoinDto> get copyWith => __$QueueJoinDtoCopyWithImpl<_QueueJoinDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueJoinDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueJoinDto&&const DeepCollectionEquality().equals(other.entry, entry)&&const DeepCollectionEquality().equals(other.clientSecret, clientSecret)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.estimate, estimate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entry),const DeepCollectionEquality().hash(clientSecret),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(estimate));

@override
String toString() {
  return 'QueueJoinDto(entry: $entry, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeAmountCents: $feeAmountCents, estimate: $estimate)';
}


}

/// @nodoc
abstract mixin class _$QueueJoinDtoCopyWith<$Res> implements $QueueJoinDtoCopyWith<$Res> {
  factory _$QueueJoinDtoCopyWith(_QueueJoinDto value, $Res Function(_QueueJoinDto) _then) = __$QueueJoinDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'entry') Object? entry,@JsonKey(name: 'clientSecret') Object? clientSecret,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'estimate') Object? estimate
});




}
/// @nodoc
class __$QueueJoinDtoCopyWithImpl<$Res>
    implements _$QueueJoinDtoCopyWith<$Res> {
  __$QueueJoinDtoCopyWithImpl(this._self, this._then);

  final _QueueJoinDto _self;
  final $Res Function(_QueueJoinDto) _then;

/// Create a copy of QueueJoinDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = freezed,Object? clientSecret = freezed,Object? holdExpiresAt = freezed,Object? feeAmountCents = freezed,Object? estimate = freezed,}) {
  return _then(_QueueJoinDto(
entry: freezed == entry ? _self.entry : entry ,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,estimate: freezed == estimate ? _self.estimate : estimate ,
  ));
}


}


/// @nodoc
mixin _$OwnerQueueEntryDto {

@JsonKey(name: 'entryId') Object? get entryId;@JsonKey(name: 'status') Object? get status;@JsonKey(name: 'kind') Object? get kind;@JsonKey(name: 'customerName') Object? get customerName;@JsonKey(name: 'serviceId') Object? get serviceId;@JsonKey(name: 'serviceName') Object? get serviceName;@JsonKey(name: 'durationMin') Object? get durationMin;@JsonKey(name: 'joinedAt') Object? get joinedAt;@JsonKey(name: 'calledAt') Object? get calledAt;@JsonKey(name: 'startedAt') Object? get startedAt;@JsonKey(name: 'noShowFrom') Object? get noShowFrom;@JsonKey(name: 'requestedProviderId') Object? get requestedProviderId;@JsonKey(name: 'providerId') Object? get providerId;@JsonKey(name: 'providerName') Object? get providerName;
/// Create a copy of OwnerQueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerQueueEntryDtoCopyWith<OwnerQueueEntryDto> get copyWith => _$OwnerQueueEntryDtoCopyWithImpl<OwnerQueueEntryDto>(this as OwnerQueueEntryDto, _$identity);

  /// Serializes this OwnerQueueEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerQueueEntryDto&&const DeepCollectionEquality().equals(other.entryId, entryId)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.kind, kind)&&const DeepCollectionEquality().equals(other.customerName, customerName)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.joinedAt, joinedAt)&&const DeepCollectionEquality().equals(other.calledAt, calledAt)&&const DeepCollectionEquality().equals(other.startedAt, startedAt)&&const DeepCollectionEquality().equals(other.noShowFrom, noShowFrom)&&const DeepCollectionEquality().equals(other.requestedProviderId, requestedProviderId)&&const DeepCollectionEquality().equals(other.providerId, providerId)&&const DeepCollectionEquality().equals(other.providerName, providerName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entryId),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(kind),const DeepCollectionEquality().hash(customerName),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(joinedAt),const DeepCollectionEquality().hash(calledAt),const DeepCollectionEquality().hash(startedAt),const DeepCollectionEquality().hash(noShowFrom),const DeepCollectionEquality().hash(requestedProviderId),const DeepCollectionEquality().hash(providerId),const DeepCollectionEquality().hash(providerName));

@override
String toString() {
  return 'OwnerQueueEntryDto(entryId: $entryId, status: $status, kind: $kind, customerName: $customerName, serviceId: $serviceId, serviceName: $serviceName, durationMin: $durationMin, joinedAt: $joinedAt, calledAt: $calledAt, startedAt: $startedAt, noShowFrom: $noShowFrom, requestedProviderId: $requestedProviderId, providerId: $providerId, providerName: $providerName)';
}


}

/// @nodoc
abstract mixin class $OwnerQueueEntryDtoCopyWith<$Res>  {
  factory $OwnerQueueEntryDtoCopyWith(OwnerQueueEntryDto value, $Res Function(OwnerQueueEntryDto) _then) = _$OwnerQueueEntryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'entryId') Object? entryId,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'kind') Object? kind,@JsonKey(name: 'customerName') Object? customerName,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'joinedAt') Object? joinedAt,@JsonKey(name: 'calledAt') Object? calledAt,@JsonKey(name: 'startedAt') Object? startedAt,@JsonKey(name: 'noShowFrom') Object? noShowFrom,@JsonKey(name: 'requestedProviderId') Object? requestedProviderId,@JsonKey(name: 'providerId') Object? providerId,@JsonKey(name: 'providerName') Object? providerName
});




}
/// @nodoc
class _$OwnerQueueEntryDtoCopyWithImpl<$Res>
    implements $OwnerQueueEntryDtoCopyWith<$Res> {
  _$OwnerQueueEntryDtoCopyWithImpl(this._self, this._then);

  final OwnerQueueEntryDto _self;
  final $Res Function(OwnerQueueEntryDto) _then;

/// Create a copy of OwnerQueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = freezed,Object? status = freezed,Object? kind = freezed,Object? customerName = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? durationMin = freezed,Object? joinedAt = freezed,Object? calledAt = freezed,Object? startedAt = freezed,Object? noShowFrom = freezed,Object? requestedProviderId = freezed,Object? providerId = freezed,Object? providerName = freezed,}) {
  return _then(_self.copyWith(
entryId: freezed == entryId ? _self.entryId : entryId ,status: freezed == status ? _self.status : status ,kind: freezed == kind ? _self.kind : kind ,customerName: freezed == customerName ? _self.customerName : customerName ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt ,calledAt: freezed == calledAt ? _self.calledAt : calledAt ,startedAt: freezed == startedAt ? _self.startedAt : startedAt ,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom ,requestedProviderId: freezed == requestedProviderId ? _self.requestedProviderId : requestedProviderId ,providerId: freezed == providerId ? _self.providerId : providerId ,providerName: freezed == providerName ? _self.providerName : providerName ,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerQueueEntryDto].
extension OwnerQueueEntryDtoPatterns on OwnerQueueEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerQueueEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerQueueEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerQueueEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _OwnerQueueEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerQueueEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerQueueEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'entryId')  Object? entryId, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'kind')  Object? kind, @JsonKey(name: 'customerName')  Object? customerName, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'joinedAt')  Object? joinedAt, @JsonKey(name: 'calledAt')  Object? calledAt, @JsonKey(name: 'startedAt')  Object? startedAt, @JsonKey(name: 'noShowFrom')  Object? noShowFrom, @JsonKey(name: 'requestedProviderId')  Object? requestedProviderId, @JsonKey(name: 'providerId')  Object? providerId, @JsonKey(name: 'providerName')  Object? providerName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerQueueEntryDto() when $default != null:
return $default(_that.entryId,_that.status,_that.kind,_that.customerName,_that.serviceId,_that.serviceName,_that.durationMin,_that.joinedAt,_that.calledAt,_that.startedAt,_that.noShowFrom,_that.requestedProviderId,_that.providerId,_that.providerName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'entryId')  Object? entryId, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'kind')  Object? kind, @JsonKey(name: 'customerName')  Object? customerName, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'joinedAt')  Object? joinedAt, @JsonKey(name: 'calledAt')  Object? calledAt, @JsonKey(name: 'startedAt')  Object? startedAt, @JsonKey(name: 'noShowFrom')  Object? noShowFrom, @JsonKey(name: 'requestedProviderId')  Object? requestedProviderId, @JsonKey(name: 'providerId')  Object? providerId, @JsonKey(name: 'providerName')  Object? providerName)  $default,) {final _that = this;
switch (_that) {
case _OwnerQueueEntryDto():
return $default(_that.entryId,_that.status,_that.kind,_that.customerName,_that.serviceId,_that.serviceName,_that.durationMin,_that.joinedAt,_that.calledAt,_that.startedAt,_that.noShowFrom,_that.requestedProviderId,_that.providerId,_that.providerName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'entryId')  Object? entryId, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'kind')  Object? kind, @JsonKey(name: 'customerName')  Object? customerName, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'joinedAt')  Object? joinedAt, @JsonKey(name: 'calledAt')  Object? calledAt, @JsonKey(name: 'startedAt')  Object? startedAt, @JsonKey(name: 'noShowFrom')  Object? noShowFrom, @JsonKey(name: 'requestedProviderId')  Object? requestedProviderId, @JsonKey(name: 'providerId')  Object? providerId, @JsonKey(name: 'providerName')  Object? providerName)?  $default,) {final _that = this;
switch (_that) {
case _OwnerQueueEntryDto() when $default != null:
return $default(_that.entryId,_that.status,_that.kind,_that.customerName,_that.serviceId,_that.serviceName,_that.durationMin,_that.joinedAt,_that.calledAt,_that.startedAt,_that.noShowFrom,_that.requestedProviderId,_that.providerId,_that.providerName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerQueueEntryDto extends OwnerQueueEntryDto {
  const _OwnerQueueEntryDto({@JsonKey(name: 'entryId') this.entryId, @JsonKey(name: 'status') this.status, @JsonKey(name: 'kind') this.kind, @JsonKey(name: 'customerName') this.customerName, @JsonKey(name: 'serviceId') this.serviceId, @JsonKey(name: 'serviceName') this.serviceName, @JsonKey(name: 'durationMin') this.durationMin, @JsonKey(name: 'joinedAt') this.joinedAt, @JsonKey(name: 'calledAt') this.calledAt, @JsonKey(name: 'startedAt') this.startedAt, @JsonKey(name: 'noShowFrom') this.noShowFrom, @JsonKey(name: 'requestedProviderId') this.requestedProviderId, @JsonKey(name: 'providerId') this.providerId, @JsonKey(name: 'providerName') this.providerName}): super._();
  factory _OwnerQueueEntryDto.fromJson(Map<String, dynamic> json) => _$OwnerQueueEntryDtoFromJson(json);

@override@JsonKey(name: 'entryId') final  Object? entryId;
@override@JsonKey(name: 'status') final  Object? status;
@override@JsonKey(name: 'kind') final  Object? kind;
@override@JsonKey(name: 'customerName') final  Object? customerName;
@override@JsonKey(name: 'serviceId') final  Object? serviceId;
@override@JsonKey(name: 'serviceName') final  Object? serviceName;
@override@JsonKey(name: 'durationMin') final  Object? durationMin;
@override@JsonKey(name: 'joinedAt') final  Object? joinedAt;
@override@JsonKey(name: 'calledAt') final  Object? calledAt;
@override@JsonKey(name: 'startedAt') final  Object? startedAt;
@override@JsonKey(name: 'noShowFrom') final  Object? noShowFrom;
@override@JsonKey(name: 'requestedProviderId') final  Object? requestedProviderId;
@override@JsonKey(name: 'providerId') final  Object? providerId;
@override@JsonKey(name: 'providerName') final  Object? providerName;

/// Create a copy of OwnerQueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerQueueEntryDtoCopyWith<_OwnerQueueEntryDto> get copyWith => __$OwnerQueueEntryDtoCopyWithImpl<_OwnerQueueEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerQueueEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerQueueEntryDto&&const DeepCollectionEquality().equals(other.entryId, entryId)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.kind, kind)&&const DeepCollectionEquality().equals(other.customerName, customerName)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.joinedAt, joinedAt)&&const DeepCollectionEquality().equals(other.calledAt, calledAt)&&const DeepCollectionEquality().equals(other.startedAt, startedAt)&&const DeepCollectionEquality().equals(other.noShowFrom, noShowFrom)&&const DeepCollectionEquality().equals(other.requestedProviderId, requestedProviderId)&&const DeepCollectionEquality().equals(other.providerId, providerId)&&const DeepCollectionEquality().equals(other.providerName, providerName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entryId),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(kind),const DeepCollectionEquality().hash(customerName),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(joinedAt),const DeepCollectionEquality().hash(calledAt),const DeepCollectionEquality().hash(startedAt),const DeepCollectionEquality().hash(noShowFrom),const DeepCollectionEquality().hash(requestedProviderId),const DeepCollectionEquality().hash(providerId),const DeepCollectionEquality().hash(providerName));

@override
String toString() {
  return 'OwnerQueueEntryDto(entryId: $entryId, status: $status, kind: $kind, customerName: $customerName, serviceId: $serviceId, serviceName: $serviceName, durationMin: $durationMin, joinedAt: $joinedAt, calledAt: $calledAt, startedAt: $startedAt, noShowFrom: $noShowFrom, requestedProviderId: $requestedProviderId, providerId: $providerId, providerName: $providerName)';
}


}

/// @nodoc
abstract mixin class _$OwnerQueueEntryDtoCopyWith<$Res> implements $OwnerQueueEntryDtoCopyWith<$Res> {
  factory _$OwnerQueueEntryDtoCopyWith(_OwnerQueueEntryDto value, $Res Function(_OwnerQueueEntryDto) _then) = __$OwnerQueueEntryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'entryId') Object? entryId,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'kind') Object? kind,@JsonKey(name: 'customerName') Object? customerName,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'joinedAt') Object? joinedAt,@JsonKey(name: 'calledAt') Object? calledAt,@JsonKey(name: 'startedAt') Object? startedAt,@JsonKey(name: 'noShowFrom') Object? noShowFrom,@JsonKey(name: 'requestedProviderId') Object? requestedProviderId,@JsonKey(name: 'providerId') Object? providerId,@JsonKey(name: 'providerName') Object? providerName
});




}
/// @nodoc
class __$OwnerQueueEntryDtoCopyWithImpl<$Res>
    implements _$OwnerQueueEntryDtoCopyWith<$Res> {
  __$OwnerQueueEntryDtoCopyWithImpl(this._self, this._then);

  final _OwnerQueueEntryDto _self;
  final $Res Function(_OwnerQueueEntryDto) _then;

/// Create a copy of OwnerQueueEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = freezed,Object? status = freezed,Object? kind = freezed,Object? customerName = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? durationMin = freezed,Object? joinedAt = freezed,Object? calledAt = freezed,Object? startedAt = freezed,Object? noShowFrom = freezed,Object? requestedProviderId = freezed,Object? providerId = freezed,Object? providerName = freezed,}) {
  return _then(_OwnerQueueEntryDto(
entryId: freezed == entryId ? _self.entryId : entryId ,status: freezed == status ? _self.status : status ,kind: freezed == kind ? _self.kind : kind ,customerName: freezed == customerName ? _self.customerName : customerName ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt ,calledAt: freezed == calledAt ? _self.calledAt : calledAt ,startedAt: freezed == startedAt ? _self.startedAt : startedAt ,noShowFrom: freezed == noShowFrom ? _self.noShowFrom : noShowFrom ,requestedProviderId: freezed == requestedProviderId ? _self.requestedProviderId : requestedProviderId ,providerId: freezed == providerId ? _self.providerId : providerId ,providerName: freezed == providerName ? _self.providerName : providerName ,
  ));
}


}


/// @nodoc
mixin _$OwnerQueueDto {

@JsonKey(name: 'localDate') Object? get localDate;@JsonKey(name: 'state') Object? get state;@JsonKey(name: 'waitingCount') Object? get waitingCount;@JsonKey(name: 'emptiesAt') Object? get emptiesAt;@JsonKey(name: 'entries') List<dynamic>? get entries;@JsonKey(name: 'providers') List<dynamic>? get providers;
/// Create a copy of OwnerQueueDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerQueueDtoCopyWith<OwnerQueueDto> get copyWith => _$OwnerQueueDtoCopyWithImpl<OwnerQueueDto>(this as OwnerQueueDto, _$identity);

  /// Serializes this OwnerQueueDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerQueueDto&&const DeepCollectionEquality().equals(other.localDate, localDate)&&const DeepCollectionEquality().equals(other.state, state)&&const DeepCollectionEquality().equals(other.waitingCount, waitingCount)&&const DeepCollectionEquality().equals(other.emptiesAt, emptiesAt)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.providers, providers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(localDate),const DeepCollectionEquality().hash(state),const DeepCollectionEquality().hash(waitingCount),const DeepCollectionEquality().hash(emptiesAt),const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(providers));

@override
String toString() {
  return 'OwnerQueueDto(localDate: $localDate, state: $state, waitingCount: $waitingCount, emptiesAt: $emptiesAt, entries: $entries, providers: $providers)';
}


}

/// @nodoc
abstract mixin class $OwnerQueueDtoCopyWith<$Res>  {
  factory $OwnerQueueDtoCopyWith(OwnerQueueDto value, $Res Function(OwnerQueueDto) _then) = _$OwnerQueueDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'localDate') Object? localDate,@JsonKey(name: 'state') Object? state,@JsonKey(name: 'waitingCount') Object? waitingCount,@JsonKey(name: 'emptiesAt') Object? emptiesAt,@JsonKey(name: 'entries') List<dynamic>? entries,@JsonKey(name: 'providers') List<dynamic>? providers
});




}
/// @nodoc
class _$OwnerQueueDtoCopyWithImpl<$Res>
    implements $OwnerQueueDtoCopyWith<$Res> {
  _$OwnerQueueDtoCopyWithImpl(this._self, this._then);

  final OwnerQueueDto _self;
  final $Res Function(OwnerQueueDto) _then;

/// Create a copy of OwnerQueueDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localDate = freezed,Object? state = freezed,Object? waitingCount = freezed,Object? emptiesAt = freezed,Object? entries = freezed,Object? providers = freezed,}) {
  return _then(_self.copyWith(
localDate: freezed == localDate ? _self.localDate : localDate ,state: freezed == state ? _self.state : state ,waitingCount: freezed == waitingCount ? _self.waitingCount : waitingCount ,emptiesAt: freezed == emptiesAt ? _self.emptiesAt : emptiesAt ,entries: freezed == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,providers: freezed == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerQueueDto].
extension OwnerQueueDtoPatterns on OwnerQueueDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerQueueDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerQueueDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerQueueDto value)  $default,){
final _that = this;
switch (_that) {
case _OwnerQueueDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerQueueDto value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerQueueDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'localDate')  Object? localDate, @JsonKey(name: 'state')  Object? state, @JsonKey(name: 'waitingCount')  Object? waitingCount, @JsonKey(name: 'emptiesAt')  Object? emptiesAt, @JsonKey(name: 'entries')  List<dynamic>? entries, @JsonKey(name: 'providers')  List<dynamic>? providers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerQueueDto() when $default != null:
return $default(_that.localDate,_that.state,_that.waitingCount,_that.emptiesAt,_that.entries,_that.providers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'localDate')  Object? localDate, @JsonKey(name: 'state')  Object? state, @JsonKey(name: 'waitingCount')  Object? waitingCount, @JsonKey(name: 'emptiesAt')  Object? emptiesAt, @JsonKey(name: 'entries')  List<dynamic>? entries, @JsonKey(name: 'providers')  List<dynamic>? providers)  $default,) {final _that = this;
switch (_that) {
case _OwnerQueueDto():
return $default(_that.localDate,_that.state,_that.waitingCount,_that.emptiesAt,_that.entries,_that.providers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'localDate')  Object? localDate, @JsonKey(name: 'state')  Object? state, @JsonKey(name: 'waitingCount')  Object? waitingCount, @JsonKey(name: 'emptiesAt')  Object? emptiesAt, @JsonKey(name: 'entries')  List<dynamic>? entries, @JsonKey(name: 'providers')  List<dynamic>? providers)?  $default,) {final _that = this;
switch (_that) {
case _OwnerQueueDto() when $default != null:
return $default(_that.localDate,_that.state,_that.waitingCount,_that.emptiesAt,_that.entries,_that.providers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerQueueDto extends OwnerQueueDto {
  const _OwnerQueueDto({@JsonKey(name: 'localDate') this.localDate, @JsonKey(name: 'state') this.state, @JsonKey(name: 'waitingCount') this.waitingCount, @JsonKey(name: 'emptiesAt') this.emptiesAt, @JsonKey(name: 'entries') final  List<dynamic>? entries, @JsonKey(name: 'providers') final  List<dynamic>? providers}): _entries = entries,_providers = providers,super._();
  factory _OwnerQueueDto.fromJson(Map<String, dynamic> json) => _$OwnerQueueDtoFromJson(json);

@override@JsonKey(name: 'localDate') final  Object? localDate;
@override@JsonKey(name: 'state') final  Object? state;
@override@JsonKey(name: 'waitingCount') final  Object? waitingCount;
@override@JsonKey(name: 'emptiesAt') final  Object? emptiesAt;
 final  List<dynamic>? _entries;
@override@JsonKey(name: 'entries') List<dynamic>? get entries {
  final value = _entries;
  if (value == null) return null;
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _providers;
@override@JsonKey(name: 'providers') List<dynamic>? get providers {
  final value = _providers;
  if (value == null) return null;
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OwnerQueueDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerQueueDtoCopyWith<_OwnerQueueDto> get copyWith => __$OwnerQueueDtoCopyWithImpl<_OwnerQueueDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerQueueDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerQueueDto&&const DeepCollectionEquality().equals(other.localDate, localDate)&&const DeepCollectionEquality().equals(other.state, state)&&const DeepCollectionEquality().equals(other.waitingCount, waitingCount)&&const DeepCollectionEquality().equals(other.emptiesAt, emptiesAt)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._providers, _providers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(localDate),const DeepCollectionEquality().hash(state),const DeepCollectionEquality().hash(waitingCount),const DeepCollectionEquality().hash(emptiesAt),const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_providers));

@override
String toString() {
  return 'OwnerQueueDto(localDate: $localDate, state: $state, waitingCount: $waitingCount, emptiesAt: $emptiesAt, entries: $entries, providers: $providers)';
}


}

/// @nodoc
abstract mixin class _$OwnerQueueDtoCopyWith<$Res> implements $OwnerQueueDtoCopyWith<$Res> {
  factory _$OwnerQueueDtoCopyWith(_OwnerQueueDto value, $Res Function(_OwnerQueueDto) _then) = __$OwnerQueueDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'localDate') Object? localDate,@JsonKey(name: 'state') Object? state,@JsonKey(name: 'waitingCount') Object? waitingCount,@JsonKey(name: 'emptiesAt') Object? emptiesAt,@JsonKey(name: 'entries') List<dynamic>? entries,@JsonKey(name: 'providers') List<dynamic>? providers
});




}
/// @nodoc
class __$OwnerQueueDtoCopyWithImpl<$Res>
    implements _$OwnerQueueDtoCopyWith<$Res> {
  __$OwnerQueueDtoCopyWithImpl(this._self, this._then);

  final _OwnerQueueDto _self;
  final $Res Function(_OwnerQueueDto) _then;

/// Create a copy of OwnerQueueDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localDate = freezed,Object? state = freezed,Object? waitingCount = freezed,Object? emptiesAt = freezed,Object? entries = freezed,Object? providers = freezed,}) {
  return _then(_OwnerQueueDto(
localDate: freezed == localDate ? _self.localDate : localDate ,state: freezed == state ? _self.state : state ,waitingCount: freezed == waitingCount ? _self.waitingCount : waitingCount ,emptiesAt: freezed == emptiesAt ? _self.emptiesAt : emptiesAt ,entries: freezed == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,providers: freezed == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}

// dart format on

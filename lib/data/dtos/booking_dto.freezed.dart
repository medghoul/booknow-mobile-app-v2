// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingDto {

@JsonKey(name: 'bookingId') Object? get bookingId;@JsonKey(name: 'status') Object? get status;@JsonKey(name: 'startUtc') Object? get startUtc;@JsonKey(name: 'endUtc') Object? get endUtc;@JsonKey(name: 'durationMin') Object? get durationMin;@JsonKey(name: 'timeZone') Object? get timeZone;@JsonKey(name: 'shopId') Object? get shopId;@JsonKey(name: 'shopName') Object? get shopName;@JsonKey(name: 'shopAddressLine') Object? get shopAddressLine;@JsonKey(name: 'shopPhone') Object? get shopPhone;@JsonKey(name: 'serviceId') Object? get serviceId;@JsonKey(name: 'serviceName') Object? get serviceName;@JsonKey(name: 'providerName') Object? get providerName;@JsonKey(name: 'priceCents') Object? get priceCents;@JsonKey(name: 'feeAmountCents') Object? get feeAmountCents;@JsonKey(name: 'freeCancellationUntilUtc') Object? get freeCancellationUntilUtc;@JsonKey(name: 'holdExpiresAt') Object? get holdExpiresAt;@JsonKey(name: 'cardBrand') Object? get cardBrand;@JsonKey(name: 'cardLast4') Object? get cardLast4;@JsonKey(name: 'cancelledBy') Object? get cancelledBy;@JsonKey(name: 'refunded') Object? get refunded;
/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDtoCopyWith<BookingDto> get copyWith => _$BookingDtoCopyWithImpl<BookingDto>(this as BookingDto, _$identity);

  /// Serializes this BookingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDto&&const DeepCollectionEquality().equals(other.bookingId, bookingId)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.startUtc, startUtc)&&const DeepCollectionEquality().equals(other.endUtc, endUtc)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.timeZone, timeZone)&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.shopName, shopName)&&const DeepCollectionEquality().equals(other.shopAddressLine, shopAddressLine)&&const DeepCollectionEquality().equals(other.shopPhone, shopPhone)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.providerName, providerName)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.freeCancellationUntilUtc, freeCancellationUntilUtc)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.cardBrand, cardBrand)&&const DeepCollectionEquality().equals(other.cardLast4, cardLast4)&&const DeepCollectionEquality().equals(other.cancelledBy, cancelledBy)&&const DeepCollectionEquality().equals(other.refunded, refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(bookingId),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(startUtc),const DeepCollectionEquality().hash(endUtc),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(timeZone),const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(shopName),const DeepCollectionEquality().hash(shopAddressLine),const DeepCollectionEquality().hash(shopPhone),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(providerName),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(freeCancellationUntilUtc),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(cardBrand),const DeepCollectionEquality().hash(cardLast4),const DeepCollectionEquality().hash(cancelledBy),const DeepCollectionEquality().hash(refunded)]);

@override
String toString() {
  return 'BookingDto(bookingId: $bookingId, status: $status, startUtc: $startUtc, endUtc: $endUtc, durationMin: $durationMin, timeZone: $timeZone, shopId: $shopId, shopName: $shopName, shopAddressLine: $shopAddressLine, shopPhone: $shopPhone, serviceId: $serviceId, serviceName: $serviceName, providerName: $providerName, priceCents: $priceCents, feeAmountCents: $feeAmountCents, freeCancellationUntilUtc: $freeCancellationUntilUtc, holdExpiresAt: $holdExpiresAt, cardBrand: $cardBrand, cardLast4: $cardLast4, cancelledBy: $cancelledBy, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class $BookingDtoCopyWith<$Res>  {
  factory $BookingDtoCopyWith(BookingDto value, $Res Function(BookingDto) _then) = _$BookingDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'bookingId') Object? bookingId,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'startUtc') Object? startUtc,@JsonKey(name: 'endUtc') Object? endUtc,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'timeZone') Object? timeZone,@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'shopName') Object? shopName,@JsonKey(name: 'shopAddressLine') Object? shopAddressLine,@JsonKey(name: 'shopPhone') Object? shopPhone,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'providerName') Object? providerName,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'freeCancellationUntilUtc') Object? freeCancellationUntilUtc,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'cardBrand') Object? cardBrand,@JsonKey(name: 'cardLast4') Object? cardLast4,@JsonKey(name: 'cancelledBy') Object? cancelledBy,@JsonKey(name: 'refunded') Object? refunded
});




}
/// @nodoc
class _$BookingDtoCopyWithImpl<$Res>
    implements $BookingDtoCopyWith<$Res> {
  _$BookingDtoCopyWithImpl(this._self, this._then);

  final BookingDto _self;
  final $Res Function(BookingDto) _then;

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = freezed,Object? status = freezed,Object? startUtc = freezed,Object? endUtc = freezed,Object? durationMin = freezed,Object? timeZone = freezed,Object? shopId = freezed,Object? shopName = freezed,Object? shopAddressLine = freezed,Object? shopPhone = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? providerName = freezed,Object? priceCents = freezed,Object? feeAmountCents = freezed,Object? freeCancellationUntilUtc = freezed,Object? holdExpiresAt = freezed,Object? cardBrand = freezed,Object? cardLast4 = freezed,Object? cancelledBy = freezed,Object? refunded = freezed,}) {
  return _then(_self.copyWith(
bookingId: freezed == bookingId ? _self.bookingId : bookingId ,status: freezed == status ? _self.status : status ,startUtc: freezed == startUtc ? _self.startUtc : startUtc ,endUtc: freezed == endUtc ? _self.endUtc : endUtc ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,timeZone: freezed == timeZone ? _self.timeZone : timeZone ,shopId: freezed == shopId ? _self.shopId : shopId ,shopName: freezed == shopName ? _self.shopName : shopName ,shopAddressLine: freezed == shopAddressLine ? _self.shopAddressLine : shopAddressLine ,shopPhone: freezed == shopPhone ? _self.shopPhone : shopPhone ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,providerName: freezed == providerName ? _self.providerName : providerName ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,freeCancellationUntilUtc: freezed == freeCancellationUntilUtc ? _self.freeCancellationUntilUtc : freeCancellationUntilUtc ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,cardBrand: freezed == cardBrand ? _self.cardBrand : cardBrand ,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 ,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy ,refunded: freezed == refunded ? _self.refunded : refunded ,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingDto].
extension BookingDtoPatterns on BookingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDto value)  $default,){
final _that = this;
switch (_that) {
case _BookingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDto value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'bookingId')  Object? bookingId, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'startUtc')  Object? startUtc, @JsonKey(name: 'endUtc')  Object? endUtc, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'shopAddressLine')  Object? shopAddressLine, @JsonKey(name: 'shopPhone')  Object? shopPhone, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'providerName')  Object? providerName, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'freeCancellationUntilUtc')  Object? freeCancellationUntilUtc, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'cardBrand')  Object? cardBrand, @JsonKey(name: 'cardLast4')  Object? cardLast4, @JsonKey(name: 'cancelledBy')  Object? cancelledBy, @JsonKey(name: 'refunded')  Object? refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
return $default(_that.bookingId,_that.status,_that.startUtc,_that.endUtc,_that.durationMin,_that.timeZone,_that.shopId,_that.shopName,_that.shopAddressLine,_that.shopPhone,_that.serviceId,_that.serviceName,_that.providerName,_that.priceCents,_that.feeAmountCents,_that.freeCancellationUntilUtc,_that.holdExpiresAt,_that.cardBrand,_that.cardLast4,_that.cancelledBy,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'bookingId')  Object? bookingId, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'startUtc')  Object? startUtc, @JsonKey(name: 'endUtc')  Object? endUtc, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'shopAddressLine')  Object? shopAddressLine, @JsonKey(name: 'shopPhone')  Object? shopPhone, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'providerName')  Object? providerName, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'freeCancellationUntilUtc')  Object? freeCancellationUntilUtc, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'cardBrand')  Object? cardBrand, @JsonKey(name: 'cardLast4')  Object? cardLast4, @JsonKey(name: 'cancelledBy')  Object? cancelledBy, @JsonKey(name: 'refunded')  Object? refunded)  $default,) {final _that = this;
switch (_that) {
case _BookingDto():
return $default(_that.bookingId,_that.status,_that.startUtc,_that.endUtc,_that.durationMin,_that.timeZone,_that.shopId,_that.shopName,_that.shopAddressLine,_that.shopPhone,_that.serviceId,_that.serviceName,_that.providerName,_that.priceCents,_that.feeAmountCents,_that.freeCancellationUntilUtc,_that.holdExpiresAt,_that.cardBrand,_that.cardLast4,_that.cancelledBy,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'bookingId')  Object? bookingId, @JsonKey(name: 'status')  Object? status, @JsonKey(name: 'startUtc')  Object? startUtc, @JsonKey(name: 'endUtc')  Object? endUtc, @JsonKey(name: 'durationMin')  Object? durationMin, @JsonKey(name: 'timeZone')  Object? timeZone, @JsonKey(name: 'shopId')  Object? shopId, @JsonKey(name: 'shopName')  Object? shopName, @JsonKey(name: 'shopAddressLine')  Object? shopAddressLine, @JsonKey(name: 'shopPhone')  Object? shopPhone, @JsonKey(name: 'serviceId')  Object? serviceId, @JsonKey(name: 'serviceName')  Object? serviceName, @JsonKey(name: 'providerName')  Object? providerName, @JsonKey(name: 'priceCents')  Object? priceCents, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents, @JsonKey(name: 'freeCancellationUntilUtc')  Object? freeCancellationUntilUtc, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'cardBrand')  Object? cardBrand, @JsonKey(name: 'cardLast4')  Object? cardLast4, @JsonKey(name: 'cancelledBy')  Object? cancelledBy, @JsonKey(name: 'refunded')  Object? refunded)?  $default,) {final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
return $default(_that.bookingId,_that.status,_that.startUtc,_that.endUtc,_that.durationMin,_that.timeZone,_that.shopId,_that.shopName,_that.shopAddressLine,_that.shopPhone,_that.serviceId,_that.serviceName,_that.providerName,_that.priceCents,_that.feeAmountCents,_that.freeCancellationUntilUtc,_that.holdExpiresAt,_that.cardBrand,_that.cardLast4,_that.cancelledBy,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingDto extends BookingDto {
  const _BookingDto({@JsonKey(name: 'bookingId') this.bookingId, @JsonKey(name: 'status') this.status, @JsonKey(name: 'startUtc') this.startUtc, @JsonKey(name: 'endUtc') this.endUtc, @JsonKey(name: 'durationMin') this.durationMin, @JsonKey(name: 'timeZone') this.timeZone, @JsonKey(name: 'shopId') this.shopId, @JsonKey(name: 'shopName') this.shopName, @JsonKey(name: 'shopAddressLine') this.shopAddressLine, @JsonKey(name: 'shopPhone') this.shopPhone, @JsonKey(name: 'serviceId') this.serviceId, @JsonKey(name: 'serviceName') this.serviceName, @JsonKey(name: 'providerName') this.providerName, @JsonKey(name: 'priceCents') this.priceCents, @JsonKey(name: 'feeAmountCents') this.feeAmountCents, @JsonKey(name: 'freeCancellationUntilUtc') this.freeCancellationUntilUtc, @JsonKey(name: 'holdExpiresAt') this.holdExpiresAt, @JsonKey(name: 'cardBrand') this.cardBrand, @JsonKey(name: 'cardLast4') this.cardLast4, @JsonKey(name: 'cancelledBy') this.cancelledBy, @JsonKey(name: 'refunded') this.refunded}): super._();
  factory _BookingDto.fromJson(Map<String, dynamic> json) => _$BookingDtoFromJson(json);

@override@JsonKey(name: 'bookingId') final  Object? bookingId;
@override@JsonKey(name: 'status') final  Object? status;
@override@JsonKey(name: 'startUtc') final  Object? startUtc;
@override@JsonKey(name: 'endUtc') final  Object? endUtc;
@override@JsonKey(name: 'durationMin') final  Object? durationMin;
@override@JsonKey(name: 'timeZone') final  Object? timeZone;
@override@JsonKey(name: 'shopId') final  Object? shopId;
@override@JsonKey(name: 'shopName') final  Object? shopName;
@override@JsonKey(name: 'shopAddressLine') final  Object? shopAddressLine;
@override@JsonKey(name: 'shopPhone') final  Object? shopPhone;
@override@JsonKey(name: 'serviceId') final  Object? serviceId;
@override@JsonKey(name: 'serviceName') final  Object? serviceName;
@override@JsonKey(name: 'providerName') final  Object? providerName;
@override@JsonKey(name: 'priceCents') final  Object? priceCents;
@override@JsonKey(name: 'feeAmountCents') final  Object? feeAmountCents;
@override@JsonKey(name: 'freeCancellationUntilUtc') final  Object? freeCancellationUntilUtc;
@override@JsonKey(name: 'holdExpiresAt') final  Object? holdExpiresAt;
@override@JsonKey(name: 'cardBrand') final  Object? cardBrand;
@override@JsonKey(name: 'cardLast4') final  Object? cardLast4;
@override@JsonKey(name: 'cancelledBy') final  Object? cancelledBy;
@override@JsonKey(name: 'refunded') final  Object? refunded;

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDtoCopyWith<_BookingDto> get copyWith => __$BookingDtoCopyWithImpl<_BookingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDto&&const DeepCollectionEquality().equals(other.bookingId, bookingId)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.startUtc, startUtc)&&const DeepCollectionEquality().equals(other.endUtc, endUtc)&&const DeepCollectionEquality().equals(other.durationMin, durationMin)&&const DeepCollectionEquality().equals(other.timeZone, timeZone)&&const DeepCollectionEquality().equals(other.shopId, shopId)&&const DeepCollectionEquality().equals(other.shopName, shopName)&&const DeepCollectionEquality().equals(other.shopAddressLine, shopAddressLine)&&const DeepCollectionEquality().equals(other.shopPhone, shopPhone)&&const DeepCollectionEquality().equals(other.serviceId, serviceId)&&const DeepCollectionEquality().equals(other.serviceName, serviceName)&&const DeepCollectionEquality().equals(other.providerName, providerName)&&const DeepCollectionEquality().equals(other.priceCents, priceCents)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents)&&const DeepCollectionEquality().equals(other.freeCancellationUntilUtc, freeCancellationUntilUtc)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.cardBrand, cardBrand)&&const DeepCollectionEquality().equals(other.cardLast4, cardLast4)&&const DeepCollectionEquality().equals(other.cancelledBy, cancelledBy)&&const DeepCollectionEquality().equals(other.refunded, refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(bookingId),const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(startUtc),const DeepCollectionEquality().hash(endUtc),const DeepCollectionEquality().hash(durationMin),const DeepCollectionEquality().hash(timeZone),const DeepCollectionEquality().hash(shopId),const DeepCollectionEquality().hash(shopName),const DeepCollectionEquality().hash(shopAddressLine),const DeepCollectionEquality().hash(shopPhone),const DeepCollectionEquality().hash(serviceId),const DeepCollectionEquality().hash(serviceName),const DeepCollectionEquality().hash(providerName),const DeepCollectionEquality().hash(priceCents),const DeepCollectionEquality().hash(feeAmountCents),const DeepCollectionEquality().hash(freeCancellationUntilUtc),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(cardBrand),const DeepCollectionEquality().hash(cardLast4),const DeepCollectionEquality().hash(cancelledBy),const DeepCollectionEquality().hash(refunded)]);

@override
String toString() {
  return 'BookingDto(bookingId: $bookingId, status: $status, startUtc: $startUtc, endUtc: $endUtc, durationMin: $durationMin, timeZone: $timeZone, shopId: $shopId, shopName: $shopName, shopAddressLine: $shopAddressLine, shopPhone: $shopPhone, serviceId: $serviceId, serviceName: $serviceName, providerName: $providerName, priceCents: $priceCents, feeAmountCents: $feeAmountCents, freeCancellationUntilUtc: $freeCancellationUntilUtc, holdExpiresAt: $holdExpiresAt, cardBrand: $cardBrand, cardLast4: $cardLast4, cancelledBy: $cancelledBy, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$BookingDtoCopyWith<$Res> implements $BookingDtoCopyWith<$Res> {
  factory _$BookingDtoCopyWith(_BookingDto value, $Res Function(_BookingDto) _then) = __$BookingDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'bookingId') Object? bookingId,@JsonKey(name: 'status') Object? status,@JsonKey(name: 'startUtc') Object? startUtc,@JsonKey(name: 'endUtc') Object? endUtc,@JsonKey(name: 'durationMin') Object? durationMin,@JsonKey(name: 'timeZone') Object? timeZone,@JsonKey(name: 'shopId') Object? shopId,@JsonKey(name: 'shopName') Object? shopName,@JsonKey(name: 'shopAddressLine') Object? shopAddressLine,@JsonKey(name: 'shopPhone') Object? shopPhone,@JsonKey(name: 'serviceId') Object? serviceId,@JsonKey(name: 'serviceName') Object? serviceName,@JsonKey(name: 'providerName') Object? providerName,@JsonKey(name: 'priceCents') Object? priceCents,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents,@JsonKey(name: 'freeCancellationUntilUtc') Object? freeCancellationUntilUtc,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'cardBrand') Object? cardBrand,@JsonKey(name: 'cardLast4') Object? cardLast4,@JsonKey(name: 'cancelledBy') Object? cancelledBy,@JsonKey(name: 'refunded') Object? refunded
});




}
/// @nodoc
class __$BookingDtoCopyWithImpl<$Res>
    implements _$BookingDtoCopyWith<$Res> {
  __$BookingDtoCopyWithImpl(this._self, this._then);

  final _BookingDto _self;
  final $Res Function(_BookingDto) _then;

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = freezed,Object? status = freezed,Object? startUtc = freezed,Object? endUtc = freezed,Object? durationMin = freezed,Object? timeZone = freezed,Object? shopId = freezed,Object? shopName = freezed,Object? shopAddressLine = freezed,Object? shopPhone = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? providerName = freezed,Object? priceCents = freezed,Object? feeAmountCents = freezed,Object? freeCancellationUntilUtc = freezed,Object? holdExpiresAt = freezed,Object? cardBrand = freezed,Object? cardLast4 = freezed,Object? cancelledBy = freezed,Object? refunded = freezed,}) {
  return _then(_BookingDto(
bookingId: freezed == bookingId ? _self.bookingId : bookingId ,status: freezed == status ? _self.status : status ,startUtc: freezed == startUtc ? _self.startUtc : startUtc ,endUtc: freezed == endUtc ? _self.endUtc : endUtc ,durationMin: freezed == durationMin ? _self.durationMin : durationMin ,timeZone: freezed == timeZone ? _self.timeZone : timeZone ,shopId: freezed == shopId ? _self.shopId : shopId ,shopName: freezed == shopName ? _self.shopName : shopName ,shopAddressLine: freezed == shopAddressLine ? _self.shopAddressLine : shopAddressLine ,shopPhone: freezed == shopPhone ? _self.shopPhone : shopPhone ,serviceId: freezed == serviceId ? _self.serviceId : serviceId ,serviceName: freezed == serviceName ? _self.serviceName : serviceName ,providerName: freezed == providerName ? _self.providerName : providerName ,priceCents: freezed == priceCents ? _self.priceCents : priceCents ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,freeCancellationUntilUtc: freezed == freeCancellationUntilUtc ? _self.freeCancellationUntilUtc : freeCancellationUntilUtc ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,cardBrand: freezed == cardBrand ? _self.cardBrand : cardBrand ,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 ,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy ,refunded: freezed == refunded ? _self.refunded : refunded ,
  ));
}


}


/// @nodoc
mixin _$BookingListDto {

@JsonKey(name: 'scope') Object? get scope;@JsonKey(name: 'bookings') List<dynamic>? get bookings;
/// Create a copy of BookingListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingListDtoCopyWith<BookingListDto> get copyWith => _$BookingListDtoCopyWithImpl<BookingListDto>(this as BookingListDto, _$identity);

  /// Serializes this BookingListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingListDto&&const DeepCollectionEquality().equals(other.scope, scope)&&const DeepCollectionEquality().equals(other.bookings, bookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(scope),const DeepCollectionEquality().hash(bookings));

@override
String toString() {
  return 'BookingListDto(scope: $scope, bookings: $bookings)';
}


}

/// @nodoc
abstract mixin class $BookingListDtoCopyWith<$Res>  {
  factory $BookingListDtoCopyWith(BookingListDto value, $Res Function(BookingListDto) _then) = _$BookingListDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'scope') Object? scope,@JsonKey(name: 'bookings') List<dynamic>? bookings
});




}
/// @nodoc
class _$BookingListDtoCopyWithImpl<$Res>
    implements $BookingListDtoCopyWith<$Res> {
  _$BookingListDtoCopyWithImpl(this._self, this._then);

  final BookingListDto _self;
  final $Res Function(BookingListDto) _then;

/// Create a copy of BookingListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scope = freezed,Object? bookings = freezed,}) {
  return _then(_self.copyWith(
scope: freezed == scope ? _self.scope : scope ,bookings: freezed == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingListDto].
extension BookingListDtoPatterns on BookingListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingListDto value)  $default,){
final _that = this;
switch (_that) {
case _BookingListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingListDto value)?  $default,){
final _that = this;
switch (_that) {
case _BookingListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'scope')  Object? scope, @JsonKey(name: 'bookings')  List<dynamic>? bookings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingListDto() when $default != null:
return $default(_that.scope,_that.bookings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'scope')  Object? scope, @JsonKey(name: 'bookings')  List<dynamic>? bookings)  $default,) {final _that = this;
switch (_that) {
case _BookingListDto():
return $default(_that.scope,_that.bookings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'scope')  Object? scope, @JsonKey(name: 'bookings')  List<dynamic>? bookings)?  $default,) {final _that = this;
switch (_that) {
case _BookingListDto() when $default != null:
return $default(_that.scope,_that.bookings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingListDto extends BookingListDto {
  const _BookingListDto({@JsonKey(name: 'scope') this.scope, @JsonKey(name: 'bookings') final  List<dynamic>? bookings}): _bookings = bookings,super._();
  factory _BookingListDto.fromJson(Map<String, dynamic> json) => _$BookingListDtoFromJson(json);

@override@JsonKey(name: 'scope') final  Object? scope;
 final  List<dynamic>? _bookings;
@override@JsonKey(name: 'bookings') List<dynamic>? get bookings {
  final value = _bookings;
  if (value == null) return null;
  if (_bookings is EqualUnmodifiableListView) return _bookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BookingListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingListDtoCopyWith<_BookingListDto> get copyWith => __$BookingListDtoCopyWithImpl<_BookingListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingListDto&&const DeepCollectionEquality().equals(other.scope, scope)&&const DeepCollectionEquality().equals(other._bookings, _bookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(scope),const DeepCollectionEquality().hash(_bookings));

@override
String toString() {
  return 'BookingListDto(scope: $scope, bookings: $bookings)';
}


}

/// @nodoc
abstract mixin class _$BookingListDtoCopyWith<$Res> implements $BookingListDtoCopyWith<$Res> {
  factory _$BookingListDtoCopyWith(_BookingListDto value, $Res Function(_BookingListDto) _then) = __$BookingListDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'scope') Object? scope,@JsonKey(name: 'bookings') List<dynamic>? bookings
});




}
/// @nodoc
class __$BookingListDtoCopyWithImpl<$Res>
    implements _$BookingListDtoCopyWith<$Res> {
  __$BookingListDtoCopyWithImpl(this._self, this._then);

  final _BookingListDto _self;
  final $Res Function(_BookingListDto) _then;

/// Create a copy of BookingListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scope = freezed,Object? bookings = freezed,}) {
  return _then(_BookingListDto(
scope: freezed == scope ? _self.scope : scope ,bookings: freezed == bookings ? _self._bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$BookingHoldDto {

@JsonKey(name: 'booking') Map<String, dynamic>? get booking;@JsonKey(name: 'clientSecret') Object? get clientSecret;@JsonKey(name: 'holdExpiresAt') Object? get holdExpiresAt;@JsonKey(name: 'feeAmountCents') Object? get feeAmountCents;
/// Create a copy of BookingHoldDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingHoldDtoCopyWith<BookingHoldDto> get copyWith => _$BookingHoldDtoCopyWithImpl<BookingHoldDto>(this as BookingHoldDto, _$identity);

  /// Serializes this BookingHoldDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingHoldDto&&const DeepCollectionEquality().equals(other.booking, booking)&&const DeepCollectionEquality().equals(other.clientSecret, clientSecret)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(booking),const DeepCollectionEquality().hash(clientSecret),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(feeAmountCents));

@override
String toString() {
  return 'BookingHoldDto(booking: $booking, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeAmountCents: $feeAmountCents)';
}


}

/// @nodoc
abstract mixin class $BookingHoldDtoCopyWith<$Res>  {
  factory $BookingHoldDtoCopyWith(BookingHoldDto value, $Res Function(BookingHoldDto) _then) = _$BookingHoldDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'booking') Map<String, dynamic>? booking,@JsonKey(name: 'clientSecret') Object? clientSecret,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents
});




}
/// @nodoc
class _$BookingHoldDtoCopyWithImpl<$Res>
    implements $BookingHoldDtoCopyWith<$Res> {
  _$BookingHoldDtoCopyWithImpl(this._self, this._then);

  final BookingHoldDto _self;
  final $Res Function(BookingHoldDto) _then;

/// Create a copy of BookingHoldDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = freezed,Object? clientSecret = freezed,Object? holdExpiresAt = freezed,Object? feeAmountCents = freezed,}) {
  return _then(_self.copyWith(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingHoldDto].
extension BookingHoldDtoPatterns on BookingHoldDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingHoldDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingHoldDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingHoldDto value)  $default,){
final _that = this;
switch (_that) {
case _BookingHoldDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingHoldDto value)?  $default,){
final _that = this;
switch (_that) {
case _BookingHoldDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking')  Map<String, dynamic>? booking, @JsonKey(name: 'clientSecret')  Object? clientSecret, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingHoldDto() when $default != null:
return $default(_that.booking,_that.clientSecret,_that.holdExpiresAt,_that.feeAmountCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'booking')  Map<String, dynamic>? booking, @JsonKey(name: 'clientSecret')  Object? clientSecret, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents)  $default,) {final _that = this;
switch (_that) {
case _BookingHoldDto():
return $default(_that.booking,_that.clientSecret,_that.holdExpiresAt,_that.feeAmountCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'booking')  Map<String, dynamic>? booking, @JsonKey(name: 'clientSecret')  Object? clientSecret, @JsonKey(name: 'holdExpiresAt')  Object? holdExpiresAt, @JsonKey(name: 'feeAmountCents')  Object? feeAmountCents)?  $default,) {final _that = this;
switch (_that) {
case _BookingHoldDto() when $default != null:
return $default(_that.booking,_that.clientSecret,_that.holdExpiresAt,_that.feeAmountCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingHoldDto extends BookingHoldDto {
  const _BookingHoldDto({@JsonKey(name: 'booking') final  Map<String, dynamic>? booking, @JsonKey(name: 'clientSecret') this.clientSecret, @JsonKey(name: 'holdExpiresAt') this.holdExpiresAt, @JsonKey(name: 'feeAmountCents') this.feeAmountCents}): _booking = booking,super._();
  factory _BookingHoldDto.fromJson(Map<String, dynamic> json) => _$BookingHoldDtoFromJson(json);

 final  Map<String, dynamic>? _booking;
@override@JsonKey(name: 'booking') Map<String, dynamic>? get booking {
  final value = _booking;
  if (value == null) return null;
  if (_booking is EqualUnmodifiableMapView) return _booking;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'clientSecret') final  Object? clientSecret;
@override@JsonKey(name: 'holdExpiresAt') final  Object? holdExpiresAt;
@override@JsonKey(name: 'feeAmountCents') final  Object? feeAmountCents;

/// Create a copy of BookingHoldDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingHoldDtoCopyWith<_BookingHoldDto> get copyWith => __$BookingHoldDtoCopyWithImpl<_BookingHoldDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingHoldDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingHoldDto&&const DeepCollectionEquality().equals(other._booking, _booking)&&const DeepCollectionEquality().equals(other.clientSecret, clientSecret)&&const DeepCollectionEquality().equals(other.holdExpiresAt, holdExpiresAt)&&const DeepCollectionEquality().equals(other.feeAmountCents, feeAmountCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_booking),const DeepCollectionEquality().hash(clientSecret),const DeepCollectionEquality().hash(holdExpiresAt),const DeepCollectionEquality().hash(feeAmountCents));

@override
String toString() {
  return 'BookingHoldDto(booking: $booking, clientSecret: $clientSecret, holdExpiresAt: $holdExpiresAt, feeAmountCents: $feeAmountCents)';
}


}

/// @nodoc
abstract mixin class _$BookingHoldDtoCopyWith<$Res> implements $BookingHoldDtoCopyWith<$Res> {
  factory _$BookingHoldDtoCopyWith(_BookingHoldDto value, $Res Function(_BookingHoldDto) _then) = __$BookingHoldDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'booking') Map<String, dynamic>? booking,@JsonKey(name: 'clientSecret') Object? clientSecret,@JsonKey(name: 'holdExpiresAt') Object? holdExpiresAt,@JsonKey(name: 'feeAmountCents') Object? feeAmountCents
});




}
/// @nodoc
class __$BookingHoldDtoCopyWithImpl<$Res>
    implements _$BookingHoldDtoCopyWith<$Res> {
  __$BookingHoldDtoCopyWithImpl(this._self, this._then);

  final _BookingHoldDto _self;
  final $Res Function(_BookingHoldDto) _then;

/// Create a copy of BookingHoldDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = freezed,Object? clientSecret = freezed,Object? holdExpiresAt = freezed,Object? feeAmountCents = freezed,}) {
  return _then(_BookingHoldDto(
booking: freezed == booking ? _self._booking : booking // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret ,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt ,feeAmountCents: freezed == feeAmountCents ? _self.feeAmountCents : feeAmountCents ,
  ));
}


}

// dart format on

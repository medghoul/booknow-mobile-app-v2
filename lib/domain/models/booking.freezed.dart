// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Booking {

 String get id; BookingStatus get status; DateTime get startUtc; DateTime get endUtc; int get durationMinutes; String get timeZone; String get shopId; String? get shopName; String? get shopAddressLine; String? get shopPhone; String get serviceId; String get serviceName;/// Who does the work, as it was when the booking was made. The API names
/// the shop for a shop of one, whose owner has no name of their own here.
 String? get providerName; int get priceCents; int get feeCents;/// Two hours before the start. Cancelling after it keeps the fee (§10.1).
 DateTime get freeCancellationUntilUtc;/// Only while the booking is waiting to be paid for.
 DateTime? get holdExpiresAt; String? get cardBrand; String? get cardLast4; String? get cancelledBy; bool get refunded;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddressLine, shopAddressLine) || other.shopAddressLine == shopAddressLine)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.freeCancellationUntilUtc, freeCancellationUntilUtc) || other.freeCancellationUntilUtc == freeCancellationUntilUtc)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,status,startUtc,endUtc,durationMinutes,timeZone,shopId,shopName,shopAddressLine,shopPhone,serviceId,serviceName,providerName,priceCents,feeCents,freeCancellationUntilUtc,holdExpiresAt,cardBrand,cardLast4,cancelledBy,refunded]);

@override
String toString() {
  return 'Booking(id: $id, status: $status, startUtc: $startUtc, endUtc: $endUtc, durationMinutes: $durationMinutes, timeZone: $timeZone, shopId: $shopId, shopName: $shopName, shopAddressLine: $shopAddressLine, shopPhone: $shopPhone, serviceId: $serviceId, serviceName: $serviceName, providerName: $providerName, priceCents: $priceCents, feeCents: $feeCents, freeCancellationUntilUtc: $freeCancellationUntilUtc, holdExpiresAt: $holdExpiresAt, cardBrand: $cardBrand, cardLast4: $cardLast4, cancelledBy: $cancelledBy, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String id, BookingStatus status, DateTime startUtc, DateTime endUtc, int durationMinutes, String timeZone, String shopId, String? shopName, String? shopAddressLine, String? shopPhone, String serviceId, String serviceName, String? providerName, int priceCents, int feeCents, DateTime freeCancellationUntilUtc, DateTime? holdExpiresAt, String? cardBrand, String? cardLast4, String? cancelledBy, bool refunded
});




}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? startUtc = null,Object? endUtc = null,Object? durationMinutes = null,Object? timeZone = null,Object? shopId = null,Object? shopName = freezed,Object? shopAddressLine = freezed,Object? shopPhone = freezed,Object? serviceId = null,Object? serviceName = null,Object? providerName = freezed,Object? priceCents = null,Object? feeCents = null,Object? freeCancellationUntilUtc = null,Object? holdExpiresAt = freezed,Object? cardBrand = freezed,Object? cardLast4 = freezed,Object? cancelledBy = freezed,Object? refunded = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,shopAddressLine: freezed == shopAddressLine ? _self.shopAddressLine : shopAddressLine // ignore: cast_nullable_to_non_nullable
as String?,shopPhone: freezed == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,freeCancellationUntilUtc: null == freeCancellationUntilUtc ? _self.freeCancellationUntilUtc : freeCancellationUntilUtc // ignore: cast_nullable_to_non_nullable
as DateTime,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cardBrand: freezed == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as String?,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  BookingStatus status,  DateTime startUtc,  DateTime endUtc,  int durationMinutes,  String timeZone,  String shopId,  String? shopName,  String? shopAddressLine,  String? shopPhone,  String serviceId,  String serviceName,  String? providerName,  int priceCents,  int feeCents,  DateTime freeCancellationUntilUtc,  DateTime? holdExpiresAt,  String? cardBrand,  String? cardLast4,  String? cancelledBy,  bool refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.status,_that.startUtc,_that.endUtc,_that.durationMinutes,_that.timeZone,_that.shopId,_that.shopName,_that.shopAddressLine,_that.shopPhone,_that.serviceId,_that.serviceName,_that.providerName,_that.priceCents,_that.feeCents,_that.freeCancellationUntilUtc,_that.holdExpiresAt,_that.cardBrand,_that.cardLast4,_that.cancelledBy,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  BookingStatus status,  DateTime startUtc,  DateTime endUtc,  int durationMinutes,  String timeZone,  String shopId,  String? shopName,  String? shopAddressLine,  String? shopPhone,  String serviceId,  String serviceName,  String? providerName,  int priceCents,  int feeCents,  DateTime freeCancellationUntilUtc,  DateTime? holdExpiresAt,  String? cardBrand,  String? cardLast4,  String? cancelledBy,  bool refunded)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.status,_that.startUtc,_that.endUtc,_that.durationMinutes,_that.timeZone,_that.shopId,_that.shopName,_that.shopAddressLine,_that.shopPhone,_that.serviceId,_that.serviceName,_that.providerName,_that.priceCents,_that.feeCents,_that.freeCancellationUntilUtc,_that.holdExpiresAt,_that.cardBrand,_that.cardLast4,_that.cancelledBy,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  BookingStatus status,  DateTime startUtc,  DateTime endUtc,  int durationMinutes,  String timeZone,  String shopId,  String? shopName,  String? shopAddressLine,  String? shopPhone,  String serviceId,  String serviceName,  String? providerName,  int priceCents,  int feeCents,  DateTime freeCancellationUntilUtc,  DateTime? holdExpiresAt,  String? cardBrand,  String? cardLast4,  String? cancelledBy,  bool refunded)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.status,_that.startUtc,_that.endUtc,_that.durationMinutes,_that.timeZone,_that.shopId,_that.shopName,_that.shopAddressLine,_that.shopPhone,_that.serviceId,_that.serviceName,_that.providerName,_that.priceCents,_that.feeCents,_that.freeCancellationUntilUtc,_that.holdExpiresAt,_that.cardBrand,_that.cardLast4,_that.cancelledBy,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc


class _Booking extends Booking {
  const _Booking({required this.id, required this.status, required this.startUtc, required this.endUtc, required this.durationMinutes, required this.timeZone, required this.shopId, required this.shopName, required this.shopAddressLine, required this.shopPhone, required this.serviceId, required this.serviceName, this.providerName, required this.priceCents, required this.feeCents, required this.freeCancellationUntilUtc, required this.holdExpiresAt, required this.cardBrand, required this.cardLast4, required this.cancelledBy, required this.refunded}): super._();
  

@override final  String id;
@override final  BookingStatus status;
@override final  DateTime startUtc;
@override final  DateTime endUtc;
@override final  int durationMinutes;
@override final  String timeZone;
@override final  String shopId;
@override final  String? shopName;
@override final  String? shopAddressLine;
@override final  String? shopPhone;
@override final  String serviceId;
@override final  String serviceName;
/// Who does the work, as it was when the booking was made. The API names
/// the shop for a shop of one, whose owner has no name of their own here.
@override final  String? providerName;
@override final  int priceCents;
@override final  int feeCents;
/// Two hours before the start. Cancelling after it keeps the fee (§10.1).
@override final  DateTime freeCancellationUntilUtc;
/// Only while the booking is waiting to be paid for.
@override final  DateTime? holdExpiresAt;
@override final  String? cardBrand;
@override final  String? cardLast4;
@override final  String? cancelledBy;
@override final  bool refunded;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddressLine, shopAddressLine) || other.shopAddressLine == shopAddressLine)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.freeCancellationUntilUtc, freeCancellationUntilUtc) || other.freeCancellationUntilUtc == freeCancellationUntilUtc)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,status,startUtc,endUtc,durationMinutes,timeZone,shopId,shopName,shopAddressLine,shopPhone,serviceId,serviceName,providerName,priceCents,feeCents,freeCancellationUntilUtc,holdExpiresAt,cardBrand,cardLast4,cancelledBy,refunded]);

@override
String toString() {
  return 'Booking(id: $id, status: $status, startUtc: $startUtc, endUtc: $endUtc, durationMinutes: $durationMinutes, timeZone: $timeZone, shopId: $shopId, shopName: $shopName, shopAddressLine: $shopAddressLine, shopPhone: $shopPhone, serviceId: $serviceId, serviceName: $serviceName, providerName: $providerName, priceCents: $priceCents, feeCents: $feeCents, freeCancellationUntilUtc: $freeCancellationUntilUtc, holdExpiresAt: $holdExpiresAt, cardBrand: $cardBrand, cardLast4: $cardLast4, cancelledBy: $cancelledBy, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String id, BookingStatus status, DateTime startUtc, DateTime endUtc, int durationMinutes, String timeZone, String shopId, String? shopName, String? shopAddressLine, String? shopPhone, String serviceId, String serviceName, String? providerName, int priceCents, int feeCents, DateTime freeCancellationUntilUtc, DateTime? holdExpiresAt, String? cardBrand, String? cardLast4, String? cancelledBy, bool refunded
});




}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? startUtc = null,Object? endUtc = null,Object? durationMinutes = null,Object? timeZone = null,Object? shopId = null,Object? shopName = freezed,Object? shopAddressLine = freezed,Object? shopPhone = freezed,Object? serviceId = null,Object? serviceName = null,Object? providerName = freezed,Object? priceCents = null,Object? feeCents = null,Object? freeCancellationUntilUtc = null,Object? holdExpiresAt = freezed,Object? cardBrand = freezed,Object? cardLast4 = freezed,Object? cancelledBy = freezed,Object? refunded = null,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,shopAddressLine: freezed == shopAddressLine ? _self.shopAddressLine : shopAddressLine // ignore: cast_nullable_to_non_nullable
as String?,shopPhone: freezed == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,freeCancellationUntilUtc: null == freeCancellationUntilUtc ? _self.freeCancellationUntilUtc : freeCancellationUntilUtc // ignore: cast_nullable_to_non_nullable
as DateTime,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cardBrand: freezed == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as String?,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

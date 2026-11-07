// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AgendaRow {

 DateTime get startUtc; DateTime get endUtc;/// Whose time it is (providers §5). Null from an API older than providers.
 String? get providerId;
/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaRowCopyWith<AgendaRow> get copyWith => _$AgendaRowCopyWithImpl<AgendaRow>(this as AgendaRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaRow&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,startUtc,endUtc,providerId);

@override
String toString() {
  return 'AgendaRow(startUtc: $startUtc, endUtc: $endUtc, providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class $AgendaRowCopyWith<$Res>  {
  factory $AgendaRowCopyWith(AgendaRow value, $Res Function(AgendaRow) _then) = _$AgendaRowCopyWithImpl;
@useResult
$Res call({
 DateTime startUtc, DateTime endUtc, String? providerId
});




}
/// @nodoc
class _$AgendaRowCopyWithImpl<$Res>
    implements $AgendaRowCopyWith<$Res> {
  _$AgendaRowCopyWithImpl(this._self, this._then);

  final AgendaRow _self;
  final $Res Function(AgendaRow) _then;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startUtc = null,Object? endUtc = null,Object? providerId = freezed,}) {
  return _then(_self.copyWith(
startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaRow].
extension AgendaRowPatterns on AgendaRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AgendaBookingRow value)?  booking,TResult Function( AgendaBlockRow value)?  block,TResult Function( AgendaFreeRow value)?  free,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AgendaBookingRow() when booking != null:
return booking(_that);case AgendaBlockRow() when block != null:
return block(_that);case AgendaFreeRow() when free != null:
return free(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AgendaBookingRow value)  booking,required TResult Function( AgendaBlockRow value)  block,required TResult Function( AgendaFreeRow value)  free,}){
final _that = this;
switch (_that) {
case AgendaBookingRow():
return booking(_that);case AgendaBlockRow():
return block(_that);case AgendaFreeRow():
return free(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AgendaBookingRow value)?  booking,TResult? Function( AgendaBlockRow value)?  block,TResult? Function( AgendaFreeRow value)?  free,}){
final _that = this;
switch (_that) {
case AgendaBookingRow() when booking != null:
return booking(_that);case AgendaBlockRow() when block != null:
return block(_that);case AgendaFreeRow() when free != null:
return free(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  DateTime startUtc,  DateTime endUtc,  DateTime occupiedUntilUtc,  int durationMinutes,  BookingStatus status,  String serviceName,  int priceCents,  int feeCents,  String? customerName,  String? customerPhone,  String? providerId)?  booking,TResult Function( String id,  DateTime startUtc,  DateTime endUtc,  String? note,  String? providerId)?  block,TResult Function( DateTime startUtc,  DateTime endUtc,  String? freedBy,  String? providerId)?  free,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AgendaBookingRow() when booking != null:
return booking(_that.id,_that.startUtc,_that.endUtc,_that.occupiedUntilUtc,_that.durationMinutes,_that.status,_that.serviceName,_that.priceCents,_that.feeCents,_that.customerName,_that.customerPhone,_that.providerId);case AgendaBlockRow() when block != null:
return block(_that.id,_that.startUtc,_that.endUtc,_that.note,_that.providerId);case AgendaFreeRow() when free != null:
return free(_that.startUtc,_that.endUtc,_that.freedBy,_that.providerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  DateTime startUtc,  DateTime endUtc,  DateTime occupiedUntilUtc,  int durationMinutes,  BookingStatus status,  String serviceName,  int priceCents,  int feeCents,  String? customerName,  String? customerPhone,  String? providerId)  booking,required TResult Function( String id,  DateTime startUtc,  DateTime endUtc,  String? note,  String? providerId)  block,required TResult Function( DateTime startUtc,  DateTime endUtc,  String? freedBy,  String? providerId)  free,}) {final _that = this;
switch (_that) {
case AgendaBookingRow():
return booking(_that.id,_that.startUtc,_that.endUtc,_that.occupiedUntilUtc,_that.durationMinutes,_that.status,_that.serviceName,_that.priceCents,_that.feeCents,_that.customerName,_that.customerPhone,_that.providerId);case AgendaBlockRow():
return block(_that.id,_that.startUtc,_that.endUtc,_that.note,_that.providerId);case AgendaFreeRow():
return free(_that.startUtc,_that.endUtc,_that.freedBy,_that.providerId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  DateTime startUtc,  DateTime endUtc,  DateTime occupiedUntilUtc,  int durationMinutes,  BookingStatus status,  String serviceName,  int priceCents,  int feeCents,  String? customerName,  String? customerPhone,  String? providerId)?  booking,TResult? Function( String id,  DateTime startUtc,  DateTime endUtc,  String? note,  String? providerId)?  block,TResult? Function( DateTime startUtc,  DateTime endUtc,  String? freedBy,  String? providerId)?  free,}) {final _that = this;
switch (_that) {
case AgendaBookingRow() when booking != null:
return booking(_that.id,_that.startUtc,_that.endUtc,_that.occupiedUntilUtc,_that.durationMinutes,_that.status,_that.serviceName,_that.priceCents,_that.feeCents,_that.customerName,_that.customerPhone,_that.providerId);case AgendaBlockRow() when block != null:
return block(_that.id,_that.startUtc,_that.endUtc,_that.note,_that.providerId);case AgendaFreeRow() when free != null:
return free(_that.startUtc,_that.endUtc,_that.freedBy,_that.providerId);case _:
  return null;

}
}

}

/// @nodoc


class AgendaBookingRow extends AgendaRow {
  const AgendaBookingRow({required this.id, required this.startUtc, required this.endUtc, required this.occupiedUntilUtc, required this.durationMinutes, required this.status, required this.serviceName, required this.priceCents, required this.feeCents, required this.customerName, required this.customerPhone, this.providerId}): super._();
  

 final  String id;
@override final  DateTime startUtc;
@override final  DateTime endUtc;
/// When the slot is free again — the service plus its buffer. Longer than
/// [endUtc], and never shown: the customer's appointment ends at [endUtc].
 final  DateTime occupiedUntilUtc;
 final  int durationMinutes;
 final  BookingStatus status;
 final  String serviceName;
/// The service, paid in the shop.
 final  int priceCents;
/// The hold already charged in the app. Kept apart from [priceCents]
/// rather than added to it: the sheet shows what the barber collects over
/// what the customer has already paid, which is how the two settle.
 final  int feeCents;
 final  String? customerName;
 final  String? customerPhone;
/// Whose time it is (providers §5). Null from an API older than providers.
@override final  String? providerId;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaBookingRowCopyWith<AgendaBookingRow> get copyWith => _$AgendaBookingRowCopyWithImpl<AgendaBookingRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaBookingRow&&(identical(other.id, id) || other.id == id)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.occupiedUntilUtc, occupiedUntilUtc) || other.occupiedUntilUtc == occupiedUntilUtc)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.feeCents, feeCents) || other.feeCents == feeCents)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,id,startUtc,endUtc,occupiedUntilUtc,durationMinutes,status,serviceName,priceCents,feeCents,customerName,customerPhone,providerId);

@override
String toString() {
  return 'AgendaRow.booking(id: $id, startUtc: $startUtc, endUtc: $endUtc, occupiedUntilUtc: $occupiedUntilUtc, durationMinutes: $durationMinutes, status: $status, serviceName: $serviceName, priceCents: $priceCents, feeCents: $feeCents, customerName: $customerName, customerPhone: $customerPhone, providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class $AgendaBookingRowCopyWith<$Res> implements $AgendaRowCopyWith<$Res> {
  factory $AgendaBookingRowCopyWith(AgendaBookingRow value, $Res Function(AgendaBookingRow) _then) = _$AgendaBookingRowCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startUtc, DateTime endUtc, DateTime occupiedUntilUtc, int durationMinutes, BookingStatus status, String serviceName, int priceCents, int feeCents, String? customerName, String? customerPhone, String? providerId
});




}
/// @nodoc
class _$AgendaBookingRowCopyWithImpl<$Res>
    implements $AgendaBookingRowCopyWith<$Res> {
  _$AgendaBookingRowCopyWithImpl(this._self, this._then);

  final AgendaBookingRow _self;
  final $Res Function(AgendaBookingRow) _then;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startUtc = null,Object? endUtc = null,Object? occupiedUntilUtc = null,Object? durationMinutes = null,Object? status = null,Object? serviceName = null,Object? priceCents = null,Object? feeCents = null,Object? customerName = freezed,Object? customerPhone = freezed,Object? providerId = freezed,}) {
  return _then(AgendaBookingRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,occupiedUntilUtc: null == occupiedUntilUtc ? _self.occupiedUntilUtc : occupiedUntilUtc // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,feeCents: null == feeCents ? _self.feeCents : feeCents // ignore: cast_nullable_to_non_nullable
as int,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AgendaBlockRow extends AgendaRow {
  const AgendaBlockRow({required this.id, required this.startUtc, required this.endUtc, required this.note, this.providerId}): super._();
  

 final  String id;
@override final  DateTime startUtc;
@override final  DateTime endUtc;
 final  String? note;
@override final  String? providerId;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaBlockRowCopyWith<AgendaBlockRow> get copyWith => _$AgendaBlockRowCopyWithImpl<AgendaBlockRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaBlockRow&&(identical(other.id, id) || other.id == id)&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.note, note) || other.note == note)&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,id,startUtc,endUtc,note,providerId);

@override
String toString() {
  return 'AgendaRow.block(id: $id, startUtc: $startUtc, endUtc: $endUtc, note: $note, providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class $AgendaBlockRowCopyWith<$Res> implements $AgendaRowCopyWith<$Res> {
  factory $AgendaBlockRowCopyWith(AgendaBlockRow value, $Res Function(AgendaBlockRow) _then) = _$AgendaBlockRowCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startUtc, DateTime endUtc, String? note, String? providerId
});




}
/// @nodoc
class _$AgendaBlockRowCopyWithImpl<$Res>
    implements $AgendaBlockRowCopyWith<$Res> {
  _$AgendaBlockRowCopyWithImpl(this._self, this._then);

  final AgendaBlockRow _self;
  final $Res Function(AgendaBlockRow) _then;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startUtc = null,Object? endUtc = null,Object? note = freezed,Object? providerId = freezed,}) {
  return _then(AgendaBlockRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AgendaFreeRow extends AgendaRow {
  const AgendaFreeRow({required this.startUtc, required this.endUtc, required this.freedBy, this.providerId}): super._();
  

@override final  DateTime startUtc;
@override final  DateTime endUtc;
/// The customer whose cancellation opened this, when one did. A quiet
/// morning and a client who dropped out read differently — the second is
/// someone the owner may want to call.
 final  String? freedBy;
/// Whose free time: blocking it takes theirs and nobody else's.
@override final  String? providerId;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaFreeRowCopyWith<AgendaFreeRow> get copyWith => _$AgendaFreeRowCopyWithImpl<AgendaFreeRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaFreeRow&&(identical(other.startUtc, startUtc) || other.startUtc == startUtc)&&(identical(other.endUtc, endUtc) || other.endUtc == endUtc)&&(identical(other.freedBy, freedBy) || other.freedBy == freedBy)&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,startUtc,endUtc,freedBy,providerId);

@override
String toString() {
  return 'AgendaRow.free(startUtc: $startUtc, endUtc: $endUtc, freedBy: $freedBy, providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class $AgendaFreeRowCopyWith<$Res> implements $AgendaRowCopyWith<$Res> {
  factory $AgendaFreeRowCopyWith(AgendaFreeRow value, $Res Function(AgendaFreeRow) _then) = _$AgendaFreeRowCopyWithImpl;
@override @useResult
$Res call({
 DateTime startUtc, DateTime endUtc, String? freedBy, String? providerId
});




}
/// @nodoc
class _$AgendaFreeRowCopyWithImpl<$Res>
    implements $AgendaFreeRowCopyWith<$Res> {
  _$AgendaFreeRowCopyWithImpl(this._self, this._then);

  final AgendaFreeRow _self;
  final $Res Function(AgendaFreeRow) _then;

/// Create a copy of AgendaRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startUtc = null,Object? endUtc = null,Object? freedBy = freezed,Object? providerId = freezed,}) {
  return _then(AgendaFreeRow(
startUtc: null == startUtc ? _self.startUtc : startUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endUtc: null == endUtc ? _self.endUtc : endUtc // ignore: cast_nullable_to_non_nullable
as DateTime,freedBy: freezed == freedBy ? _self.freedBy : freedBy // ignore: cast_nullable_to_non_nullable
as String?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

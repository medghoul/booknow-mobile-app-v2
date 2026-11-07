// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueFlowState {

 String get shopId; QueueStep get step; Shop? get shop; ShopQueue? get queue; ShopService? get service;/// Who the customer will wait for; null is whoever is free first.
 String? get providerId;/// The pending place and its payment, kept so a closed sheet re-opens the
/// same payment instead of asking the server for a second place.
 QueueJoin? get join;/// The customer's own place while in line.
 QueueEntry? get entry;/// Set once the customer left, to say whether the fee came back.
 bool? get leftRefunded; bool get isLoading; bool get isBusy;/// The clock the "your turn" countdown is drawn against.
 DateTime get now; NetworkException? get failure;
/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueFlowStateCopyWith<QueueFlowState> get copyWith => _$QueueFlowStateCopyWithImpl<QueueFlowState>(this as QueueFlowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueFlowState&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.step, step) || other.step == step)&&(identical(other.shop, shop) || other.shop == shop)&&(identical(other.queue, queue) || other.queue == queue)&&(identical(other.service, service) || other.service == service)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.join, join) || other.join == join)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.leftRefunded, leftRefunded) || other.leftRefunded == leftRefunded)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,step,shop,queue,service,providerId,join,entry,leftRefunded,isLoading,isBusy,now,failure);

@override
String toString() {
  return 'QueueFlowState(shopId: $shopId, step: $step, shop: $shop, queue: $queue, service: $service, providerId: $providerId, join: $join, entry: $entry, leftRefunded: $leftRefunded, isLoading: $isLoading, isBusy: $isBusy, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $QueueFlowStateCopyWith<$Res>  {
  factory $QueueFlowStateCopyWith(QueueFlowState value, $Res Function(QueueFlowState) _then) = _$QueueFlowStateCopyWithImpl;
@useResult
$Res call({
 String shopId, QueueStep step, Shop? shop, ShopQueue? queue, ShopService? service, String? providerId, QueueJoin? join, QueueEntry? entry, bool? leftRefunded, bool isLoading, bool isBusy, DateTime now, NetworkException? failure
});


$ShopCopyWith<$Res>? get shop;$ShopQueueCopyWith<$Res>? get queue;$ShopServiceCopyWith<$Res>? get service;$QueueJoinCopyWith<$Res>? get join;$QueueEntryCopyWith<$Res>? get entry;

}
/// @nodoc
class _$QueueFlowStateCopyWithImpl<$Res>
    implements $QueueFlowStateCopyWith<$Res> {
  _$QueueFlowStateCopyWithImpl(this._self, this._then);

  final QueueFlowState _self;
  final $Res Function(QueueFlowState) _then;

/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? step = null,Object? shop = freezed,Object? queue = freezed,Object? service = freezed,Object? providerId = freezed,Object? join = freezed,Object? entry = freezed,Object? leftRefunded = freezed,Object? isLoading = null,Object? isBusy = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as QueueStep,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,queue: freezed == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as ShopQueue?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ShopService?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,join: freezed == join ? _self.join : join // ignore: cast_nullable_to_non_nullable
as QueueJoin?,entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as QueueEntry?,leftRefunded: freezed == leftRefunded ? _self.leftRefunded : leftRefunded // ignore: cast_nullable_to_non_nullable
as bool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopCopyWith<$Res>? get shop {
    if (_self.shop == null) {
    return null;
  }

  return $ShopCopyWith<$Res>(_self.shop!, (value) {
    return _then(_self.copyWith(shop: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopQueueCopyWith<$Res>? get queue {
    if (_self.queue == null) {
    return null;
  }

  return $ShopQueueCopyWith<$Res>(_self.queue!, (value) {
    return _then(_self.copyWith(queue: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopServiceCopyWith<$Res>? get service {
    if (_self.service == null) {
    return null;
  }

  return $ShopServiceCopyWith<$Res>(_self.service!, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueJoinCopyWith<$Res>? get join {
    if (_self.join == null) {
    return null;
  }

  return $QueueJoinCopyWith<$Res>(_self.join!, (value) {
    return _then(_self.copyWith(join: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res>? get entry {
    if (_self.entry == null) {
    return null;
  }

  return $QueueEntryCopyWith<$Res>(_self.entry!, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueFlowState].
extension QueueFlowStatePatterns on QueueFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueFlowState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueFlowState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueFlowState value)  $default,){
final _that = this;
switch (_that) {
case _QueueFlowState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueFlowState value)?  $default,){
final _that = this;
switch (_that) {
case _QueueFlowState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  QueueStep step,  Shop? shop,  ShopQueue? queue,  ShopService? service,  String? providerId,  QueueJoin? join,  QueueEntry? entry,  bool? leftRefunded,  bool isLoading,  bool isBusy,  DateTime now,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueFlowState() when $default != null:
return $default(_that.shopId,_that.step,_that.shop,_that.queue,_that.service,_that.providerId,_that.join,_that.entry,_that.leftRefunded,_that.isLoading,_that.isBusy,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  QueueStep step,  Shop? shop,  ShopQueue? queue,  ShopService? service,  String? providerId,  QueueJoin? join,  QueueEntry? entry,  bool? leftRefunded,  bool isLoading,  bool isBusy,  DateTime now,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _QueueFlowState():
return $default(_that.shopId,_that.step,_that.shop,_that.queue,_that.service,_that.providerId,_that.join,_that.entry,_that.leftRefunded,_that.isLoading,_that.isBusy,_that.now,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  QueueStep step,  Shop? shop,  ShopQueue? queue,  ShopService? service,  String? providerId,  QueueJoin? join,  QueueEntry? entry,  bool? leftRefunded,  bool isLoading,  bool isBusy,  DateTime now,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _QueueFlowState() when $default != null:
return $default(_that.shopId,_that.step,_that.shop,_that.queue,_that.service,_that.providerId,_that.join,_that.entry,_that.leftRefunded,_that.isLoading,_that.isBusy,_that.now,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _QueueFlowState extends QueueFlowState {
  const _QueueFlowState({required this.shopId, this.step = QueueStep.overview, this.shop, this.queue, this.service, this.providerId, this.join, this.entry, this.leftRefunded, this.isLoading = true, this.isBusy = false, required this.now, this.failure}): super._();
  

@override final  String shopId;
@override@JsonKey() final  QueueStep step;
@override final  Shop? shop;
@override final  ShopQueue? queue;
@override final  ShopService? service;
/// Who the customer will wait for; null is whoever is free first.
@override final  String? providerId;
/// The pending place and its payment, kept so a closed sheet re-opens the
/// same payment instead of asking the server for a second place.
@override final  QueueJoin? join;
/// The customer's own place while in line.
@override final  QueueEntry? entry;
/// Set once the customer left, to say whether the fee came back.
@override final  bool? leftRefunded;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isBusy;
/// The clock the "your turn" countdown is drawn against.
@override final  DateTime now;
@override final  NetworkException? failure;

/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueFlowStateCopyWith<_QueueFlowState> get copyWith => __$QueueFlowStateCopyWithImpl<_QueueFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueFlowState&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.step, step) || other.step == step)&&(identical(other.shop, shop) || other.shop == shop)&&(identical(other.queue, queue) || other.queue == queue)&&(identical(other.service, service) || other.service == service)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.join, join) || other.join == join)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.leftRefunded, leftRefunded) || other.leftRefunded == leftRefunded)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy)&&(identical(other.now, now) || other.now == now)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,step,shop,queue,service,providerId,join,entry,leftRefunded,isLoading,isBusy,now,failure);

@override
String toString() {
  return 'QueueFlowState(shopId: $shopId, step: $step, shop: $shop, queue: $queue, service: $service, providerId: $providerId, join: $join, entry: $entry, leftRefunded: $leftRefunded, isLoading: $isLoading, isBusy: $isBusy, now: $now, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$QueueFlowStateCopyWith<$Res> implements $QueueFlowStateCopyWith<$Res> {
  factory _$QueueFlowStateCopyWith(_QueueFlowState value, $Res Function(_QueueFlowState) _then) = __$QueueFlowStateCopyWithImpl;
@override @useResult
$Res call({
 String shopId, QueueStep step, Shop? shop, ShopQueue? queue, ShopService? service, String? providerId, QueueJoin? join, QueueEntry? entry, bool? leftRefunded, bool isLoading, bool isBusy, DateTime now, NetworkException? failure
});


@override $ShopCopyWith<$Res>? get shop;@override $ShopQueueCopyWith<$Res>? get queue;@override $ShopServiceCopyWith<$Res>? get service;@override $QueueJoinCopyWith<$Res>? get join;@override $QueueEntryCopyWith<$Res>? get entry;

}
/// @nodoc
class __$QueueFlowStateCopyWithImpl<$Res>
    implements _$QueueFlowStateCopyWith<$Res> {
  __$QueueFlowStateCopyWithImpl(this._self, this._then);

  final _QueueFlowState _self;
  final $Res Function(_QueueFlowState) _then;

/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? step = null,Object? shop = freezed,Object? queue = freezed,Object? service = freezed,Object? providerId = freezed,Object? join = freezed,Object? entry = freezed,Object? leftRefunded = freezed,Object? isLoading = null,Object? isBusy = null,Object? now = null,Object? failure = freezed,}) {
  return _then(_QueueFlowState(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as QueueStep,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,queue: freezed == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as ShopQueue?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ShopService?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,join: freezed == join ? _self.join : join // ignore: cast_nullable_to_non_nullable
as QueueJoin?,entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as QueueEntry?,leftRefunded: freezed == leftRefunded ? _self.leftRefunded : leftRefunded // ignore: cast_nullable_to_non_nullable
as bool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopCopyWith<$Res>? get shop {
    if (_self.shop == null) {
    return null;
  }

  return $ShopCopyWith<$Res>(_self.shop!, (value) {
    return _then(_self.copyWith(shop: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopQueueCopyWith<$Res>? get queue {
    if (_self.queue == null) {
    return null;
  }

  return $ShopQueueCopyWith<$Res>(_self.queue!, (value) {
    return _then(_self.copyWith(queue: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopServiceCopyWith<$Res>? get service {
    if (_self.service == null) {
    return null;
  }

  return $ShopServiceCopyWith<$Res>(_self.service!, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueJoinCopyWith<$Res>? get join {
    if (_self.join == null) {
    return null;
  }

  return $QueueJoinCopyWith<$Res>(_self.join!, (value) {
    return _then(_self.copyWith(join: value));
  });
}/// Create a copy of QueueFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res>? get entry {
    if (_self.entry == null) {
    return null;
  }

  return $QueueEntryCopyWith<$Res>(_self.entry!, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}

// dart format on

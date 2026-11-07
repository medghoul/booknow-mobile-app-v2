// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_suggestion_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceSuggestionDto {

@JsonKey(name: 'placeId') Object? get placeId;@JsonKey(name: 'id') Object? get id;@JsonKey(name: 'label') Object? get label;@JsonKey(name: 'text') Object? get text;@JsonKey(name: 'secondaryLabel') Object? get secondaryLabel;
/// Create a copy of PlaceSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSuggestionDtoCopyWith<PlaceSuggestionDto> get copyWith => _$PlaceSuggestionDtoCopyWithImpl<PlaceSuggestionDto>(this as PlaceSuggestionDto, _$identity);

  /// Serializes this PlaceSuggestionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSuggestionDto&&const DeepCollectionEquality().equals(other.placeId, placeId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.label, label)&&const DeepCollectionEquality().equals(other.text, text)&&const DeepCollectionEquality().equals(other.secondaryLabel, secondaryLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(placeId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(label),const DeepCollectionEquality().hash(text),const DeepCollectionEquality().hash(secondaryLabel));

@override
String toString() {
  return 'PlaceSuggestionDto(placeId: $placeId, id: $id, label: $label, text: $text, secondaryLabel: $secondaryLabel)';
}


}

/// @nodoc
abstract mixin class $PlaceSuggestionDtoCopyWith<$Res>  {
  factory $PlaceSuggestionDtoCopyWith(PlaceSuggestionDto value, $Res Function(PlaceSuggestionDto) _then) = _$PlaceSuggestionDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'placeId') Object? placeId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'label') Object? label,@JsonKey(name: 'text') Object? text,@JsonKey(name: 'secondaryLabel') Object? secondaryLabel
});




}
/// @nodoc
class _$PlaceSuggestionDtoCopyWithImpl<$Res>
    implements $PlaceSuggestionDtoCopyWith<$Res> {
  _$PlaceSuggestionDtoCopyWithImpl(this._self, this._then);

  final PlaceSuggestionDto _self;
  final $Res Function(PlaceSuggestionDto) _then;

/// Create a copy of PlaceSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = freezed,Object? id = freezed,Object? label = freezed,Object? text = freezed,Object? secondaryLabel = freezed,}) {
  return _then(_self.copyWith(
placeId: freezed == placeId ? _self.placeId : placeId ,id: freezed == id ? _self.id : id ,label: freezed == label ? _self.label : label ,text: freezed == text ? _self.text : text ,secondaryLabel: freezed == secondaryLabel ? _self.secondaryLabel : secondaryLabel ,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSuggestionDto].
extension PlaceSuggestionDtoPatterns on PlaceSuggestionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSuggestionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSuggestionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSuggestionDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSuggestionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'placeId')  Object? placeId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'label')  Object? label, @JsonKey(name: 'text')  Object? text, @JsonKey(name: 'secondaryLabel')  Object? secondaryLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSuggestionDto() when $default != null:
return $default(_that.placeId,_that.id,_that.label,_that.text,_that.secondaryLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'placeId')  Object? placeId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'label')  Object? label, @JsonKey(name: 'text')  Object? text, @JsonKey(name: 'secondaryLabel')  Object? secondaryLabel)  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestionDto():
return $default(_that.placeId,_that.id,_that.label,_that.text,_that.secondaryLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'placeId')  Object? placeId, @JsonKey(name: 'id')  Object? id, @JsonKey(name: 'label')  Object? label, @JsonKey(name: 'text')  Object? text, @JsonKey(name: 'secondaryLabel')  Object? secondaryLabel)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestionDto() when $default != null:
return $default(_that.placeId,_that.id,_that.label,_that.text,_that.secondaryLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceSuggestionDto implements PlaceSuggestionDto {
  const _PlaceSuggestionDto({@JsonKey(name: 'placeId') this.placeId, @JsonKey(name: 'id') this.id, @JsonKey(name: 'label') this.label, @JsonKey(name: 'text') this.text, @JsonKey(name: 'secondaryLabel') this.secondaryLabel});
  factory _PlaceSuggestionDto.fromJson(Map<String, dynamic> json) => _$PlaceSuggestionDtoFromJson(json);

@override@JsonKey(name: 'placeId') final  Object? placeId;
@override@JsonKey(name: 'id') final  Object? id;
@override@JsonKey(name: 'label') final  Object? label;
@override@JsonKey(name: 'text') final  Object? text;
@override@JsonKey(name: 'secondaryLabel') final  Object? secondaryLabel;

/// Create a copy of PlaceSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSuggestionDtoCopyWith<_PlaceSuggestionDto> get copyWith => __$PlaceSuggestionDtoCopyWithImpl<_PlaceSuggestionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceSuggestionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSuggestionDto&&const DeepCollectionEquality().equals(other.placeId, placeId)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.label, label)&&const DeepCollectionEquality().equals(other.text, text)&&const DeepCollectionEquality().equals(other.secondaryLabel, secondaryLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(placeId),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(label),const DeepCollectionEquality().hash(text),const DeepCollectionEquality().hash(secondaryLabel));

@override
String toString() {
  return 'PlaceSuggestionDto(placeId: $placeId, id: $id, label: $label, text: $text, secondaryLabel: $secondaryLabel)';
}


}

/// @nodoc
abstract mixin class _$PlaceSuggestionDtoCopyWith<$Res> implements $PlaceSuggestionDtoCopyWith<$Res> {
  factory _$PlaceSuggestionDtoCopyWith(_PlaceSuggestionDto value, $Res Function(_PlaceSuggestionDto) _then) = __$PlaceSuggestionDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'placeId') Object? placeId,@JsonKey(name: 'id') Object? id,@JsonKey(name: 'label') Object? label,@JsonKey(name: 'text') Object? text,@JsonKey(name: 'secondaryLabel') Object? secondaryLabel
});




}
/// @nodoc
class __$PlaceSuggestionDtoCopyWithImpl<$Res>
    implements _$PlaceSuggestionDtoCopyWith<$Res> {
  __$PlaceSuggestionDtoCopyWithImpl(this._self, this._then);

  final _PlaceSuggestionDto _self;
  final $Res Function(_PlaceSuggestionDto) _then;

/// Create a copy of PlaceSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = freezed,Object? id = freezed,Object? label = freezed,Object? text = freezed,Object? secondaryLabel = freezed,}) {
  return _then(_PlaceSuggestionDto(
placeId: freezed == placeId ? _self.placeId : placeId ,id: freezed == id ? _self.id : id ,label: freezed == label ? _self.label : label ,text: freezed == text ? _self.text : text ,secondaryLabel: freezed == secondaryLabel ? _self.secondaryLabel : secondaryLabel ,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopSetupState {

 ShopSetupStep get step;/// Null only until the shop has been loaded or created.
 Shop? get shop; List<PlaceSuggestion> get suggestions;/// The initial load — `GET /me/shop`, and `POST /shops` if there isn't one.
 bool get isLoading;/// A step is being saved. Blocks the step's own action, not the whole
/// screen: the owner can still read what they typed.
 bool get isSaving; bool get isSearching;/// Publishing succeeded; the host navigates away on this.
 bool get isPublished;/// The service the inline card is editing, or null when it is adding a new
/// one. The card is the same either way — there is no modal to lose, which
/// is the point of editing in place.
 String? get editingServiceId;/// The file the owner just picked, shown while it uploads so the preview
/// is instant. A path rather than an `XFile`, which has no value equality
/// and would defeat the state's `==`.
 String? get pendingPhotoPath;/// Separate from [isSaving] so a photo upload does not put the step's
/// Continue button into a loading state it has nothing to do with.
 bool get isUploadingPhoto; NetworkException? get failure;
/// Create a copy of ShopSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSetupStateCopyWith<ShopSetupState> get copyWith => _$ShopSetupStateCopyWithImpl<ShopSetupState>(this as ShopSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSetupState&&(identical(other.step, step) || other.step == step)&&(identical(other.shop, shop) || other.shop == shop)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.editingServiceId, editingServiceId) || other.editingServiceId == editingServiceId)&&(identical(other.pendingPhotoPath, pendingPhotoPath) || other.pendingPhotoPath == pendingPhotoPath)&&(identical(other.isUploadingPhoto, isUploadingPhoto) || other.isUploadingPhoto == isUploadingPhoto)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,step,shop,const DeepCollectionEquality().hash(suggestions),isLoading,isSaving,isSearching,isPublished,editingServiceId,pendingPhotoPath,isUploadingPhoto,failure);

@override
String toString() {
  return 'ShopSetupState(step: $step, shop: $shop, suggestions: $suggestions, isLoading: $isLoading, isSaving: $isSaving, isSearching: $isSearching, isPublished: $isPublished, editingServiceId: $editingServiceId, pendingPhotoPath: $pendingPhotoPath, isUploadingPhoto: $isUploadingPhoto, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ShopSetupStateCopyWith<$Res>  {
  factory $ShopSetupStateCopyWith(ShopSetupState value, $Res Function(ShopSetupState) _then) = _$ShopSetupStateCopyWithImpl;
@useResult
$Res call({
 ShopSetupStep step, Shop? shop, List<PlaceSuggestion> suggestions, bool isLoading, bool isSaving, bool isSearching, bool isPublished, String? editingServiceId, String? pendingPhotoPath, bool isUploadingPhoto, NetworkException? failure
});


$ShopCopyWith<$Res>? get shop;

}
/// @nodoc
class _$ShopSetupStateCopyWithImpl<$Res>
    implements $ShopSetupStateCopyWith<$Res> {
  _$ShopSetupStateCopyWithImpl(this._self, this._then);

  final ShopSetupState _self;
  final $Res Function(ShopSetupState) _then;

/// Create a copy of ShopSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? shop = freezed,Object? suggestions = null,Object? isLoading = null,Object? isSaving = null,Object? isSearching = null,Object? isPublished = null,Object? editingServiceId = freezed,Object? pendingPhotoPath = freezed,Object? isUploadingPhoto = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ShopSetupStep,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<PlaceSuggestion>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,editingServiceId: freezed == editingServiceId ? _self.editingServiceId : editingServiceId // ignore: cast_nullable_to_non_nullable
as String?,pendingPhotoPath: freezed == pendingPhotoPath ? _self.pendingPhotoPath : pendingPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,isUploadingPhoto: null == isUploadingPhoto ? _self.isUploadingPhoto : isUploadingPhoto // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of ShopSetupState
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
}
}


/// Adds pattern-matching-related methods to [ShopSetupState].
extension ShopSetupStatePatterns on ShopSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopSetupState value)  $default,){
final _that = this;
switch (_that) {
case _ShopSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _ShopSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ShopSetupStep step,  Shop? shop,  List<PlaceSuggestion> suggestions,  bool isLoading,  bool isSaving,  bool isSearching,  bool isPublished,  String? editingServiceId,  String? pendingPhotoPath,  bool isUploadingPhoto,  NetworkException? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopSetupState() when $default != null:
return $default(_that.step,_that.shop,_that.suggestions,_that.isLoading,_that.isSaving,_that.isSearching,_that.isPublished,_that.editingServiceId,_that.pendingPhotoPath,_that.isUploadingPhoto,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ShopSetupStep step,  Shop? shop,  List<PlaceSuggestion> suggestions,  bool isLoading,  bool isSaving,  bool isSearching,  bool isPublished,  String? editingServiceId,  String? pendingPhotoPath,  bool isUploadingPhoto,  NetworkException? failure)  $default,) {final _that = this;
switch (_that) {
case _ShopSetupState():
return $default(_that.step,_that.shop,_that.suggestions,_that.isLoading,_that.isSaving,_that.isSearching,_that.isPublished,_that.editingServiceId,_that.pendingPhotoPath,_that.isUploadingPhoto,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ShopSetupStep step,  Shop? shop,  List<PlaceSuggestion> suggestions,  bool isLoading,  bool isSaving,  bool isSearching,  bool isPublished,  String? editingServiceId,  String? pendingPhotoPath,  bool isUploadingPhoto,  NetworkException? failure)?  $default,) {final _that = this;
switch (_that) {
case _ShopSetupState() when $default != null:
return $default(_that.step,_that.shop,_that.suggestions,_that.isLoading,_that.isSaving,_that.isSearching,_that.isPublished,_that.editingServiceId,_that.pendingPhotoPath,_that.isUploadingPhoto,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ShopSetupState extends ShopSetupState {
  const _ShopSetupState({this.step = ShopSetupStep.shop, this.shop, final  List<PlaceSuggestion> suggestions = const <PlaceSuggestion>[], this.isLoading = true, this.isSaving = false, this.isSearching = false, this.isPublished = false, this.editingServiceId, this.pendingPhotoPath, this.isUploadingPhoto = false, this.failure}): _suggestions = suggestions,super._();
  

@override@JsonKey() final  ShopSetupStep step;
/// Null only until the shop has been loaded or created.
@override final  Shop? shop;
 final  List<PlaceSuggestion> _suggestions;
@override@JsonKey() List<PlaceSuggestion> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

/// The initial load — `GET /me/shop`, and `POST /shops` if there isn't one.
@override@JsonKey() final  bool isLoading;
/// A step is being saved. Blocks the step's own action, not the whole
/// screen: the owner can still read what they typed.
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSearching;
/// Publishing succeeded; the host navigates away on this.
@override@JsonKey() final  bool isPublished;
/// The service the inline card is editing, or null when it is adding a new
/// one. The card is the same either way — there is no modal to lose, which
/// is the point of editing in place.
@override final  String? editingServiceId;
/// The file the owner just picked, shown while it uploads so the preview
/// is instant. A path rather than an `XFile`, which has no value equality
/// and would defeat the state's `==`.
@override final  String? pendingPhotoPath;
/// Separate from [isSaving] so a photo upload does not put the step's
/// Continue button into a loading state it has nothing to do with.
@override@JsonKey() final  bool isUploadingPhoto;
@override final  NetworkException? failure;

/// Create a copy of ShopSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopSetupStateCopyWith<_ShopSetupState> get copyWith => __$ShopSetupStateCopyWithImpl<_ShopSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopSetupState&&(identical(other.step, step) || other.step == step)&&(identical(other.shop, shop) || other.shop == shop)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.editingServiceId, editingServiceId) || other.editingServiceId == editingServiceId)&&(identical(other.pendingPhotoPath, pendingPhotoPath) || other.pendingPhotoPath == pendingPhotoPath)&&(identical(other.isUploadingPhoto, isUploadingPhoto) || other.isUploadingPhoto == isUploadingPhoto)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,step,shop,const DeepCollectionEquality().hash(_suggestions),isLoading,isSaving,isSearching,isPublished,editingServiceId,pendingPhotoPath,isUploadingPhoto,failure);

@override
String toString() {
  return 'ShopSetupState(step: $step, shop: $shop, suggestions: $suggestions, isLoading: $isLoading, isSaving: $isSaving, isSearching: $isSearching, isPublished: $isPublished, editingServiceId: $editingServiceId, pendingPhotoPath: $pendingPhotoPath, isUploadingPhoto: $isUploadingPhoto, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ShopSetupStateCopyWith<$Res> implements $ShopSetupStateCopyWith<$Res> {
  factory _$ShopSetupStateCopyWith(_ShopSetupState value, $Res Function(_ShopSetupState) _then) = __$ShopSetupStateCopyWithImpl;
@override @useResult
$Res call({
 ShopSetupStep step, Shop? shop, List<PlaceSuggestion> suggestions, bool isLoading, bool isSaving, bool isSearching, bool isPublished, String? editingServiceId, String? pendingPhotoPath, bool isUploadingPhoto, NetworkException? failure
});


@override $ShopCopyWith<$Res>? get shop;

}
/// @nodoc
class __$ShopSetupStateCopyWithImpl<$Res>
    implements _$ShopSetupStateCopyWith<$Res> {
  __$ShopSetupStateCopyWithImpl(this._self, this._then);

  final _ShopSetupState _self;
  final $Res Function(_ShopSetupState) _then;

/// Create a copy of ShopSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? shop = freezed,Object? suggestions = null,Object? isLoading = null,Object? isSaving = null,Object? isSearching = null,Object? isPublished = null,Object? editingServiceId = freezed,Object? pendingPhotoPath = freezed,Object? isUploadingPhoto = null,Object? failure = freezed,}) {
  return _then(_ShopSetupState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ShopSetupStep,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as Shop?,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<PlaceSuggestion>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,editingServiceId: freezed == editingServiceId ? _self.editingServiceId : editingServiceId // ignore: cast_nullable_to_non_nullable
as String?,pendingPhotoPath: freezed == pendingPhotoPath ? _self.pendingPhotoPath : pendingPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,isUploadingPhoto: null == isUploadingPhoto ? _self.isUploadingPhoto : isUploadingPhoto // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of ShopSetupState
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
}
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_destination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthDestination {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination()';
}


}

/// @nodoc
class $AuthDestinationCopyWith<$Res>  {
$AuthDestinationCopyWith(AuthDestination _, $Res Function(AuthDestination) __);
}


/// Adds pattern-matching-related methods to [AuthDestination].
extension AuthDestinationPatterns on AuthDestination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignInDestination value)?  signIn,TResult Function( RoleChoiceDestination value)?  roleChoice,TResult Function( ShopSetupDestination value)?  shopSetup,TResult Function( OwnerAgendaDestination value)?  ownerAgenda,TResult Function( CustomerHomeDestination value)?  customerHome,TResult Function( ProfileSetupDestination value)?  profileSetup,TResult Function( NotificationPermissionDestination value)?  notificationPermission,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignInDestination() when signIn != null:
return signIn(_that);case RoleChoiceDestination() when roleChoice != null:
return roleChoice(_that);case ShopSetupDestination() when shopSetup != null:
return shopSetup(_that);case OwnerAgendaDestination() when ownerAgenda != null:
return ownerAgenda(_that);case CustomerHomeDestination() when customerHome != null:
return customerHome(_that);case ProfileSetupDestination() when profileSetup != null:
return profileSetup(_that);case NotificationPermissionDestination() when notificationPermission != null:
return notificationPermission(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignInDestination value)  signIn,required TResult Function( RoleChoiceDestination value)  roleChoice,required TResult Function( ShopSetupDestination value)  shopSetup,required TResult Function( OwnerAgendaDestination value)  ownerAgenda,required TResult Function( CustomerHomeDestination value)  customerHome,required TResult Function( ProfileSetupDestination value)  profileSetup,required TResult Function( NotificationPermissionDestination value)  notificationPermission,}){
final _that = this;
switch (_that) {
case SignInDestination():
return signIn(_that);case RoleChoiceDestination():
return roleChoice(_that);case ShopSetupDestination():
return shopSetup(_that);case OwnerAgendaDestination():
return ownerAgenda(_that);case CustomerHomeDestination():
return customerHome(_that);case ProfileSetupDestination():
return profileSetup(_that);case NotificationPermissionDestination():
return notificationPermission(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignInDestination value)?  signIn,TResult? Function( RoleChoiceDestination value)?  roleChoice,TResult? Function( ShopSetupDestination value)?  shopSetup,TResult? Function( OwnerAgendaDestination value)?  ownerAgenda,TResult? Function( CustomerHomeDestination value)?  customerHome,TResult? Function( ProfileSetupDestination value)?  profileSetup,TResult? Function( NotificationPermissionDestination value)?  notificationPermission,}){
final _that = this;
switch (_that) {
case SignInDestination() when signIn != null:
return signIn(_that);case RoleChoiceDestination() when roleChoice != null:
return roleChoice(_that);case ShopSetupDestination() when shopSetup != null:
return shopSetup(_that);case OwnerAgendaDestination() when ownerAgenda != null:
return ownerAgenda(_that);case CustomerHomeDestination() when customerHome != null:
return customerHome(_that);case ProfileSetupDestination() when profileSetup != null:
return profileSetup(_that);case NotificationPermissionDestination() when notificationPermission != null:
return notificationPermission(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  signIn,TResult Function()?  roleChoice,TResult Function( ShopSetupStep step)?  shopSetup,TResult Function()?  ownerAgenda,TResult Function()?  customerHome,TResult Function()?  profileSetup,TResult Function()?  notificationPermission,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignInDestination() when signIn != null:
return signIn();case RoleChoiceDestination() when roleChoice != null:
return roleChoice();case ShopSetupDestination() when shopSetup != null:
return shopSetup(_that.step);case OwnerAgendaDestination() when ownerAgenda != null:
return ownerAgenda();case CustomerHomeDestination() when customerHome != null:
return customerHome();case ProfileSetupDestination() when profileSetup != null:
return profileSetup();case NotificationPermissionDestination() when notificationPermission != null:
return notificationPermission();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  signIn,required TResult Function()  roleChoice,required TResult Function( ShopSetupStep step)  shopSetup,required TResult Function()  ownerAgenda,required TResult Function()  customerHome,required TResult Function()  profileSetup,required TResult Function()  notificationPermission,}) {final _that = this;
switch (_that) {
case SignInDestination():
return signIn();case RoleChoiceDestination():
return roleChoice();case ShopSetupDestination():
return shopSetup(_that.step);case OwnerAgendaDestination():
return ownerAgenda();case CustomerHomeDestination():
return customerHome();case ProfileSetupDestination():
return profileSetup();case NotificationPermissionDestination():
return notificationPermission();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  signIn,TResult? Function()?  roleChoice,TResult? Function( ShopSetupStep step)?  shopSetup,TResult? Function()?  ownerAgenda,TResult? Function()?  customerHome,TResult? Function()?  profileSetup,TResult? Function()?  notificationPermission,}) {final _that = this;
switch (_that) {
case SignInDestination() when signIn != null:
return signIn();case RoleChoiceDestination() when roleChoice != null:
return roleChoice();case ShopSetupDestination() when shopSetup != null:
return shopSetup(_that.step);case OwnerAgendaDestination() when ownerAgenda != null:
return ownerAgenda();case CustomerHomeDestination() when customerHome != null:
return customerHome();case ProfileSetupDestination() when profileSetup != null:
return profileSetup();case NotificationPermissionDestination() when notificationPermission != null:
return notificationPermission();case _:
  return null;

}
}

}

/// @nodoc


class SignInDestination implements AuthDestination {
  const SignInDestination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination.signIn()';
}


}




/// @nodoc


class RoleChoiceDestination implements AuthDestination {
  const RoleChoiceDestination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleChoiceDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination.roleChoice()';
}


}




/// @nodoc


class ShopSetupDestination implements AuthDestination {
  const ShopSetupDestination(this.step);
  

 final  ShopSetupStep step;

/// Create a copy of AuthDestination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSetupDestinationCopyWith<ShopSetupDestination> get copyWith => _$ShopSetupDestinationCopyWithImpl<ShopSetupDestination>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSetupDestination&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'AuthDestination.shopSetup(step: $step)';
}


}

/// @nodoc
abstract mixin class $ShopSetupDestinationCopyWith<$Res> implements $AuthDestinationCopyWith<$Res> {
  factory $ShopSetupDestinationCopyWith(ShopSetupDestination value, $Res Function(ShopSetupDestination) _then) = _$ShopSetupDestinationCopyWithImpl;
@useResult
$Res call({
 ShopSetupStep step
});




}
/// @nodoc
class _$ShopSetupDestinationCopyWithImpl<$Res>
    implements $ShopSetupDestinationCopyWith<$Res> {
  _$ShopSetupDestinationCopyWithImpl(this._self, this._then);

  final ShopSetupDestination _self;
  final $Res Function(ShopSetupDestination) _then;

/// Create a copy of AuthDestination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(ShopSetupDestination(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ShopSetupStep,
  ));
}


}

/// @nodoc


class OwnerAgendaDestination implements AuthDestination {
  const OwnerAgendaDestination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerAgendaDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination.ownerAgenda()';
}


}




/// @nodoc


class CustomerHomeDestination implements AuthDestination {
  const CustomerHomeDestination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerHomeDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination.customerHome()';
}


}




/// @nodoc


class ProfileSetupDestination implements AuthDestination {
  const ProfileSetupDestination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination.profileSetup()';
}


}




/// @nodoc


class NotificationPermissionDestination implements AuthDestination {
  const NotificationPermissionDestination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPermissionDestination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthDestination.notificationPermission()';
}


}




// dart format on

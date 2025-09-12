// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InviteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InviteState()';
}


}

/// @nodoc
class $InviteStateCopyWith<$Res>  {
$InviteStateCopyWith(InviteState _, $Res Function(InviteState) __);
}


/// Adds pattern-matching-related methods to [InviteState].
extension InviteStatePatterns on InviteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InviteIdle value)?  idle,TResult Function( _InviteLoading value)?  loading,TResult Function( _InviteError value)?  error,TResult Function( _InviteSuccess value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteIdle() when idle != null:
return idle(_that);case _InviteLoading() when loading != null:
return loading(_that);case _InviteError() when error != null:
return error(_that);case _InviteSuccess() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InviteIdle value)  idle,required TResult Function( _InviteLoading value)  loading,required TResult Function( _InviteError value)  error,required TResult Function( _InviteSuccess value)  success,}){
final _that = this;
switch (_that) {
case _InviteIdle():
return idle(_that);case _InviteLoading():
return loading(_that);case _InviteError():
return error(_that);case _InviteSuccess():
return success(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InviteIdle value)?  idle,TResult? Function( _InviteLoading value)?  loading,TResult? Function( _InviteError value)?  error,TResult? Function( _InviteSuccess value)?  success,}){
final _that = this;
switch (_that) {
case _InviteIdle() when idle != null:
return idle(_that);case _InviteLoading() when loading != null:
return loading(_that);case _InviteError() when error != null:
return error(_that);case _InviteSuccess() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( String ownerUid,  AuthResult result)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteIdle() when idle != null:
return idle();case _InviteLoading() when loading != null:
return loading();case _InviteError() when error != null:
return error(_that.message);case _InviteSuccess() when success != null:
return success(_that.ownerUid,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( String ownerUid,  AuthResult result)  success,}) {final _that = this;
switch (_that) {
case _InviteIdle():
return idle();case _InviteLoading():
return loading();case _InviteError():
return error(_that.message);case _InviteSuccess():
return success(_that.ownerUid,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( String ownerUid,  AuthResult result)?  success,}) {final _that = this;
switch (_that) {
case _InviteIdle() when idle != null:
return idle();case _InviteLoading() when loading != null:
return loading();case _InviteError() when error != null:
return error(_that.message);case _InviteSuccess() when success != null:
return success(_that.ownerUid,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _InviteIdle implements InviteState {
  const _InviteIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InviteState.idle()';
}


}




/// @nodoc


class _InviteLoading implements InviteState {
  const _InviteLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InviteState.loading()';
}


}




/// @nodoc


class _InviteError implements InviteState {
  const _InviteError(this.message);
  

 final  String message;

/// Create a copy of InviteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteErrorCopyWith<_InviteError> get copyWith => __$InviteErrorCopyWithImpl<_InviteError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'InviteState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$InviteErrorCopyWith<$Res> implements $InviteStateCopyWith<$Res> {
  factory _$InviteErrorCopyWith(_InviteError value, $Res Function(_InviteError) _then) = __$InviteErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$InviteErrorCopyWithImpl<$Res>
    implements _$InviteErrorCopyWith<$Res> {
  __$InviteErrorCopyWithImpl(this._self, this._then);

  final _InviteError _self;
  final $Res Function(_InviteError) _then;

/// Create a copy of InviteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_InviteError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _InviteSuccess implements InviteState {
  const _InviteSuccess({required this.ownerUid, required this.result});
  

 final  String ownerUid;
 final  AuthResult result;

/// Create a copy of InviteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteSuccessCopyWith<_InviteSuccess> get copyWith => __$InviteSuccessCopyWithImpl<_InviteSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteSuccess&&(identical(other.ownerUid, ownerUid) || other.ownerUid == ownerUid)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,ownerUid,result);

@override
String toString() {
  return 'InviteState.success(ownerUid: $ownerUid, result: $result)';
}


}

/// @nodoc
abstract mixin class _$InviteSuccessCopyWith<$Res> implements $InviteStateCopyWith<$Res> {
  factory _$InviteSuccessCopyWith(_InviteSuccess value, $Res Function(_InviteSuccess) _then) = __$InviteSuccessCopyWithImpl;
@useResult
$Res call({
 String ownerUid, AuthResult result
});


$AuthResultCopyWith<$Res> get result;

}
/// @nodoc
class __$InviteSuccessCopyWithImpl<$Res>
    implements _$InviteSuccessCopyWith<$Res> {
  __$InviteSuccessCopyWithImpl(this._self, this._then);

  final _InviteSuccess _self;
  final $Res Function(_InviteSuccess) _then;

/// Create a copy of InviteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ownerUid = null,Object? result = null,}) {
  return _then(_InviteSuccess(
ownerUid: null == ownerUid ? _self.ownerUid : ownerUid // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AuthResult,
  ));
}

/// Create a copy of InviteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthResultCopyWith<$Res> get result {
  
  return $AuthResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on

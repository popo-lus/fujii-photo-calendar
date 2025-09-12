// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoginIdle value)?  idle,TResult Function( _LoginLoading value)?  loading,TResult Function( _LoginError value)?  error,TResult Function( _LoginSuccess value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginIdle() when idle != null:
return idle(_that);case _LoginLoading() when loading != null:
return loading(_that);case _LoginError() when error != null:
return error(_that);case _LoginSuccess() when success != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoginIdle value)  idle,required TResult Function( _LoginLoading value)  loading,required TResult Function( _LoginError value)  error,required TResult Function( _LoginSuccess value)  success,}){
final _that = this;
switch (_that) {
case _LoginIdle():
return idle(_that);case _LoginLoading():
return loading(_that);case _LoginError():
return error(_that);case _LoginSuccess():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoginIdle value)?  idle,TResult? Function( _LoginLoading value)?  loading,TResult? Function( _LoginError value)?  error,TResult? Function( _LoginSuccess value)?  success,}){
final _that = this;
switch (_that) {
case _LoginIdle() when idle != null:
return idle(_that);case _LoginLoading() when loading != null:
return loading(_that);case _LoginError() when error != null:
return error(_that);case _LoginSuccess() when success != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( AuthResult result)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginIdle() when idle != null:
return idle();case _LoginLoading() when loading != null:
return loading();case _LoginError() when error != null:
return error(_that.message);case _LoginSuccess() when success != null:
return success(_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( AuthResult result)  success,}) {final _that = this;
switch (_that) {
case _LoginIdle():
return idle();case _LoginLoading():
return loading();case _LoginError():
return error(_that.message);case _LoginSuccess():
return success(_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( AuthResult result)?  success,}) {final _that = this;
switch (_that) {
case _LoginIdle() when idle != null:
return idle();case _LoginLoading() when loading != null:
return loading();case _LoginError() when error != null:
return error(_that.message);case _LoginSuccess() when success != null:
return success(_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _LoginIdle implements LoginState {
  const _LoginIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.idle()';
}


}




/// @nodoc


class _LoginLoading implements LoginState {
  const _LoginLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loading()';
}


}




/// @nodoc


class _LoginError implements LoginState {
  const _LoginError(this.message);
  

 final  String message;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginErrorCopyWith<_LoginError> get copyWith => __$LoginErrorCopyWithImpl<_LoginError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LoginState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoginErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginErrorCopyWith(_LoginError value, $Res Function(_LoginError) _then) = __$LoginErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LoginErrorCopyWithImpl<$Res>
    implements _$LoginErrorCopyWith<$Res> {
  __$LoginErrorCopyWithImpl(this._self, this._then);

  final _LoginError _self;
  final $Res Function(_LoginError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LoginError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoginSuccess implements LoginState {
  const _LoginSuccess(this.result);
  

 final  AuthResult result;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginSuccessCopyWith<_LoginSuccess> get copyWith => __$LoginSuccessCopyWithImpl<_LoginSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'LoginState.success(result: $result)';
}


}

/// @nodoc
abstract mixin class _$LoginSuccessCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginSuccessCopyWith(_LoginSuccess value, $Res Function(_LoginSuccess) _then) = __$LoginSuccessCopyWithImpl;
@useResult
$Res call({
 AuthResult result
});


$AuthResultCopyWith<$Res> get result;

}
/// @nodoc
class __$LoginSuccessCopyWithImpl<$Res>
    implements _$LoginSuccessCopyWith<$Res> {
  __$LoginSuccessCopyWithImpl(this._self, this._then);

  final _LoginSuccess _self;
  final $Res Function(_LoginSuccess) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_LoginSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AuthResult,
  ));
}

/// Create a copy of LoginState
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

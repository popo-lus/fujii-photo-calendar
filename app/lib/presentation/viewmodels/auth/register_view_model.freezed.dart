// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState()';
}


}

/// @nodoc
class $RegisterStateCopyWith<$Res>  {
$RegisterStateCopyWith(RegisterState _, $Res Function(RegisterState) __);
}


/// Adds pattern-matching-related methods to [RegisterState].
extension RegisterStatePatterns on RegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RegisterIdle value)?  idle,TResult Function( _RegisterLoading value)?  loading,TResult Function( _RegisterError value)?  error,TResult Function( _RegisterSuccess value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterIdle() when idle != null:
return idle(_that);case _RegisterLoading() when loading != null:
return loading(_that);case _RegisterError() when error != null:
return error(_that);case _RegisterSuccess() when success != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RegisterIdle value)  idle,required TResult Function( _RegisterLoading value)  loading,required TResult Function( _RegisterError value)  error,required TResult Function( _RegisterSuccess value)  success,}){
final _that = this;
switch (_that) {
case _RegisterIdle():
return idle(_that);case _RegisterLoading():
return loading(_that);case _RegisterError():
return error(_that);case _RegisterSuccess():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RegisterIdle value)?  idle,TResult? Function( _RegisterLoading value)?  loading,TResult? Function( _RegisterError value)?  error,TResult? Function( _RegisterSuccess value)?  success,}){
final _that = this;
switch (_that) {
case _RegisterIdle() when idle != null:
return idle(_that);case _RegisterLoading() when loading != null:
return loading(_that);case _RegisterError() when error != null:
return error(_that);case _RegisterSuccess() when success != null:
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
case _RegisterIdle() when idle != null:
return idle();case _RegisterLoading() when loading != null:
return loading();case _RegisterError() when error != null:
return error(_that.message);case _RegisterSuccess() when success != null:
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
case _RegisterIdle():
return idle();case _RegisterLoading():
return loading();case _RegisterError():
return error(_that.message);case _RegisterSuccess():
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
case _RegisterIdle() when idle != null:
return idle();case _RegisterLoading() when loading != null:
return loading();case _RegisterError() when error != null:
return error(_that.message);case _RegisterSuccess() when success != null:
return success(_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterIdle implements RegisterState {
  const _RegisterIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.idle()';
}


}




/// @nodoc


class _RegisterLoading implements RegisterState {
  const _RegisterLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.loading()';
}


}




/// @nodoc


class _RegisterError implements RegisterState {
  const _RegisterError(this.message);
  

 final  String message;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterErrorCopyWith<_RegisterError> get copyWith => __$RegisterErrorCopyWithImpl<_RegisterError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RegisterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$RegisterErrorCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory _$RegisterErrorCopyWith(_RegisterError value, $Res Function(_RegisterError) _then) = __$RegisterErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$RegisterErrorCopyWithImpl<$Res>
    implements _$RegisterErrorCopyWith<$Res> {
  __$RegisterErrorCopyWithImpl(this._self, this._then);

  final _RegisterError _self;
  final $Res Function(_RegisterError) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_RegisterError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RegisterSuccess implements RegisterState {
  const _RegisterSuccess(this.result);
  

 final  AuthResult result;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterSuccessCopyWith<_RegisterSuccess> get copyWith => __$RegisterSuccessCopyWithImpl<_RegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'RegisterState.success(result: $result)';
}


}

/// @nodoc
abstract mixin class _$RegisterSuccessCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory _$RegisterSuccessCopyWith(_RegisterSuccess value, $Res Function(_RegisterSuccess) _then) = __$RegisterSuccessCopyWithImpl;
@useResult
$Res call({
 AuthResult result
});


$AuthResultCopyWith<$Res> get result;

}
/// @nodoc
class __$RegisterSuccessCopyWithImpl<$Res>
    implements _$RegisterSuccessCopyWith<$Res> {
  __$RegisterSuccessCopyWithImpl(this._self, this._then);

  final _RegisterSuccess _self;
  final $Res Function(_RegisterSuccess) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_RegisterSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AuthResult,
  ));
}

/// Create a copy of RegisterState
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

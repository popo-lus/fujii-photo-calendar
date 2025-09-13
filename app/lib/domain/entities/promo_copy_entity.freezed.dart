// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promo_copy_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PromoCopyEntity {

 String get text; String get source;
/// Create a copy of PromoCopyEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromoCopyEntityCopyWith<PromoCopyEntity> get copyWith => _$PromoCopyEntityCopyWithImpl<PromoCopyEntity>(this as PromoCopyEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromoCopyEntity&&(identical(other.text, text) || other.text == text)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,text,source);

@override
String toString() {
  return 'PromoCopyEntity(text: $text, source: $source)';
}


}

/// @nodoc
abstract mixin class $PromoCopyEntityCopyWith<$Res>  {
  factory $PromoCopyEntityCopyWith(PromoCopyEntity value, $Res Function(PromoCopyEntity) _then) = _$PromoCopyEntityCopyWithImpl;
@useResult
$Res call({
 String text, String source
});




}
/// @nodoc
class _$PromoCopyEntityCopyWithImpl<$Res>
    implements $PromoCopyEntityCopyWith<$Res> {
  _$PromoCopyEntityCopyWithImpl(this._self, this._then);

  final PromoCopyEntity _self;
  final $Res Function(PromoCopyEntity) _then;

/// Create a copy of PromoCopyEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? source = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PromoCopyEntity].
extension PromoCopyEntityPatterns on PromoCopyEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromoCopyEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromoCopyEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromoCopyEntity value)  $default,){
final _that = this;
switch (_that) {
case _PromoCopyEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromoCopyEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PromoCopyEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromoCopyEntity() when $default != null:
return $default(_that.text,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String source)  $default,) {final _that = this;
switch (_that) {
case _PromoCopyEntity():
return $default(_that.text,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String source)?  $default,) {final _that = this;
switch (_that) {
case _PromoCopyEntity() when $default != null:
return $default(_that.text,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _PromoCopyEntity implements PromoCopyEntity {
  const _PromoCopyEntity({required this.text, this.source = 'gemini'});
  

@override final  String text;
@override@JsonKey() final  String source;

/// Create a copy of PromoCopyEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromoCopyEntityCopyWith<_PromoCopyEntity> get copyWith => __$PromoCopyEntityCopyWithImpl<_PromoCopyEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromoCopyEntity&&(identical(other.text, text) || other.text == text)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,text,source);

@override
String toString() {
  return 'PromoCopyEntity(text: $text, source: $source)';
}


}

/// @nodoc
abstract mixin class _$PromoCopyEntityCopyWith<$Res> implements $PromoCopyEntityCopyWith<$Res> {
  factory _$PromoCopyEntityCopyWith(_PromoCopyEntity value, $Res Function(_PromoCopyEntity) _then) = __$PromoCopyEntityCopyWithImpl;
@override @useResult
$Res call({
 String text, String source
});




}
/// @nodoc
class __$PromoCopyEntityCopyWithImpl<$Res>
    implements _$PromoCopyEntityCopyWith<$Res> {
  __$PromoCopyEntityCopyWithImpl(this._self, this._then);

  final _PromoCopyEntity _self;
  final $Res Function(_PromoCopyEntity) _then;

/// Create a copy of PromoCopyEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? source = null,}) {
  return _then(_PromoCopyEntity(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

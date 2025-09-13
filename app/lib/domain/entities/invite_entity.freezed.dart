// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviteEntity {

 String get code; String get ownerUid; bool get disabled; DateTime? get expiresAt; DateTime? get createdAt;
/// Create a copy of InviteEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteEntityCopyWith<InviteEntity> get copyWith => _$InviteEntityCopyWithImpl<InviteEntity>(this as InviteEntity, _$identity);

  /// Serializes this InviteEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.ownerUid, ownerUid) || other.ownerUid == ownerUid)&&(identical(other.disabled, disabled) || other.disabled == disabled)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,ownerUid,disabled,expiresAt,createdAt);

@override
String toString() {
  return 'InviteEntity(code: $code, ownerUid: $ownerUid, disabled: $disabled, expiresAt: $expiresAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InviteEntityCopyWith<$Res>  {
  factory $InviteEntityCopyWith(InviteEntity value, $Res Function(InviteEntity) _then) = _$InviteEntityCopyWithImpl;
@useResult
$Res call({
 String code, String ownerUid, bool disabled, DateTime? expiresAt, DateTime? createdAt
});




}
/// @nodoc
class _$InviteEntityCopyWithImpl<$Res>
    implements $InviteEntityCopyWith<$Res> {
  _$InviteEntityCopyWithImpl(this._self, this._then);

  final InviteEntity _self;
  final $Res Function(InviteEntity) _then;

/// Create a copy of InviteEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? ownerUid = null,Object? disabled = null,Object? expiresAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,ownerUid: null == ownerUid ? _self.ownerUid : ownerUid // ignore: cast_nullable_to_non_nullable
as String,disabled: null == disabled ? _self.disabled : disabled // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteEntity].
extension InviteEntityPatterns on InviteEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteEntity value)  $default,){
final _that = this;
switch (_that) {
case _InviteEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteEntity value)?  $default,){
final _that = this;
switch (_that) {
case _InviteEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String ownerUid,  bool disabled,  DateTime? expiresAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteEntity() when $default != null:
return $default(_that.code,_that.ownerUid,_that.disabled,_that.expiresAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String ownerUid,  bool disabled,  DateTime? expiresAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _InviteEntity():
return $default(_that.code,_that.ownerUid,_that.disabled,_that.expiresAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String ownerUid,  bool disabled,  DateTime? expiresAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InviteEntity() when $default != null:
return $default(_that.code,_that.ownerUid,_that.disabled,_that.expiresAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteEntity implements InviteEntity {
  const _InviteEntity({required this.code, required this.ownerUid, this.disabled = false, this.expiresAt, this.createdAt});
  factory _InviteEntity.fromJson(Map<String, dynamic> json) => _$InviteEntityFromJson(json);

@override final  String code;
@override final  String ownerUid;
@override@JsonKey() final  bool disabled;
@override final  DateTime? expiresAt;
@override final  DateTime? createdAt;

/// Create a copy of InviteEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteEntityCopyWith<_InviteEntity> get copyWith => __$InviteEntityCopyWithImpl<_InviteEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.ownerUid, ownerUid) || other.ownerUid == ownerUid)&&(identical(other.disabled, disabled) || other.disabled == disabled)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,ownerUid,disabled,expiresAt,createdAt);

@override
String toString() {
  return 'InviteEntity(code: $code, ownerUid: $ownerUid, disabled: $disabled, expiresAt: $expiresAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InviteEntityCopyWith<$Res> implements $InviteEntityCopyWith<$Res> {
  factory _$InviteEntityCopyWith(_InviteEntity value, $Res Function(_InviteEntity) _then) = __$InviteEntityCopyWithImpl;
@override @useResult
$Res call({
 String code, String ownerUid, bool disabled, DateTime? expiresAt, DateTime? createdAt
});




}
/// @nodoc
class __$InviteEntityCopyWithImpl<$Res>
    implements _$InviteEntityCopyWith<$Res> {
  __$InviteEntityCopyWithImpl(this._self, this._then);

  final _InviteEntity _self;
  final $Res Function(_InviteEntity) _then;

/// Create a copy of InviteEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? ownerUid = null,Object? disabled = null,Object? expiresAt = freezed,Object? createdAt = freezed,}) {
  return _then(_InviteEntity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,ownerUid: null == ownerUid ? _self.ownerUid : ownerUid // ignore: cast_nullable_to_non_nullable
as String,disabled: null == disabled ? _self.disabled : disabled // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

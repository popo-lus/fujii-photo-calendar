// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestEntity {

 String get id; String get ownerUid; String get requesterUid; String get comment; DateTime? get createdAt;
/// Create a copy of RequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestEntityCopyWith<RequestEntity> get copyWith => _$RequestEntityCopyWithImpl<RequestEntity>(this as RequestEntity, _$identity);

  /// Serializes this RequestEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerUid, ownerUid) || other.ownerUid == ownerUid)&&(identical(other.requesterUid, requesterUid) || other.requesterUid == requesterUid)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerUid,requesterUid,comment,createdAt);

@override
String toString() {
  return 'RequestEntity(id: $id, ownerUid: $ownerUid, requesterUid: $requesterUid, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RequestEntityCopyWith<$Res>  {
  factory $RequestEntityCopyWith(RequestEntity value, $Res Function(RequestEntity) _then) = _$RequestEntityCopyWithImpl;
@useResult
$Res call({
 String id, String ownerUid, String requesterUid, String comment, DateTime? createdAt
});




}
/// @nodoc
class _$RequestEntityCopyWithImpl<$Res>
    implements $RequestEntityCopyWith<$Res> {
  _$RequestEntityCopyWithImpl(this._self, this._then);

  final RequestEntity _self;
  final $Res Function(RequestEntity) _then;

/// Create a copy of RequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerUid = null,Object? requesterUid = null,Object? comment = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerUid: null == ownerUid ? _self.ownerUid : ownerUid // ignore: cast_nullable_to_non_nullable
as String,requesterUid: null == requesterUid ? _self.requesterUid : requesterUid // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestEntity].
extension RequestEntityPatterns on RequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _RequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerUid,  String requesterUid,  String comment,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestEntity() when $default != null:
return $default(_that.id,_that.ownerUid,_that.requesterUid,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerUid,  String requesterUid,  String comment,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _RequestEntity():
return $default(_that.id,_that.ownerUid,_that.requesterUid,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerUid,  String requesterUid,  String comment,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RequestEntity() when $default != null:
return $default(_that.id,_that.ownerUid,_that.requesterUid,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestEntity implements RequestEntity {
  const _RequestEntity({required this.id, required this.ownerUid, required this.requesterUid, required this.comment, this.createdAt});
  factory _RequestEntity.fromJson(Map<String, dynamic> json) => _$RequestEntityFromJson(json);

@override final  String id;
@override final  String ownerUid;
@override final  String requesterUid;
@override final  String comment;
@override final  DateTime? createdAt;

/// Create a copy of RequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestEntityCopyWith<_RequestEntity> get copyWith => __$RequestEntityCopyWithImpl<_RequestEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerUid, ownerUid) || other.ownerUid == ownerUid)&&(identical(other.requesterUid, requesterUid) || other.requesterUid == requesterUid)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerUid,requesterUid,comment,createdAt);

@override
String toString() {
  return 'RequestEntity(id: $id, ownerUid: $ownerUid, requesterUid: $requesterUid, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RequestEntityCopyWith<$Res> implements $RequestEntityCopyWith<$Res> {
  factory _$RequestEntityCopyWith(_RequestEntity value, $Res Function(_RequestEntity) _then) = __$RequestEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerUid, String requesterUid, String comment, DateTime? createdAt
});




}
/// @nodoc
class __$RequestEntityCopyWithImpl<$Res>
    implements _$RequestEntityCopyWith<$Res> {
  __$RequestEntityCopyWithImpl(this._self, this._then);

  final _RequestEntity _self;
  final $Res Function(_RequestEntity) _then;

/// Create a copy of RequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerUid = null,Object? requesterUid = null,Object? comment = null,Object? createdAt = freezed,}) {
  return _then(_RequestEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerUid: null == ownerUid ? _self.ownerUid : ownerUid // ignore: cast_nullable_to_non_nullable
as String,requesterUid: null == requesterUid ? _self.requesterUid : requesterUid // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

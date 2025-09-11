// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoEntity {

 String get id; PhotoType get type; int get month;// 1..12
 String get monthKey;// zero padded 2桁
 DateTime get capturedAt; String get url; int get priority;// derived (admin=10, user=0 初期)
 String? get memo; DateTime get updatedAt;
/// Create a copy of PhotoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoEntityCopyWith<PhotoEntity> get copyWith => _$PhotoEntityCopyWithImpl<PhotoEntity>(this as PhotoEntity, _$identity);

  /// Serializes this PhotoEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.month, month) || other.month == month)&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.url, url) || other.url == url)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,month,monthKey,capturedAt,url,priority,memo,updatedAt);

@override
String toString() {
  return 'PhotoEntity(id: $id, type: $type, month: $month, monthKey: $monthKey, capturedAt: $capturedAt, url: $url, priority: $priority, memo: $memo, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PhotoEntityCopyWith<$Res>  {
  factory $PhotoEntityCopyWith(PhotoEntity value, $Res Function(PhotoEntity) _then) = _$PhotoEntityCopyWithImpl;
@useResult
$Res call({
 String id, PhotoType type, int month, String monthKey, DateTime capturedAt, String url, int priority, String? memo, DateTime updatedAt
});




}
/// @nodoc
class _$PhotoEntityCopyWithImpl<$Res>
    implements $PhotoEntityCopyWith<$Res> {
  _$PhotoEntityCopyWithImpl(this._self, this._then);

  final PhotoEntity _self;
  final $Res Function(PhotoEntity) _then;

/// Create a copy of PhotoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? month = null,Object? monthKey = null,Object? capturedAt = null,Object? url = null,Object? priority = null,Object? memo = freezed,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PhotoType,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoEntity].
extension PhotoEntityPatterns on PhotoEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoEntity value)  $default,){
final _that = this;
switch (_that) {
case _PhotoEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PhotoType type,  int month,  String monthKey,  DateTime capturedAt,  String url,  int priority,  String? memo,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoEntity() when $default != null:
return $default(_that.id,_that.type,_that.month,_that.monthKey,_that.capturedAt,_that.url,_that.priority,_that.memo,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PhotoType type,  int month,  String monthKey,  DateTime capturedAt,  String url,  int priority,  String? memo,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PhotoEntity():
return $default(_that.id,_that.type,_that.month,_that.monthKey,_that.capturedAt,_that.url,_that.priority,_that.memo,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PhotoType type,  int month,  String monthKey,  DateTime capturedAt,  String url,  int priority,  String? memo,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PhotoEntity() when $default != null:
return $default(_that.id,_that.type,_that.month,_that.monthKey,_that.capturedAt,_that.url,_that.priority,_that.memo,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoEntity implements PhotoEntity {
  const _PhotoEntity({required this.id, required this.type, required this.month, required this.monthKey, required this.capturedAt, required this.url, required this.priority, this.memo, required this.updatedAt});
  factory _PhotoEntity.fromJson(Map<String, dynamic> json) => _$PhotoEntityFromJson(json);

@override final  String id;
@override final  PhotoType type;
@override final  int month;
// 1..12
@override final  String monthKey;
// zero padded 2桁
@override final  DateTime capturedAt;
@override final  String url;
@override final  int priority;
// derived (admin=10, user=0 初期)
@override final  String? memo;
@override final  DateTime updatedAt;

/// Create a copy of PhotoEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoEntityCopyWith<_PhotoEntity> get copyWith => __$PhotoEntityCopyWithImpl<_PhotoEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.month, month) || other.month == month)&&(identical(other.monthKey, monthKey) || other.monthKey == monthKey)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.url, url) || other.url == url)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,month,monthKey,capturedAt,url,priority,memo,updatedAt);

@override
String toString() {
  return 'PhotoEntity(id: $id, type: $type, month: $month, monthKey: $monthKey, capturedAt: $capturedAt, url: $url, priority: $priority, memo: $memo, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PhotoEntityCopyWith<$Res> implements $PhotoEntityCopyWith<$Res> {
  factory _$PhotoEntityCopyWith(_PhotoEntity value, $Res Function(_PhotoEntity) _then) = __$PhotoEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, PhotoType type, int month, String monthKey, DateTime capturedAt, String url, int priority, String? memo, DateTime updatedAt
});




}
/// @nodoc
class __$PhotoEntityCopyWithImpl<$Res>
    implements _$PhotoEntityCopyWith<$Res> {
  __$PhotoEntityCopyWithImpl(this._self, this._then);

  final _PhotoEntity _self;
  final $Res Function(_PhotoEntity) _then;

/// Create a copy of PhotoEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? month = null,Object? monthKey = null,Object? capturedAt = null,Object? url = null,Object? priority = null,Object? memo = freezed,Object? updatedAt = null,}) {
  return _then(_PhotoEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PhotoType,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,monthKey: null == monthKey ? _self.monthKey : monthKey // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

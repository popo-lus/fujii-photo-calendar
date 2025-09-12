// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthState {

 String get uid; int get month;// 1..12
 List<PhotoEntity> get photos; List<PhotoEntity>? get slideshowBatch; bool get isReadOnly;
/// Create a copy of MonthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthStateCopyWith<MonthState> get copyWith => _$MonthStateCopyWithImpl<MonthState>(this as MonthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthState&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.photos, photos)&&const DeepCollectionEquality().equals(other.slideshowBatch, slideshowBatch)&&(identical(other.isReadOnly, isReadOnly) || other.isReadOnly == isReadOnly));
}


@override
int get hashCode => Object.hash(runtimeType,uid,month,const DeepCollectionEquality().hash(photos),const DeepCollectionEquality().hash(slideshowBatch),isReadOnly);

@override
String toString() {
  return 'MonthState(uid: $uid, month: $month, photos: $photos, slideshowBatch: $slideshowBatch, isReadOnly: $isReadOnly)';
}


}

/// @nodoc
abstract mixin class $MonthStateCopyWith<$Res>  {
  factory $MonthStateCopyWith(MonthState value, $Res Function(MonthState) _then) = _$MonthStateCopyWithImpl;
@useResult
$Res call({
 String uid, int month, List<PhotoEntity> photos, List<PhotoEntity>? slideshowBatch, bool isReadOnly
});




}
/// @nodoc
class _$MonthStateCopyWithImpl<$Res>
    implements $MonthStateCopyWith<$Res> {
  _$MonthStateCopyWithImpl(this._self, this._then);

  final MonthState _self;
  final $Res Function(MonthState) _then;

/// Create a copy of MonthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? month = null,Object? photos = null,Object? slideshowBatch = freezed,Object? isReadOnly = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<PhotoEntity>,slideshowBatch: freezed == slideshowBatch ? _self.slideshowBatch : slideshowBatch // ignore: cast_nullable_to_non_nullable
as List<PhotoEntity>?,isReadOnly: null == isReadOnly ? _self.isReadOnly : isReadOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthState].
extension MonthStatePatterns on MonthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthState value)  $default,){
final _that = this;
switch (_that) {
case _MonthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthState value)?  $default,){
final _that = this;
switch (_that) {
case _MonthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  int month,  List<PhotoEntity> photos,  List<PhotoEntity>? slideshowBatch,  bool isReadOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthState() when $default != null:
return $default(_that.uid,_that.month,_that.photos,_that.slideshowBatch,_that.isReadOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  int month,  List<PhotoEntity> photos,  List<PhotoEntity>? slideshowBatch,  bool isReadOnly)  $default,) {final _that = this;
switch (_that) {
case _MonthState():
return $default(_that.uid,_that.month,_that.photos,_that.slideshowBatch,_that.isReadOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  int month,  List<PhotoEntity> photos,  List<PhotoEntity>? slideshowBatch,  bool isReadOnly)?  $default,) {final _that = this;
switch (_that) {
case _MonthState() when $default != null:
return $default(_that.uid,_that.month,_that.photos,_that.slideshowBatch,_that.isReadOnly);case _:
  return null;

}
}

}

/// @nodoc


class _MonthState implements MonthState {
  const _MonthState({required this.uid, required this.month, required final  List<PhotoEntity> photos, final  List<PhotoEntity>? slideshowBatch, this.isReadOnly = false}): _photos = photos,_slideshowBatch = slideshowBatch;
  

@override final  String uid;
@override final  int month;
// 1..12
 final  List<PhotoEntity> _photos;
// 1..12
@override List<PhotoEntity> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

 final  List<PhotoEntity>? _slideshowBatch;
@override List<PhotoEntity>? get slideshowBatch {
  final value = _slideshowBatch;
  if (value == null) return null;
  if (_slideshowBatch is EqualUnmodifiableListView) return _slideshowBatch;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isReadOnly;

/// Create a copy of MonthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthStateCopyWith<_MonthState> get copyWith => __$MonthStateCopyWithImpl<_MonthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthState&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other._photos, _photos)&&const DeepCollectionEquality().equals(other._slideshowBatch, _slideshowBatch)&&(identical(other.isReadOnly, isReadOnly) || other.isReadOnly == isReadOnly));
}


@override
int get hashCode => Object.hash(runtimeType,uid,month,const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_slideshowBatch),isReadOnly);

@override
String toString() {
  return 'MonthState(uid: $uid, month: $month, photos: $photos, slideshowBatch: $slideshowBatch, isReadOnly: $isReadOnly)';
}


}

/// @nodoc
abstract mixin class _$MonthStateCopyWith<$Res> implements $MonthStateCopyWith<$Res> {
  factory _$MonthStateCopyWith(_MonthState value, $Res Function(_MonthState) _then) = __$MonthStateCopyWithImpl;
@override @useResult
$Res call({
 String uid, int month, List<PhotoEntity> photos, List<PhotoEntity>? slideshowBatch, bool isReadOnly
});




}
/// @nodoc
class __$MonthStateCopyWithImpl<$Res>
    implements _$MonthStateCopyWith<$Res> {
  __$MonthStateCopyWithImpl(this._self, this._then);

  final _MonthState _self;
  final $Res Function(_MonthState) _then;

/// Create a copy of MonthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? month = null,Object? photos = null,Object? slideshowBatch = freezed,Object? isReadOnly = null,}) {
  return _then(_MonthState(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<PhotoEntity>,slideshowBatch: freezed == slideshowBatch ? _self._slideshowBatch : slideshowBatch // ignore: cast_nullable_to_non_nullable
as List<PhotoEntity>?,isReadOnly: null == isReadOnly ? _self.isReadOnly : isReadOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

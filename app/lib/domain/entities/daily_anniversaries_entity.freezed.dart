// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_anniversaries_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyAnniversariesEntity {

 String get mmdd; List<String> get items;
/// Create a copy of DailyAnniversariesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyAnniversariesEntityCopyWith<DailyAnniversariesEntity> get copyWith => _$DailyAnniversariesEntityCopyWithImpl<DailyAnniversariesEntity>(this as DailyAnniversariesEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyAnniversariesEntity&&(identical(other.mmdd, mmdd) || other.mmdd == mmdd)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,mmdd,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'DailyAnniversariesEntity(mmdd: $mmdd, items: $items)';
}


}

/// @nodoc
abstract mixin class $DailyAnniversariesEntityCopyWith<$Res>  {
  factory $DailyAnniversariesEntityCopyWith(DailyAnniversariesEntity value, $Res Function(DailyAnniversariesEntity) _then) = _$DailyAnniversariesEntityCopyWithImpl;
@useResult
$Res call({
 String mmdd, List<String> items
});




}
/// @nodoc
class _$DailyAnniversariesEntityCopyWithImpl<$Res>
    implements $DailyAnniversariesEntityCopyWith<$Res> {
  _$DailyAnniversariesEntityCopyWithImpl(this._self, this._then);

  final DailyAnniversariesEntity _self;
  final $Res Function(DailyAnniversariesEntity) _then;

/// Create a copy of DailyAnniversariesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mmdd = null,Object? items = null,}) {
  return _then(_self.copyWith(
mmdd: null == mmdd ? _self.mmdd : mmdd // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyAnniversariesEntity].
extension DailyAnniversariesEntityPatterns on DailyAnniversariesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyAnniversariesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyAnniversariesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyAnniversariesEntity value)  $default,){
final _that = this;
switch (_that) {
case _DailyAnniversariesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyAnniversariesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DailyAnniversariesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mmdd,  List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyAnniversariesEntity() when $default != null:
return $default(_that.mmdd,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mmdd,  List<String> items)  $default,) {final _that = this;
switch (_that) {
case _DailyAnniversariesEntity():
return $default(_that.mmdd,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mmdd,  List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _DailyAnniversariesEntity() when $default != null:
return $default(_that.mmdd,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _DailyAnniversariesEntity implements DailyAnniversariesEntity {
  const _DailyAnniversariesEntity({required this.mmdd, required final  List<String> items}): _items = items;
  

@override final  String mmdd;
 final  List<String> _items;
@override List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of DailyAnniversariesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyAnniversariesEntityCopyWith<_DailyAnniversariesEntity> get copyWith => __$DailyAnniversariesEntityCopyWithImpl<_DailyAnniversariesEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyAnniversariesEntity&&(identical(other.mmdd, mmdd) || other.mmdd == mmdd)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,mmdd,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'DailyAnniversariesEntity(mmdd: $mmdd, items: $items)';
}


}

/// @nodoc
abstract mixin class _$DailyAnniversariesEntityCopyWith<$Res> implements $DailyAnniversariesEntityCopyWith<$Res> {
  factory _$DailyAnniversariesEntityCopyWith(_DailyAnniversariesEntity value, $Res Function(_DailyAnniversariesEntity) _then) = __$DailyAnniversariesEntityCopyWithImpl;
@override @useResult
$Res call({
 String mmdd, List<String> items
});




}
/// @nodoc
class __$DailyAnniversariesEntityCopyWithImpl<$Res>
    implements _$DailyAnniversariesEntityCopyWith<$Res> {
  __$DailyAnniversariesEntityCopyWithImpl(this._self, this._then);

  final _DailyAnniversariesEntity _self;
  final $Res Function(_DailyAnniversariesEntity) _then;

/// Create a copy of DailyAnniversariesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mmdd = null,Object? items = null,}) {
  return _then(_DailyAnniversariesEntity(
mmdd: null == mmdd ? _self.mmdd : mmdd // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

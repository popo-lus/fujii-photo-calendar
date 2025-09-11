// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PhotoEntity _$PhotoEntityFromJson(Map<String, dynamic> json) {
  return _PhotoEntity.fromJson(json);
}

/// @nodoc
mixin _$PhotoEntity {
  String get id => throw _privateConstructorUsedError;
  PhotoType get type => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError; // 1..12
  String get monthKey => throw _privateConstructorUsedError; // zero padded 2桁
  DateTime get capturedAt => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  int get priority =>
      throw _privateConstructorUsedError; // derived (admin=10, user=0 初期)
  String? get memo => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PhotoEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoEntityCopyWith<PhotoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoEntityCopyWith<$Res> {
  factory $PhotoEntityCopyWith(
    PhotoEntity value,
    $Res Function(PhotoEntity) then,
  ) = _$PhotoEntityCopyWithImpl<$Res, PhotoEntity>;
  @useResult
  $Res call({
    String id,
    PhotoType type,
    int month,
    String monthKey,
    DateTime capturedAt,
    String url,
    int priority,
    String? memo,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$PhotoEntityCopyWithImpl<$Res, $Val extends PhotoEntity>
    implements $PhotoEntityCopyWith<$Res> {
  _$PhotoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? month = null,
    Object? monthKey = null,
    Object? capturedAt = null,
    Object? url = null,
    Object? priority = null,
    Object? memo = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PhotoType,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            monthKey: null == monthKey
                ? _value.monthKey
                : monthKey // ignore: cast_nullable_to_non_nullable
                      as String,
            capturedAt: null == capturedAt
                ? _value.capturedAt
                : capturedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
            memo: freezed == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoEntityImplCopyWith<$Res>
    implements $PhotoEntityCopyWith<$Res> {
  factory _$$PhotoEntityImplCopyWith(
    _$PhotoEntityImpl value,
    $Res Function(_$PhotoEntityImpl) then,
  ) = __$$PhotoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PhotoType type,
    int month,
    String monthKey,
    DateTime capturedAt,
    String url,
    int priority,
    String? memo,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$PhotoEntityImplCopyWithImpl<$Res>
    extends _$PhotoEntityCopyWithImpl<$Res, _$PhotoEntityImpl>
    implements _$$PhotoEntityImplCopyWith<$Res> {
  __$$PhotoEntityImplCopyWithImpl(
    _$PhotoEntityImpl _value,
    $Res Function(_$PhotoEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? month = null,
    Object? monthKey = null,
    Object? capturedAt = null,
    Object? url = null,
    Object? priority = null,
    Object? memo = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PhotoEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PhotoType,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        monthKey: null == monthKey
            ? _value.monthKey
            : monthKey // ignore: cast_nullable_to_non_nullable
                  as String,
        capturedAt: null == capturedAt
            ? _value.capturedAt
            : capturedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
        memo: freezed == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoEntityImpl implements _PhotoEntity {
  const _$PhotoEntityImpl({
    required this.id,
    required this.type,
    required this.month,
    required this.monthKey,
    required this.capturedAt,
    required this.url,
    required this.priority,
    this.memo,
    required this.updatedAt,
  });

  factory _$PhotoEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoEntityImplFromJson(json);

  @override
  final String id;
  @override
  final PhotoType type;
  @override
  final int month;
  // 1..12
  @override
  final String monthKey;
  // zero padded 2桁
  @override
  final DateTime capturedAt;
  @override
  final String url;
  @override
  final int priority;
  // derived (admin=10, user=0 初期)
  @override
  final String? memo;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PhotoEntity(id: $id, type: $type, month: $month, monthKey: $monthKey, capturedAt: $capturedAt, url: $url, priority: $priority, memo: $memo, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthKey, monthKey) ||
                other.monthKey == monthKey) &&
            (identical(other.capturedAt, capturedAt) ||
                other.capturedAt == capturedAt) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    month,
    monthKey,
    capturedAt,
    url,
    priority,
    memo,
    updatedAt,
  );

  /// Create a copy of PhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoEntityImplCopyWith<_$PhotoEntityImpl> get copyWith =>
      __$$PhotoEntityImplCopyWithImpl<_$PhotoEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoEntityImplToJson(this);
  }
}

abstract class _PhotoEntity implements PhotoEntity {
  const factory _PhotoEntity({
    required final String id,
    required final PhotoType type,
    required final int month,
    required final String monthKey,
    required final DateTime capturedAt,
    required final String url,
    required final int priority,
    final String? memo,
    required final DateTime updatedAt,
  }) = _$PhotoEntityImpl;

  factory _PhotoEntity.fromJson(Map<String, dynamic> json) =
      _$PhotoEntityImpl.fromJson;

  @override
  String get id;
  @override
  PhotoType get type;
  @override
  int get month; // 1..12
  @override
  String get monthKey; // zero padded 2桁
  @override
  DateTime get capturedAt;
  @override
  String get url;
  @override
  int get priority; // derived (admin=10, user=0 初期)
  @override
  String? get memo;
  @override
  DateTime get updatedAt;

  /// Create a copy of PhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoEntityImplCopyWith<_$PhotoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

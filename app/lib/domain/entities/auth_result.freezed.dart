// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthResult _$AuthResultFromJson(Map<String, dynamic> json) {
  return _AuthResult.fromJson(json);
}

/// @nodoc
mixin _$AuthResult {
  String get email => throw _privateConstructorUsedError;
  String get userUid => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this AuthResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResultCopyWith<AuthResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResultCopyWith<$Res> {
  factory $AuthResultCopyWith(
    AuthResult value,
    $Res Function(AuthResult) then,
  ) = _$AuthResultCopyWithImpl<$Res, AuthResult>;
  @useResult
  $Res call({
    String email,
    String userUid,
    String identifier,
    DateTime? lastLoginAt,
  });
}

/// @nodoc
class _$AuthResultCopyWithImpl<$Res, $Val extends AuthResult>
    implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? userUid = null,
    Object? identifier = null,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            userUid: null == userUid
                ? _value.userUid
                : userUid // ignore: cast_nullable_to_non_nullable
                      as String,
            identifier: null == identifier
                ? _value.identifier
                : identifier // ignore: cast_nullable_to_non_nullable
                      as String,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthResultImplCopyWith<$Res>
    implements $AuthResultCopyWith<$Res> {
  factory _$$AuthResultImplCopyWith(
    _$AuthResultImpl value,
    $Res Function(_$AuthResultImpl) then,
  ) = __$$AuthResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String email,
    String userUid,
    String identifier,
    DateTime? lastLoginAt,
  });
}

/// @nodoc
class __$$AuthResultImplCopyWithImpl<$Res>
    extends _$AuthResultCopyWithImpl<$Res, _$AuthResultImpl>
    implements _$$AuthResultImplCopyWith<$Res> {
  __$$AuthResultImplCopyWithImpl(
    _$AuthResultImpl _value,
    $Res Function(_$AuthResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? userUid = null,
    Object? identifier = null,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _$AuthResultImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        userUid: null == userUid
            ? _value.userUid
            : userUid // ignore: cast_nullable_to_non_nullable
                  as String,
        identifier: null == identifier
            ? _value.identifier
            : identifier // ignore: cast_nullable_to_non_nullable
                  as String,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResultImpl implements _AuthResult {
  const _$AuthResultImpl({
    required this.email,
    required this.userUid,
    required this.identifier,
    this.lastLoginAt,
  });

  factory _$AuthResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResultImplFromJson(json);

  @override
  final String email;
  @override
  final String userUid;
  @override
  final String identifier;
  @override
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'AuthResult(email: $email, userUid: $userUid, identifier: $identifier, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResultImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, userUid, identifier, lastLoginAt);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResultImplCopyWith<_$AuthResultImpl> get copyWith =>
      __$$AuthResultImplCopyWithImpl<_$AuthResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResultImplToJson(this);
  }
}

abstract class _AuthResult implements AuthResult {
  const factory _AuthResult({
    required final String email,
    required final String userUid,
    required final String identifier,
    final DateTime? lastLoginAt,
  }) = _$AuthResultImpl;

  factory _AuthResult.fromJson(Map<String, dynamic> json) =
      _$AuthResultImpl.fromJson;

  @override
  String get email;
  @override
  String get userUid;
  @override
  String get identifier;
  @override
  DateTime? get lastLoginAt;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResultImplCopyWith<_$AuthResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

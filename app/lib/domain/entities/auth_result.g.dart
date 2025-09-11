// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  email: json['email'] as String,
  userUid: json['userUid'] as String,
  identifier: json['identifier'] as String,
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userUid': instance.userUid,
      'identifier': instance.identifier,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
    };

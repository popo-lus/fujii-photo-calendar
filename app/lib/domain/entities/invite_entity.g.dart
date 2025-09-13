// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteEntity _$InviteEntityFromJson(Map<String, dynamic> json) =>
    _InviteEntity(
      code: json['code'] as String,
      ownerUid: json['ownerUid'] as String,
      disabled: json['disabled'] as bool? ?? false,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$InviteEntityToJson(_InviteEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'ownerUid': instance.ownerUid,
      'disabled': instance.disabled,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

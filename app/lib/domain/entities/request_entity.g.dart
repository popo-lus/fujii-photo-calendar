// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestEntity _$RequestEntityFromJson(Map<String, dynamic> json) =>
    _RequestEntity(
      id: json['id'] as String,
      ownerUid: json['ownerUid'] as String,
      requesterUid: json['requesterUid'] as String,
      comment: json['comment'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RequestEntityToJson(_RequestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerUid': instance.ownerUid,
      'requesterUid': instance.requesterUid,
      'comment': instance.comment,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

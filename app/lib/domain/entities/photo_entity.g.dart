// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhotoEntity _$PhotoEntityFromJson(Map<String, dynamic> json) => _PhotoEntity(
  id: json['id'] as String,
  type: $enumDecode(_$PhotoTypeEnumMap, json['type']),
  month: (json['month'] as num).toInt(),
  monthKey: json['monthKey'] as String,
  capturedAt: DateTime.parse(json['capturedAt'] as String),
  url: json['url'] as String,
  priority: (json['priority'] as num).toInt(),
  memo: json['memo'] as String?,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PhotoEntityToJson(_PhotoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$PhotoTypeEnumMap[instance.type]!,
      'month': instance.month,
      'monthKey': instance.monthKey,
      'capturedAt': instance.capturedAt.toIso8601String(),
      'url': instance.url,
      'priority': instance.priority,
      'memo': instance.memo,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PhotoTypeEnumMap = {
  PhotoType.fujiiPhotos: 'fujii-photos',
  PhotoType.userPhotos: 'user-photos',
};

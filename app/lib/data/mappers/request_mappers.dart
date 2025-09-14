import 'package:fujii_photo_calendar/domain/entities/request_entity.dart';
import 'package:fujii_photo_calendar/data/mappers/user_mappers.dart';

RequestEntity mapJsonToRequestEntity(
  String id,
  String ownerUid,
  Map<String, dynamic> json,
) {
  final requesterUid = (json['requesterUid'] as String?)?.trim() ?? '';
  final comment = (json['comment'] as String?)?.trim() ?? '';
  final createdAt = toDateTime(json['createdAt']);
  return RequestEntity(
    id: id,
    ownerUid: ownerUid,
    requesterUid: requesterUid,
    comment: comment,
    createdAt: createdAt,
  );
}

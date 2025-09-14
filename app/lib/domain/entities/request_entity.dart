import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_entity.freezed.dart';
part 'request_entity.g.dart';

@freezed
abstract class RequestEntity with _$RequestEntity {
  const factory RequestEntity({
    required String id,
    required String ownerUid,
    required String requesterUid,
    required String comment,
    DateTime? createdAt,
  }) = _RequestEntity;

  factory RequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestEntityFromJson(json);
}

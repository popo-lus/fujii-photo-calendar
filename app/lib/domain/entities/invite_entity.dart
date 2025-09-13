import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_entity.freezed.dart';
part 'invite_entity.g.dart';

@freezed
abstract class InviteEntity with _$InviteEntity {
  const factory InviteEntity({
    required String code,
    required String ownerUid,
    @Default(false) bool disabled,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) = _InviteEntity;

  factory InviteEntity.fromJson(Map<String, dynamic> json) =>
      _$InviteEntityFromJson(json);
}

import 'package:fujii_photo_calendar/domain/entities/invite_entity.dart';

abstract class InviteRepository {
  Future<InviteEntity> create({
    required String ownerUid,
    DateTime? expiresAt,
    int length = 20,
    int maxRetry = 1,
  });

  Future<InviteEntity?> getByCode(String code);

  Future<void> disable(String code);
}

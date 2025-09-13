import 'package:fujii_photo_calendar/domain/entities/invite_entity.dart';

abstract class InviteRepository {
  Future<InviteEntity> create({
    required String ownerUid,
    DateTime? expiresAt,
    int length = 8,
    int maxRetry = 5,
  });

  Future<InviteEntity?> getByCode(String code);

  Future<void> disable(String code);
}


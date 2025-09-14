import 'package:fujii_photo_calendar/domain/entities/request_entity.dart';

abstract class RequestRepository {
  Future<void> submit({required String ownerUid, required String comment});

  Stream<List<RequestEntity>> watchRecent({
    required String ownerUid,
    int retentionDays = 14,
  });

  Future<void> delete({required String ownerUid, required String requestId});
}

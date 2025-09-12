// (T007) UserRepository interface

import 'package:fujii_photo_calendar/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<UserEntity?> watchByUid(String uid);
  Future<UserEntity?> getByUidOnce(String uid);
  Future<void> updateDisplayName({
    required String uid,
    required String displayName,
  });
}

// (T008) UserRepositoryImpl: map JSON from UserService to UserEntity

import 'package:fujii_photo_calendar/data/services/user_service.dart';
import 'package:fujii_photo_calendar/data/mappers/user_mappers.dart';
import 'package:fujii_photo_calendar/domain/entities/user_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._service);
  final UserService _service;

  @override
  Stream<UserEntity?> watchByUid(String uid) {
    return _service.watchUserJson(uid).map((json) {
      if (json == null) return null;
      return mapJsonToUserEntity(uid, json);
    });
  }

  @override
  Future<UserEntity?> getByUidOnce(String uid) async {
    final json = await _service.getUserJsonOnce(uid);
    if (json == null) return null;
    return mapJsonToUserEntity(uid, json);
  }

  @override
  Future<void> updateDisplayName({
    required String uid,
    required String displayName,
  }) {
    return _service.updateDisplayName(uid: uid, displayName: displayName);
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final service = ref.watch(userServiceProvider);
  return UserRepositoryImpl(service);
}

@Riverpod(keepAlive: true)
Stream<UserEntity?> userByUidStream(Ref ref, String uid) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.watchByUid(uid);
}

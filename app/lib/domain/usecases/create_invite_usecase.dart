import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/domain/entities/invite_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/invite_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/data/repositories/invite_repository_impl.dart';

part 'create_invite_usecase.g.dart';

class CreateInviteUsecase {
  const CreateInviteUsecase(this._repo);
  final InviteRepository _repo;

  Future<InviteEntity> call({
    required String ownerUid,
    DateTime? expiresAt,
    int length = 20,
  }) async {
    AppLogger.instance
        .log('invite_create_start', data: {'ownerUid': ownerUid});
    try {
      final inv = await _repo.create(
        ownerUid: ownerUid,
        expiresAt: expiresAt,
        length: length,
      );
      AppLogger.instance.log('invite_create_success',
          data: {'ownerUid': ownerUid, 'code': inv.code});
      return inv;
    } catch (e) {
      AppLogger.instance
          .log('invite_create_failure', data: {'ownerUid': ownerUid, 'e': e.toString()});
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
CreateInviteUsecase createInviteUsecase(Ref ref) {
  final repo = ref.watch(inviteRepositoryProvider);
  return CreateInviteUsecase(repo);
}

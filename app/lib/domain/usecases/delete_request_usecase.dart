import 'package:fujii_photo_calendar/domain/repositories/request_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/data/repositories/request_repository_impl.dart';

part 'delete_request_usecase.g.dart';

class DeleteRequestUsecase {
  const DeleteRequestUsecase(this._repo);
  final RequestRepository _repo;

  Future<void> call({required String ownerUid, required String requestId}) {
    return _repo.delete(ownerUid: ownerUid, requestId: requestId);
  }
}

@Riverpod(keepAlive: true)
DeleteRequestUsecase deleteRequestUsecase(Ref ref) {
  final repo = ref.watch(requestRepositoryProvider);
  return DeleteRequestUsecase(repo);
}

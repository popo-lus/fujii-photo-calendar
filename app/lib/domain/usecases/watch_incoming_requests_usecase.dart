import 'package:fujii_photo_calendar/domain/entities/request_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/request_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/data/repositories/request_repository_impl.dart';

part 'watch_incoming_requests_usecase.g.dart';

class WatchIncomingRequestsUsecase {
  const WatchIncomingRequestsUsecase(this._repo);
  final RequestRepository _repo;

  Stream<List<RequestEntity>> call({
    required String ownerUid,
    int retentionDays = 14,
  }) {
    return _repo.watchRecent(ownerUid: ownerUid, retentionDays: retentionDays);
  }
}

@Riverpod(keepAlive: true)
WatchIncomingRequestsUsecase watchIncomingRequestsUsecase(Ref ref) {
  final repo = ref.watch(requestRepositoryProvider);
  return WatchIncomingRequestsUsecase(repo);
}

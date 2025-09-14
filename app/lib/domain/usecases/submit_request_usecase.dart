import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/domain/repositories/request_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/data/repositories/request_repository_impl.dart';

part 'submit_request_usecase.g.dart';

class SubmitRequestUsecase {
  const SubmitRequestUsecase(this._repo);
  final RequestRepository _repo;

  Future<void> call({required String ownerUid, required String comment}) async {
    AppLogger.instance.log(
      'request_submit_start',
      data: {'ownerUid': ownerUid},
    );
    try {
      await _repo.submit(ownerUid: ownerUid, comment: comment);
      AppLogger.instance.log(
        'request_submit_success',
        data: {'ownerUid': ownerUid},
      );
    } catch (e) {
      AppLogger.instance.log(
        'request_submit_failure',
        data: {'ownerUid': ownerUid, 'e': e.toString()},
      );
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
SubmitRequestUsecase submitRequestUsecase(Ref ref) {
  final repo = ref.watch(requestRepositoryProvider);
  return SubmitRequestUsecase(repo);
}

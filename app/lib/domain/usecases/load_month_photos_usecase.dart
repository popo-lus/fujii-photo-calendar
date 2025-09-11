// (T014) UseCase: 月写真ロード
// Repository をラップし、後続 UseCase (スライドショー計算/露出保証) の共通入口を提供。

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/fujii_photos_repository.dart';
import 'package:fujii_photo_calendar/domain/repositories/user_photos_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/data/repositories/fujii_photos_repository_impl.dart';
import 'package:fujii_photo_calendar/data/repositories/user_photos_repository_impl.dart';

part 'load_month_photos_usecase.g.dart';

class LoadMonthPhotosUseCase {
  const LoadMonthPhotosUseCase(this._fujiiRepo, this._userRepo);
  final FujiiPhotosRepository _fujiiRepo;
  final UserPhotosRepository _userRepo;

  Future<Result<List<PhotoEntity>>> call({
    required String uid,
    required int month,
  }) async {
    final f = await _fujiiRepo.loadMonthFujiiPhotos(uid: uid, month: month);
    final u = await _userRepo.loadMonthUserPhotos(uid: uid, month: month);
    return switch ((f, u)) {
      (Success(value: final fl), Success(value: final ul)) =>
        Success<List<PhotoEntity>>(_mergeAndSort(fl, ul)),
      (Failure(rawError: final e, stackTrace: final st), _) =>
        Failure<List<PhotoEntity>>(e, st),
      (_, Failure(rawError: final e, stackTrace: final st)) =>
        Failure<List<PhotoEntity>>(e, st),
    };
  }

  List<PhotoEntity> _mergeAndSort(List<PhotoEntity> a, List<PhotoEntity> b) {
    final all = <PhotoEntity>[...a, ...b];
    if (all.isEmpty) return all;
    all.sort((x, y) {
      final p = y.priority.compareTo(x.priority);
      if (p != 0) return p;
      return x.capturedAt.compareTo(y.capturedAt);
    });
    return all;
  }
}

@Riverpod()
LoadMonthPhotosUseCase loadMonthPhotosUseCase(Ref ref) {
  final fRepo = ref.watch(fujiiPhotosRepositoryProvider);
  final uRepo = ref.watch(userPhotosRepositoryProvider);
  return LoadMonthPhotosUseCase(fRepo, uRepo);
}

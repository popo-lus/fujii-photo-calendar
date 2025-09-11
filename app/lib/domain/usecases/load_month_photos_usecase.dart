// (T014) UseCase: 月写真ロード
// Repository をラップし、後続 UseCase (スライドショー計算/露出保証) の共通入口を提供。

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/calendar_repository.dart';

class LoadMonthPhotosUseCase {
  const LoadMonthPhotosUseCase(this._repository);
  final CalendarRepository _repository;

  Future<Result<List<PhotoEntity>>> call({
    required String uid,
    required int month,
  }) async {
    return _repository.loadMonthPhotos(uid: uid, month: month);
  }
}

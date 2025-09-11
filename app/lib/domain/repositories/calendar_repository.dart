// (T012) Repository Interface: 月の写真集合ロード。
//
// Result<List<PhotoEntity>> で成功/失敗を返却。
// キャッシュ戦略や再試行は実装層に委譲。

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

abstract interface class CalendarRepository {
  Future<Result<List<PhotoEntity>>> loadMonthPhotos({
    required String uid,
    required int month,
  });
}

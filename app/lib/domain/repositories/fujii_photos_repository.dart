import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

abstract interface class FujiiPhotosRepository {
  Future<Result<List<PhotoEntity>>> loadMonthFujiiPhotos({
    required String uid,
    required int month,
  });
}

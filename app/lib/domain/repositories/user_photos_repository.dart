import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

abstract interface class UserPhotosRepository {
  Future<Result<List<PhotoEntity>>> loadMonthUserPhotos({
    required String uid,
    required int month,
  });
}

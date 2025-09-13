import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/daily_anniversaries_entity.dart';

abstract interface class AnnivRepository {
  Future<Result<DailyAnniversariesEntity>> fetchAnniv({required String mmdd});
}


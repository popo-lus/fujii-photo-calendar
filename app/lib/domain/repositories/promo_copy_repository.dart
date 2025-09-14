import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/promo_copy_entity.dart';

abstract interface class PromoCopyRepository {
  Future<Result<PromoCopyEntity>> generatePromo({
    required String mmdd,
    required List<String> anniversaries,
  });
}

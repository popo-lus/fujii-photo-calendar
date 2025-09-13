import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/services/anniv_api_service.dart';
import 'package:fujii_photo_calendar/domain/entities/daily_anniversaries_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/anniv_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'anniv_repository_impl.g.dart';

class AnnivRepositoryImpl implements AnnivRepository {
  AnnivRepositoryImpl(this._api);
  final AnnivApiService _api;

  @override
  Future<Result<DailyAnniversariesEntity>> fetchAnniv({
    required String mmdd,
  }) async {
    try {
      final entity = await _api.getAnniv(mmdd);
      return Success(entity);
    } catch (e, st) {
      return Failure(e, st);
    }
  }
}

@Riverpod(keepAlive: true)
AnnivRepository annivRepository(Ref ref) =>
    AnnivRepositoryImpl(ref.watch(annivApiServiceProvider));


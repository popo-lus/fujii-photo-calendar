import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/repositories/anniv_repository_impl.dart';
import 'package:fujii_photo_calendar/data/repositories/promo_copy_repository_impl.dart';
import 'package:fujii_photo_calendar/domain/entities/promo_copy_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/anniv_repository.dart';
import 'package:fujii_photo_calendar/domain/repositories/promo_copy_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generate_anniv_promo_usecase.g.dart';

class GenerateAnnivPromoUsecase {
  const GenerateAnnivPromoUsecase(this._annivRepo, this._promoRepo);
  final AnnivRepository _annivRepo;
  final PromoCopyRepository _promoRepo;

  Future<Result<PromoCopyEntity>> call({required DateTime date}) async {
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    final mmdd = '$mm$dd';

    final annivRes = await _annivRepo.fetchAnniv(mmdd: mmdd);
    return await annivRes.fold(
      onSuccess: (a) async {
        if (a.items.isEmpty) {
          return Success(_fallback(mmdd));
        }
        final promoRes = await _promoRepo.generatePromo(
          mmdd: mmdd,
          anniversaries: a.items,
        );
        return promoRes.fold(
          onSuccess: (p) => Success(p),
          onFailure: (_, _) => Success(_fallback(mmdd)),
        );
      },
      onFailure: (_, _) => Success(_fallback(mmdd)),
    );
  }

  PromoCopyEntity _fallback(String mmdd) =>
      PromoCopyEntity(text: _buildFallbackText(mmdd), source: 'fallback');

  String _buildFallbackText(String mmdd) {
    // シンプルな一般向けコピー（記念日取得不可/生成失敗時）
    return '今日はちょっと特別。小さなご褒美をどうぞ。($mmdd)';
  }
}

@Riverpod(keepAlive: true)
GenerateAnnivPromoUsecase generateAnnivPromoUsecase(Ref ref) =>
    GenerateAnnivPromoUsecase(
      ref.watch(annivRepositoryProvider),
      ref.watch(promoCopyRepositoryProvider),
    );

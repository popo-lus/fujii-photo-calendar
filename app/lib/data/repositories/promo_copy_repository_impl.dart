import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/services/gemini_service.dart';
import 'package:fujii_photo_calendar/domain/entities/promo_copy_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/promo_copy_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promo_copy_repository_impl.g.dart';

class PromoCopyRepositoryImpl implements PromoCopyRepository {
  PromoCopyRepositoryImpl(this._gemini);
  final GeminiService _gemini;

  @override
  Future<Result<PromoCopyEntity>> generatePromo({
    required String mmdd,
    required List<String> anniversaries,
  }) async {
    try {
      final text = await _gemini.generatePromo(
        mmdd: mmdd,
        anniversaries: anniversaries,
      );
      return Success(PromoCopyEntity(text: text, source: 'gemini'));
    } catch (e, st) {
      return Failure(e, st);
    }
  }
}

@Riverpod(keepAlive: true)
PromoCopyRepository promoCopyRepository(Ref ref) =>
    PromoCopyRepositoryImpl(ref.watch(geminiServiceProvider));


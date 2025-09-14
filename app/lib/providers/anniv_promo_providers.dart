import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/domain/usecases/generate_anniv_promo_usecase.dart';

part 'anniv_promo_providers.g.dart';

@Riverpod(keepAlive: true)
Future<String> todayAnnivPromoText(Ref ref) async {
  final usecase = ref.read(generateAnnivPromoUsecaseProvider);
  final res = await usecase.call(date: DateTime.now());
  return res.fold(
    onSuccess: (p) => p.text,
    onFailure: (_, __) => '今日はちょっと特別。小さなご褒美をどうぞ。',
  );
}

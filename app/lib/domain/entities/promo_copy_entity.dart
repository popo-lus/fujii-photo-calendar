import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo_copy_entity.freezed.dart';

@freezed
abstract class PromoCopyEntity with _$PromoCopyEntity {
  const factory PromoCopyEntity({
    required String text,
    @Default('gemini') String source,
  }) = _PromoCopyEntity;
}

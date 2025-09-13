import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_anniversaries_entity.freezed.dart';

@freezed
abstract class DailyAnniversariesEntity with _$DailyAnniversariesEntity {
  const factory DailyAnniversariesEntity({
    required String mmdd,
    required List<String> items,
  }) = _DailyAnniversariesEntity;
}

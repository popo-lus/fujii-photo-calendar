// (T016) UseCase: Admin 露出保証
// 入力: 全写真リスト allPhotos, 現在のスライドショーバッチ batch
// 要件: Admin(fujii) 写真が all に存在する場合、batch に最低 1 枚含まれるよう保証。
// 方法: batch に存在しなければ admin 内から 1 枚選び先頭差替 (もしくは空なら追加)。
// 露出不可 (admin が存在しない or 差替不可能) で例外は投げず batch をそのまま返す。
// ただし admin が存在するのに挿入できない異常ケースは AdminExposureViolation を投げうる。

import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

class EnsureAdminExposureUseCase {
  const EnsureAdminExposureUseCase();

  List<PhotoEntity> call({
    required List<PhotoEntity> allPhotos,
    required List<PhotoEntity> batch,
  }) {
    final adminPhotos = allPhotos.where((p) => p.type.isAdmin).toList();
    if (adminPhotos.isEmpty) return batch; // 保証不要

    final hasAdmin = batch.any((p) => p.type.isAdmin);
    if (hasAdmin) return batch; // 既に露出

    if (batch.isEmpty) {
      // そのまま 1 枚追加
      return [adminPhotos.first];
    }

    // 差替: バッチ先頭を admin に置換
    final newBatch = [...batch];
    if (newBatch.isEmpty) {
      throw AdminExposureViolation(
        'Unexpected empty batch after non-empty check',
      );
    }
    newBatch[0] = adminPhotos.first;
    return newBatch;
  }
}

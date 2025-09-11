// (T015) UseCase: スライドショー用バッチ計算
// 入力: 対象月の全 PhotoEntity, 任意の最大枚数, 乱数シード
// 出力: スライドショーに利用するサブセット (List<PhotoEntity>)
// 方針: priority > ランダム性 を両立するため以下アルゴリズム
//  1. admin(fujii) と user を分離
//  2. 各集合を個別シャッフル
//  3. バケット比率: admin:全体の max(1, ceil(N*0.25)) を上限（存在する場合）
//  4. admin 割当後、残りを user で充填
//  5. 合計 maxCount を超えたら切り捨て
//  6. shuffle 全体を軽くもう一度実施 (admin が必ず1枚以上は後続 T016 で保証)
// 失敗要因が少ないため Result でなく純リストを返し、空集合はそのまま返却。

import 'dart:math';

import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'compute_slideshow_batch_usecase.g.dart';

class ComputeSlideshowBatchUseCase {
  const ComputeSlideshowBatchUseCase({this.defaultMaxCount = 20});
  final int defaultMaxCount;

  List<PhotoEntity> call(List<PhotoEntity> all, {int? maxCount, int? seed}) {
    if (all.isEmpty) return const [];
    final maxC = (maxCount ?? defaultMaxCount).clamp(1, 500); // 安全上限
    final rnd = Random(seed ?? DateTime.now().millisecondsSinceEpoch);

    final admin = all.where((p) => p.type.isAdmin).toList();
    final user = all.where((p) => !p.type.isAdmin).toList();

    void shuffleList<T>(List<T> list) {
      for (var i = list.length - 1; i > 0; i--) {
        final j = rnd.nextInt(i + 1);
        final tmp = list[i];
        list[i] = list[j];
        list[j] = tmp;
      }
    }

    shuffleList(admin);
    shuffleList(user);

    final adminQuota = admin.isEmpty ? 0 : (maxC * 0.25).ceil().clamp(1, maxC);
    final result = <PhotoEntity>[];

    if (adminQuota > 0) {
      result.addAll(admin.take(adminQuota));
    }
    if (result.length < maxC) {
      final remain = maxC - result.length;
      result.addAll(user.take(remain));
    }

    // 仕上げに軽くシャッフル（admin 固定 1 枚保証は後段 T016）
    shuffleList(result);
    return result.take(maxC).toList();
  }
}

@Riverpod()
ComputeSlideshowBatchUseCase computeSlideshowBatchUseCase(Ref ref) =>
    const ComputeSlideshowBatchUseCase();

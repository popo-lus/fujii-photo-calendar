// (T018) Month ViewModel: 月別写真表示とスライドショー制御
// 責務:
//  - 初期ロード (指定 uid + month)
//  - 月切替 (前月/次月)
//  - スライドショーバッチ生成 & Admin 露出保証適用
//  - UI 状態 (loading / loaded / error / empty / slideshow)
//  - 冪等な再読み込み
//
// 設計方針:
//  - Riverpod code-gen Notifier で状態管理
//  - Result を受け取り UIState へ正規化
//  - 取得済み月データキャッシュは Repository 層に集約（ViewModel は保持しない）
//  - スライドショー状態は別サブ状態に展開
//
// 依存:
//  - loadMonthPhotosUseCaseProvider
//  - computeSlideshowBatchUseCaseProvider
//  - ensureAdminExposureUseCaseProvider
//
// 今フェーズでは永続設定/ユーザー選択状態は扱わない (後続拡張余地)

import 'dart:async';

import 'package:fujii_photo_calendar/data/services/auth_service.dart';
import 'package:fujii_photo_calendar/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';
import 'package:fujii_photo_calendar/domain/usecases/load_month_photos_usecase.dart';
import 'package:fujii_photo_calendar/domain/usecases/compute_slideshow_batch_usecase.dart';
import 'package:fujii_photo_calendar/domain/usecases/ensure_admin_exposure_usecase.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/core/utils/perf_timer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_view_model.g.dart';
part 'month_view_model.freezed.dart';

// Freezed ベースの状態モデル
@freezed
abstract class MonthState with _$MonthState {
  const factory MonthState({
    required String uid,
    required int month, // 1..12
    required List<PhotoEntity> photos,
    List<PhotoEntity>? slideshowBatch,
    @Default(false) bool isReadOnly,
  }) = _MonthState;
}

extension MonthStateX on MonthState {
  bool get isEmpty => photos.isEmpty;
  bool get inSlideshow => slideshowBatch != null;
}

@Riverpod(keepAlive: true)
class MonthViewModel extends _$MonthViewModel {
  int _month = DateTime.now().month;

  @override
  Future<MonthState> build() async {
    return _fetch();
  }

  Future<MonthState> _fetch() async {
    final auth = ref.read(authServiceProvider);
    String uid;
    bool isReadOnly = false;
    if (auth.isCurrentUserAnonymous()) {
      uid = await auth.resolveOwnerUidForCurrentAnonymous();
      isReadOnly = true;
    } else {
      final user = ref.read(firebaseAuthProvider).currentUser;
      if (user == null) {
        throw StateError('Not authenticated');
      }
      uid = user.uid;
    }
    final loader = ref.read(loadMonthPhotosUseCaseProvider);
    return PerfTimer.measureFuture('month_load_$_month', () async {
      final result = await loader.call(uid: uid, month: _month);
      switch (result) {
        case Success<List<PhotoEntity>>(value: final list):
          AppLogger.instance.logMonthLoad(
            uid: uid,
            month: _month,
            count: list.length,
          );
          return MonthState(
            uid: uid,
            month: _month,
            photos: list,
            isReadOnly: isReadOnly,
          );
        case Failure<List<PhotoEntity>>(rawError: final e):
          AppLogger.instance.logError(e, phase: 'month_load');
          throw e; // AsyncValue.error へ伝播
      }
    });
  }

  Future<void> reload() async {
    state = const AsyncLoading<MonthState>();
    state = await AsyncValue.guard(_fetch);
  }

  Future<void> nextMonth() async {
    _month = _month >= 12 ? 1 : _month + 1;
    AppLogger.instance.logMonthSwipe(
      from: _month == 1 ? 12 : _month - 1,
      to: _month,
    );
    await reload();
  }

  Future<void> prevMonth() async {
    _month = _month <= 1 ? 12 : _month - 1;
    AppLogger.instance.logMonthSwipe(
      from: _month == 12 ? 1 : _month + 1,
      to: _month,
    );
    await reload();
  }

  Future<void> startSlideshow({int? maxCount, int? seed}) async {
    final data = state.value;
    if (data == null || data.photos.isEmpty) return;
    final compute = ref.read(computeSlideshowBatchUseCaseProvider);
    final ensure = ref.read(ensureAdminExposureUseCaseProvider);
    final batch0 = compute.call(data.photos, maxCount: maxCount, seed: seed);
    final batch = ensure.call(allPhotos: data.photos, batch: batch0);
    state = AsyncData(data.copyWith(slideshowBatch: batch));
    AppLogger.instance.logSlideshowStart(batch.length, data.photos.length);
  }

  void endSlideshow() {
    final data = state.value;
    if (data == null) return;
    if (!data.inSlideshow) return;
    state = AsyncData(data.copyWith(slideshowBatch: null));
    AppLogger.instance.logSlideshowEnd();
  }

  Future<void> logout() async {
    final service = ref.read(authServiceProvider);
    try {
      await service.signOut();
    } catch (e) {
      AppLogger.instance.logAuthSignOutFailure(error: e);
    }
  }
}

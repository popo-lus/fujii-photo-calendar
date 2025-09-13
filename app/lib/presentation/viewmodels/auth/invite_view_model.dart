// (T011) InviteViewModel: 招待コードによる匿名閲覧の状態管理
// 状態: idle / loading / error / success(ownerUid + AuthResult)

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/core/error/auth_error_mapper.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/data/services/auth_service.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_view_model.g.dart';
part 'invite_view_model.freezed.dart';

@freezed
class InviteState with _$InviteState {
  const factory InviteState.idle() = _InviteIdle;
  const factory InviteState.loading() = _InviteLoading;
  const factory InviteState.error(String message) = _InviteError;
  const factory InviteState.success({
    required String ownerUid,
    required AuthResult result,
  }) = _InviteSuccess;
}

@Riverpod(keepAlive: true)
class InviteViewModel extends _$InviteViewModel {
  @override
  InviteState build() => const InviteState.idle();

  Future<void> submit({required String code}) async {
    if (state is _InviteLoading) return;
    state = const InviteState.loading();
    final service = ref.read(authServiceProvider);

    try {
      // ログ: 開始（匿名 + 招待コード）
      // Service 側でも開始ログを出すが、VM レイヤでも記録しておく
      // 目的: 画面操作の起点とサービス層の起点を両方トレース可能にする
      AppLogger.instance.logAnonymousStart(code: code);
      final res = await service.signInAnonymousWithCode(code);
      // ownerUid は別呼び出しで解決
      final ownerUid = await service.resolveOwnerUidForInviteCode(code);
      // ログ: 成功
      AppLogger.instance.logAnonymousSuccess(
        viewerUid: res.userUid,
        ownerUid: ownerUid,
        code: code,
      );
      state = InviteState.success(ownerUid: ownerUid, result: res);
    } on AuthDomainException catch (e) {
      state = InviteState.error(e.message);
      AppLogger.instance.logAnonymousFailure(code: code, error: e.code);
    } on FirebaseAuthException catch (e) {
      state = InviteState.error(mapAuthError(e));
      AppLogger.instance.logAnonymousFailure(code: code, error: e.code);
    } catch (e) {
      state = InviteState.error(mapAuthError(e));
      AppLogger.instance.logAnonymousFailure(code: code, error: e);
    }
  }

  // 成否を boolean で返す軽量版（Deep Link フローでの分岐に利用）
  Future<bool> trySubmit({required String code}) async {
    try {
      await submit(code: code);
      return state.maybeWhen(
        success: (ownerUid, result) => true,
        orElse: () => false,
      );
    } catch (_) {
      return false;
    }
  }

  void reset() => state = const InviteState.idle();
}

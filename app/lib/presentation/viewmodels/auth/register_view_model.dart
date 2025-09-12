// (T010) RegisterViewModel: 新規登録フォームの状態管理
// 状態: idle / loading / error / success(AuthResult)

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/core/error/auth_error_mapper.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/data/services/auth_service.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_view_model.g.dart';
part 'register_view_model.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.idle() = _RegisterIdle;
  const factory RegisterState.loading() = _RegisterLoading;
  const factory RegisterState.error(String message) = _RegisterError;
  const factory RegisterState.success(AuthResult result) = _RegisterSuccess;
}

@Riverpod(keepAlive: true)
class RegisterViewModel extends _$RegisterViewModel {
  @override
  RegisterState build() => const RegisterState.idle();

  Future<void> submit({
    required String displayName,
    required String email,
    required String password,
  }) async {
    if (state is _RegisterLoading) return;
    state = const RegisterState.loading();
    final service = ref.read(authServiceProvider);

    try {
      // ログ: 開始
      AppLogger.instance.logRegisterStart(email: email);
      final res = await service.register(
        displayName: displayName,
        email: email,
        password: password,
      );
      // ログ: 成功
      AppLogger.instance.logRegisterSuccess(uid: res.userUid, email: res.email);
      state = RegisterState.success(res);
    } on AuthDomainException catch (e) {
      // ドメイン例外はメッセージが整備済み
      state = RegisterState.error(e.message);
      AppLogger.instance.logRegisterFailure(email: email, error: e.code);
    } on FirebaseAuthException catch (e) {
      state = RegisterState.error(mapAuthError(e));
      AppLogger.instance.logRegisterFailure(email: email, error: e.code);
    } catch (e) {
      state = RegisterState.error(mapAuthError(e));
      AppLogger.instance.logRegisterFailure(email: email, error: e);
    }
  }

  void reset() => state = const RegisterState.idle();
}

// (T009) LoginViewModel: ログインフォーム状態管理
// 状態: idle / loading / error / success(AuthResult)

import 'package:fujii_photo_calendar/data/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/core/error/auth_error_mapper.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_view_model.g.dart';
part 'login_view_model.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.idle() = _LoginIdle;
  const factory LoginState.loading() = _LoginLoading;
  const factory LoginState.error(String message) = _LoginError;
  const factory LoginState.success(AuthResult result) = _LoginSuccess;
}

@Riverpod(keepAlive: true)
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState.idle();

  Future<void> login({required String email, required String password}) async {
    // 既にロード中なら無視
    if (state is _LoginLoading) return;
    state = const LoginState.loading();
    final service = ref.read(authServiceProvider);
    try {
      final res = await service.signIn(email: email, password: password);
      state = LoginState.success(res);
    } on FirebaseAuthException catch (e) {
      state = LoginState.error(mapAuthError(e));
      AppLogger.instance.logAuthSignInFailure(email: email, error: e.code);
    } catch (e) {
      state = LoginState.error(mapAuthError(e));
      AppLogger.instance.logAuthSignInFailure(email: email, error: e);
    }
  }

  Future<void> logout() async {
    final service = ref.read(authServiceProvider);
    try {
      await service.signOut();
      state = const LoginState.idle();
    } catch (e) {
      AppLogger.instance.logAuthSignOutFailure(error: e);
      // 失敗しても状態は変えない
    }
  }

  void reset() => state = const LoginState.idle();
}

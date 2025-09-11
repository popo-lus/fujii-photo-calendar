// (T009) LoginViewModel: ログインフォーム状態管理
// 状態: idle / loading / error / success(AuthResult)

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:fujii_photo_calendar/providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/core/error/auth_error_mapper.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';

part 'login_view_model.g.dart';

sealed class LoginState {
  const LoginState();
}

class LoginIdle extends LoginState {
  const LoginIdle();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginError extends LoginState {
  const LoginError(this.message);
  final String message;
}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.result);
  final AuthResult result;
}

@Riverpod(keepAlive: true)
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginIdle();

  Future<void> login({required String email, required String password}) async {
    // 既にロード中なら無視
    if (state is LoginLoading) return;
    state = const LoginLoading();
    final service = ref.read(authServiceProvider);
    try {
      final res = await service.signIn(email: email, password: password);
      state = LoginSuccess(res);
    } on FirebaseAuthException catch (e) {
      state = LoginError(mapAuthError(e));
      AppLogger.instance.logAuthSignInFailure(email: email, error: e.code);
    } catch (e) {
      state = LoginError(mapAuthError(e));
      AppLogger.instance.logAuthSignInFailure(email: email, error: e);
    }
  }

  void reset() => state = const LoginIdle();
}

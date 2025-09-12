// (T008) アプリ共通例外階層。
// Repository / UseCase 層で捕捉し UI フィードバックやログに利用する。

import 'package:firebase_auth/firebase_auth.dart';

sealed class AppException implements Exception {
  const AppException(this.message, {this.cause, this.stackTrace});
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

/// ネットワーク/Firestore 通信失敗。
final class NetworkException extends AppException {
  const NetworkException(super.message, {super.cause, super.stackTrace});
}

/// デコード/マッピング失敗 (スキーマ不整合など)。
final class DecodeException extends AppException {
  const DecodeException(super.message, {super.cause, super.stackTrace});
}

/// 指定月の写真集合が空。
final class EmptyPhotoSetException extends AppException {
  const EmptyPhotoSetException(super.message);
}

/// 管理者 (fujii) 写真露出保証ロジックで違反。
final class AdminExposureViolation extends AppException {
  const AdminExposureViolation(super.message);
}

/// 認証関連のドメイン例外
final class AuthDomainException extends AppException {
  const AuthDomainException({
    required this.code,
    required String message,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message, cause: cause, stackTrace: stackTrace);
  final String code;

  @override
  String toString() => 'AuthDomainException($code): $message';

  factory AuthDomainException.fromFirebaseAuth(FirebaseAuthException e) {
    // 必要に応じてコードを整理・統合
    const messages = {
      'email-already-in-use': 'このメールアドレスは既に使用されています',
      'invalid-email': 'メールアドレスが不正です',
      'weak-password': 'パスワードが弱すぎます',
      'operation-not-allowed': 'この操作は許可されていません',
      'network-request-failed': 'ネットワークエラーが発生しました',
      'too-many-requests': 'リクエストが多すぎます',
      'user-disabled': 'このユーザーは無効化されています',
      'user-not-found': 'ユーザーが見つかりません',
      'wrong-password': 'パスワードが正しくありません',
    };
    final msg = messages[e.code] ?? (e.message ?? e.code);
    return AuthDomainException(code: e.code, message: msg, cause: e);
  }
}

// (T016) FirebaseAuthException コード -> ユーザー向けメッセージ

import 'package:firebase_auth/firebase_auth.dart';

String mapAuthError(Object error) {
  if (error is! FirebaseAuthException) return '予期しないエラーが発生しました';
  final code = error.code;
  switch (code) {
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'メールアドレスまたはパスワードが正しくありません';
    case 'network-request-failed':
      return 'ネットワーク接続を確認してください';
    case 'too-many-requests':
      return 'しばらく待って再度お試しください';
    default:
      return '予期しないエラーが発生しました';
  }
}

import 'package:firebase_core/firebase_core.dart';

String mapStorageError(Object error) {
  if (error is! FirebaseException) {
    return 'アップロードに失敗しました。しばらくしてからもう一度お試しください。';
  }
  switch (error.code) {
    case 'unauthorized':
      return '権限がありません。ログイン状態を確認してください。';
    case 'object-not-found':
      return '対象のファイルが見つかりません。';
    case 'canceled':
      return 'アップロードがキャンセルされました。';
    case 'quota-exceeded':
      return 'ストレージの上限に達しています。時間を置いて再試行してください。';
    case 'retry-limit-exceeded':
      return '通信が不安定です。ネットワーク環境を確認して再度お試しください。';
    case 'network-request-failed':
      return 'ネットワーク接続に問題があります。接続を確認してください。';
    default:
      return 'アップロードでエラーが発生しました（${error.code}）。';
  }
}

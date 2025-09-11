// (T008) アプリ共通例外階層。
// Repository / UseCase 層で捕捉し UI フィードバックやログに利用する。

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

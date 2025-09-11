import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_result.freezed.dart';
part 'auth_result.g.dart';

// (T005) AuthResult モデル: Firebase User をアプリ内部表現へ正規化
// 仕様フィールド: email, userUid, identifier, lastLoginAt
// identifier は displayName 廃止方針のため暫定: email ローカル部 or UID
@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required String email,
    required String userUid,
    required String identifier,
    DateTime? lastLoginAt,
  }) = _AuthResult;

  factory AuthResult.fromJson(Map<String, Object?> json) =>
      _$AuthResultFromJson(json);

  // FirebaseAuth User からの変換
  static AuthResult fromFirebaseUser(User user) {
    final email = user.email ?? '';
    final identifier = _deriveIdentifier(user);
    final lastLoginAt = user.metadata.lastSignInTime;
    return AuthResult(
      email: email,
      userUid: user.uid,
      identifier: identifier,
      lastLoginAt: lastLoginAt,
    );
  }
}

String _deriveIdentifier(User user) {
  final email = user.email;
  if (email != null && email.contains('@')) {
    return email.split('@').first; // ローカル部を簡易識別子に利用
  }
  return user.uid;
}

// (T007) AuthService 実装
// 契約: signIn / signOut / getCurrentUser / observeAuthState
// (T004/T005) register / signInAnonymousWithCode を追加

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/providers/auth_providers.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  AuthService(this._auth, this._db);
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    AppLogger.instance.logAuthSignInStart(email: email);
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user!;
      final result = AuthResult.fromFirebaseUser(user);
      AppLogger.instance.logAuthSignInSuccess(
        uid: user.uid,
        email: result.email,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      AppLogger.instance.logAuthSignInFailure(email: email, error: e.code);
      rethrow;
    } catch (e) {
      AppLogger.instance.logAuthSignInFailure(email: email, error: e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    final uid = _auth.currentUser?.uid;
    await _auth.signOut();
    if (uid != null) {
      AppLogger.instance.logAuthSignOut(uid: uid);
    }
  }

  AuthResult? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthResult.fromFirebaseUser(user);
  }

  Stream<AuthResult?> observeAuthState() => _auth.authStateChanges().map(
    (u) => u == null ? null : AuthResult.fromFirebaseUser(u),
  );

  // 現在のユーザーが匿名（招待閲覧）かどうか
  bool isCurrentUserAnonymous() {
    final u = _auth.currentUser;
    return u?.isAnonymous ?? false;
  }

  // 現在の匿名ユーザーに紐づく招待コードから ownerUid を解決
  // guestSessions/{viewerUid}.code を取得し、resolveOwnerUidForInviteCode を用いて検証・解決する
  Future<String> resolveOwnerUidForCurrentAnonymous() async {
    final viewer = _auth.currentUser;
    if (viewer == null || !viewer.isAnonymous) {
      throw const AuthDomainException(
        code: 'not-anonymous',
        message: '匿名ユーザーではありません',
      );
    }
    final snap = await _db.collection('guestSessions').doc(viewer.uid).get();
    if (!snap.exists) {
      throw const AuthDomainException(
        code: 'guest-session-not-found',
        message: '招待セッションが見つかりません',
      );
    }
    final data = snap.data();
    final code = data?['code'] as String? ?? '';
    if (code.isEmpty) {
      throw const AuthDomainException(
        code: 'invite-code-missing',
        message: '招待コードが見つかりません',
      );
    }
    // コードの妥当性は resolveOwnerUidForInviteCode 内で検証
    return resolveOwnerUidForInviteCode(code);
  }

  // (T004) 新規登録
  Future<AuthResult> register({
    required String displayName,
    required String email,
    required String password,
  }) async {
    AppLogger.instance.logRegisterStart(email: email);
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) {
        throw const AuthDomainException(
          code: 'user-null',
          message: 'ユーザー作成に失敗しました',
        );
      }
      // 表示名更新
      await user.updateDisplayName(displayName);

      final uid = user.uid;
      // Firestore users/{uid}
      final now = FieldValue.serverTimestamp();
      await _db.collection('users').doc(uid).set({
        'displayName': displayName,
        'email': user.email ?? email,
        'status': 'active',
        'createdAt': now,
        'updatedAt': now,
      }, SetOptions(merge: true));

      final result = AuthResult.fromFirebaseUser(user);
      AppLogger.instance.logRegisterSuccess(uid: uid, email: result.email);
      return result;
    } on FirebaseAuthException catch (e) {
      AppLogger.instance.logRegisterFailure(email: email, error: e.code);
      throw AuthDomainException.fromFirebaseAuth(e);
    } on FirebaseException catch (e) {
      AppLogger.instance.logRegisterFailure(email: email, error: e.code);
      throw AuthDomainException(
        code: 'firestore',
        message: e.message ?? e.code,
      );
    } catch (e) {
      AppLogger.instance.logRegisterFailure(email: email, error: e);
      throw AuthDomainException(code: 'unknown', message: e.toString());
    }
  }

  // (T005) 招待コードで匿名サインイン
  // 返り値は AuthResult に統一。ownerUid は必要に応じて
  // resolveOwnerUidForInviteCode(code) を別途呼び出して取得してください。
  // (T021) invites の参照方針:
  //  - セキュリティルールで invites コレクションは list/クエリ禁止、単一ドキュメント get のみ許可
  //  - したがってここでは invites/{code} のドキュメント ID を直接指定して get する
  //  - コード列挙や部分一致検索は行わない（プライバシー/探索耐性のため）
  //  - 期限切れ/disabled をアプリ側でも検証し、監査用に guestSessions/{viewerUid} を作成
  Future<AuthResult> signInAnonymousWithCode(String code) async {
    AppLogger.instance.logAnonymousStart(code: code);
    try {
      final cred = await _auth.signInAnonymously();
      final viewer = cred.user;
      if (viewer == null) {
        throw const AuthDomainException(
          code: 'anonymous-failed',
          message: '匿名サインインに失敗しました',
        );
      }

      // invites/{code} は list 禁止前提、get のみ（クエリ/列挙は行わない）
      final snap = await _db.collection('invites').doc(code).get();
      if (!snap.exists) {
        throw const AuthDomainException(
          code: 'invalid-code',
          message: '無効な招待コードです',
        );
      }
      final data = snap.data() as Map<String, dynamic>;
      final disabled = (data['disabled'] as bool?) ?? false;
      if (disabled) {
        throw const AuthDomainException(
          code: 'invite-disabled',
          message: 'この招待は無効です',
        );
      }
      final expiresAtRaw = data['expiresAt'];
      if (expiresAtRaw != null) {
        DateTime expiresAt;
        if (expiresAtRaw is Timestamp) {
          expiresAt = expiresAtRaw.toDate();
        } else if (expiresAtRaw is DateTime) {
          expiresAt = expiresAtRaw;
        } else {
          // 予期しない型は即時期限切れとみなす
          expiresAt = DateTime.fromMillisecondsSinceEpoch(0);
        }
        if (expiresAt.isBefore(DateTime.now())) {
          throw const AuthDomainException(
            code: 'invite-expired',
            message: '招待の有効期限が切れています',
          );
        }
      }
      final ownerUid = (data['ownerUid'] as String?) ?? '';
      if (ownerUid.isEmpty) {
        throw const AuthDomainException(
          code: 'invite-no-owner',
          message: '招待の参照先が不明です',
        );
      }

      // 任意: guestSessions/{viewerUid}
      await _db.collection('guestSessions').doc(viewer.uid).set({
        'code': code,
        'albumOwnerUid': ownerUid,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      AppLogger.instance.logAnonymousSuccess(
        viewerUid: viewer.uid,
        ownerUid: ownerUid,
        code: code,
      );
      return AuthResult.fromFirebaseUser(viewer);
    } on FirebaseAuthException catch (e) {
      AppLogger.instance.logAnonymousFailure(code: code, error: e.code);
      throw AuthDomainException.fromFirebaseAuth(e);
    } on FirebaseException catch (e) {
      AppLogger.instance.logAnonymousFailure(code: code, error: e.code);
      throw AuthDomainException(
        code: 'firestore',
        message: e.message ?? e.code,
      );
    } catch (e) {
      AppLogger.instance.logAnonymousFailure(code: code, error: e);
      throw AuthDomainException(code: 'unknown', message: e.toString());
    }
  }

  // 招待コード -> ownerUid の解決ヘルパ（VM 遷移に利用）
  // (T021) ここでも list 禁止 / get のみのポリシーに従い、invites/{code} を直接取得して検証する
  Future<String> resolveOwnerUidForInviteCode(String code) async {
    final snap = await _db.collection('invites').doc(code).get();
    if (!snap.exists) {
      throw const AuthDomainException(
        code: 'invalid-code',
        message: '無効な招待コードです',
      );
    }
    final data = snap.data() as Map<String, dynamic>;
    final disabled = (data['disabled'] as bool?) ?? false;
    if (disabled) {
      throw const AuthDomainException(
        code: 'invite-disabled',
        message: 'この招待は無効です',
      );
    }
    final ownerUid = (data['ownerUid'] as String?) ?? '';
    if (ownerUid.isEmpty) {
      throw const AuthDomainException(
        code: 'invite-no-owner',
        message: '招待の参照先が不明です',
      );
    }
    final expiresAtRaw = data['expiresAt'];
    if (expiresAtRaw != null) {
      DateTime expiresAt;
      if (expiresAtRaw is Timestamp) {
        expiresAt = expiresAtRaw.toDate();
      } else if (expiresAtRaw is DateTime) {
        expiresAt = expiresAtRaw;
      } else {
        expiresAt = DateTime.fromMillisecondsSinceEpoch(0);
      }
      if (expiresAt.isBefore(DateTime.now())) {
        throw const AuthDomainException(
          code: 'invite-expired',
          message: '招待の有効期限が切れています',
        );
      }
    }
    return ownerUid;
  }
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final db = ref.watch(firestoreProvider);
  return AuthService(auth, db);
}

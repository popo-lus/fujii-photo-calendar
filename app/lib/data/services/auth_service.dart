// (T007) AuthService 実装
// 契約: signIn / signOut / getCurrentUser / observeAuthState

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/providers/auth_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  AuthService(this._auth);
  final FirebaseAuth _auth;

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
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthService(auth);
}

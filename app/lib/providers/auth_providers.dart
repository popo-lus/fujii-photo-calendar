// (T004) Auth 基礎 Provider: FirebaseAuth instance と authStateChanges Stream
// 目的: 下位層 (Service / ViewModel) で FirebaseAuth を依存注入しやすくする
// NOTE: build_runner による生成不要なためプレーン定義

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:fujii_photo_calendar/data/services/auth_service.dart';

// FirebaseAuth シングルトン provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// 認証状態変更ストリーム provider (User? を流す)
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});

// (T008) AuthService Provider
final authServiceProvider = Provider<AuthService>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthService(auth);
});

// (T026) ロギング/メトリクス: シンプル JSON ロガー
// 目的:
//  - 起動 / 初期化 / 月移動 / スライドショー / パフォーマンス計測 を統一フォーマットで debugPrint
//  - 将来 Firestore 送信 / Crashlytics 連携 / ファイル出力 へ差し替え容易にする抽象化
// 設計:
//  - 単純な key-value を Map として保持し ISO8601 時刻付与
//  - 依存最小化 (print ベース)
//  - Provider から利用しやすいシングルトン

import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();
  static final AppLogger instance = AppLogger._();

  void _emit(String event, {Map<String, Object?> data = const {}}) {
    final record = <String, Object?>{
      'ts': DateTime.now().toIso8601String(),
      'event': event,
      if (data.isNotEmpty) 'data': data,
      'env': kReleaseMode ? 'release' : 'debug',
    };
    debugPrint('[LOG] ${jsonEncode(record)}');
  }

  // 汎用
  void log(String event, {Map<String, Object?> data = const {}}) =>
      _emit(event, data: data);

  // 起動系
  void logStartup({required bool useEmulators, int? firebaseInitMs}) => _emit(
    'startup',
    data: {
      'useEmulators': useEmulators,
      if (firebaseInitMs != null) 'firebaseInitMs': firebaseInitMs,
    },
  );

  // パフォーマンス計測結果
  void logPerf(String label, int ms) =>
      _emit('perf', data: {'label': label, 'ms': ms});

  // 月データロード
  void logMonthLoad({
    required String uid,
    required int month,
    required int count,
    int? ms,
  }) => _emit(
    'month_load',
    data: {
      'uid': uid,
      'month': month,
      'count': count,
      if (ms != null) 'ms': ms,
    },
  );

  // 月移動
  void logMonthSwipe({required int from, required int to}) =>
      _emit('month_swipe', data: {'from': from, 'to': to});

  // スライドショー
  void logSlideshowStart(int batchCount, int total) =>
      _emit('slideshow_start', data: {'batch': batchCount, 'total': total});
  void logSlideshowEnd() => _emit('slideshow_end');

  // エラー
  void logError(Object error, {StackTrace? stack, String? phase}) => _emit(
    'error',
    data: {
      'error': error.toString(),
      if (phase != null) 'phase': phase,
      if (stack != null) 'stack': stack.toString(),
    },
  );

  // (T003) Auth ログ
  void logAuthSignInStart({required String email}) =>
      _emit('auth_signin_start', data: {'email': email});
  void logAuthSignInSuccess({required String uid, required String email}) =>
      _emit('auth_signin_success', data: {'uid': uid, 'email': email});
  void logAuthSignInFailure({required String email, required Object error}) =>
      _emit(
        'auth_signin_failure',
        data: {'email': email, 'error': error.toString()},
      );
  void logAuthSignOut({required String uid}) =>
      _emit('auth_signout', data: {'uid': uid});
  void logAuthSignOutFailure({required Object error}) =>
      _emit('auth_signout_failure', data: {'error': error.toString()});
}

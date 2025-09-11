// (T027) パフォーマンス計測ラッパー
// 単純な経過時間測定ユーティリティ (ms) -> コールバック or logger 出力

import 'dart:async';
import 'package:fujii_photo_calendar/core/logger/logger.dart';

class PerfTimer {
  PerfTimer(this.label) : _start = DateTime.now();
  final String label;
  final DateTime _start;

  int stop({bool log = true}) {
    final elapsed = DateTime.now().difference(_start).inMilliseconds;
    if (log) AppLogger.instance.logPerf(label, elapsed);
    return elapsed;
  }

  static Future<T> measureFuture<T>(
    String label,
    Future<T> Function() fn,
  ) async {
    final t = PerfTimer(label);
    try {
      return await fn();
    } finally {
      t.stop();
    }
  }
}

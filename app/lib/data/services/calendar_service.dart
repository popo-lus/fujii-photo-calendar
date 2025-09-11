// (T011) Firestore Service: 指定ユーザー & 月の fujii-photos / user-photos を取得。
//
// Repository 層から呼び出される最下層 (データ取得) 責務。
// 返却値は Firestore 生データ Map リスト（id フィールド付与済）。
// 例外は FirebaseException を NetworkException にラップして上位へ伝搬。

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'calendar_service.g.dart';

class CalendarService {
  CalendarService(this._firestore);
  final FirebaseFirestore _firestore;

  Future<List<Map<String, dynamic>>> fetchMonthRawPhotos({
    required String uid,
    required int month,
  }) async {
    final monthKey = month.toString().padLeft(2, '0');
    try {
      final base = _firestore
          .collection('users')
          .doc(uid)
          .collection('calendar')
          .doc(monthKey);
      final futures = [
        base.collection('fujii-photos').get(),
        base.collection('user-photos').get(),
      ];
      final snaps = await Future.wait(futures);
      final all = <Map<String, dynamic>>[];
      for (final qs in snaps) {
        for (final doc in qs.docs) {
          final data = doc.data();
          // id を明示保持
          all.add({...data, 'id': doc.id});
        }
      }
      return all;
    } on FirebaseException catch (e, st) {
      throw NetworkException(
        'Firestore fetch failed: ${e.message}',
        cause: e,
        stackTrace: st,
      );
    }
  }
}

@Riverpod(keepAlive: true)
CalendarService calendarService(Ref ref) {
  final fs = ref.watch(firestoreProvider);
  return CalendarService(fs);
}

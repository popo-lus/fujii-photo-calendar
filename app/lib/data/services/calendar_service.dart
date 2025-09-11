// (T011) Firestore Service: 指定ユーザー & 月の写真を、月ドキュメント配列（userPhotos / fujiiPhotos）から取得。
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
      final docRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('calendar')
          .doc(monthKey);
      final snap = await docRef.get();
      if (!snap.exists) {
        return <Map<String, dynamic>>[];
      }
      final data = snap.data() ?? <String, dynamic>{};
      List<dynamic> asList(dynamic v) => v is List ? v : const [];

      final user = asList(data['userPhotos'])
          .whereType<Map<String, dynamic>>()
          .map((e) => {...e, 'type': 'user-photos'})
          .toList();
      final fujii = asList(data['fujiiPhotos'])
          .whereType<Map<String, dynamic>>()
          .map((e) => {...e, 'type': 'fujii-photos'})
          .toList();

      // どちらの配列にも id が含まれている前提（seed に準拠）。
      // 念のため欠落時は URL 末尾やインデックスで補完しない（DecodeException で上位へ）。
      return [...user, ...fujii];
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

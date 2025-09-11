// Firestore Service (FujiiPhotos): 指定ユーザー & 月の fujiiPhotos 配列のみ取得。
// 返却値は Firestore 生データ Map リスト（id 付与済み前提）。

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fujii_photos_service.g.dart';

class FujiiPhotosService {
  FujiiPhotosService(this._firestore);
  final FirebaseFirestore _firestore;

  Future<List<Map<String, dynamic>>> fetchMonthRawFujiiPhotos({
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
      if (!snap.exists) return const <Map<String, dynamic>>[];
      final data = snap.data() ?? <String, dynamic>{};
      final List<dynamic> raw = (data['fujiiPhotos'] is List)
          ? data['fujiiPhotos'] as List<dynamic>
          : const <dynamic>[];
      return raw
          .whereType<Map<String, dynamic>>()
          .map((e) => {...e, 'type': 'fujii-photos'})
          .toList();
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
FujiiPhotosService fujiiPhotosService(Ref ref) {
  final fs = ref.watch(firestoreProvider);
  return FujiiPhotosService(fs);
}

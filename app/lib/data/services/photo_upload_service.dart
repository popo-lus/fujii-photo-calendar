import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_upload_service.g.dart';

class PhotoUploadService {
  PhotoUploadService(this._storage, this._firestore);
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;

  // 画像ファイルを Storage にアップロードし、users/{uid}/calendar/{MM}.userPhotos にメタ追加
  // フォーマット制限なし（失敗時は例外をスロー）
  Future<String> uploadAndAppendUserPhoto({
    required String ownerUid,
    required int month,
    required File file,
    DateTime? capturedAt,
    String? memo,
  }) async {
    try {
      final mm = month.toString().padLeft(2, '0');
      final filename =
          '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
      final path = 'user-uploads/$ownerUid/$mm/$filename';
      final ref = _storage.ref(path);
      final task = await ref.putFile(file);
      if (task.state != TaskState.success) {
        throw const NetworkException('アップロードに失敗しました');
      }
      final url = await ref.getDownloadURL();

      // Firestore 側に配列要素としてメタを追記
      final doc = _firestore
          .collection('users')
          .doc(ownerUid)
          .collection('calendar')
          .doc(mm);
      final id = _firestore.collection('_').doc().id; // ランダムID生成用途
      final now = FieldValue.serverTimestamp();
      final map = <String, dynamic>{
        'id': id,
        'url': url,
        'capturedAt': capturedAt ?? DateTime.now(),
        'month': month,
        'type': 'user-photos',
        'updatedAt': now,
        if (memo != null && memo.isNotEmpty) 'memo': memo,
      };
      await doc.set({
        'month': month,
        'updatedAt': now,
        'userPhotos': FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));

      AppLogger.instance.log(
        'photo_upload_success',
        data: {'ownerUid': ownerUid, 'month': month, 'path': path},
      );
      return url;
    } on FirebaseException catch (e, st) {
      AppLogger.instance.logError(e, stack: st, phase: 'photo_upload');
      throw NetworkException(e.message ?? e.code, cause: e, stackTrace: st);
    } catch (e, st) {
      AppLogger.instance.logError(e, stack: st, phase: 'photo_upload');
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
PhotoUploadService photoUploadService(Ref ref) {
  final FirebaseStorage storage = ref.watch(firebaseStorageProvider);
  final FirebaseFirestore fs = ref.watch(firestoreProvider);
  return PhotoUploadService(storage, fs);
}

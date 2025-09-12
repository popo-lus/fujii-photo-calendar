// (T008) UserService: Firestore single data source for users

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

class UserService {
  UserService(this._db);
  final FirebaseFirestore _db;

  Stream<Map<String, dynamic>?> watchUserJson(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((s) => s.data());
  }

  Future<Map<String, dynamic>?> getUserJsonOnce(String uid) async {
    final s = await _db.collection('users').doc(uid).get();
    return s.data();
  }

  Future<void> updateDisplayName({
    required String uid,
    required String displayName,
  }) async {
    await _db.collection('users').doc(uid).update({
      'displayName': displayName,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}

@Riverpod(keepAlive: true)
UserService userService(Ref ref) {
  final db = ref.watch(firestoreProvider);
  return UserService(db);
}

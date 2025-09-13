import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invite_service.g.dart';

class InviteService {
  InviteService(this._db);
  final FirebaseFirestore _db;

  Future<bool> exists(String code) async {
    final s = await _db.collection('invites').doc(code).get();
    return s.exists;
  }

  Future<void> put({
    required String code,
    required String ownerUid,
    bool disabled = false,
    DateTime? expiresAt,
  }) async {
    await _db.collection('invites').doc(code).set({
      'ownerUid': ownerUid,
      'disabled': disabled,
      if (expiresAt != null) 'expiresAt': Timestamp.fromDate(expiresAt),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getJson(String code) async {
    final s = await _db.collection('invites').doc(code).get();
    return s.data();
  }

  Future<void> updateDisabled(String code, bool disabled) async {
    await _db.collection('invites').doc(code).update({
      'disabled': disabled,
    });
  }
}

@Riverpod(keepAlive: true)
InviteService inviteService(Ref ref) {
  final db = ref.watch(firestoreProvider);
  return InviteService(db);
}


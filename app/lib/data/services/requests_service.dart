import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fujii_photo_calendar/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'requests_service.g.dart';

class RequestsService {
  RequestsService(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _col(String ownerUid) =>
      _db.collection('users').doc(ownerUid).collection('requests');

  Future<void> addRequest({
    required String ownerUid,
    required Map<String, dynamic> json,
  }) async {
    final doc = _col(ownerUid).doc();
    await doc.set({
      ...json,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<List<Map<String, dynamic>>> watchRecent({
    required String ownerUid,
    int retentionDays = 14,
  }) {
    final since = DateTime.now().subtract(Duration(days: retentionDays));
    return _col(ownerUid)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(since))
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
        );
  }

  Future<void> delete({
    required String ownerUid,
    required String requestId,
  }) async {
    await _col(ownerUid).doc(requestId).delete();
  }
}

@Riverpod(keepAlive: true)
RequestsService requestsService(Ref ref) {
  final db = ref.watch(firestoreProvider);
  return RequestsService(db);
}

// Mapping helpers for User related JSON <-> Entity

import 'package:fujii_photo_calendar/domain/entities/user_entity.dart';

// Converts Firestore/JSON map into UserEntity with sane defaults.
UserEntity mapJsonToUserEntity(String uid, Map<String, dynamic> json) {
  final email = (json['email'] as String?)?.trim() ?? '';
  final displayName = (json['displayName'] as String?)?.trim() ?? '';
  final status = (json['status'] as String?)?.trim() ?? 'active';
  final role = (json['role'] as String?)?.trim() ?? 'user';
  final createdAt = toDateTime(json['createdAt']);
  final updatedAt = toDateTime(json['updatedAt']);
  return UserEntity(
    uid: uid,
    email: email,
    displayName: displayName,
    status: status,
    role: role,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

// Best-effort conversion for Firestore Timestamp, DateTime, String, or int(ms epoch)
DateTime? toDateTime(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  try {
    final toDate = (v as dynamic).toDate;
    if (toDate is Function) {
      return (v as dynamic).toDate() as DateTime;
    }
  } catch (_) {
    /* ignore */
  }
  if (v is String) return DateTime.tryParse(v);
  if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
  return null;
}

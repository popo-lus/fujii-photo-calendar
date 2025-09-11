// (T010) Firestore Raw Data -> PhotoEntity 変換。
// Firestore 取得結果 (Map<String,dynamic>) からアプリ内部モデルへ変換し、
// 導出フィールド priority, monthKey を付与する。
// 失敗時は DecodeException を投げ、呼び出し側で Result.guard 利用を推奨。
import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

/// 必須キー一覧
const _requiredKeys = ['type', 'month', 'capturedAt', 'url', 'updatedAt'];

PhotoEntity mapFirestorePhoto(String id, Map<String, dynamic> raw) {
  for (final k in _requiredKeys) {
    if (!raw.containsKey(k) || raw[k] == null) {
      throw DecodeException('Missing key `$k` for photo `$id`');
    }
  }

  final typeStr = raw['type'] as String;
  final type = switch (typeStr) {
    'fujii-photos' => PhotoType.fujiiPhotos,
    'user-photos' => PhotoType.userPhotos,
    _ => throw DecodeException('Unknown photo type `$typeStr` for `$id`'),
  };

  final month = raw['month'] as int;
  if (month < 1 || month > 12) {
    throw DecodeException('Invalid month `$month` for `$id`');
  }
  final monthKey = month.toString().padLeft(2, '0');

  DateTime parseTs(String field) {
    final v = raw[field];
    if (v is DateTime) return v.toUtc();
    if (v is String) return DateTime.parse(v).toUtc();
    // cloud_firestore Timestamp を遅延識別
    try {
      final dynamic dyn = v;
      if (dyn != null && dyn.toString().startsWith('Timestamp(')) {
        final date = dyn.toDate();
        if (date is DateTime) return date.toUtc();
      }
    } catch (_) {}
    throw DecodeException('Invalid timestamp `$field` for `$id`');
  }

  final capturedAt = parseTs('capturedAt');
  final updatedAt = parseTs('updatedAt');

  final url = raw['url'] as String;
  final memo = raw['memo'] as String?;

  final priority = type == PhotoType.fujiiPhotos ? 10 : 0;

  final entity = PhotoEntity(
    id: id,
    type: type,
    month: month,
    monthKey: monthKey,
    capturedAt: capturedAt,
    url: url,
    priority: priority,
    memo: memo,
    updatedAt: updatedAt,
  );

  if (!entity.isMonthValid) {
    throw DecodeException('Month validation failed for `$id`');
  }
  return entity;
}

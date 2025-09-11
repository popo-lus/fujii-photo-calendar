/// (T009) PhotoEntity: Firestore 写真ドキュメントのアプリ内部正規化モデル。
///
/// Freezed + json_serializable を利用。Firestore からの直接デシリアライズは行わず
/// `data/mappers/photo_mapper.dart` 経由で導出フィールド (priority, monthKey) を付与する。
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_entity.freezed.dart';
part 'photo_entity.g.dart';

/// Firestore `type` フィールドに対応。
enum PhotoType {
  @JsonValue('fujii-photos')
  fujiiPhotos,
  @JsonValue('user-photos')
  userPhotos,
}

extension PhotoTypeX on PhotoType {
  bool get isAdmin => this == PhotoType.fujiiPhotos;
  String get raw => switch (this) {
    PhotoType.fujiiPhotos => 'fujii-photos',
    PhotoType.userPhotos => 'user-photos',
  };
}

@freezed
class PhotoEntity with _$PhotoEntity {
  const factory PhotoEntity({
    required String id,
    required PhotoType type,
    required int month, // 1..12
    required String monthKey, // zero padded 2桁
    required DateTime capturedAt,
    required String url,
    required int priority, // derived (admin=10, user=0 初期)
    String? memo,
    required DateTime updatedAt,
  }) = _PhotoEntity;

  factory PhotoEntity.fromJson(Map<String, dynamic> json) =>
      _$PhotoEntityFromJson(json);
}

extension PhotoEntityX on PhotoEntity {
  /// 基本的な整合性検証。
  bool get isMonthValid =>
      month >= 1 && month <= 12 && monthKey == month.toString().padLeft(2, '0');
}

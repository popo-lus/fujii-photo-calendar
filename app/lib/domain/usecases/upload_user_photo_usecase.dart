import 'dart:io';

import 'package:exif/exif.dart';
import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/services/photo_upload_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_user_photo_usecase.g.dart';

/// UseCase: ユーザー写真をアップロードし、capturedAt を EXIF から自動取得して保存する。
class UploadUserPhotoUseCase {
  const UploadUserPhotoUseCase(this._service);
  final PhotoUploadService _service;

  /// 成功時はダウンロード URL を返す。
  Future<Result<String>> call({
    required String ownerUid,
    required File file,
    String? memo,
  }) async {
    try {
      final capturedAt = await _detectCapturedAt(file);
      final month = capturedAt.month; // 1..12
      final url = await _service.uploadAndAppendUserPhoto(
        ownerUid: ownerUid,
        month: month,
        file: file,
        capturedAt: capturedAt,
        memo: memo,
      );
      return Success(url);
    } catch (e, st) {
      return Failure<String>(e, st);
    }
  }

  Future<DateTime> _detectCapturedAt(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final data = await readExifFromBytes(bytes);
      final dt = _readDateFromExif(data);
      if (dt != null) return dt;
    } catch (_) {
      // 解析失敗 → フォールバックへ
    }
    try {
      return await file.lastModified();
    } catch (_) {
      return DateTime.now();
    }
  }

  DateTime? _readDateFromExif(Map<String, IfdTag> data) {
    final keys = <String>[
      'EXIF DateTimeOriginal',
      'Image DateTime',
      'EXIF DateTimeDigitized',
    ];
    for (final k in keys) {
      final tag = data[k];
      final raw = tag?.printable;
      if (raw == null || raw.trim().isEmpty) continue;
      final parsed = _parseExifDateTime(raw.trim());
      if (parsed != null) return parsed;
    }
    return null;
  }

  // EXIF の日付文字列 (例: 2020:01:31 12:34:56) を DateTime に変換
  DateTime? _parseExifDateTime(String s) {
    try {
      final parts = s.split(' ');
      if (parts.length != 2) return null;
      final ymd = parts[0].split(':');
      final hms = parts[1].split(':');
      if (ymd.length != 3 || hms.length != 3) return null;
      final year = int.parse(ymd[0]);
      final month = int.parse(ymd[1]);
      final day = int.parse(ymd[2]);
      final hour = int.parse(hms[0]);
      final minute = int.parse(hms[1]);
      final second = int.parse(hms[2]);
      return DateTime(year, month, day, hour, minute, second);
    } catch (_) {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
UploadUserPhotoUseCase uploadUserPhotoUseCase(Ref ref) {
  final service = ref.watch(photoUploadServiceProvider);
  return UploadUserPhotoUseCase(service);
}

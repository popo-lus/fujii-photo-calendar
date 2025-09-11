// (T013) Repository 実装:
// - Service 呼出
// - Mapper 適用 (Firestore raw -> PhotoEntity)
// - メモリキャッシュ (uid:MM -> List<PhotoEntity>)
// - NetworkException のみ 1 回リトライ
// - 空集合時は EmptyPhotoSetException を Failure として返却

//TODO: キャッシュをRepository側で実装

import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/mappers/photo_mapper.dart';
import 'package:fujii_photo_calendar/data/services/calendar_service.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/calendar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'calendar_repository_impl.g.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl(this._service);
  final CalendarService _service;

  final Map<String, List<PhotoEntity>> _cache = {};

  @override
  Future<Result<List<PhotoEntity>>> loadMonthPhotos({
    required String uid,
    required int month,
  }) async {
    final key = _cacheKey(uid, month);
    final cached = _cache[key];
    if (cached != null) {
      return Success(cached);
    }

    Future<Result<List<PhotoEntity>>> run() async {
      try {
        final rawList = await _service.fetchMonthRawPhotos(
          uid: uid,
          month: month,
        );
        final entities = rawList
            .map((r) => mapFirestorePhoto(r['id'] as String, r))
            .toList();
        if (entities.isEmpty) {
          throw EmptyPhotoSetException('No photos for $uid month=$month');
        }
        // 優先度 (priority) / capturedAt ソート (priority desc, capturedAt asc)
        entities.sort((a, b) {
          final p = b.priority.compareTo(a.priority);
          if (p != 0) return p;
          return a.capturedAt.compareTo(b.capturedAt);
        });
        _cache[key] = entities;
        return Success<List<PhotoEntity>>(entities);
      } catch (e, st) {
        return Failure<List<PhotoEntity>>(e, st);
      }
    }

    final first = await run();
    if (first is Failure<List<PhotoEntity>> &&
        first.error is NetworkException) {
      final second = await run();
      return second;
    }
    return first;
  }

  String _cacheKey(String uid, int month) =>
      '$uid:${month.toString().padLeft(2, '0')}'.toLowerCase();
}

@Riverpod(keepAlive: true)
CalendarRepository calendarRepository(Ref ref) {
  final service = ref.watch(calendarServiceProvider); // generated function name
  return CalendarRepositoryImpl(service);
}

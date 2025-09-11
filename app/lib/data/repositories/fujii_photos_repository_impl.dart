import 'package:fujii_photo_calendar/core/error/app_exceptions.dart';
import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/mappers/photo_mapper.dart';
import 'package:fujii_photo_calendar/data/services/fujii_photos_service.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/fujii_photos_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'fujii_photos_repository_impl.g.dart';

class FujiiPhotosRepositoryImpl implements FujiiPhotosRepository {
  FujiiPhotosRepositoryImpl(this._service);
  final FujiiPhotosService _service;

  final Map<String, List<PhotoEntity>> _cache = {};

  @override
  Future<Result<List<PhotoEntity>>> loadMonthFujiiPhotos({
    required String uid,
    required int month,
  }) async {
    final key = '$uid:fujii:${month.toString().padLeft(2, '0')}'.toLowerCase();
    final cached = _cache[key];
    if (cached != null) return Success(cached);

    Future<Result<List<PhotoEntity>>> run() async {
      try {
        final rawList = await _service.fetchMonthRawFujiiPhotos(
          uid: uid,
          month: month,
        );
        var entities = rawList
            .map((r) => mapFirestorePhoto(r['id'] as String, r))
            .toList();
        entities = entities.where((e) => e.month == month).toList();
        if (entities.isNotEmpty) {
          entities.sort((a, b) {
            final p = b.priority.compareTo(a.priority);
            if (p != 0) return p;
            return a.capturedAt.compareTo(b.capturedAt);
          });
        }
        _cache[key] = entities;
        return Success<List<PhotoEntity>>(entities);
      } catch (e, st) {
        return Failure<List<PhotoEntity>>(e, st);
      }
    }

    final first = await run();
    if (first is Failure<List<PhotoEntity>> &&
        first.error is NetworkException) {
      return await run();
    }
    return first;
  }
}

@Riverpod(keepAlive: true)
FujiiPhotosRepository fujiiPhotosRepository(Ref ref) {
  final service = ref.watch(fujiiPhotosServiceProvider);
  return FujiiPhotosRepositoryImpl(service);
}

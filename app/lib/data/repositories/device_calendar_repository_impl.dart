// (DC050) DeviceCalendarRepositoryImpl: Service + Mapper による実装

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/data/mappers/device_calendar_mappers.dart';
import 'package:fujii_photo_calendar/data/services/device_calendar_service.dart';
import 'package:fujii_photo_calendar/domain/entities/device_calendar_entity.dart';
import 'package:fujii_photo_calendar/domain/entities/device_event_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/device_calendar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_calendar_repository_impl.g.dart';
class DeviceCalendarRepositoryImpl implements DeviceCalendarRepository {
  DeviceCalendarRepositoryImpl(this._service);
  final DeviceCalendarService _service;

  @override
  Future<Result<bool>> ensurePermission() async {
    try {
      final has = await _service.hasPermissions();
      if (has) return const Success(true);
      final granted = await _service.requestPermissions();
      return Success(granted);
    } catch (e, st) {
      return Failure<bool>(e, st);
    }
  }

  @override
  Future<Result<List<DeviceCalendarEntity>>> fetchCalendars({
    bool onlyWritable = false,
  }) async {
    try {
      final list =
          await _service.retrieveCalendars(onlyWritable: onlyWritable);
      final mapped = list.map(mapCalendarToEntity).toList(growable: false);
      return Success(mapped);
    } catch (e, st) {
      return Failure<List<DeviceCalendarEntity>>(e, st);
    }
  }

  @override
  Future<Result<List<DeviceEventEntity>>> fetchEvents({
    required String calendarId,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final list = await _service.retrieveEvents(calendarId, start, end);
      final mapped = list.map(mapEventToEntity).toList(growable: false);
      return Success(mapped);
    } catch (e, st) {
      return Failure<List<DeviceEventEntity>>(e, st);
    }
  }
}

@Riverpod(keepAlive: true)
DeviceCalendarRepository deviceCalendarRepository(Ref ref) {
  final service = ref.watch(deviceCalendarServiceProvider);
  return DeviceCalendarRepositoryImpl(service);
}

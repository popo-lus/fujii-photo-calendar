// (DC022) LoadDeviceEventsInRangeUsecase: 期間内イベント取得

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/device_event_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/device_calendar_repository.dart';
import 'package:fujii_photo_calendar/data/repositories/device_calendar_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'load_device_events_in_range_usecase.g.dart';

class LoadDeviceEventsInRangeUsecase {
  const LoadDeviceEventsInRangeUsecase(this._repo);
  final DeviceCalendarRepository _repo;

  Future<Result<List<DeviceEventEntity>>> call({
    required String calendarId,
    required DateTime start,
    required DateTime end,
  }) {
    return _repo.fetchEvents(calendarId: calendarId, start: start, end: end);
  }
}

@Riverpod()
LoadDeviceEventsInRangeUsecase loadDeviceEventsInRangeUsecase(Ref ref) {
  final repo = ref.watch(deviceCalendarRepositoryProvider);
  return LoadDeviceEventsInRangeUsecase(repo);
}

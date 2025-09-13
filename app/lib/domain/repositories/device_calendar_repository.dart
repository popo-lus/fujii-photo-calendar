// (DC010) DeviceCalendarRepository: 端末カレンダー取得用リポジトリIF

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/device_calendar_entity.dart';
import 'package:fujii_photo_calendar/domain/entities/device_event_entity.dart';

abstract class DeviceCalendarRepository {
  Future<Result<bool>> ensurePermission();

  Future<Result<List<DeviceCalendarEntity>>> fetchCalendars({
    bool onlyWritable = false,
  });

  Future<Result<List<DeviceEventEntity>>> fetchEvents({
    required String calendarId,
    required DateTime start,
    required DateTime end,
  });
}

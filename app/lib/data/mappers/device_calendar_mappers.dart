// (DC040) device_calendar_mappers: Plugin -> Domain 変換

import 'package:device_calendar/device_calendar.dart';
import 'package:fujii_photo_calendar/domain/entities/device_calendar_entity.dart';
import 'package:fujii_photo_calendar/domain/entities/device_event_entity.dart';

DeviceCalendarEntity mapCalendarToEntity(Calendar c) {
  return DeviceCalendarEntity(
    id: c.id ?? '',
    name: c.name ?? '',
    accountName: c.accountName,
    isReadOnly: c.isReadOnly ?? false,
  );
}

DeviceEventEntity mapEventToEntity(Event e) {
  // device_calendar の Event は eventId / calendarId を持つ
  final id = e.eventId ?? '';
  return DeviceEventEntity(
    id: id,
    calendarId: e.calendarId ?? '',
    title: e.title ?? '',
    description: e.description,
    location: e.location,
    start: e.start ?? DateTime.fromMillisecondsSinceEpoch(0),
    end: e.end ?? DateTime.fromMillisecondsSinceEpoch(0),
    isAllDay: e.allDay ?? false,
  );
}

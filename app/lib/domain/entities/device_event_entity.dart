// (DC002) DeviceEventEntity: 端末カレンダーイベント情報の正規化モデル

class DeviceEventEntity {
  const DeviceEventEntity({
    required this.id,
    required this.calendarId,
    required this.title,
    this.description,
    this.location,
    required this.start,
    required this.end,
    this.isAllDay = false,
  });

  final String id;
  final String calendarId;
  final String title;
  final String? description;
  final String? location;
  final DateTime start;
  final DateTime end;
  final bool isAllDay;
}

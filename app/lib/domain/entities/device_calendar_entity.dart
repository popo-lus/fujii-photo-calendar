// (DC001) DeviceCalendarEntity: 端末カレンダー情報の正規化モデル

class DeviceCalendarEntity {
  const DeviceCalendarEntity({
    required this.id,
    required this.name,
    this.accountName,
    this.isReadOnly = false,
  });

  final String id;
  final String name;
  final String? accountName;
  final bool isReadOnly;
}

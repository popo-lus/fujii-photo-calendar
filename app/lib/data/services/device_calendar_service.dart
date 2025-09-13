// (DC030) DeviceCalendarService: `device_calendar` プラグインの薄いラッパー

import 'dart:async';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_calendar_service.g.dart';

class DeviceCalendarService {
  DeviceCalendarService() : _plugin = DeviceCalendarPlugin();
  final DeviceCalendarPlugin _plugin;

  bool get _isSupportedPlatform =>
      !kIsWeb && (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<bool> hasPermissions() async {
    if (!_isSupportedPlatform) return false;
    final p = await _plugin.hasPermissions();
    return p.data == true;
  }

  Future<bool> requestPermissions() async {
    if (!_isSupportedPlatform) return false;
    final r = await _plugin.requestPermissions();
    return r.data == true;
  }

  Future<List<Calendar>> retrieveCalendars({bool onlyWritable = false}) async {
    if (!_isSupportedPlatform) return const <Calendar>[];
    final res = await _plugin.retrieveCalendars();
    final List<Calendar> items =
        res.data?.toList() ?? const <Calendar>[];
    if (!onlyWritable) return items;
    // フィルタ: 書き込み可能（isReadOnly!=true）
    return items.where((c) => !(c.isReadOnly ?? false)).toList(growable: false);
  }

  Future<List<Event>> retrieveEvents(
    String calendarId,
    DateTime start,
    DateTime end,
  ) async {
    if (!_isSupportedPlatform) return const <Event>[];
    final res = await _plugin.retrieveEvents(
      calendarId,
      RetrieveEventsParams(
        startDate: start,
        endDate: end,
      ),
    );
    return res.data?.toList() ?? const <Event>[];
  }
}

@Riverpod(keepAlive: true)
DeviceCalendarService deviceCalendarService(Ref ref) {
  return DeviceCalendarService();
}

// (DC021) LoadDeviceCalendarsUsecase: 端末カレンダー一覧の取得

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/entities/device_calendar_entity.dart';
import 'package:fujii_photo_calendar/domain/repositories/device_calendar_repository.dart';
import 'package:fujii_photo_calendar/data/repositories/device_calendar_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'load_device_calendars_usecase.g.dart';
class LoadDeviceCalendarsUsecase {
  const LoadDeviceCalendarsUsecase(this._repo);
  final DeviceCalendarRepository _repo;

  Future<Result<List<DeviceCalendarEntity>>> call({bool onlyWritable = false}) {
    return _repo.fetchCalendars(onlyWritable: onlyWritable);
  }
}

@Riverpod()
LoadDeviceCalendarsUsecase loadDeviceCalendarsUsecase(Ref ref) {
  final repo = ref.watch(deviceCalendarRepositoryProvider);
  return LoadDeviceCalendarsUsecase(repo);
}

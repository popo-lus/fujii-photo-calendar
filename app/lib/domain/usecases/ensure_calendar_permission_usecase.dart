// (DC020) EnsureCalendarPermissionUsecase: カレンダー権限の確保

import 'package:fujii_photo_calendar/core/result/result.dart';
import 'package:fujii_photo_calendar/domain/repositories/device_calendar_repository.dart';
import 'package:fujii_photo_calendar/data/repositories/device_calendar_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ensure_calendar_permission_usecase.g.dart';
class EnsureCalendarPermissionUsecase {
  const EnsureCalendarPermissionUsecase(this._repo);
  final DeviceCalendarRepository _repo;

  Future<Result<bool>> call() => _repo.ensurePermission();
}

@Riverpod()
EnsureCalendarPermissionUsecase ensureCalendarPermissionUsecase(Ref ref) {
  final repo = ref.watch(deviceCalendarRepositoryProvider);
  return EnsureCalendarPermissionUsecase(repo);
}

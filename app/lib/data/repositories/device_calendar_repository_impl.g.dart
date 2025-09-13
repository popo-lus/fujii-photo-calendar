// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_calendar_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceCalendarRepository)
const deviceCalendarRepositoryProvider = DeviceCalendarRepositoryProvider._();

final class DeviceCalendarRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceCalendarRepository,
          DeviceCalendarRepository,
          DeviceCalendarRepository
        >
    with $Provider<DeviceCalendarRepository> {
  const DeviceCalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceCalendarRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceCalendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceCalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceCalendarRepository create(Ref ref) {
    return deviceCalendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceCalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceCalendarRepository>(value),
    );
  }
}

String _$deviceCalendarRepositoryHash() =>
    r'97f8e0eec23ee69d67e04ad9fe98f00530251323';

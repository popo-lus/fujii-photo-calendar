// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_calendar_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceCalendarService)
const deviceCalendarServiceProvider = DeviceCalendarServiceProvider._();

final class DeviceCalendarServiceProvider
    extends
        $FunctionalProvider<
          DeviceCalendarService,
          DeviceCalendarService,
          DeviceCalendarService
        >
    with $Provider<DeviceCalendarService> {
  const DeviceCalendarServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceCalendarServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceCalendarServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceCalendarService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceCalendarService create(Ref ref) {
    return deviceCalendarService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceCalendarService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceCalendarService>(value),
    );
  }
}

String _$deviceCalendarServiceHash() =>
    r'56b9f25960e9f14da2c373bced2ed3e593ee4b1a';

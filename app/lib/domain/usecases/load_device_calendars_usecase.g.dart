// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_device_calendars_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loadDeviceCalendarsUsecase)
const loadDeviceCalendarsUsecaseProvider =
    LoadDeviceCalendarsUsecaseProvider._();

final class LoadDeviceCalendarsUsecaseProvider
    extends
        $FunctionalProvider<
          LoadDeviceCalendarsUsecase,
          LoadDeviceCalendarsUsecase,
          LoadDeviceCalendarsUsecase
        >
    with $Provider<LoadDeviceCalendarsUsecase> {
  const LoadDeviceCalendarsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadDeviceCalendarsUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadDeviceCalendarsUsecaseHash();

  @$internal
  @override
  $ProviderElement<LoadDeviceCalendarsUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoadDeviceCalendarsUsecase create(Ref ref) {
    return loadDeviceCalendarsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadDeviceCalendarsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadDeviceCalendarsUsecase>(value),
    );
  }
}

String _$loadDeviceCalendarsUsecaseHash() =>
    r'a1c2ea10fcf347d7e71c620c62637dd5f2e5e43b';

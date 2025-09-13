// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_device_events_in_range_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loadDeviceEventsInRangeUsecase)
const loadDeviceEventsInRangeUsecaseProvider =
    LoadDeviceEventsInRangeUsecaseProvider._();

final class LoadDeviceEventsInRangeUsecaseProvider
    extends
        $FunctionalProvider<
          LoadDeviceEventsInRangeUsecase,
          LoadDeviceEventsInRangeUsecase,
          LoadDeviceEventsInRangeUsecase
        >
    with $Provider<LoadDeviceEventsInRangeUsecase> {
  const LoadDeviceEventsInRangeUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadDeviceEventsInRangeUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadDeviceEventsInRangeUsecaseHash();

  @$internal
  @override
  $ProviderElement<LoadDeviceEventsInRangeUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoadDeviceEventsInRangeUsecase create(Ref ref) {
    return loadDeviceEventsInRangeUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadDeviceEventsInRangeUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadDeviceEventsInRangeUsecase>(
        value,
      ),
    );
  }
}

String _$loadDeviceEventsInRangeUsecaseHash() =>
    r'1d686f586b3c9c735fe77a767fecd7d4004771c8';

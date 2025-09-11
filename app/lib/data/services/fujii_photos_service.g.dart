// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fujii_photos_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fujiiPhotosService)
const fujiiPhotosServiceProvider = FujiiPhotosServiceProvider._();

final class FujiiPhotosServiceProvider
    extends
        $FunctionalProvider<
          FujiiPhotosService,
          FujiiPhotosService,
          FujiiPhotosService
        >
    with $Provider<FujiiPhotosService> {
  const FujiiPhotosServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fujiiPhotosServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fujiiPhotosServiceHash();

  @$internal
  @override
  $ProviderElement<FujiiPhotosService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FujiiPhotosService create(Ref ref) {
    return fujiiPhotosService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FujiiPhotosService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FujiiPhotosService>(value),
    );
  }
}

String _$fujiiPhotosServiceHash() =>
    r'3f605f7085e89f272474c20f06bdbbe14fef9402';

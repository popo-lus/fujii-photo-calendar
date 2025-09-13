// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_upload_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoUploadService)
const photoUploadServiceProvider = PhotoUploadServiceProvider._();

final class PhotoUploadServiceProvider
    extends
        $FunctionalProvider<
          PhotoUploadService,
          PhotoUploadService,
          PhotoUploadService
        >
    with $Provider<PhotoUploadService> {
  const PhotoUploadServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoUploadServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoUploadServiceHash();

  @$internal
  @override
  $ProviderElement<PhotoUploadService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhotoUploadService create(Ref ref) {
    return photoUploadService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoUploadService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoUploadService>(value),
    );
  }
}

String _$photoUploadServiceHash() =>
    r'ce74f4aa18cc6029121ac76b2c6c6948e3e6ea17';

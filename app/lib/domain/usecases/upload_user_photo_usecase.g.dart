// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_user_photo_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(uploadUserPhotoUseCase)
const uploadUserPhotoUseCaseProvider = UploadUserPhotoUseCaseProvider._();

final class UploadUserPhotoUseCaseProvider
    extends
        $FunctionalProvider<
          UploadUserPhotoUseCase,
          UploadUserPhotoUseCase,
          UploadUserPhotoUseCase
        >
    with $Provider<UploadUserPhotoUseCase> {
  const UploadUserPhotoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadUserPhotoUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadUserPhotoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UploadUserPhotoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UploadUserPhotoUseCase create(Ref ref) {
    return uploadUserPhotoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadUserPhotoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadUserPhotoUseCase>(value),
    );
  }
}

String _$uploadUserPhotoUseCaseHash() =>
    r'a284816528cc523698d5b00785c48bd60562036d';

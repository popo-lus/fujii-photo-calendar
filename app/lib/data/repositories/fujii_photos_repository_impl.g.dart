// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fujii_photos_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fujiiPhotosRepository)
const fujiiPhotosRepositoryProvider = FujiiPhotosRepositoryProvider._();

final class FujiiPhotosRepositoryProvider
    extends
        $FunctionalProvider<
          FujiiPhotosRepository,
          FujiiPhotosRepository,
          FujiiPhotosRepository
        >
    with $Provider<FujiiPhotosRepository> {
  const FujiiPhotosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fujiiPhotosRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fujiiPhotosRepositoryHash();

  @$internal
  @override
  $ProviderElement<FujiiPhotosRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FujiiPhotosRepository create(Ref ref) {
    return fujiiPhotosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FujiiPhotosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FujiiPhotosRepository>(value),
    );
  }
}

String _$fujiiPhotosRepositoryHash() =>
    r'36bb1ba6a553a4a46dfbc0fb16d65edc1b06f26b';

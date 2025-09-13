// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniv_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(annivRepository)
const annivRepositoryProvider = AnnivRepositoryProvider._();

final class AnnivRepositoryProvider
    extends
        $FunctionalProvider<AnnivRepository, AnnivRepository, AnnivRepository>
    with $Provider<AnnivRepository> {
  const AnnivRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annivRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annivRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnnivRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnnivRepository create(Ref ref) {
    return annivRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnivRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnivRepository>(value),
    );
  }
}

String _$annivRepositoryHash() => r'900e7e2460a1c3d2942a865efaa7d8be9035bc06';

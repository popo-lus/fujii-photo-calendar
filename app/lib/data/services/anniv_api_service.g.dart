// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniv_api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(annivApiService)
const annivApiServiceProvider = AnnivApiServiceProvider._();

final class AnnivApiServiceProvider
    extends
        $FunctionalProvider<AnnivApiService, AnnivApiService, AnnivApiService>
    with $Provider<AnnivApiService> {
  const AnnivApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annivApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annivApiServiceHash();

  @$internal
  @override
  $ProviderElement<AnnivApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnnivApiService create(Ref ref) {
    return annivApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnivApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnivApiService>(value),
    );
  }
}

String _$annivApiServiceHash() => r'7b49f9faf77e98037a1b2c7c6c707e6c3947530b';

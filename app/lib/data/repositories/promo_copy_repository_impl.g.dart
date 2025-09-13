// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_copy_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(promoCopyRepository)
const promoCopyRepositoryProvider = PromoCopyRepositoryProvider._();

final class PromoCopyRepositoryProvider
    extends
        $FunctionalProvider<
          PromoCopyRepository,
          PromoCopyRepository,
          PromoCopyRepository
        >
    with $Provider<PromoCopyRepository> {
  const PromoCopyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promoCopyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promoCopyRepositoryHash();

  @$internal
  @override
  $ProviderElement<PromoCopyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PromoCopyRepository create(Ref ref) {
    return promoCopyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PromoCopyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PromoCopyRepository>(value),
    );
  }
}

String _$promoCopyRepositoryHash() =>
    r'522a777e9a097417b3c87b41a0ce0601118882fc';

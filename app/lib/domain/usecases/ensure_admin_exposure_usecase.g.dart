// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ensure_admin_exposure_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ensureAdminExposureUseCase)
const ensureAdminExposureUseCaseProvider =
    EnsureAdminExposureUseCaseProvider._();

final class EnsureAdminExposureUseCaseProvider
    extends
        $FunctionalProvider<
          EnsureAdminExposureUseCase,
          EnsureAdminExposureUseCase,
          EnsureAdminExposureUseCase
        >
    with $Provider<EnsureAdminExposureUseCase> {
  const EnsureAdminExposureUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ensureAdminExposureUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ensureAdminExposureUseCaseHash();

  @$internal
  @override
  $ProviderElement<EnsureAdminExposureUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnsureAdminExposureUseCase create(Ref ref) {
    return ensureAdminExposureUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnsureAdminExposureUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnsureAdminExposureUseCase>(value),
    );
  }
}

String _$ensureAdminExposureUseCaseHash() =>
    r'86f0f34c32dd2ecb05ebba445d5884226208bbee';

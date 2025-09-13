// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_anniv_promo_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generateAnnivPromoUsecase)
const generateAnnivPromoUsecaseProvider = GenerateAnnivPromoUsecaseProvider._();

final class GenerateAnnivPromoUsecaseProvider
    extends
        $FunctionalProvider<
          GenerateAnnivPromoUsecase,
          GenerateAnnivPromoUsecase,
          GenerateAnnivPromoUsecase
        >
    with $Provider<GenerateAnnivPromoUsecase> {
  const GenerateAnnivPromoUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateAnnivPromoUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateAnnivPromoUsecaseHash();

  @$internal
  @override
  $ProviderElement<GenerateAnnivPromoUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GenerateAnnivPromoUsecase create(Ref ref) {
    return generateAnnivPromoUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateAnnivPromoUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateAnnivPromoUsecase>(value),
    );
  }
}

String _$generateAnnivPromoUsecaseHash() =>
    r'7971c01554b062adda5e08a3b020919a671436ac';

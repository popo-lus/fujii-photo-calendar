// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compute_slideshow_batch_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(computeSlideshowBatchUseCase)
const computeSlideshowBatchUseCaseProvider =
    ComputeSlideshowBatchUseCaseProvider._();

final class ComputeSlideshowBatchUseCaseProvider
    extends
        $FunctionalProvider<
          ComputeSlideshowBatchUseCase,
          ComputeSlideshowBatchUseCase,
          ComputeSlideshowBatchUseCase
        >
    with $Provider<ComputeSlideshowBatchUseCase> {
  const ComputeSlideshowBatchUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'computeSlideshowBatchUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$computeSlideshowBatchUseCaseHash();

  @$internal
  @override
  $ProviderElement<ComputeSlideshowBatchUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ComputeSlideshowBatchUseCase create(Ref ref) {
    return computeSlideshowBatchUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ComputeSlideshowBatchUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ComputeSlideshowBatchUseCase>(value),
    );
  }
}

String _$computeSlideshowBatchUseCaseHash() =>
    r'697418fe1c4a5b9f99d5cc3b65c9eaba6fbec020';

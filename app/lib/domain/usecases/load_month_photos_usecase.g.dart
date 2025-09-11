// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_month_photos_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loadMonthPhotosUseCase)
const loadMonthPhotosUseCaseProvider = LoadMonthPhotosUseCaseProvider._();

final class LoadMonthPhotosUseCaseProvider
    extends
        $FunctionalProvider<
          LoadMonthPhotosUseCase,
          LoadMonthPhotosUseCase,
          LoadMonthPhotosUseCase
        >
    with $Provider<LoadMonthPhotosUseCase> {
  const LoadMonthPhotosUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadMonthPhotosUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadMonthPhotosUseCaseHash();

  @$internal
  @override
  $ProviderElement<LoadMonthPhotosUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoadMonthPhotosUseCase create(Ref ref) {
    return loadMonthPhotosUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadMonthPhotosUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadMonthPhotosUseCase>(value),
    );
  }
}

String _$loadMonthPhotosUseCaseHash() =>
    r'c12613015431b02811d30c0b6356b7b7cae88bd4';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_request_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(submitRequestUsecase)
const submitRequestUsecaseProvider = SubmitRequestUsecaseProvider._();

final class SubmitRequestUsecaseProvider
    extends
        $FunctionalProvider<
          SubmitRequestUsecase,
          SubmitRequestUsecase,
          SubmitRequestUsecase
        >
    with $Provider<SubmitRequestUsecase> {
  const SubmitRequestUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitRequestUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitRequestUsecaseHash();

  @$internal
  @override
  $ProviderElement<SubmitRequestUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubmitRequestUsecase create(Ref ref) {
    return submitRequestUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitRequestUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitRequestUsecase>(value),
    );
  }
}

String _$submitRequestUsecaseHash() =>
    r'2002bd8814e394f26ecd3ee562135689e4642c47';

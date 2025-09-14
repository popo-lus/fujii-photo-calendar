// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_request_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteRequestUsecase)
const deleteRequestUsecaseProvider = DeleteRequestUsecaseProvider._();

final class DeleteRequestUsecaseProvider
    extends
        $FunctionalProvider<
          DeleteRequestUsecase,
          DeleteRequestUsecase,
          DeleteRequestUsecase
        >
    with $Provider<DeleteRequestUsecase> {
  const DeleteRequestUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteRequestUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteRequestUsecaseHash();

  @$internal
  @override
  $ProviderElement<DeleteRequestUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteRequestUsecase create(Ref ref) {
    return deleteRequestUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteRequestUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteRequestUsecase>(value),
    );
  }
}

String _$deleteRequestUsecaseHash() =>
    r'e14c88fae9bf3f2d23eb9596e8dd86052b2664c1';

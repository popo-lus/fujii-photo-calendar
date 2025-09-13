// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_invite_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createInviteUsecase)
const createInviteUsecaseProvider = CreateInviteUsecaseProvider._();

final class CreateInviteUsecaseProvider
    extends
        $FunctionalProvider<
          CreateInviteUsecase,
          CreateInviteUsecase,
          CreateInviteUsecase
        >
    with $Provider<CreateInviteUsecase> {
  const CreateInviteUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createInviteUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createInviteUsecaseHash();

  @$internal
  @override
  $ProviderElement<CreateInviteUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateInviteUsecase create(Ref ref) {
    return createInviteUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateInviteUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateInviteUsecase>(value),
    );
  }
}

String _$createInviteUsecaseHash() =>
    r'f2d6740e962fa87253bac0de555c7650a6499e86';

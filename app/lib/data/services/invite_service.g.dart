// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inviteService)
const inviteServiceProvider = InviteServiceProvider._();

final class InviteServiceProvider
    extends $FunctionalProvider<InviteService, InviteService, InviteService>
    with $Provider<InviteService> {
  const InviteServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteServiceHash();

  @$internal
  @override
  $ProviderElement<InviteService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InviteService create(Ref ref) {
    return inviteService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteService>(value),
    );
  }
}

String _$inviteServiceHash() => r'b95c77ecb884ce1717de4fd9b0d641fbcd8d6a3d';

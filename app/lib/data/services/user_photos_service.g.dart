// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_photos_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userPhotosService)
const userPhotosServiceProvider = UserPhotosServiceProvider._();

final class UserPhotosServiceProvider
    extends
        $FunctionalProvider<
          UserPhotosService,
          UserPhotosService,
          UserPhotosService
        >
    with $Provider<UserPhotosService> {
  const UserPhotosServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPhotosServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPhotosServiceHash();

  @$internal
  @override
  $ProviderElement<UserPhotosService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserPhotosService create(Ref ref) {
    return userPhotosService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPhotosService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPhotosService>(value),
    );
  }
}

String _$userPhotosServiceHash() => r'925c2562508be77565d34fdc9e77c8c76428c9f1';

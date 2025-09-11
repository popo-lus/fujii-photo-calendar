// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_photos_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userPhotosRepository)
const userPhotosRepositoryProvider = UserPhotosRepositoryProvider._();

final class UserPhotosRepositoryProvider
    extends
        $FunctionalProvider<
          UserPhotosRepository,
          UserPhotosRepository,
          UserPhotosRepository
        >
    with $Provider<UserPhotosRepository> {
  const UserPhotosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPhotosRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPhotosRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserPhotosRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserPhotosRepository create(Ref ref) {
    return userPhotosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPhotosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPhotosRepository>(value),
    );
  }
}

String _$userPhotosRepositoryHash() =>
    r'7c6c8dbf3a237329770772b85a41a7f524042731';

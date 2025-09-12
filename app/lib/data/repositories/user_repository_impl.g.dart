// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'422d81b209b8c077359548357358b77380ff28c5';

@ProviderFor(userByUidStream)
const userByUidStreamProvider = UserByUidStreamFamily._();

final class UserByUidStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserEntity?>,
          UserEntity?,
          Stream<UserEntity?>
        >
    with $FutureModifier<UserEntity?>, $StreamProvider<UserEntity?> {
  const UserByUidStreamProvider._({
    required UserByUidStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userByUidStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userByUidStreamHash();

  @override
  String toString() {
    return r'userByUidStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<UserEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserEntity?> create(Ref ref) {
    final argument = this.argument as String;
    return userByUidStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserByUidStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userByUidStreamHash() => r'7a0a7cbd6c9ee0857340a3e3c234730af5e4c9f8';

final class UserByUidStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<UserEntity?>, String> {
  const UserByUidStreamFamily._()
    : super(
        retry: null,
        name: r'userByUidStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UserByUidStreamProvider call(String uid) =>
      UserByUidStreamProvider._(argument: uid, from: this);

  @override
  String toString() => r'userByUidStreamProvider';
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(requestRepository)
const requestRepositoryProvider = RequestRepositoryProvider._();

final class RequestRepositoryProvider
    extends
        $FunctionalProvider<
          RequestRepository,
          RequestRepository,
          RequestRepository
        >
    with $Provider<RequestRepository> {
  const RequestRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestRepositoryHash();

  @$internal
  @override
  $ProviderElement<RequestRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RequestRepository create(Ref ref) {
    return requestRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestRepository>(value),
    );
  }
}

String _$requestRepositoryHash() => r'ab5266d1779e1f8d966c27b101a45c14303d0b5a';

@ProviderFor(recentRequestsStream)
const recentRequestsStreamProvider = RecentRequestsStreamFamily._();

final class RecentRequestsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RequestEntity>>,
          List<RequestEntity>,
          Stream<List<RequestEntity>>
        >
    with
        $FutureModifier<List<RequestEntity>>,
        $StreamProvider<List<RequestEntity>> {
  const RecentRequestsStreamProvider._({
    required RecentRequestsStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'recentRequestsStreamProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recentRequestsStreamHash();

  @override
  String toString() {
    return r'recentRequestsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<RequestEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RequestEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return recentRequestsStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentRequestsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recentRequestsStreamHash() =>
    r'6637f463a59fde37b3e3519e388cd09b8e99ecc3';

final class RecentRequestsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<RequestEntity>>, String> {
  const RecentRequestsStreamFamily._()
    : super(
        retry: null,
        name: r'recentRequestsStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  RecentRequestsStreamProvider call(String ownerUid) =>
      RecentRequestsStreamProvider._(argument: ownerUid, from: this);

  @override
  String toString() => r'recentRequestsStreamProvider';
}

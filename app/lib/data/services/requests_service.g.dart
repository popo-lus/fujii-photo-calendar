// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(requestsService)
const requestsServiceProvider = RequestsServiceProvider._();

final class RequestsServiceProvider
    extends
        $FunctionalProvider<RequestsService, RequestsService, RequestsService>
    with $Provider<RequestsService> {
  const RequestsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestsServiceHash();

  @$internal
  @override
  $ProviderElement<RequestsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RequestsService create(Ref ref) {
    return requestsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestsService>(value),
    );
  }
}

String _$requestsServiceHash() => r'e847382c34c5245e1a7d99a96f3bdcff452067d5';

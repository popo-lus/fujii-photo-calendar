// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_incoming_requests_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(watchIncomingRequestsUsecase)
const watchIncomingRequestsUsecaseProvider =
    WatchIncomingRequestsUsecaseProvider._();

final class WatchIncomingRequestsUsecaseProvider
    extends
        $FunctionalProvider<
          WatchIncomingRequestsUsecase,
          WatchIncomingRequestsUsecase,
          WatchIncomingRequestsUsecase
        >
    with $Provider<WatchIncomingRequestsUsecase> {
  const WatchIncomingRequestsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchIncomingRequestsUsecaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchIncomingRequestsUsecaseHash();

  @$internal
  @override
  $ProviderElement<WatchIncomingRequestsUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchIncomingRequestsUsecase create(Ref ref) {
    return watchIncomingRequestsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchIncomingRequestsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchIncomingRequestsUsecase>(value),
    );
  }
}

String _$watchIncomingRequestsUsecaseHash() =>
    r'd6c82d7caa5fd97210705f67ebc0286a2849fc69';

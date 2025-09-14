// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniv_promo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todayAnnivPromoText)
const todayAnnivPromoTextProvider = TodayAnnivPromoTextProvider._();

final class TodayAnnivPromoTextProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const TodayAnnivPromoTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayAnnivPromoTextProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayAnnivPromoTextHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return todayAnnivPromoText(ref);
  }
}

String _$todayAnnivPromoTextHash() =>
    r'f13b6dceab5b40cdc446ba790d2e5e64f040c185';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MonthViewModel)
const monthViewModelProvider = MonthViewModelProvider._();

final class MonthViewModelProvider
    extends $AsyncNotifierProvider<MonthViewModel, MonthState> {
  const MonthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthViewModelHash();

  @$internal
  @override
  MonthViewModel create() => MonthViewModel();
}

String _$monthViewModelHash() => r'd239c0c1080344d143ca35fe1d0b6a7a5648aa25';

abstract class _$MonthViewModel extends $AsyncNotifier<MonthState> {
  FutureOr<MonthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<MonthState>, MonthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MonthState>, MonthState>,
              AsyncValue<MonthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

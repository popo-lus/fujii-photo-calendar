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
    extends $AsyncNotifierProvider<MonthViewModel, MonthData> {
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

String _$monthViewModelHash() => r'b5fa64a2c307913c607d59c63f0ae911f07b49b7';

abstract class _$MonthViewModel extends $AsyncNotifier<MonthData> {
  FutureOr<MonthData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<MonthData>, MonthData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MonthData>, MonthData>,
              AsyncValue<MonthData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

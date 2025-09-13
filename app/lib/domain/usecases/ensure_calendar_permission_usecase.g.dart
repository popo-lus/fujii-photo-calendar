// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ensure_calendar_permission_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ensureCalendarPermissionUsecase)
const ensureCalendarPermissionUsecaseProvider =
    EnsureCalendarPermissionUsecaseProvider._();

final class EnsureCalendarPermissionUsecaseProvider
    extends
        $FunctionalProvider<
          EnsureCalendarPermissionUsecase,
          EnsureCalendarPermissionUsecase,
          EnsureCalendarPermissionUsecase
        >
    with $Provider<EnsureCalendarPermissionUsecase> {
  const EnsureCalendarPermissionUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ensureCalendarPermissionUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ensureCalendarPermissionUsecaseHash();

  @$internal
  @override
  $ProviderElement<EnsureCalendarPermissionUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnsureCalendarPermissionUsecase create(Ref ref) {
    return ensureCalendarPermissionUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnsureCalendarPermissionUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnsureCalendarPermissionUsecase>(
        value,
      ),
    );
  }
}

String _$ensureCalendarPermissionUsecaseHash() =>
    r'c708aeb7bcef2a254252581050628b35481627ef';

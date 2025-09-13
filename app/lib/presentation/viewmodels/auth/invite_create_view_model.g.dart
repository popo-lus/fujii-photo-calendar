// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_create_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InviteCreateViewModel)
const inviteCreateViewModelProvider = InviteCreateViewModelProvider._();

final class InviteCreateViewModelProvider
    extends $NotifierProvider<InviteCreateViewModel, InviteCreateState> {
  const InviteCreateViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteCreateViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteCreateViewModelHash();

  @$internal
  @override
  InviteCreateViewModel create() => InviteCreateViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteCreateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteCreateState>(value),
    );
  }
}

String _$inviteCreateViewModelHash() =>
    r'698f7d797561af572bc48fef32ccda65e7512ffa';

abstract class _$InviteCreateViewModel extends $Notifier<InviteCreateState> {
  InviteCreateState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<InviteCreateState, InviteCreateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InviteCreateState, InviteCreateState>,
              InviteCreateState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

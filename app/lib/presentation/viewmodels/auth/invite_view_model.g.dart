// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InviteViewModel)
const inviteViewModelProvider = InviteViewModelProvider._();

final class InviteViewModelProvider
    extends $NotifierProvider<InviteViewModel, InviteState> {
  const InviteViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteViewModelHash();

  @$internal
  @override
  InviteViewModel create() => InviteViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteState>(value),
    );
  }
}

String _$inviteViewModelHash() => r'4348ad8f6338a06659bcc992d159a3a97a2726e3';

abstract class _$InviteViewModel extends $Notifier<InviteState> {
  InviteState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<InviteState, InviteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InviteState, InviteState>,
              InviteState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

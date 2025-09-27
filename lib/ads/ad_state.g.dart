// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdState)
const adStateProvider = AdStateProvider._();

final class AdStateProvider extends $NotifierProvider<AdState, bool> {
  const AdStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adStateHash();

  @$internal
  @override
  AdState create() => AdState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$adStateHash() => r'9bcb96fa99503c2e1dae79d76fd7c9225cb735cc';

abstract class _$AdState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

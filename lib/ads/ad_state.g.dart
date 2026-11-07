// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdState)
final adStateProvider = AdStateProvider._();

final class AdStateProvider extends $NotifierProvider<AdState, bool> {
  AdStateProvider._()
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

String _$adStateHash() => r'ade772eca0e82631f0308d5a72e95fcdd2bed0fa';

abstract class _$AdState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

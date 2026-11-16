// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SimCallHandler)
final simCallHandlerProvider = SimCallHandlerProvider._();

final class SimCallHandlerProvider
    extends $NotifierProvider<SimCallHandler, SimCardEntity?> {
  SimCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simCallHandlerHash();

  @$internal
  @override
  SimCallHandler create() => SimCallHandler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimCardEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimCardEntity?>(value),
    );
  }
}

String _$simCallHandlerHash() => r'ac86564fafcf6ef6385d1a7ca0f1d2e6b4883442';

abstract class _$SimCallHandler extends $Notifier<SimCardEntity?> {
  SimCardEntity? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final state = build();
    return (state: state, result: null);
  }
}

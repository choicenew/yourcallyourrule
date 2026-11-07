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
    extends $NotifierProvider<SimCallHandler, SimInfo?> {
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
  Override overrideWithValue(SimInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimInfo?>(value),
    );
  }
}

String _$simCallHandlerHash() => r'2f68475c3f5148bf1a8bceabddf14042dd969ee3';

abstract class _$SimCallHandler extends $Notifier<SimInfo?> {
  SimInfo? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SimInfo?, SimInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SimInfo?, SimInfo?>,
              SimInfo?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

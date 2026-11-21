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

String _$simCallHandlerHash() => r'19e6f1701283d096a06cd064c03592397cade65d';

abstract class _$SimCallHandler extends $Notifier<SimCardEntity?> {
  SimCardEntity? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SimCardEntity?, SimCardEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SimCardEntity?, SimCardEntity?>,
              SimCardEntity?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SimSlotConfigNotifier)
const simSlotConfigProvider = SimSlotConfigNotifierProvider._();

final class SimSlotConfigNotifierProvider
    extends $AsyncNotifierProvider<SimSlotConfigNotifier, SimSlotConfigState> {
  const SimSlotConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simSlotConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simSlotConfigNotifierHash();

  @$internal
  @override
  SimSlotConfigNotifier create() => SimSlotConfigNotifier();
}

String _$simSlotConfigNotifierHash() =>
    r'788650f67885e6cccedf8d12fe330d6a0f9dcf27';

abstract class _$SimSlotConfigNotifier
    extends $AsyncNotifier<SimSlotConfigState> {
  FutureOr<SimSlotConfigState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<SimSlotConfigState>, SimSlotConfigState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SimSlotConfigState>, SimSlotConfigState>,
              AsyncValue<SimSlotConfigState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

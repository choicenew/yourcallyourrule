// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SimSlotConfigNotifier)
final simSlotConfigProvider = SimSlotConfigNotifierProvider._();

final class SimSlotConfigNotifierProvider
    extends $AsyncNotifierProvider<SimSlotConfigNotifier, SimSlotConfigState> {
  SimSlotConfigNotifierProvider._()
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
    r'4a92309a11f8ebfcc29414a980b8335d80e58dc1';

abstract class _$SimSlotConfigNotifier
    extends $AsyncNotifier<SimSlotConfigState> {
  FutureOr<SimSlotConfigState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}

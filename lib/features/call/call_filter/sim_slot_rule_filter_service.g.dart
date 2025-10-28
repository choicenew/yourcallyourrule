// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(simSlotRuleService)
const simSlotRuleServiceProvider = SimSlotRuleServiceProvider._();

final class SimSlotRuleServiceProvider
    extends
        $FunctionalProvider<
          SimSlotRuleService,
          SimSlotRuleService,
          SimSlotRuleService
        >
    with $Provider<SimSlotRuleService> {
  const SimSlotRuleServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simSlotRuleServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simSlotRuleServiceHash();

  @$internal
  @override
  $ProviderElement<SimSlotRuleService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SimSlotRuleService create(Ref ref) {
    return simSlotRuleService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimSlotRuleService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimSlotRuleService>(value),
    );
  }
}

String _$simSlotRuleServiceHash() =>
    r'b4cfc17d010f4552bf9eb14862864a1d7312afb2';

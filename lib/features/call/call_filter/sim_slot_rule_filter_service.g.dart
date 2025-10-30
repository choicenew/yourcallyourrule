// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(simSlotRuleFilterService)
const simSlotRuleFilterServiceProvider = SimSlotRuleFilterServiceProvider._();

final class SimSlotRuleFilterServiceProvider
    extends
        $FunctionalProvider<
          SimSlotRuleFilterService,
          SimSlotRuleFilterService,
          SimSlotRuleFilterService
        >
    with $Provider<SimSlotRuleFilterService> {
  const SimSlotRuleFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simSlotRuleFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simSlotRuleFilterServiceHash();

  @$internal
  @override
  $ProviderElement<SimSlotRuleFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SimSlotRuleFilterService create(Ref ref) {
    return simSlotRuleFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimSlotRuleFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimSlotRuleFilterService>(value),
    );
  }
}

String _$simSlotRuleFilterServiceHash() =>
    r'c09050497cc2f0a38e3bc038b7c8f150fc6e46f4';

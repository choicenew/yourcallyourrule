// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(simSlotRuleFilterService)
final simSlotRuleFilterServiceProvider = SimSlotRuleFilterServiceProvider._();

final class SimSlotRuleFilterServiceProvider
    extends
        $FunctionalProvider<
          SimSlotRuleFilterService,
          SimSlotRuleFilterService,
          SimSlotRuleFilterService
        >
    with $Provider<SimSlotRuleFilterService> {
  SimSlotRuleFilterServiceProvider._()
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
    r'fcfc3ddb23a465a26279b88221bc27ddecafa4d8';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_service.dart';

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
        isAutoDispose: false,
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
    r'9e472f41a778d1238ae540eaf0e09627b666f923';

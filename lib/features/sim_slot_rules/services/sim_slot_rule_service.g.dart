// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(simSlotRuleService)
final simSlotRuleServiceProvider = SimSlotRuleServiceProvider._();

final class SimSlotRuleServiceProvider
    extends
        $FunctionalProvider<
          SimSlotRuleService,
          SimSlotRuleService,
          SimSlotRuleService
        >
    with $Provider<SimSlotRuleService> {
  SimSlotRuleServiceProvider._()
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
    r'235bac23862fc5e9514466c37974e0faeeabcfb2';

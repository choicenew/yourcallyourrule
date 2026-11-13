// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(simSlotRuleControlCenter)
final simSlotRuleControlCenterProvider = SimSlotRuleControlCenterProvider._();

final class SimSlotRuleControlCenterProvider
    extends
        $FunctionalProvider<
          SimSlotRuleControlCenter,
          SimSlotRuleControlCenter,
          SimSlotRuleControlCenter
        >
    with $Provider<SimSlotRuleControlCenter> {
  SimSlotRuleControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simSlotRuleControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simSlotRuleControlCenterHash();

  @$internal
  @override
  $ProviderElement<SimSlotRuleControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SimSlotRuleControlCenter create(Ref ref) {
    return simSlotRuleControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimSlotRuleControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimSlotRuleControlCenter>(value),
    );
  }
}

String _$simSlotRuleControlCenterHash() =>
    r'779cf6b65a56f5226e2a9b2b089ca0d1405cb3b2';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_call_policy_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emergencyCallPolicyService)
final emergencyCallPolicyServiceProvider =
    EmergencyCallPolicyServiceProvider._();

final class EmergencyCallPolicyServiceProvider
    extends
        $FunctionalProvider<
          EmergencyCallPolicyService,
          EmergencyCallPolicyService,
          EmergencyCallPolicyService
        >
    with $Provider<EmergencyCallPolicyService> {
  EmergencyCallPolicyServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyCallPolicyServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyCallPolicyServiceHash();

  @$internal
  @override
  $ProviderElement<EmergencyCallPolicyService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmergencyCallPolicyService create(Ref ref) {
    return emergencyCallPolicyService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyCallPolicyService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyCallPolicyService>(value),
    );
  }
}

String _$emergencyCallPolicyServiceHash() =>
    r'330c82edc7c58e1e15b76dde5c504facbd2a1241';

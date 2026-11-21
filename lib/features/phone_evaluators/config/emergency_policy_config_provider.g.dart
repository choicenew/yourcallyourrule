// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_policy_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmergencyPolicyConfigNotifier)
final emergencyPolicyConfigProvider = EmergencyPolicyConfigNotifierProvider._();

final class EmergencyPolicyConfigNotifierProvider
    extends $NotifierProvider<EmergencyPolicyConfigNotifier, EmergencyPolicyConfig> {
  EmergencyPolicyConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyPolicyConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyPolicyConfigNotifierHash();

  @$internal
  @override
  EmergencyPolicyConfigNotifier create() => EmergencyPolicyConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyPolicyConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyPolicyConfig>(value),
    );
  }
}

String _$emergencyPolicyConfigNotifierHash() =>
    r'e0e854b77f98c91350a4bf85bc51381395c657a8';

abstract class _$EmergencyPolicyConfigNotifier
    extends $Notifier<EmergencyPolicyConfig> {
  EmergencyPolicyConfig build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EmergencyPolicyConfig, EmergencyPolicyConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmergencyPolicyConfig, EmergencyPolicyConfig>,
              EmergencyPolicyConfig,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}


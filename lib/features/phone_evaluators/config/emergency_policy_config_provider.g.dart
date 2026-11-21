// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_policy_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 紧急呼叫全局豁免策略配置 Notifier (支持开关、放行时长与自定义紧急号码持久化)

@ProviderFor(EmergencyPolicyConfigNotifier)
final emergencyPolicyConfigProvider = EmergencyPolicyConfigNotifierProvider._();

/// 紧急呼叫全局豁免策略配置 Notifier (支持开关、放行时长与自定义紧急号码持久化)
final class EmergencyPolicyConfigNotifierProvider
    extends
        $NotifierProvider<
          EmergencyPolicyConfigNotifier,
          EmergencyPolicyConfig
        > {
  /// 紧急呼叫全局豁免策略配置 Notifier (支持开关、放行时长与自定义紧急号码持久化)
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
    r'99bcde3f94507b6c44e646426f08574f6eba2e14';

/// 紧急呼叫全局豁免策略配置 Notifier (支持开关、放行时长与自定义紧急号码持久化)

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

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/emergency_call_policy_service.dart';

part 'emergency_policy_config_provider.g.dart';

/// 紧急呼叫全局豁免策略配置 Notifier (支持开关、放行时长与自定义紧急号码持久化)
@Riverpod(keepAlive: true)
class EmergencyPolicyConfigNotifier extends _$EmergencyPolicyConfigNotifier {
  static const String _configKey = 'config_emergency_policy';

  @override
  EmergencyPolicyConfig build() {
    _loadConfig();
    return const EmergencyPolicyConfig();
  }

  Future<void> _loadConfig() async {
    final repository = ref.read(configRepositoryProvider);
    final map = await repository.getConfig(_configKey);
    if (map != null && ref.mounted) {
      final config = EmergencyPolicyConfig.fromJson(map);
      state = config;
      _applyToService(config);
    }
  }

  Future<void> updateConfig(EmergencyPolicyConfig newConfig) async {
    state = newConfig;
    _applyToService(newConfig);
    try {
      await ref.read(configRepositoryProvider).saveConfig(_configKey, newConfig.toJson());
    } catch (e) {
      debugPrint('[EmergencyPolicyConfigNotifier] 保存紧急呼叫策略配置失败: $e');
    }
  }

  void _applyToService(EmergencyPolicyConfig config) {
    ref.read(emergencyCallPolicyServiceProvider).updateConfig(
          enabled: config.enabled,
          durationMinutes: config.durationMinutes,
          customNumbers: config.customNumbers,
        );
  }
}


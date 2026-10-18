import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';

part 'call_filter_provider.g.dart';

@riverpod
class CallFilterConfigNotifier extends _$CallFilterConfigNotifier {
  static const String _configKey = 'config_call_filter';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<CallFilterConfig> build() async {
    final configMap = await _configRepo.getConfig(_configKey);
    if (configMap != null) {
      return CallFilterConfig.fromMap(configMap);
    }
    return CallFilterConfig(); // 返回默认配置
  }

  /// 提供一个统一的更新方法，接收一个新的Config对象
  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_configKey, newConfig.toMap());
      return newConfig;
    });
  }
}

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）
@riverpod
class SimSlotCallFilterConfigNotifier extends _$SimSlotCallFilterConfigNotifier {
  String _getSimKey(int simSlotIndex) => 'config_call_filter_sim_$simSlotIndex';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<CallFilterConfig> build(int simSlotIndex) async {
    final configMap = await _configRepo.getConfig(_getSimKey(simSlotIndex));
    if (configMap != null) {
      return CallFilterConfig.fromMap(configMap);
    }
    // 未设置时从全局配置继承基础初值
    final globalConfig = await ref.read(callFilterConfigProvider.future);
    return globalConfig.copyWith();
  }

  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_getSimKey(simSlotIndex), newConfig.toMap());
      return newConfig;
    });
  }
}

/// 是否开启“多卡槽独立控制”开关的持久化 Notifier
@riverpod
class SeparateSimsNotifier extends _$SeparateSimsNotifier {
  static const String _key = 'config_separate_sims';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<bool> build() async {
    final map = await _configRepo.getConfig(_key);
    if (map != null && map['enabled'] is bool) {
      return map['enabled'] as bool;
    }
    return false;
  }

  Future<void> setSeparateSims(bool value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(_key, {'enabled': value});
      return value;
    });
  }
}
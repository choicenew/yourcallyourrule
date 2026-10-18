import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';

part 'call_filter_provider.g.dart';

/// 集中式 Key 常量定义库（消除手写魔术字符串）
abstract class CallFilterConfigKeys {
  static const String globalCallFilter = 'config_call_filter';
  static String simSlotCallFilter(int index) => 'config_call_filter_sim_$index';
  static const String separateSims = 'config_separate_sims';
  static const String enabledField = 'enabled';
}

/// “多卡槽独立控制”开关的强类型配置实体类
class SeparateSimsState {
  final bool isEnabled;

  const SeparateSimsState({this.isEnabled = false});

  factory SeparateSimsState.fromMap(Map<String, dynamic> map) {
    return SeparateSimsState(
      isEnabled: map[CallFilterConfigKeys.enabledField] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CallFilterConfigKeys.enabledField: isEnabled,
    };
  }
}

@Riverpod(keepAlive: true)
class CallFilterConfigNotifier extends _$CallFilterConfigNotifier {
  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<CallFilterConfig> build() async {
    final configMap = await _configRepo.getConfig(CallFilterConfigKeys.globalCallFilter);
    if (configMap != null) {
      return CallFilterConfig.fromMap(configMap);
    }
    return CallFilterConfig(); // 返回默认配置
  }

  /// 提供一个统一的更新方法（同步乐观更新，避免 AsyncValue.loading 造成界面闪烁与状态回弹）
  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = AsyncValue.data(newConfig);
    try {
      await _configRepo.saveConfig(CallFilterConfigKeys.globalCallFilter, newConfig.toMap());
    } catch (e) {
      debugPrint('[CallFilterConfigNotifier] 保存配置失败: $e');
    }
  }
}

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）
@Riverpod(keepAlive: true)
class SimSlotCallFilterConfigNotifier extends _$SimSlotCallFilterConfigNotifier {
  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<CallFilterConfig> build(int simSlotIndex) async {
    final configMap = await _configRepo.getConfig(CallFilterConfigKeys.simSlotCallFilter(simSlotIndex));
    if (configMap != null) {
      return CallFilterConfig.fromMap(configMap);
    }
    // 未设置时从全局配置继承基础初值
    final globalConfig = await ref.read(callFilterConfigProvider.future);
    return globalConfig.copyWith();
  }

  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = AsyncValue.data(newConfig);
    try {
      await _configRepo.saveConfig(CallFilterConfigKeys.simSlotCallFilter(simSlotIndex), newConfig.toMap());
    } catch (e) {
      debugPrint('[SimSlotCallFilterConfigNotifier] 保存卡槽 $simSlotIndex 配置失败: $e');
    }
  }
}

/// 是否开启“多卡槽独立控制”开关的持久化 Notifier (强实体绑定，keepAlive: true 保证切页面不释放状态)
@Riverpod(keepAlive: true)
class SeparateSimsNotifier extends _$SeparateSimsNotifier {
  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<bool> build() async {
    final map = await _configRepo.getConfig(CallFilterConfigKeys.separateSims);
    if (map != null) {
      return SeparateSimsState.fromMap(map).isEnabled;
    }
    return false;
  }

  Future<void> setSeparateSims(bool value) async {
    // 1. 同步乐观更新状态，保证 UI 绝不因 AsyncValue.loading 丢失 value 或闪烁回弹
    state = AsyncValue.data(value);
    // 2. 后台异步保存至 SharedPreferences 持久化
    try {
      final simState = SeparateSimsState(isEnabled: value);
      await _configRepo.saveConfig(CallFilterConfigKeys.separateSims, simState.toMap());
    } catch (e) {
      debugPrint('[SeparateSimsNotifier] 持久化保存失败: $e');
    }
  }
}
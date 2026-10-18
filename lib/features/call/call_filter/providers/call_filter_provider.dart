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

@riverpod
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

  /// 提供一个统一的更新方法，接收一个新的Config对象
  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(CallFilterConfigKeys.globalCallFilter, newConfig.toMap());
      return newConfig;
    });
  }
}

/// 分卡槽独立通话过滤配置 Notifier（按 simSlotIndex 独立存取与维护配置）
@riverpod
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _configRepo.saveConfig(CallFilterConfigKeys.simSlotCallFilter(simSlotIndex), newConfig.toMap());
      return newConfig;
    });
  }
}

/// 是否开启“多卡槽独立控制”开关的持久化 Notifier (强实体绑定)
@riverpod
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final simState = SeparateSimsState(isEnabled: value);
      await _configRepo.saveConfig(CallFilterConfigKeys.separateSims, simState.toMap());
      return value;
    });
  }
}
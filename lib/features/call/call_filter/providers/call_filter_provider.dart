import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';

part 'call_filter_provider.g.dart';

abstract class CallFilterConfigKeys {
  static const String globalCallFilter = 'config_call_filter';
  static String simSlotCallFilter(int index) => 'config_call_filter_sim_$index';
  static const String separateSims = 'config_separate_sims';
  static const String enabledField = 'enabled';
}

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
    return CallFilterConfig();
  }

  Future<void> updateConfig(CallFilterConfig newConfig) async {
    state = AsyncValue.data(newConfig);
    try {
      await _configRepo.saveConfig(CallFilterConfigKeys.globalCallFilter, newConfig.toMap());
    } catch (e) {
      debugPrint('[CallFilterConfigNotifier] 保存配置失败: $e');
    }
  }
}

@Riverpod(keepAlive: true)
class SimSlotCallFilterConfigNotifier extends _$SimSlotCallFilterConfigNotifier {
  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<CallFilterConfig> build(int simSlotIndex) async {
    final configMap = await _configRepo.getConfig(CallFilterConfigKeys.simSlotCallFilter(simSlotIndex));
    if (configMap != null) {
      return CallFilterConfig.fromMap(configMap);
    }
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
    state = AsyncValue.data(value);
    try {
      final simState = SeparateSimsState(isEnabled: value);
      await _configRepo.saveConfig(CallFilterConfigKeys.separateSims, simState.toMap());
    } catch (e) {
      debugPrint('[SeparateSimsNotifier] 持久化保存失败: $e');
    }
  }
}

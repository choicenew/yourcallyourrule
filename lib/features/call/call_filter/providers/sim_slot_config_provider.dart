import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'sim_slot_config_provider.g.dart';

/// 状态模型，用于封装 SIM 卡配置状态
class SimSlotConfigState {
  // Map<simSlotIndex, isEnabled>
  final Map<int, bool> simSlotFilterEnabled;

  const SimSlotConfigState({
    this.simSlotFilterEnabled = const {},
  });

  SimSlotConfigState copyWith({
    Map<int, bool>? simSlotFilterEnabled,
  }) {
    return SimSlotConfigState(
      simSlotFilterEnabled: simSlotFilterEnabled ?? this.simSlotFilterEnabled,
    );
  }
}

@riverpod
class SimSlotConfigNotifier extends _$SimSlotConfigNotifier {
  static const String _configKey = 'config_sim_slot_filter_enabled';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<SimSlotConfigState> build() async {
    final configMap = await _configRepo.getConfig(_configKey);
    if (configMap != null) {
      final enabledMap = Map<int, bool>.from(
        configMap.map((key, value) => MapEntry(
              int.parse(key),
              value as bool,
            )),
      );
      return SimSlotConfigState(simSlotFilterEnabled: enabledMap);
    }
    return const SimSlotConfigState();
  }

  Future<void> _updateAndSave(SimSlotConfigState newState) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // 保存时需要将 int key 转为 String key
      final configMap = newState.simSlotFilterEnabled.map(
        (key, value) => MapEntry(key.toString(), value),
      );
      await _configRepo.saveConfig(_configKey, configMap);
      return newState;
    });
  }

  /// 启用指定SIM卡槽位的过滤器
  Future<void> enableSimSlotFilter(int simSlotIndex) async {
    final currentState = await future;
    final newMap = Map<int, bool>.from(currentState.simSlotFilterEnabled)
      ..[simSlotIndex] = true;
    await _updateAndSave(currentState.copyWith(simSlotFilterEnabled: newMap));
  }

  /// 禁用指定SIM卡槽位的过滤器
  Future<void> disableSimSlotFilter(int simSlotIndex) async {
    final currentState = await future;
    final newMap = Map<int, bool>.from(currentState.simSlotFilterEnabled)
      ..[simSlotIndex] = false;
    await _updateAndSave(currentState.copyWith(simSlotFilterEnabled: newMap));
  }
}
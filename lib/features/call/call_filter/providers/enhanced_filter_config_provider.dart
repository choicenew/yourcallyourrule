import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';


part 'enhanced_filter_config_provider.g.dart';

/// 状态模型，封装 Enhanced Filter 的所有配置
class EnhancedFilterConfigState {
  // 全局过滤器启用状态
  final Map<String, bool> filterEnabledMap;
  // SIM卡槽位特定过滤器配置
  final Map<int, Map<String, bool>> simSlotFilterConfigMap;

  const EnhancedFilterConfigState({
    this.filterEnabledMap = const {},
    this.simSlotFilterConfigMap = const {},
  });

  EnhancedFilterConfigState copyWith({
    Map<String, bool>? filterEnabledMap,
    Map<int, Map<String, bool>>? simSlotFilterConfigMap,
  }) {
    return EnhancedFilterConfigState(
      filterEnabledMap: filterEnabledMap ?? this.filterEnabledMap,
      simSlotFilterConfigMap: simSlotFilterConfigMap ?? this.simSlotFilterConfigMap,
    );
  }
}

@riverpod
class EnhancedFilterConfigNotifier extends _$EnhancedFilterConfigNotifier {
  static const String _filterEnabledMapKey = 'config_filter_enabled_map';
  static const String _simSlotFilterConfigKey = 'config_sim_slot_filter_config';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  @override
  Future<EnhancedFilterConfigState> build() async {
    // 并行加载两个配置
    final results = await Future.wait([
      _configRepo.getConfig(_filterEnabledMapKey),
      _configRepo.getConfig(_simSlotFilterConfigKey),
    ]);

    final filterEnabledMapRaw = results[0];
    final simSlotConfigMapRaw = results[1];

    final filterEnabledMap = filterEnabledMapRaw != null
        ? Map<String, bool>.from(filterEnabledMapRaw)
        : <String, bool>{};
    
    final simSlotFilterConfigMap = <int, Map<String, bool>>{};
    if (simSlotConfigMapRaw != null) {
      simSlotConfigMapRaw.forEach((key, value) {
        final simSlotIndex = int.parse(key);
        simSlotFilterConfigMap[simSlotIndex] = Map<String, bool>.from(value);
      });
    }

    return EnhancedFilterConfigState(
      filterEnabledMap: filterEnabledMap,
      simSlotFilterConfigMap: simSlotFilterConfigMap,
    );
  }

  Future<void> _updateAndSave(EnhancedFilterConfigState newState) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // 序列化 simSlotFilterConfigMap 的 key
      final serializableSimConfig = newState.simSlotFilterConfigMap.map(
        (key, value) => MapEntry(key.toString(), value),
      );
      // 并行保存两个配置
      await Future.wait([
        _configRepo.saveConfig(_filterEnabledMapKey, newState.filterEnabledMap),
        _configRepo.saveConfig(_simSlotFilterConfigKey, serializableSimConfig),
      ]);
      return newState;
    });
  }
  
  // --- 更新方法 ---

  Future<void> enableFilter(String filterName) async {
    final currentState = await future;
    final newMap = Map<String, bool>.from(currentState.filterEnabledMap)..[filterName] = true;
    await _updateAndSave(currentState.copyWith(filterEnabledMap: newMap));
  }

  Future<void> disableFilter(String filterName) async {
    final currentState = await future;
    final newMap = Map<String, bool>.from(currentState.filterEnabledMap)..[filterName] = false;
    await _updateAndSave(currentState.copyWith(filterEnabledMap: newMap));
  }

  Future<void> enableFilterForSimSlot(int simSlotIndex, String filterName) async {
    final currentState = await future;
    final newMap = Map<int, Map<String, bool>>.from(currentState.simSlotFilterConfigMap);
    newMap.putIfAbsent(simSlotIndex, () => {})[filterName] = true;
    await _updateAndSave(currentState.copyWith(simSlotFilterConfigMap: newMap));
  }

  Future<void> disableFilterForSimSlot(int simSlotIndex, String filterName) async {
    final currentState = await future;
    final newMap = Map<int, Map<String, bool>>.from(currentState.simSlotFilterConfigMap);
    newMap.putIfAbsent(simSlotIndex, () => {})[filterName] = false;
    await _updateAndSave(currentState.copyWith(simSlotFilterConfigMap: newMap));
  }
}
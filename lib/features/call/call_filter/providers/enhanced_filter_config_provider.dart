import 'dart:collection';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';

part 'enhanced_filter_config_provider.g.dart';

/// 兼容 Map 包装器：支持 CallFilterType 和历史 String 键无缝读取
class FilterEnabledCompatMap with MapMixin<dynamic, bool> {
  final Map<CallFilterType, bool> _inner;
  FilterEnabledCompatMap(this._inner);

  @override
  bool? operator [](Object? key) {
    if (key is CallFilterType) {
      return _inner[key];
    }
    if (key is String) {
      final type = EnhancedFilterConfigNotifier.parseFilterType(key);
      if (type != null) return _inner[type];
    }
    return null;
  }

  @override
  void operator []=(dynamic key, bool value) {
    throw UnsupportedError('Read-only map');
  }

  @override
  void clear() => throw UnsupportedError('Read-only map');

  @override
  Iterable<dynamic> get keys => _inner.keys;

  @override
  bool? remove(Object? key) => throw UnsupportedError('Read-only map');
}

/// 状态模型，封装 Enhanced Filter 的所有配置（完全强类型驱动）
class EnhancedFilterConfigState {
  // 全局过滤器启用状态
  final Map<CallFilterType, bool> _filterEnabledMap;
  // SIM卡槽位特定过滤器配置
  final Map<int, Map<CallFilterType, bool>> simSlotFilterConfigMap;

  const EnhancedFilterConfigState({
    Map<CallFilterType, bool> filterEnabledMap = const {},
    this.simSlotFilterConfigMap = const {},
  }) : _filterEnabledMap = filterEnabledMap;

  /// 强类型 Map 获取
  Map<CallFilterType, bool> get typedFilterEnabledMap => _filterEnabledMap;

  /// 兼容 Map 获取（支持 CallFilterType 和 String）
  FilterEnabledCompatMap get filterEnabledMap => FilterEnabledCompatMap(_filterEnabledMap);

  EnhancedFilterConfigState copyWith({
    Map<CallFilterType, bool>? filterEnabledMap,
    Map<int, Map<CallFilterType, bool>>? simSlotFilterConfigMap,
  }) {
    return EnhancedFilterConfigState(
      filterEnabledMap: filterEnabledMap ?? _filterEnabledMap,
      simSlotFilterConfigMap: simSlotFilterConfigMap ?? this.simSlotFilterConfigMap,
    );
  }
}

@riverpod
class EnhancedFilterConfigNotifier extends _$EnhancedFilterConfigNotifier {
  static const String _filterEnabledMapKey = 'config_filter_enabled_map';
  static const String _simSlotFilterConfigKey = 'config_sim_slot_filter_config';

  ConfigRepository get _configRepo => ref.read(configRepositoryProvider);

  static CallFilterType? parseFilterType(String key) {
    for (final type in CallFilterType.values) {
      if (type.name == key) return type;
    }
    // 兼容历史类名字符串持久化数据
    switch (key) {
      case 'CallFilterService': return CallFilterType.basicRule;
      case 'LocalCountFilterService': return CallFilterType.localCount;
      case 'RemoteNumberFilterService': return CallFilterType.remoteNumber;
      case 'SimSlotRuleService':
      case 'SimSlotRuleFilterService': return CallFilterType.simSlotRule;
    }
    return null;
  }

  @override
  Future<EnhancedFilterConfigState> build() async {
    // 并行加载两个配置
    final results = await Future.wait([
      _configRepo.getConfig(_filterEnabledMapKey),
      _configRepo.getConfig(_simSlotFilterConfigKey),
    ]);

    final filterEnabledMapRaw = results[0];
    final simSlotConfigMapRaw = results[1];

    final filterEnabledMap = <CallFilterType, bool>{};
    if (filterEnabledMapRaw != null) {
      filterEnabledMapRaw.forEach((key, value) {
        final type = parseFilterType(key);
        if (type != null && value is bool) {
          filterEnabledMap[type] = value;
        }
      });
    }

    final simSlotFilterConfigMap = <int, Map<CallFilterType, bool>>{};
    if (simSlotConfigMapRaw != null) {
      simSlotConfigMapRaw.forEach((slotKey, slotVal) {
        final simSlotIndex = int.tryParse(slotKey);
        if (simSlotIndex != null && slotVal is Map) {
          final slotMap = <CallFilterType, bool>{};
          slotVal.forEach((key, value) {
            final type = parseFilterType(key.toString());
            if (type != null && value is bool) {
              slotMap[type] = value;
            }
          });
          simSlotFilterConfigMap[simSlotIndex] = slotMap;
        }
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
      final serializableGlobalMap = newState.typedFilterEnabledMap.map(
        (type, value) => MapEntry(type.name, value),
      );
      final serializableSimConfig = newState.simSlotFilterConfigMap.map(
        (slotIndex, typeMap) => MapEntry(
          slotIndex.toString(),
          typeMap.map((type, val) => MapEntry(type.name, val)),
        ),
      );
      await Future.wait([
        _configRepo.saveConfig(_filterEnabledMapKey, serializableGlobalMap),
        _configRepo.saveConfig(_simSlotFilterConfigKey, serializableSimConfig),
      ]);
      return newState;
    });
  }

  // --- 强类型与向后兼容的更新方法 ---

  Future<void> enableFilter(dynamic filter) async {
    final type = filter is CallFilterType ? filter : parseFilterType(filter.toString());
    if (type == null) return;
    final currentState = await future;
    final newMap = Map<CallFilterType, bool>.from(currentState.typedFilterEnabledMap)..[type] = true;
    await _updateAndSave(currentState.copyWith(filterEnabledMap: newMap));
  }

  Future<void> disableFilter(dynamic filter) async {
    final type = filter is CallFilterType ? filter : parseFilterType(filter.toString());
    if (type == null) return;
    final currentState = await future;
    final newMap = Map<CallFilterType, bool>.from(currentState.typedFilterEnabledMap)..[type] = false;
    await _updateAndSave(currentState.copyWith(filterEnabledMap: newMap));
  }

  Future<void> enableFilterForSimSlot(int simSlotIndex, dynamic filter) async {
    final type = filter is CallFilterType ? filter : parseFilterType(filter.toString());
    if (type == null) return;
    final currentState = await future;
    final newMap = Map<int, Map<CallFilterType, bool>>.from(currentState.simSlotFilterConfigMap);
    newMap.putIfAbsent(simSlotIndex, () => {})[type] = true;
    await _updateAndSave(currentState.copyWith(simSlotFilterConfigMap: newMap));
  }

  Future<void> disableFilterForSimSlot(int simSlotIndex, dynamic filter) async {
    final type = filter is CallFilterType ? filter : parseFilterType(filter.toString());
    if (type == null) return;
    final currentState = await future;
    final newMap = Map<int, Map<CallFilterType, bool>>.from(currentState.simSlotFilterConfigMap);
    newMap.putIfAbsent(simSlotIndex, () => {})[type] = false;
    await _updateAndSave(currentState.copyWith(simSlotFilterConfigMap: newMap));
  }
}
// 增强版组合过滤器服务，支持每个SIM卡独立配置过滤器

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';

/// 增强版组合过滤器服务
/// 作为过滤链的总入口点，支持每个SIM卡独立配置过滤器
/// 使用装饰器模式保持各个过滤器的独立性
class EnhancedCompositeFilterService implements CallFilterInterface {
  final List<CallFilterInterface> _filters;
  final SimSlotRuleService _simSlotRuleService;
  final ConfigRepository _configRepository;

  /// 获取过滤器列表
  List<CallFilterInterface> get filters => List.unmodifiable(_filters);
  
  // 存储全局过滤器启用状态的配置映射
  Map<String, bool> _filterEnabledMap = {};
  
  // 存储每个SIM卡槽位的过滤器配置
  // 格式: {simSlotIndex: {filterName: isEnabled}}
  Map<int, Map<String, bool>> _simSlotFilterConfigMap = {};
  
  EnhancedCompositeFilterService({
    required List<CallFilterInterface> filters,
    required SimSlotRuleService simSlotRuleService,
    required ConfigRepository configRepository,
  }) : _filters = filters,
       _simSlotRuleService = simSlotRuleService,
       _configRepository = configRepository;
  
  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    // 默认接受来电
    bool shouldAccept = true;
    
    // 按照过滤链顺序依次检查各个过滤器
    for (var filter in _filters) {
      // 获取过滤器类名作为标识
      final filterName = filter.runtimeType.toString();
      
      // 检查过滤器是否全局启用
      if (_filterEnabledMap[filterName] ?? true) {
        // 应用过滤器规则
        final result = await filter.shouldAcceptCall(phoneNumber);
        
        // 如果任何一个过滤器拒绝，则直接返回拒绝结果
        if (!result) {
          return false;
        }
      }
    }
    
    return shouldAccept;
  }
  
  /// 判断是否应该接受来电（带SIM卡信息）
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) async {
    // 如果没有SIM卡信息，则使用标准过滤链
    if (simInfo == null || simInfo.simSlotIndex == null) {
      return await shouldAcceptCall(phoneNumber);
    }
    
    // 获取SIM卡槽位索引
    final simSlotIndex = simInfo.simSlotIndex!;
    
    // 首先检查SIM卡槽位规则
    final simSlotRuleResult = await _simSlotRuleService.shouldAcceptCallWithSim(
      phoneNumber, 
      simInfo: simInfo
    );
    
    // 如果SIM卡槽位规则拒绝，则直接返回拒绝结果
    if (!simSlotRuleResult) {
      return false;
    }
    
    // 按照过滤链顺序依次检查各个过滤器
    for (var filter in _filters) {
      // 获取过滤器类名作为标识
      final filterName = filter.runtimeType.toString();
      
      // 检查该SIM卡槽位的过滤器是否启用
      final isEnabledForSimSlot = isFilterEnabledForSimSlot(simSlotIndex, filterName);
      
      // 如果该过滤器对此SIM卡槽位启用
      if (isEnabledForSimSlot) {
        // 对于所有过滤器，使用标准接口
        final result = await filter.shouldAcceptCall(phoneNumber);
        if (!result) {
          return false; // 如果任何过滤器拒绝，直接返回拒绝结果
        }
      }
    }
    
    return true;
  }
  
  /// 全局启用指定过滤器
  Future<void> enableFilter(String filterName) async {
    _filterEnabledMap[filterName] = true;
    await _saveFilterEnabledConfig();
  }
  
  /// 全局禁用指定过滤器
  Future<void> disableFilter(String filterName) async {
    _filterEnabledMap[filterName] = false;
    await _saveFilterEnabledConfig();
  }
  
  /// 获取过滤器全局启用状态
  bool isFilterEnabled(String filterName) {
    return _filterEnabledMap[filterName] ?? true;
  }
  
  /// 为指定SIM卡槽位启用过滤器
  Future<void> enableFilterForSimSlot(int simSlotIndex, String filterName) async {
    if (!_simSlotFilterConfigMap.containsKey(simSlotIndex)) {
      _simSlotFilterConfigMap[simSlotIndex] = {};
    }
    _simSlotFilterConfigMap[simSlotIndex]![filterName] = true;
    await _saveSimSlotFilterConfig();
  }
  
  /// 为指定SIM卡槽位禁用过滤器
  Future<void> disableFilterForSimSlot(int simSlotIndex, String filterName) async {
    if (!_simSlotFilterConfigMap.containsKey(simSlotIndex)) {
      _simSlotFilterConfigMap[simSlotIndex] = {};
    }
    _simSlotFilterConfigMap[simSlotIndex]![filterName] = false;
    await _saveSimSlotFilterConfig();
  }
  
  /// 检查过滤器是否对指定SIM卡槽位启用
  bool isFilterEnabledForSimSlot(int simSlotIndex, String filterName) {
    // 如果没有该SIM卡槽位的配置，则使用全局配置
    if (!_simSlotFilterConfigMap.containsKey(simSlotIndex) ||
        !_simSlotFilterConfigMap[simSlotIndex]!.containsKey(filterName)) {
      return isFilterEnabled(filterName);
    }
    return _simSlotFilterConfigMap[simSlotIndex]![filterName]!;
  }
  
  /// 保存过滤器全局启用状态配置
  Future<void> _saveFilterEnabledConfig() async {
    await _configRepository.saveConfig('filter_enabled_map', _filterEnabledMap);
  }
  
  /// 保存SIM卡槽位过滤器配置
  Future<void> _saveSimSlotFilterConfig() async {
    // 将嵌套Map转换为可序列化的格式
    final Map<String, dynamic> serializableMap = {};
    _simSlotFilterConfigMap.forEach((simSlotIndex, filterMap) {
      serializableMap[simSlotIndex.toString()] = filterMap;
    });
    await _configRepository.saveConfig('sim_slot_filter_config', serializableMap);
  }
  
  /// 加载过滤器全局启用状态配置
  Future<void> _loadFilterEnabledConfig() async {
    final configMap = await _configRepository.getConfig('filter_enabled_map');
    if (configMap != null) {
      _filterEnabledMap = Map<String, bool>.from(configMap);
    }
  }
  
  /// 加载SIM卡槽位过滤器配置
  Future<void> _loadSimSlotFilterConfig() async {
    final configMap = await _configRepository.getConfig('sim_slot_filter_config');
    if (configMap != null) {
      _simSlotFilterConfigMap = {};
      configMap.forEach((key, value) {
        final simSlotIndex = int.parse(key);
        _simSlotFilterConfigMap[simSlotIndex] = Map<String, bool>.from(value);
      });
    }
  }
  
  @override
  Future<void> initialize() async {
    // 加载配置
    await _loadFilterEnabledConfig();
    await _loadSimSlotFilterConfig();
    
    // 初始化所有过滤器
    await _simSlotRuleService.initialize();
    for (var filter in _filters) {
      await filter.initialize();
    }
  }
}
// 组合过滤器服务，作为过滤链的总入口点

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';

/// 组合过滤器服务
/// 作为过滤链的总入口点，组合多个过滤器但不暴露它们的内部配置
/// 使用装饰器模式保持各个过滤器的独立性
class CompositeFilterService implements CallFilterInterface {
  final List<CallFilterInterface> _filters;
  final ConfigRepository _configRepository;
  
  // 存储过滤器启用状态的配置映射
  Map<String, bool> _filterEnabledMap = {};
  
  CompositeFilterService({
    required List<CallFilterInterface> filters,
    required ConfigRepository configRepository,
  }) : _filters = filters,
       _configRepository = configRepository;
  
  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    // 默认接受来电
    bool shouldAccept = true;
    
    // 按照过滤链顺序依次检查各个过滤器
    for (var filter in _filters) {
      // 获取过滤器类名作为标识
      final filterName = filter.runtimeType.toString();
      
      // 检查过滤器是否启用
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
    
    // 默认接受来电
    bool shouldAccept = true;
    
    // 按照过滤链顺序依次检查各个过滤器
    for (var filter in _filters) {
      // 获取过滤器类名作为标识
      final filterName = filter.runtimeType.toString();
      
      // 检查过滤器是否启用
      if (_filterEnabledMap[filterName] ?? true) {
        // 对于所有过滤器，使用标准接口
        final result = await filter.shouldAcceptCall(phoneNumber);
        if (!result) {
          return false; // 如果任何过滤器拒绝，直接返回拒绝结果
        }
      }
    }
    
    return shouldAccept;
  }
  
  /// 启用指定过滤器
  Future<void> enableFilter(String filterName) async {
    _filterEnabledMap[filterName] = true;
    await _saveFilterEnabledConfig();
  }
  
  /// 禁用指定过滤器
  Future<void> disableFilter(String filterName) async {
    _filterEnabledMap[filterName] = false;
    await _saveFilterEnabledConfig();
  }
  
  /// 获取过滤器启用状态
  bool isFilterEnabled(String filterName) {
    return _filterEnabledMap[filterName] ?? true;
  }
  
  /// 保存过滤器启用状态配置
  Future<void> _saveFilterEnabledConfig() async {
    await _configRepository.saveConfig('filter_enabled_map', _filterEnabledMap);
  }
  
  /// 加载过滤器启用状态配置
  Future<void> _loadFilterEnabledConfig() async {
    final configMap = await _configRepository.getConfig('filter_enabled_map');
    if (configMap != null) {
      _filterEnabledMap = Map<String, bool>.from(configMap);
    }
  }
  
  @override
  Future<void> initialize() async {
    // 加载过滤器启用状态配置
    await _loadFilterEnabledConfig();
    
    // 初始化所有过滤器
    for (var filter in _filters) {
      await filter.initialize();
    }
  }
}
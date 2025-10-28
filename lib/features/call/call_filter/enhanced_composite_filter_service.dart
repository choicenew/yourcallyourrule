import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_filter_service.dart';
// 导入依赖的 Provider


import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';

part 'enhanced_composite_filter_service.g.dart';

@riverpod
EnhancedCompositeFilterService enhancedCompositeFilterService(Ref ref) {
  // 注意：这里需要注入一个过滤器列表
  // 假设我们的过滤链目前只有 CallFilterService
  final filters = [ref.watch(callFilterServiceProvider)]; 
  
  return EnhancedCompositeFilterService(
    filters: filters,
    simSlotRuleService: ref.watch(simSlotRuleServiceProvider),
    ref: ref,
  );
}

/// 增强版组合过滤器服务 (无状态)
class EnhancedCompositeFilterService implements CallFilterInterface {
  final List<CallFilterInterface> _filters;
  final SimSlotRuleService _simSlotRuleService;
  final Ref _ref;

  List<CallFilterInterface> get filters => List.unmodifiable(_filters);

  EnhancedCompositeFilterService({
    required List<CallFilterInterface> filters,
    required SimSlotRuleService simSlotRuleService,
    required Ref ref,
  }) : _filters = filters,
       _simSlotRuleService = simSlotRuleService,
       _ref = ref;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    final config = await _ref.read(enhancedFilterConfigProvider.future);
    
    // 按照过滤链顺序依次检查各个过滤器
    for (var filter in _filters) {
      // 获取过滤器类名作为标识
      final filterName = filter.runtimeType.toString();
      if (config.filterEnabledMap[filterName] ?? true) {
        // 应用过滤器规则
        if (!await filter.shouldAcceptCall(phoneNumber)) {
 // 如果任何一个过滤器拒绝，则直接返回拒绝结果
          return false;
        }
      }
    }
    return true;
  }
  
  /// 判断是否应该接受来电（带SIM卡信息）
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) async {
    // 如果没有SIM卡信息，则使用标准过滤链
    if (simInfo == null || simInfo.simSlotIndex == null) {
      return await shouldAcceptCall(phoneNumber);
    }
    
    if (!await _simSlotRuleService.shouldAcceptCallWithSim(phoneNumber, simInfo: simInfo)) {
// 如果SIM卡槽位规则拒绝，则直接返回拒绝结果
      return false;
    }

    final config = await _ref.read(enhancedFilterConfigProvider.future);
    final simSlotIndex = simInfo.simSlotIndex!;

    for (var filter in _filters) {
      // 获取过滤器类名作为标识
      final filterName = filter.runtimeType.toString();
        // 检查该SIM卡槽位的过滤器是否启用
      final isEnabledForSimSlot = config.simSlotFilterConfigMap[simSlotIndex]?[filterName] 
                                ?? config.filterEnabledMap[filterName] 
                                ?? true;
      
      // 如果该过滤器对此SIM卡槽位启用
      if (isEnabledForSimSlot) {
         // 对于所有过滤器，使用标准接口
        if (!await filter.shouldAcceptCall(phoneNumber)) {
          return false; // 如果任何过滤器拒绝，直接返回拒绝结果
        }
      }
    }
    
    return true;
  }
  
  @override
  Future<void> initialize() async {
    // 初始化所有依赖的过滤器
    await _simSlotRuleService.initialize();
    for (var filter in _filters) {
      await filter.initialize();
    }
  }
}
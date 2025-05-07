// 增强版过滤链架构示例，展示如何使用支持每个SIM卡独立配置的过滤链

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
// SimFilterService已被移除，使用SimSlotRuleService替代
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

/// 增强版过滤链架构示例类
/// 展示如何初始化和使用支持每个SIM卡独立配置的过滤链架构
class EnhancedFilterChainExample {
  /// 创建增强版过滤链
  /// 返回作为入口点的EnhancedCompositeFilterService实例
  static Future<EnhancedCompositeFilterService> createEnhancedFilterChain(
    ConfigRepository configRepository,
    RuleRepository ruleRepository,
    RegexService regexService,
    AllowedBlockedService allowedBlockedService,
    BlacklistWhitelistService blacklistWhitelistService,
    RemoteNumberService remoteNumberService,
    CallerIdService callerIdService,
  ) async {
    // 1. 创建各个独立的过滤器
    // 1.1 创建基础规则过滤服务
    final callFilterService = CallFilterService(
      regexService: regexService,
      allowedBlockedService: allowedBlockedService,
      blacklistWhitelistService: blacklistWhitelistService,
      configRepository: configRepository,
    );
    
    // 1.2 创建远程号码过滤服务
    final remoteNumberFilterService = RemoteNumberFilterService(
      remoteNumberService: remoteNumberService,
      configRepository: configRepository,
    );
    
    // 1.3 创建本地计数过滤服务
    final localCountFilterService = LocalCountFilterService(
      callerIdService: callerIdService,
      configRepository: configRepository,
    );
    
    // 不再需要创建单独的SIM卡过滤服务，因为我们已经有了SIM卡槽位规则服务
    
    // 1.5 创建SIM卡槽位规则服务
    final simSlotRuleService = SimSlotRuleService(
      ruleRepository: ruleRepository,
      configRepository: configRepository,
    );
    
    // 2. 创建增强版组合过滤器服务作为入口点
    final enhancedCompositeFilterService = EnhancedCompositeFilterService(
      filters: [
        localCountFilterService,
        remoteNumberFilterService,
        callFilterService,
      ],
      simSlotRuleService: simSlotRuleService,
      configRepository: configRepository,
    );
    
    // 3. 初始化过滤链
    await enhancedCompositeFilterService.initialize();
    
    return enhancedCompositeFilterService;
  }
  
  /// 使用增强版过滤链判断是否接受来电
  /// [enhancedCompositeFilterService] 增强版组合过滤器服务
  /// [phoneNumber] 电话号码
  /// [simInfo] SIM卡信息，可选
  /// 返回是否应该接受来电
  static Future<bool> shouldAcceptCall(
    EnhancedCompositeFilterService enhancedCompositeFilterService,
    String phoneNumber,
    {SimInfo? simInfo}
  ) async {
    if (simInfo != null) {
      return await enhancedCompositeFilterService.shouldAcceptCallWithSim(phoneNumber, simInfo: simInfo);
    } else {
      return await enhancedCompositeFilterService.shouldAcceptCall(phoneNumber);
    }
  }
  
  /// 为特定SIM卡配置过滤器示例
  static Future<void> configureSimSlotFilters(
    EnhancedCompositeFilterService enhancedCompositeFilterService,
    int simSlotIndex
  ) async {
    // 示例：为SIM卡1启用本地计数过滤器，但禁用远程号码过滤器
    await enhancedCompositeFilterService.enableFilterForSimSlot(
      simSlotIndex, 
      'LocalCountFilterService'
    );
    
    await enhancedCompositeFilterService.disableFilterForSimSlot(
      simSlotIndex, 
      'RemoteNumberFilterService'
    );
    
    // 示例：为SIM卡1添加特定号码规则
    final simSlotRuleService = enhancedCompositeFilterService as dynamic;
    await simSlotRuleService._simSlotRuleService.addSimSlotRule(
      '+1234567890', 
      simSlotIndex,
      name: 'SIM卡${simSlotIndex}特定规则',
      label: '测试号码'
    );
  }
  
  /// 使用示例
  static void example() {
    // 这里仅作为示例，实际使用时需要通过依赖注入获取相关服务
    // final enhancedCompositeFilterService = await createEnhancedFilterChain(...);
    
    // 为SIM卡1配置过滤器
    // await configureSimSlotFilters(enhancedCompositeFilterService, 0);
    
    // 为SIM卡2配置过滤器
    // await configureSimSlotFilters(enhancedCompositeFilterService, 1);
    
    // 判断来电是否应该接受
    // final simInfo = SimInfo(simSlotIndex: 0);
    // final shouldAccept = await shouldAcceptCall(enhancedCompositeFilterService, '+1234567890', simInfo: simInfo);
    // print('是否接受来电: $shouldAccept');
  }
}
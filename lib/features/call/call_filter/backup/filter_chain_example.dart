// 过滤链架构示例，展示如何使用新的过滤链架构

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/backup/composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';

import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

/// 过滤链架构示例类
/// 展示如何初始化和使用新的过滤链架构
class FilterChainExample {
  /// 创建过滤链
  /// 返回作为入口点的CompositeFilterService实例
  static Future<CompositeFilterService> createFilterChain(
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
    
    // 1.4 创建SIM卡槽位规则服务
    final simSlotRuleService = SimSlotRuleService(
      ruleRepository: ruleRepository,
      configRepository: configRepository,
    );
    
    // 2. 创建组合过滤器服务作为入口点
    final compositeFilterService = CompositeFilterService(
      filters: [
        localCountFilterService,
        remoteNumberFilterService,
        callFilterService,
      ],
      configRepository: configRepository,
    );
    
    // 初始化SIM卡槽位规则服务
    await simSlotRuleService.initialize();
    
    // 3. 初始化过滤链
    await compositeFilterService.initialize();
    
    return compositeFilterService;
  }
  
  /// 使用过滤链判断是否接受来电
  /// [compositeFilterService] 组合过滤器服务
  /// [phoneNumber] 电话号码
  /// [simInfo] SIM卡信息，可选
  /// 返回是否应该接受来电
  static Future<bool> shouldAcceptCall(
    CompositeFilterService compositeFilterService,
    String phoneNumber,
    {SimInfo? simInfo}
  ) async {
    if (simInfo != null) {
      return await compositeFilterService.shouldAcceptCallWithSim(phoneNumber, simInfo: simInfo);
    } else {
      return await compositeFilterService.shouldAcceptCall(phoneNumber);
    }
  }
  
  /// 使用示例
  static void example() {
    // 这里仅作为示例，实际使用时需要通过依赖注入获取相关服务
    // final compositeFilterService = await createFilterChain(...);
    // final shouldAccept = await shouldAcceptCall(compositeFilterService, '+1234567890');
    // print('是否接受来电: $shouldAccept');
    
    // 启用/禁用特定过滤器示例
    // await compositeFilterService.enableFilter('LocalCountFilterService');
    // await compositeFilterService.disableFilter('RemoteNumberFilterService');
  }
}
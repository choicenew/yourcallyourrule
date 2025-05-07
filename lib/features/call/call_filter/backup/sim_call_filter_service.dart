import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';

/// SIM卡通话过滤服务
/// 作为过滤服务链的入口点，整合多种过滤服务
/// 包括SIM卡槽位规则过滤、基础规则过滤、远程号码过滤和本地计数过滤
class SimCallFilterService {
  final CallFilterService _callFilterService;
  final RemoteNumberFilterService _remoteNumberFilterService;
  final LocalCountFilterService _localCountFilterService;
  final SimSlotRuleService _simSlotRuleService;

  SimCallFilterService({
    required CallFilterService callFilterService,
    required RemoteNumberFilterService remoteNumberFilterService,
    required LocalCountFilterService localCountFilterService,
    required SimSlotRuleService simSlotRuleService,
  })
      : _callFilterService = callFilterService,
        _remoteNumberFilterService = remoteNumberFilterService,
        _localCountFilterService = localCountFilterService,
        _simSlotRuleService = simSlotRuleService;

  /// 初始化服务
  Future<void> initialize() async {
    await _simSlotRuleService.initialize();
    await _callFilterService.initialize();
    await _remoteNumberFilterService.initialize();
    await _localCountFilterService.initialize();
  }

  /// 判断是否应该接受来电
  /// 按照过滤链顺序依次检查：SIM卡槽位规则 -> 本地计数规则 -> 远程号码规则 -> 基础规则
  Future<bool> shouldAcceptCall(String phoneNumber, {SimInfo? simInfo}) async {
    // 1. 首先检查SIM卡槽位规则
    if (simInfo != null) {
      final simSlotResult = await _simSlotRuleService.shouldAcceptCallWithSim(phoneNumber, simInfo: simInfo);
      if (!simSlotResult) {
        return false;
      }
    }

    // 2. 检查本地计数规则
    final localCountResult = await _localCountFilterService.shouldAcceptCall(phoneNumber);
    if (!localCountResult) {
      return false;
    }
    
    // 3. 检查远程号码规则
    final remoteNumberResult = await _remoteNumberFilterService.shouldAcceptCall(phoneNumber);
    if (!remoteNumberResult) {
      return false;
    }

    // 4. 最后使用基础规则过滤逻辑
    return await _callFilterService.shouldAcceptCall(phoneNumber);
  }

  /// 获取指定SIM卡槽位的所有规则
  Future<List<String>> getSimSlotRules(int simSlotIndex) async {
    final rules = await _simSlotRuleService.getSimSlotRules(simSlotIndex);
    return rules.map((rule) => rule.phoneNumber.value).toList();
  }

  /// 清除指定SIM卡槽位的所有规则
  Future<void> clearSimSlotRules(int simSlotIndex) async {
    await _simSlotRuleService.clearSimSlotRules(simSlotIndex);
  }

  /// 清除所有SIM卡槽位规则
  Future<void> clearAllSimSlotRules() async {
    await _simSlotRuleService.clearAllSimSlotRules();
  }
}
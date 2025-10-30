import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/features/rules/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/regex_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

part 'call_filter_service.g.dart';

/// CallFilterService 的 @riverpod Provider
/// 它会自动处理依赖注入
@riverpod
CallFilterService callFilterService(Ref ref) {
  return CallFilterService(
    regexService: ref.watch(regexServiceProvider),
    allowedBlockedService: ref.watch(allowedBlockedServiceProvider),
    ruleManagementService: ref.watch(ruleManagementServiceProvider),
    ref: ref,
  );
}

/// 通话过滤服务类 (无状态)
class CallFilterService implements CallFilterInterface {
  final RegexService _regexService;
  final AllowedBlockedService _allowedBlockedService;
  final RuleManagementService _ruleManagementService;
  final Ref _ref; // 持有 Ref 以在需要时读取最新的配置

  CallFilterService({
    required RegexService regexService,
    required AllowedBlockedService allowedBlockedService,
    required RuleManagementService ruleManagementService,
    required Ref ref,
  })  : _regexService = regexService,
        _allowedBlockedService = allowedBlockedService,
        _ruleManagementService = ruleManagementService,
        _ref = ref;

  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    // 从 Notifier 异步读取最新的配置
    final config = await _ref.read(callFilterConfigProvider.future);
    final phoneNumber = PhoneNumber(phoneNumberStr);
    InterceptAction? interceptAction;
 // 全局拒绝设置优先级最高如果配置为拒绝所有号码，直接返回false
    if (config.rejectAllNumbers) {
      _setCurrentInterceptAction(null);// 使用全局默认拦截动作
      debugPrint("rejectAllNumbers: ${config.rejectAllNumbers}");
      return false;
    }

    // 获取所有适用的规则
    final matchingRules = await _getAllMatchingRules(phoneNumber);

    // 如果没有匹配规则，放行电话
    if (matchingRules.isEmpty) {
      return true;
    }

    // 按优先级排序规则（优先级值越高，优先级越高）
    matchingRules.sort((a, b) => b.priority.value.compareTo(a.priority.value));

    // 获取优先级最高的规则
    final highestPriorityRule = matchingRules.first;

    // 根据最高优先级规则的动作类型决定是否接受来电
    switch (highestPriorityRule.action.type) {
      case RuleActionType.allow:
        return true;
      case RuleActionType.block:
      case RuleActionType.silence:
      // 设置拦截动作

        interceptAction = _getInterceptActionFromRule(highestPriorityRule.action);
        _setCurrentInterceptAction(interceptAction);
        return false;
      case RuleActionType.none:
      default:
        return true;
    }
  }

  @override
  Future<void> initialize() async {
    // 初始化方法现在是可选的，因为配置由 Notifier 自动加载
    // 如果有其他非配置相关的初始化，可以保留
    return;
  }

  // --- 其余私有方法和静态方法保持不变 ---
// 从规则动作中获取拦截动作
  InterceptAction? _getInterceptActionFromRule(RuleAction action) {
    // 根据动作类型处理
    switch (action.type) {
      case RuleActionType.block:
      // 如果没有参数，使用默认拦截动作
        if (action.parameters == null || !action.parameters!.containsKey('interceptAction')) {
          return null;
        }
        final actionName = action.parameters!['interceptAction'] as String?;
        debugPrint("_getInterceptActionFromRule: $actionName");
        return actionName != null ? InterceptAction.values.byName(actionName) : null;
      case RuleActionType.silence:
        // silence类型直接返回silenceNoAnswer
        return InterceptAction.silenceNoAnswer;

      case RuleActionType.none:
      case RuleActionType.allow:
      default:
        // 其他类型不需要拦截
        return null;
    }
  }

  // 当前拦截动作，用于在shouldAcceptCall和EndCallHandler之间传递信息
  static InterceptAction? _currentInterceptAction;

  // 设置当前拦截动作
  void _setCurrentInterceptAction(InterceptAction? action) {
    debugPrint("setCurrentInterceptAction: $action");
    _currentInterceptAction = action;
  }

  // 获取当前拦截动作
  static InterceptAction? getCurrentInterceptAction() {
    return _currentInterceptAction;
  }

  Future<List<RuleBase>> _getAllMatchingRules(PhoneNumber number) async {
    final String phoneNumberStr = number.value;
    List<RuleBase> matchingRules = [];
     
 // 从AllowedBlockedService获取所有匹配的规则
    final allowedBlockedRules = await _allowedBlockedService.getRulesByActionType(number, null);
    matchingRules.addAll(allowedBlockedRules);
     // 从RegexService获取所有匹配的规则
    final matchingRegexRules = await _regexService.getMatchingRegexRulesByActionType(phoneNumberStr, null);
    matchingRules.addAll(matchingRegexRules);
      // 从RuleManagementService获取所有匹配的规则
    final phoneRules = await _ruleManagementService.getRulesByActionType(number, null);
    matchingRules.addAll(phoneRules);
    return matchingRules;
  }

  /// 验证所有适用于指定号码的规则
  /// 返回按优先级排序的规则列表
  Future<List<RuleBase>> verifyAllRules(PhoneNumber number) async {
    // 获取所有匹配的规则
    final matchingRules = await _getAllMatchingRules(number);

    // 按优先级排序规则（优先级值越高，优先级越高）
    matchingRules.sort((a, b) => b.priority.value.compareTo(a.priority.value));
    return matchingRules;
  }
}
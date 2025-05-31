import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

/// 通话过滤服务类，用于根据规则判断是否接受来电
// 实现CallFilterInterface接口
class CallFilterService implements CallFilterInterface {
  // 显式声明所有依赖项
  final RegexService _regexService;
  final AllowedBlockedService _allowedBlockedService;
  final RuleManagementService _blacklistWhitelistService;
  final ConfigRepository _configRepository;

  CallFilterConfig callFilterConfig = CallFilterConfig();

  // 构造函数明确依赖关系
  CallFilterService({
    required RegexService regexService,
    required AllowedBlockedService allowedBlockedService,
    required RuleManagementService ruleManagementService,
    required ConfigRepository configRepository,
  })  : _regexService = regexService,
        _allowedBlockedService = allowedBlockedService,
        _blacklistWhitelistService = ruleManagementService,
        _configRepository = configRepository;

  // 优化后的方法定义，支持规则优先级
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    final phoneNumber = PhoneNumber(phoneNumberStr);
    String? interceptAction;

    // 全局拒绝设置优先级最高
    if (callFilterConfig.rejectAllNumbers) {
      _setCurrentInterceptAction(null); // 使用全局默认拦截动作
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
        interceptAction =
            _getInterceptActionFromRule(highestPriorityRule.action);
        _setCurrentInterceptAction(interceptAction);
        return false;
      case RuleActionType.none:
      default:
        return true;
    }
  }

  // 从规则动作中获取拦截动作
  String? _getInterceptActionFromRule(RuleAction action) {
    // 根据动作类型处理
    switch (action.type) {
      case RuleActionType.block:
        // 如果没有参数，使用默认拦截动作
        if (action.parameters == null ||
            !action.parameters!.containsKey('interceptAction')) {
          return null;
        }
        return action.parameters!['interceptAction'] as String?;

      case RuleActionType.silence:
        // silence类型直接返回silenceNoAnswer
        return 'silenceNoAnswer';

      case RuleActionType.none:
      case RuleActionType.allow:
      default:
        // 其他类型不需要拦截
        return null;
    }
  }

  // 当前拦截动作，用于在shouldAcceptCall和EndCallHandler之间传递信息
  static String? _currentInterceptAction;

  // 设置当前拦截动作
  void _setCurrentInterceptAction(String? action) {
    _currentInterceptAction = action;
  }

  // 获取当前拦截动作
  static String? getCurrentInterceptAction() {
    return _currentInterceptAction;
  }

  /// 从配置仓库加载配置
  Future<void> loadConfig() async {
    final configMap = await _configRepository.getConfig('call_filter');
    if (configMap != null) {
      callFilterConfig = CallFilterConfig.fromMap(configMap);
    }
  }

  /// 保存配置到配置仓库
  Future<void> saveConfig() async {
    await _configRepository.saveConfig('call_filter', callFilterConfig.toMap());
  }

  /// 更新配置
  Future<void> updateConfig(CallFilterConfig newConfig) async {
    callFilterConfig = newConfig;
    await saveConfig();
  }

  /// 初始化服务
  @override
  Future<void> initialize() async {
    // 移除旧的SharedPreferences初始化代码
    await loadConfig(); // 直接通过repository加载
  }

  /// 获取所有匹配指定号码的规则
  /// 直接获取所有匹配的规则，由优先级排序和动作类型判断机制决定最终行为
  Future<List<RuleBase>> _getAllMatchingRules(PhoneNumber number) async {
    final String phoneNumberStr = number.value;
    List<RuleBase> matchingRules = [];
    
    // 从AllowedBlockedService获取所有匹配的规则
    final allowedBlockedRules =
        await _allowedBlockedService.getRulesByActionType(number, null);
    matchingRules.addAll(allowedBlockedRules);
    
    // 从RegexService获取所有匹配的规则
    final matchingRegexRules = await _regexService
        .getMatchingRegexRulesByActionType(phoneNumberStr, null);
    matchingRules.addAll(matchingRegexRules);
    
    // 从BlacklistWhitelistService获取所有匹配的规则
    final blackWhiteRules =
        await _blacklistWhitelistService.getRulesByActionType(number, null);
    matchingRules.addAll(blackWhiteRules);
    
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

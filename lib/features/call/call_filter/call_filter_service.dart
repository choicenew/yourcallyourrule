import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

/// 通话过滤服务类，用于根据规则判断是否接受来电
// 实现CallFilterInterface接口
class CallFilterService implements CallFilterInterface {
  // 显式声明所有依赖项
  final RegexService _regexService;
  final AllowedBlockedService _allowedBlockedService;
  final BlacklistWhitelistService _blacklistWhitelistService;
  final ConfigRepository _configRepository;

  CallFilterConfig callFilterConfig = CallFilterConfig();

  // 构造函数明确依赖关系
  CallFilterService({
    required RegexService regexService,
    required AllowedBlockedService allowedBlockedService,
    required BlacklistWhitelistService blacklistWhitelistService,
    required ConfigRepository configRepository,
  })  : _regexService = regexService,
        _allowedBlockedService = allowedBlockedService,
        _blacklistWhitelistService = blacklistWhitelistService,
        _configRepository = configRepository;

  // 优化后的方法定义
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    final phoneNumber = PhoneNumber(phoneNumberStr);
    String? interceptAction;

    // 全局拒绝设置优先级最高
    if (callFilterConfig.rejectAllNumbers) {
      _setCurrentInterceptAction(null); // 使用全局默认拦截动作
      return false;
    }

    // 检查允许规则（优先级高）
    if (callFilterConfig.allowAllAllowedNumbers) {
      final allowedRules = await _allowedBlockedService.getAllowedRules(phoneNumber);
      if (allowedRules.isNotEmpty) {
        return true;
      }
    }

    // 检查阻止规则（优先级中）
    if (!callFilterConfig.allowBlockedNumbers) {
      final blockedRules = await _allowedBlockedService.getBlockedRules(phoneNumber);
      if (blockedRules.isNotEmpty) {
        // 使用第一个匹配规则的拦截动作
        interceptAction = _getInterceptActionFromRule(blockedRules.first.action);
        _setCurrentInterceptAction(interceptAction);
        return false;
      }
    }

    // 检查正则允许规则
    if (callFilterConfig.allowRegexAllowRules) {
      final matchingAllowRules = await _regexService.getMatchingRegexRulesByAction(
          phoneNumberStr, RuleAction.allow);
      if (matchingAllowRules.isNotEmpty) {
        return true;
      }
    }

    // 检查白名单规则
    if (callFilterConfig.allowAllWhitelistedNumbers) {
      final whitelistRules = await _blacklistWhitelistService.getWhitelistRules(phoneNumber);
      if (whitelistRules.isNotEmpty) {
        return true;
      }
    }

    // 检查正则阻止规则
    if (callFilterConfig.allowRegexBlockRules) {
      final matchingBlockRules = await _regexService.getMatchingRegexRulesByAction(
          phoneNumberStr, RuleAction.block);
      if (matchingBlockRules.isNotEmpty) {
        // 使用第一个匹配规则的拦截动作
        interceptAction = _getInterceptActionFromRule(matchingBlockRules.first.action);
        _setCurrentInterceptAction(interceptAction);
        return false;
      }
    }

    // 检查黑名单规则
    if (!callFilterConfig.allowAllBlacklistedNumbers) {
      final blacklistRules = await _blacklistWhitelistService.getBlacklistRules(phoneNumber);
      if (blacklistRules.isNotEmpty) {
        // 使用第一个匹配规则的拦截动作
        interceptAction = _getInterceptActionFromRule(blacklistRules.first.action);
        _setCurrentInterceptAction(interceptAction);
        return false;
      }
    }

    // 放行所有其他号码
    return true;
  }
  
  // 从规则动作中获取拦截动作
  String? _getInterceptActionFromRule(RuleAction action) {
    // 如果动作类型不是block，则不需要拦截
    if (action.type != RuleActionType.block) {
      return null;
    }
    
    // 如果没有参数，使用默认拦截动作
    if (action.parameters == null || !action.parameters!.containsKey('interceptAction')) {
      return null;
    }
    
    return action.parameters!['interceptAction'] as String?;
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

  verifyAllRules(PhoneNumber number) {}
}

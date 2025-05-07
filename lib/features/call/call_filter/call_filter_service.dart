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

  // 修复方法定义（原代码存在结构错误）
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    final phoneNumber = PhoneNumber(phoneNumberStr);

    if (callFilterConfig.rejectAllNumbers) {
      return false;
    }

    if (callFilterConfig.allowAllAllowedNumbers &&
        await _allowedBlockedService.isInAllowed(phoneNumber)) {
      return true;
    }

    if (await _allowedBlockedService.isInBlocked(phoneNumber) &&
        !callFilterConfig.allowBlockedNumbers) {
      return false;
    }

    if (callFilterConfig.allowRegexAllowRules) {
      final regexRules =
          await _regexService.getRegexRulesByAction(RuleAction.allow);
      for (var rule in regexRules) {
        if (rule.isEnabled && rule.matches(phoneNumberStr)) {
          return true;
        }
      }
    }

    // 检查号码是否在白名单中
    if (callFilterConfig.allowAllWhitelistedNumbers &&
        await _blacklistWhitelistService.isInWhitelist(phoneNumber)) {
      return true;
    }

    // 检查号码是否匹配阻止规则的正则表达式
    if (callFilterConfig.allowRegexBlockRules) {
      final regexRules =
          await _regexService.getRegexRulesByAction(RuleAction.block);
      for (var rule in regexRules) {
        if (rule.isEnabled && rule.matches(phoneNumberStr)) {
          return false;
        }
      }
    }

    // 检查号码是否在黑名单中
    if (await _blacklistWhitelistService.isInBlacklist(phoneNumber) &&
        !callFilterConfig.allowAllBlacklistedNumbers) {
      return false;
    }

    // 放行所有其他号码
    return true;
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
  Future<void> initialize() async {
    // 移除旧的SharedPreferences初始化代码
    await loadConfig(); // 直接通过repository加载
  }

  verifyAllRules(PhoneNumber number) {}
}

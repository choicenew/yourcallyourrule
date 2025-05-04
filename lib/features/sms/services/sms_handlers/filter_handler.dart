import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

import 'base_sms_handler.dart';

/// SMS过滤处理器
/// 专门负责处理SMS过滤相关的逻辑
class SmsFilterHandler extends BaseSmsHandler {
  final List<SmsRegexRule> smsRules;
  bool isEnabled = false;
  
  // 设置键名
  static const String smsFilterEnabledKey = 'sms_filter_enabled';

  /// 构造函数
  SmsFilterHandler({
    List<SmsRegexRule>? initialRules,
  }) : smsRules = initialRules ?? [];

  /// 初始化
  @override
  Future<void> initialize() async {
    await loadSettings();
  }

  /// 加载设置
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isEnabled = prefs.getBool(smsFilterEnabledKey) ?? false;
  }

  /// 设置是否启用过滤
  Future<void> setEnabled(bool enabled) async {
    if (isEnabled == enabled) return;

    isEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(smsFilterEnabledKey, enabled);
  }

  /// 添加规则
  void addRule(SmsRegexRule rule) {
    if (!smsRules.any((r) => r.id == rule.id)) {
      smsRules.add(rule);
    }
  }

  /// 添加多个规则
  void addRules(List<SmsRegexRule> rules) {
    for (final rule in rules) {
      addRule(rule);
    }
  }

  /// 更新规则
  void updateRule(SmsRegexRule rule) {
    final index = smsRules.indexWhere((r) => r.id == rule.id);
    if (index != -1) {
      smsRules[index] = rule;
    } else {
      addRule(rule);
    }
  }

  /// 删除规则
  void removeRule(String ruleId) {
    smsRules.removeWhere((rule) => rule.id == ruleId);
  }

  /// 判断是否应该通知
  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    if (!isEnabled) return true;

    // 按优先级排序规则
    smsRules.sort((a, b) => b.priority.value.compareTo(a.priority.value));
    
    // 遍历规则并检查匹配
    for (final rule in smsRules) {
      if (rule.matches(messageContent, phoneNumber)) {
        return rule.action == RuleAction.allow;
      }
    }

    // 默认允许通知
    return true;
  }
}
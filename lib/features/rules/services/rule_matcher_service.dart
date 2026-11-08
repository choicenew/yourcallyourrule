// 规则匹配服务，用于匹配来电或短信是否符合规则条件

import '../entities/rule/rule_base.dart';
import '../value_objects/phone_number.dart';
import '../value_objects/rule_action.dart';
import '../value_objects/rule_priority.dart';

/// 规则匹配服务接口
abstract class RuleMatcherService {
  /// 获取所有规则
  Future<List<RuleBase>> getAllRules();
  
  /// 根据优先级获取规则
  Future<List<RuleBase>> getRulesByPriority(RulePriority priority);
  
  /// 根据动作获取规则
  Future<List<RuleBase>> getRulesByAction(RuleAction action);
  
  /// 检查电话号码是否匹配任何规则
  /// [phoneNumber] 电话号码
  /// 返回匹配的规则，如果没有匹配则返回null
  Future<RuleBase?> matchPhoneNumber(PhoneNumber phoneNumber);
  
  /// 检查短信内容是否匹配任何规则
  /// [phoneNumber] 发送者电话号码
  /// [messageContent] 短信内容
  /// 返回匹配的规则，如果没有匹配则返回null
  Future<RuleBase?> matchSmsMessage(PhoneNumber phoneNumber, String messageContent);
  
  /// 获取应该对电话号码执行的动作
  /// [phoneNumber] 电话号码
  /// 返回应该执行的动作
  Future<RuleAction> getActionForPhoneNumber(PhoneNumber phoneNumber) async {
    final matchedRule = await matchPhoneNumber(phoneNumber);
    return matchedRule?.action ?? RuleAction.none;
  }
  
  /// 获取应该对短信执行的动作
  /// [phoneNumber] 发送者电话号码
  /// [messageContent] 短信内容
  /// 返回应该执行的动作
  Future<RuleAction> getActionForSmsMessage(PhoneNumber phoneNumber, String messageContent) async {
    final matchedRule = await matchSmsMessage(phoneNumber, messageContent);
    return matchedRule?.action ?? RuleAction.none;
  }
  
  /// 添加规则
  Future<RuleBase> addRule(RuleBase rule);
  
  /// 更新规则
  Future<RuleBase> updateRule(RuleBase rule);
  
  /// 删除规则
  Future<bool> deleteRule(String ruleId);
  
  /// 启用规则
  Future<RuleBase> enableRule(String ruleId);
  
  /// 禁用规则
  Future<RuleBase> disableRule(String ruleId);
  
  /// 获取规则优先级顺序
  Future<List<RulePriority>> getRulePriorityOrder();
  
  /// 设置规则优先级顺序
  Future<bool> setRulePriorityOrder(List<RulePriority> priorityOrder);
}
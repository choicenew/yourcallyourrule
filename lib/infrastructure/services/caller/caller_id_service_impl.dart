import '../../../domain/entities/call/call_log.dart';
import '../../../domain/entities/contact/contact.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/repositories/call_repository.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../domain/services/rule_matcher_service.dart';
import '../../../domain/services/rule_priority_service.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../base_service_impl.dart';

/// 来电识别服务实现
/// 负责识别来电号码并应用相应的规则
class CallerIdServiceImpl extends BaseServiceImpl {
  final RuleRepository _ruleRepository;
  final ContactRepository _contactRepository;
  final CallRepository _callRepository;
  final RuleMatcherService _ruleMatcherService;
  final RulePriorityService _rulePriorityService;
  
  CallerIdServiceImpl(
    this._ruleRepository,
    this._contactRepository,
    this._callRepository,
    this._ruleMatcherService,
    this._rulePriorityService,
  );
  
  /// 识别来电号码
  /// 返回匹配的规则和联系人信息
  Future<CallerIdResult> identifyCaller(String phoneNumber) async {
    final normalizedNumber = PhoneNumber(phoneNumber);
    
    // 查找联系人
    final contact = await _contactRepository.getByPhoneNumber(normalizedNumber);
    
    // 获取所有启用的规则
    final rules = await _ruleRepository.getEnabled();
    
    // 找出匹配的规则
    final matchedRules = _ruleMatcherService.findMatches(rules, normalizedNumber.normalized);
    
    // 按优先级排序规则
    final sortedRules = _rulePriorityService.sortByPriority(matchedRules);
    
    // 获取最高优先级的规则
    final highestPriorityRule = sortedRules.isNotEmpty ? sortedRules.first : null;
    
    // 确定应采取的动作
    final action = highestPriorityRule?.action ?? RuleAction.unknown;
    
    return CallerIdResult(
      phoneNumber: normalizedNumber.normalized,
      contact: contact,
      matchedRule: highestPriorityRule,
      action: action,
    );
  }
  
  /// 记录通话
  Future<void> logCall(CallLog callLog) async {
    await _callRepository.add(callLog);
  }
}

/// 来电识别结果
class CallerIdResult {
  final String phoneNumber;
  final Contact? contact;
  final RuleBase? matchedRule;
  final RuleAction action;
  
  CallerIdResult({
    required this.phoneNumber,
    this.contact,
    this.matchedRule,
    required this.action,
  });
}
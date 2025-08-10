import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

class SmsRegexRule extends RuleBase {
  final RegExp contentPattern;
  final RegExp? senderPattern;
  final String labelId; // 添加labelId字段，用于关联标签
  
  // 添加静态常量 ruleType
  static const String ruleType = 'sms_regex';

  SmsRegexRule({
    required super.id,
    required super.name,
    required String contentRegex,
    String? senderRegex,
    required super.action,
    RulePriority? priority,
    super.isEnabled = true,
    this.labelId = '', // 添加labelId参数，默认为空字符串
  }) : 
    contentPattern = RegExp(contentRegex, caseSensitive: false, unicode: true),
    senderPattern = senderRegex != null 
      ? RegExp(senderRegex, caseSensitive: false) 
      : null,
    super(priority: priority ?? _defaultPriority(action));

  static RulePriority _defaultPriority(RuleAction action) {
    switch (action.type) {
      case RuleActionType.allow:
        return RulePriority.high;  // 使用预定义常量，优先级10
      case RuleActionType.block:
        return RulePriority.medium;  // 使用预定义常量，优先级5
      case RuleActionType.silence:
        return RulePriority.silenceAction;  // 使用预定义常量，优先级1
      case RuleActionType.none:
      default:
        return RulePriority.noneAction;  // 使用预定义常量，优先级0
    }
  }


  @override
  bool matches(String content, [String? sender]) { // 改为使用字符串参数
    return isEnabled && 
      (contentPattern.hasMatch(content) ||
      (sender != null && senderPattern?.hasMatch(sender) == true));
  }


  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contentRegex': contentPattern.pattern,
      'senderRegex': senderPattern?.pattern,
      'action': action.toString(),
      'priority': priority.value,
      'isEnabled': isEnabled ? 1 : 0,
      'ruleType': ruleType,
      'labelId': labelId, // 添加labelId字段到Map
    };
  }

  factory SmsRegexRule.fromMap(Map<String, dynamic> map) {
    return SmsRegexRule(
      id: map['id'],
      name: map['name'],
      contentRegex: map['contentRegex'],
      senderRegex: map['senderRegex'],
      action: RuleAction.fromString(map['action']),
      priority: RulePriority.fromInt(map['priority']),
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      labelId: map['labelId'] ?? '', // 从Map中读取labelId字段
    );
  }

  @override
  SmsRegexRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    String? contentRegex,
    String? senderRegex,
    String? labelId,
  }) {
    return SmsRegexRule(
      id: id ?? this.id,
      name: name ?? this.name,
      contentRegex: contentRegex ?? contentPattern.pattern,
      senderRegex: senderRegex ?? senderPattern?.pattern,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
      labelId: labelId ?? this.labelId, // 添加labelId参数
    );
  }
}
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

class SmsRegexRule extends RuleBase {
  final RegExp contentPattern;
  final RegExp? senderPattern;
  
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
  }) : 
    contentPattern = RegExp(contentRegex, caseSensitive: false, unicode: true),
    senderPattern = senderRegex != null 
      ? RegExp(senderRegex, caseSensitive: false) 
      : null,
    super(priority: priority ?? _defaultPriority(action));

  static RulePriority _defaultPriority(RuleAction action) {
    return action == RuleAction.allow 
      ? const RulePriority(10)
      : const RulePriority(5);
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
      'isEnabled': isEnabled,
      'ruleType': ruleType,
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
      isEnabled: map['isEnabled'] ?? true,
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
  }) {
    return SmsRegexRule(
      id: id ?? this.id,
      name: name ?? this.name,
      contentRegex: contentRegex ?? contentPattern.pattern,
      senderRegex: senderRegex ?? senderPattern?.pattern,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
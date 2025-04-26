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


  SmsRegexRule copyWith({
    String? id,
    String? name,
    String? contentRegex,
    String? senderRegex,
    RuleAction? action,
    bool? isEnabled,
  }) {
    return SmsRegexRule(
      id: id ?? this.id,
      name: name ?? this.name,
      contentRegex: contentRegex ?? this.contentPattern.pattern,
      senderRegex: senderRegex ?? this.senderPattern?.pattern,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
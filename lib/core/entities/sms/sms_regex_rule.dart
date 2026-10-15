import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

part 'sms_regex_rule.freezed.dart';

/// 短信正则规则领域实体 (@freezed 自动生成不可变数据类)
@freezed
abstract class SmsRegexRule with _$SmsRegexRule implements RuleBase {
  const SmsRegexRule._();

  @Implements<RuleBase>()
  const factory SmsRegexRule({
    required String id,
    required String name,
    required RuleAction action,
    required String contentRegex,
    String? senderRegex,
    RulePriority? priority,
    @Default(true) bool isEnabled,
    @Default('') String labelId,
    @Default(RuleTypeKeys.smsRegex) String ruleType,
  }) = _SmsRegexRule;

  /// 编译后的内容正则表达式
  RegExp get contentPattern => RegExp(contentRegex, caseSensitive: false, unicode: true);

  /// 编译后的发送者正则表达式（可选）
  RegExp? get senderPattern => senderRegex != null ? RegExp(senderRegex!, caseSensitive: false) : null;

  /// 短信规则匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled &&
        (contentPattern.hasMatch(input) ||
            (senderPattern != null && senderPattern!.hasMatch(input)));
  }

  /// 格式化转换 Map
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contentRegex': contentRegex,
      'senderRegex': senderRegex,
      'action': action.toString(),
      'priority': priority?.value ?? 0,
      'isEnabled': isEnabled ? 1 : 0,
      'ruleType': ruleType,
      'labelId': labelId,
    };
  }

  /// 从 Map 反序列化生成实体
  factory SmsRegexRule.fromMap(Map<String, dynamic> map) {
    return SmsRegexRule(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      contentRegex: map['contentRegex']?.toString() ?? '',
      senderRegex: map['senderRegex']?.toString(),
      action: RuleAction.fromString(map['action']),
      priority: RulePriority.fromInt(map['priority']),
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
      labelId: map['labelId']?.toString() ?? '',
      ruleType: map['ruleType']?.toString() ?? RuleTypeKeys.smsRegex,
    );
  }
}

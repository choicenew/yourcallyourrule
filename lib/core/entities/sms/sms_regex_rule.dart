import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import 'package:yourcallyourrule/common/utils/bool_parser.dart';

part 'sms_regex_rule.freezed.dart';
part 'sms_regex_rule.g.dart';

/// 短信正则规则领域实体 (@freezed + @JsonSerializable 100% 自动生成序列化)
@freezed
abstract class SmsRegexRule with _$SmsRegexRule implements RuleBase {
  const SmsRegexRule._();

  @Implements<RuleBase>()
  const factory SmsRegexRule({
    required String id,
    required String name,
    @RuleActionConverter() required RuleAction action,
    required String contentRegex,
    String? senderRegex,
    @RulePriorityConverter() @Default(RulePriority.medium) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default('') String labelId,
    @Default(RuleTypeKeys.smsRegex) String ruleType,
  }) = _SmsRegexRule;

  /// 编译后的内容正则表达式
  RegExp get contentPattern => RegExp(contentRegex, caseSensitive: false, unicode: true);

  /// 编译后的发送者正则表达式（可选）
  RegExp? get senderPattern => senderRegex != null ? RegExp(senderRegex!, caseSensitive: false) : null;

  /// 短信规则匹配逻辑（接收内容与可选发送者）
  @override
  bool matches(String content, [String? sender]) {
    return isEnabled &&
        (contentPattern.hasMatch(content) ||
            (sender != null && senderPattern?.hasMatch(sender) == true));
  }

  /// 100% 自动生成 JSON 反序列化
  factory SmsRegexRule.fromJson(Map<String, dynamic> json) =>
      _$SmsRegexRuleFromJson(json);

  /// 转换 Map (委托给自动生成的 toJson)
  @override
  Map<String, dynamic> toMap() => toJson();

  /// 从 Map 反序列化
  factory SmsRegexRule.fromMap(Map<String, dynamic> map) {
    final jsonMap = Map<String, dynamic>.from(map);
    if (jsonMap.containsKey('isEnabled')) {
      jsonMap['isEnabled'] = parseBool(jsonMap['isEnabled']);
    }
    return SmsRegexRule.fromJson(jsonMap);
  }
}

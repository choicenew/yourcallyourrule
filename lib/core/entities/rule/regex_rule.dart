// 正则表达式规则实体，用于表示基于正则表达式的规则

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/common/utils/bool_parser.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

part 'regex_rule.freezed.dart';
part 'regex_rule.g.dart';

/// 正则表达式规则领域实体 (@freezed + @JsonSerializable 100% 自动生成序列化)
@freezed
abstract class RegexRule with _$RegexRule implements RuleBase {
  const RegexRule._();

  @Implements<RuleBase>()
  const factory RegexRule({
    required String id,
    required String name,
    required String pattern,
    @RuleActionConverter() required RuleAction action,
    @RulePriorityConverter() @Default(RulePriority.medium) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default(RuleTypeKeys.regex) String ruleType,
    String? subscriptionId,
  }) = _RegexRule;

  /// 将 isSubscribed 改为计算属性
  bool get isSubscribed => subscriptionId != null;

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    if (!isEnabled) return false;
    try {
      return RegExp(pattern).hasMatch(input);
    } catch (e) {
      return false;
    }
  }

  /// 100% 自动生成 JSON 反序列化
  factory RegexRule.fromJson(Map<String, dynamic> json) =>
      _$RegexRuleFromJson(json);

  /// 转换 Map (委托给自动生成的 toJson)
  @override
  Map<String, dynamic> toMap() => toJson();

  /// 从 Map 反序列化 (注入动态默认优先级：Allow / Block / Silence / None)
  factory RegexRule.fromMap(Map<String, dynamic> map) {
    final jsonMap = Map<String, dynamic>.from(map);
    if (jsonMap.containsKey('isEnabled')) {
      jsonMap['isEnabled'] = parseBool(jsonMap['isEnabled']);
    }
    if (jsonMap['priority'] == null) {
      final action = RuleAction.fromString(jsonMap['action']?.toString() ?? '');
      jsonMap['priority'] = _defaultPriority(action).value;
    }
    return RegexRule.fromJson(jsonMap);
  }

  static RulePriority _defaultPriority(RuleAction action) {
    switch (action.type) {
      case RuleActionType.allow:
        return RulePriority.high; // 使用预定义常量，优先级10
      case RuleActionType.block:
        return RulePriority.medium; // 使用预定义常量，优先级5
      case RuleActionType.silence:
        return RulePriority.silenceAction; // 使用预定义常量，优先级1
      case RuleActionType.none:
      default:
        return RulePriority.noneAction; // 使用预定义常量，优先级0
    }
  }
}
